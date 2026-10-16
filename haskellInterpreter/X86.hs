{-# LANGUAGE LambdaCase #-}

module X86Interp where

import qualified Data.Map.Strict as M
import Data.Map.Strict (Map)
import Data.Char (ord)
import Data.Bits ((.&.), (.|.), xor, shiftL, shiftR, complement)
import Data.Word (Word)
import Control.Monad (foldM)

data Register
  = RAX | RDI | RSI | RDX | RCX | RBP | RSP
  | R8  | R9  | R10 | R11 | R12 | R13 | R14 | R15
  deriving (Eq, Ord, Show, Enum, Bounded)

allRegisters :: Map Register Int
allRegisters = M.fromList [(r, 0) | r <- [minBound .. maxBound]]

data Opnd
  = R Register
  | S Int
  | L Int
  | I Int
  deriving (Eq, Show)

data Instr
  = Mov Opnd Opnd | Lea Opnd Opnd | Binop String Opnd Opnd
  | IDiv Opnd | Cltd | Set String Register
  | Push Opnd | Pop Opnd
  | Call Int | Builtin String | CallI Opnd | Ret
  | CJmp String Int | Jmp Int | JmpI Opnd
  | Dec Opnd | Or1 Opnd | Sal1 Opnd | Sar1 Opnd | Repmovsl
  deriving (Eq, Show)

type ExtInst = (Instr, Maybe String)

data MemObject
  = MemArray   [Int]
  | MemString  String
  | MemSexp    Int [Int]
  | MemClosure Int [Int]
  deriving (Show, Eq)

newtype Stack = Stack { stkCells :: Map Int Int }
  deriving (Show, Eq)

emptyStack :: Stack
emptyStack = Stack M.empty

rspOf :: State -> Int
rspOf = M.findWithDefault 0 RSP . stRegs

rbpOf :: State -> Int
rbpOf = M.findWithDefault 0 RBP . stRegs

stackPush :: Int -> State -> State
stackPush v st =
  let rsp' = rspOf st - 8
  in st { stRegs  = M.insert RSP rsp' (stRegs st)
        , stStack = Stack (M.insert rsp' v (stkCells (stStack st))) }

stackPop :: State -> Interp (Int, State)
stackPop st =
  let rsp = rspOf st
  in case M.lookup rsp (stkCells (stStack st)) of
       Nothing -> Left StackUnderflow
       Just v  -> Right ( v,
                          st { stRegs  = M.insert RSP (rsp + 8) (stRegs st)
                             , stStack = Stack (M.delete rsp (stkCells (stStack st))) } )

stackRead :: Int -> State -> Maybe Int
stackRead i st =
  let rbp = rbpOf st
      adr = if i >= 0 then rbp - (i + 1) * 8 else rbp + (-i + 1) * 8
  in M.lookup adr (stkCells (stStack st))

stackWrite :: Int -> Int -> State -> State
stackWrite i v st =
  let rbp = rbpOf st
      adr = if i >= 0 then rbp - (i + 1) * 8 else rbp + (-i + 1) * 8
  in st { stStack = Stack (M.insert adr v (stkCells (stStack st))) }

data Flags = Flags
  { flagZF :: Bool, flagSF :: Bool, flagOF :: Bool, flagCF :: Bool }
  deriving (Show, Eq)

noFlags :: Flags
noFlags = Flags False False False False

data State = State
  { stRegs    :: Map Register Int
  , stStack   :: Stack
  , stGlob    :: Map Int Int
  , stInput   :: [Int]
  , stOutput  :: [Int]
  , stMem     :: Map Int MemObject
  , stHeapTop :: Int
  , stFlags   :: Flags
  } deriving (Show)

data Machine = Machine
  { mRest  :: [ExtInst]
  , mState :: State
  } deriving (Show)

data ProgConfig = ProgConfig
  { cfgLabels  :: Map Int String
  , cfgMain    :: Int
  , cfgStrings :: Map Int String
  , cfgProgram :: [ExtInst]
  , cfgOffsets :: Map Int [ExtInst]
  }

buildConfig :: [ExtInst] -> Map Int String -> Map Int String -> Int -> Map Int [ExtInst] -> ProgConfig
buildConfig prog strings labels mainOff =
  ProgConfig labels mainOff strings prog

data InterpError
  = InvalidMemoryAddress Int
  | InvalidStackIndex Int
  | UnknownLabel Int
  | UnknownBuiltin String
  | StackUnderflow
  | DivisionByZero
  | DivisionOverflow
  | WriteToLiteral
  | WriteToRegister String
  | InvalidElement Int Int
  | MatchFailure
  | RuntimeFailure String
  deriving (Show, Eq)

type Interp a = Either InterpError a

-- RDX is the signed high half; RAX contributes its unsigned 64-bit pattern.
signedDivide128 :: Int -> Int -> Int -> Interp (Int, Int)
signedDivide128 highHalf lowHalf divisor
  | divisor == 0 = Left DivisionByZero
  | quotient < negate signedLimit || quotient >= signedLimit = Left DivisionOverflow
  | otherwise = Right (fromInteger quotient, fromInteger remainder)
  where
    registerBase :: Integer
    registerBase = 2 ^ (64 :: Int)

    signedLimit :: Integer
    signedLimit = 2 ^ (63 :: Int)

    dividend :: Integer
    dividend = toInteger highHalf * registerBase + toInteger lowHalf `mod` registerBase

    quotient :: Integer
    remainder :: Integer
    (quotient, remainder) = dividend `quotRem` toInteger divisor

initialState :: ProgConfig -> [Int] -> State
initialState _ inputs = State
  { stRegs    = allRegisters
  , stStack   = emptyStack
  , stGlob    = M.empty
  , stInput   = inputs
  , stOutput  = []
  , stMem     = M.empty
  , stHeapTop = 0
  , stFlags   = noFlags
  }

initialMachine :: ProgConfig -> [Int] -> Machine
initialMachine cfg inputs = Machine (cfgProgram cfg) (initialState cfg inputs)

checkAddr :: Int -> Interp ()
checkAddr a | odd a     = Left (InvalidMemoryAddress a)
            | otherwise = Right ()

readMem :: Int -> State -> Interp MemObject
readMem a st = do
  checkAddr a
  maybe (Left (InvalidMemoryAddress a)) Right (M.lookup a (stMem st))

readConst :: ProgConfig -> Int -> Interp String
readConst cfg a = case M.lookup a (cfgStrings cfg) of
  Just s  -> Right s
  Nothing -> Left (InvalidMemoryAddress a)

writeMem :: Int -> MemObject -> State -> Interp State
writeMem a v st = do
  checkAddr a
  Right st { stMem = M.insert a v (stMem st) }

alloc :: MemObject -> State -> (Int, State)
alloc o st =
  let adr = stHeapTop st
  in (adr, st { stMem = M.insert adr o (stMem st)
              , stHeapTop = adr + 2 })

readInt :: State -> Opnd -> Interp Int
readInt st op = case op of
  R r   -> Right (M.findWithDefault 0 r (stRegs st))
  S i   -> maybe (Left (InvalidStackIndex i)) Right (stackRead i st)
  L i   -> Right i
  I off -> do
    let adr = M.findWithDefault 0 R15 (stRegs st)
    o <- readMem adr st
    case o of
      MemClosure _ caps ->
        let k = off `div` 8 - 1
        in if k >= 0 && k < length caps
             then Right (caps !! k)
             else Left (InvalidElement k (length caps))
      _ -> Left (InvalidMemoryAddress adr)

writeInt :: State -> Opnd -> Int -> Interp State
writeInt st op v = case op of
  R r   -> Right st { stRegs = M.insert r v (stRegs st) }
  S i   -> Right (stackWrite i v st)
  L _   -> Left WriteToLiteral
  I _   -> Left (WriteToRegister "cannot write through indirect")

readAddr :: State -> Opnd -> Interp Int
readAddr st op = case op of
  S i   -> Right (rbpOf st - (i + 1) * 8)
  L i   -> Right i
  R _   -> Left (WriteToRegister "cannot take address of register")
  I _   -> Left (InvalidMemoryAddress (-1))

flagsFromSub :: Int -> Int -> Flags
flagsFromSub a b =
  let r   = a - b
      zf  = r == 0
      sf  = r < 0
      of_ = (a >= 0) /= (b >= 0) && (r >= 0) /= (a >= 0)
      cf  = (fromIntegral a :: Word) < fromIntegral b
  in Flags zf sf of_ cf

flagsFromLogic :: Int -> Flags
flagsFromLogic r = Flags (r == 0) (r < 0) False False

evalCond :: String -> Flags -> Bool
evalCond suf f = case suf of
  "e"  -> flagZF f
  "z"  -> flagZF f
  "ne" -> not (flagZF f)
  "nz" -> not (flagZF f)
  "l"  -> flagSF f /= flagOF f
  "le" -> flagZF f || (flagSF f /= flagOF f)
  "g"  -> not (flagZF f) && (flagSF f == flagOF f)
  "ge" -> flagSF f == flagOF f
  _    -> False

popN :: Int -> State -> Interp ([Int], State)
popN n st = do
  let rsp   = rspOf st
      adrs  = [rsp + k * 8 | k <- [0 .. n - 1]]
      cells = stkCells (stStack st)
  vals <- mapM (\a -> maybe (Left StackUnderflow) Right (M.lookup a cells)) adrs
  Right ( vals,
          st { stRegs  = M.insert RSP (rsp + n * 8) (stRegs st)
             , stStack = Stack (foldr M.delete cells adrs) } )

popTwo :: State -> Interp ((Int, Int), State)
popTwo initialState = do
  (values, remainingState) <- popN 2 initialState
  case values of
    [firstValue, secondValue] -> pure ((firstValue, secondValue), remainingState)
    _ -> Left StackUnderflow

popThree :: State -> Interp ((Int, Int, Int), State)
popThree initialState = do
  (values, remainingState) <- popN 3 initialState
  case values of
    [firstValue, secondValue, thirdValue] -> pure ((firstValue, secondValue, thirdValue), remainingState)
    _ -> Left StackUnderflow

pushN :: [Int] -> State -> State
pushN vs st =
  let rsp   = rspOf st
      n     = length vs
      rsp'  = rsp - n * 8
      adrs  = [rsp' + k * 8 | k <- [0 .. n - 1]]
      cells = foldr (uncurry M.insert) (stkCells (stStack st)) (zip adrs vs)
  in st { stRegs  = M.insert RSP rsp' (stRegs st)
        , stStack = Stack cells }

nargsOf :: State -> Int
nargsOf st = M.findWithDefault 0 R11 (stRegs st)

dispatchBuiltin :: ProgConfig -> String -> State -> Interp State
dispatchBuiltin cfg name st0 = case name of
  ".string" -> do
    (adr, st) <- stackPop st0
    s <- readConst cfg adr
    let (newAdr, st') = alloc (MemString s) st
    Right (pushN [newAdr] st')

  "string" -> do
    (adr, st) <- stackPop st0
    s <- readConst cfg adr
    let (newAdr, st') = alloc (MemString s) st
    Right (pushN [newAdr] st')

  ".elem" -> do
    ((idx, arr), st) <- popTwo st0
    o <- readMem arr st
    case o of
      MemArray xs
        | idx >= 0 && idx < length xs -> Right (pushN [xs !! idx] st)
        | otherwise -> Left (InvalidElement idx (length xs))
      MemSexp _ xs
        | idx >= 0 && idx < length xs -> Right (pushN [xs !! idx] st)
        | otherwise -> Left (InvalidElement idx (length xs))
      MemString s
        | idx >= 0 && idx < length s  -> Right (pushN [ord (s !! idx)] st)
        | otherwise -> Left (InvalidElement idx (length s))
      _ -> Left (InvalidElement idx (-1))

  ".sexp" -> do
    let total = nargsOf st0
    (vals, st) <- popN total st0
    case vals of
      (tag : rest) -> do
        let (adr, st') = alloc (MemSexp tag rest) st
        Right (pushN [adr] st')
      [] -> Left StackUnderflow

  ".array" -> do
    let total = nargsOf st0
    (vals, st) <- popN total st0
    let (adr, st') = alloc (MemArray vals) st
    Right (pushN [adr] st')

  ".closure" -> do
    let total = nargsOf st0
    (vals, st) <- popN total st0
    case vals of
      (codeOff : captured) -> do
        let (adr, st') = alloc (MemClosure codeOff captured) st
        Right (pushN [adr] st')
      [] -> Left StackUnderflow

  ".array_patt" -> do
    ((n, adr), st) <- popTwo st0
    o <- readMem adr st
    let v = case o of
              MemArray xs | length xs == n -> 1
              _                            -> 0
    Right (pushN [v] st)

  ".string_patt" -> do
    ((x, y), st) <- popTwo st0
    ox <- readMem x st
    oy <- readMem y st
    let v = case (ox, oy) of
              (MemString a, MemString b) | a == b -> 1
              _                                  -> 0
    Right (pushN [v] st)

  ".boxed_patt"       -> patt1 st0 even
  ".unboxed_patt"     -> patt1 st0 odd
  ".array_tag_patt"   -> patt1 st0 (isArray st0)
  ".string_tag_patt"  -> patt1 st0 (isString st0)
  ".sexp_tag_patt"    -> patt1 st0 (isSexp st0)
  ".closure_tag_patt" -> patt1 st0 (isClosure st0)

  ".sta" -> do
    ((z, j, x), st) <- popThree st0
    o <- readMem x st
    case o of
      MemArray xs | j >= 0 && j < length xs ->
        let xs' = take j xs ++ [z] ++ drop (j + 1) xs
        in Right (pushN [z] st { stMem = M.insert x (MemArray xs') (stMem st) })
      MemSexp t xs | j >= 0 && j < length xs ->
        let xs' = take j xs ++ [z] ++ drop (j + 1) xs
        in Right (pushN [z] st { stMem = M.insert x (MemSexp t xs') (stMem st) })
      _ -> Right (pushN [z] st)

  "failure" -> do
    (msgAdr, st) <- stackPop st0
    msg <- readMem msgAdr st >>= \case
             MemString s -> Right s
             _           -> Right ""
    Left (RuntimeFailure msg)

  ".match_failure" -> do
    (_, _st) <- popN 4 st0
    Left MatchFailure

  _ -> Left (UnknownBuiltin name)
  where
    patt1 :: State -> (Int -> Bool) -> Interp State
    patt1 initialState predicate = do
      (value, remainingState) <- stackPop initialState
      Right (pushN [if predicate value then 1 else 0] remainingState)

    isArray   st a = case M.lookup a (stMem st) of Just (MemArray _)     -> True; _ -> False
    isString  st a = case M.lookup a (stMem st) of Just (MemString _)    -> True; _ -> False
    isSexp    st a = case M.lookup a (stMem st) of Just (MemSexp _ _)    -> True; _ -> False
    isClosure st a = case M.lookup a (stMem st) of Just (MemClosure _ _) -> True; _ -> False

lookupOff :: ProgConfig -> Int -> Interp [ExtInst]
lookupOff cfg off = case M.lookup off (cfgOffsets cfg) of
  Just is -> Right is
  Nothing -> Left (UnknownLabel off)

step :: ProgConfig -> State -> [ExtInst] -> Interp (State, [ExtInst])
step cfg st0 ((i, _dbg) : is) = case i of
  Mov src dst -> do
    v <- readInt st0 src
    st <- writeInt st0 dst v
    Right (st, is)

  Lea src dst -> do
    a <- readAddr st0 src
    st <- writeInt st0 dst a
    Right (st, is)

  Binop op a b -> do
    va <- readInt st0 a
    vb <- readInt st0 b
    case op of
      "+"    -> writeInt st0 b (va + vb)     >>= \s -> Right (s, is)
      "-"    -> writeInt st0 b (va - vb)     >>= \s -> Right (s, is)
      "*"    -> writeInt st0 b (va * vb)     >>= \s -> Right (s, is)
      "&&"   -> writeInt st0 b (va .&. vb)   >>= \s -> Right (s, is)
      "!!"   -> writeInt st0 b (va .|. vb)   >>= \s -> Right (s, is)
      "^"    -> writeInt st0 b (va `xor` vb) >>= \s -> Right (s, is)
      "cmp"  -> Right (st0 { stFlags = flagsFromSub vb va }, is)
      "test" -> Right (st0 { stFlags = flagsFromLogic (va .&. vb) }, is)
      _      -> Left (UnknownBuiltin ("binop " ++ op))

  IDiv source -> do
    divisor <- readInt st0 source
    let lowHalf :: Int
        lowHalf = M.findWithDefault 0 RAX (stRegs st0)
        highHalf :: Int
        highHalf = M.findWithDefault 0 RDX (stRegs st0)
    (quotient, remainder) <- signedDivide128 highHalf lowHalf divisor
    let dividedState :: State
        dividedState = st0
          { stRegs = M.insert RAX quotient (M.insert RDX remainder (stRegs st0)) }
    Right (dividedState, is)

  Cltd -> do
    let raxV = M.findWithDefault 0 RAX (stRegs st0)
        rdxV = if raxV < 0 then -1 else 0
    Right (st0 { stRegs = M.insert RDX rdxV (stRegs st0) }, is)

  Set suf r -> do
    let v    = if evalCond suf (stFlags st0) then 1 else 0
        cur  = M.findWithDefault 0 r (stRegs st0)
        cur' = (cur .&. complement 0xFF) .|. (v .&. 0xFF)
    Right (st0 { stRegs = M.insert r cur' (stRegs st0) }, is)

  Push src -> do
    v <- readInt st0 src
    Right (stackPush v st0, is)

  Pop dst -> do
    (v, st') <- stackPop st0
    st <- writeInt st' dst v
    Right (st, is)

  Call off -> do
    target <- lookupOff cfg off
    let retOff = length (cfgProgram cfg) - length is
    Right (stackPush retOff st0, target)

  Builtin name -> do
    st <- dispatchBuiltin cfg name st0
    Right (st, is)

  CallI op -> do
    v <- readInt st0 op
    let retOff = length (cfgProgram cfg) - length is
    case M.lookup v (stMem st0) of
      Just (MemClosure code _) -> do
        target <- lookupOff cfg code
        Right (stackPush retOff st0, target)
      _ -> do
        target <- lookupOff cfg v
        Right (stackPush retOff st0, target)

  Ret -> do
    (off, st') <- stackPop st0
    target <- lookupOff cfg off
    Right (st', target)

  CJmp suf off ->
    if evalCond suf (stFlags st0)
      then do target <- lookupOff cfg off
              Right (st0, target)
      else Right (st0, is)

  Jmp off -> do
    target <- lookupOff cfg off
    Right (st0, target)

  JmpI op -> do
    v <- readInt st0 op
    case M.lookup v (stMem st0) of
      Just (MemClosure code _) -> do
        target <- lookupOff cfg code
        Right (st0, target)
      _ -> do
        target <- lookupOff cfg v
        Right (st0, target)

  Dec op -> do
    v <- readInt st0 op
    writeInt st0 op (v - 1) >>= \s -> Right (s, is)

  Or1 op -> do
    v <- readInt st0 op
    writeInt st0 op (v .|. 1) >>= \s -> Right (s, is)

  Sal1 op -> do
    v <- readInt st0 op
    writeInt st0 op (v `shiftL` 1) >>= \s -> Right (s, is)

  Sar1 op -> do
    v <- readInt st0 op
    writeInt st0 op (v `shiftR` 1) >>= \s -> Right (s, is)

  Repmovsl -> do
    let rcxV = M.findWithDefault 0 RCX (stRegs st0)
        rsiV = M.findWithDefault 0 RSI (stRegs st0)
        rdiV = M.findWithDefault 0 RDI (stRegs st0)
    st <- foldM (\s k -> do
                    let sA = rsiV + k * 8
                        dA = rdiV + k * 8
                    o <- readMem sA s
                    writeMem dA o s)
                st0 [0 .. rcxV - 1]
    Right (st, is)
step _ _ [] = Left (InvalidMemoryAddress (-1))

runInterp :: ProgConfig -> Machine -> Interp State
runInterp _   (Machine [] st) = Right st
runInterp cfg (Machine rest st) = do
  (st', rest') <- step cfg st rest
  runInterp cfg (Machine rest' st')
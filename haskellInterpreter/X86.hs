{-# LANGUAGE LambdaCase #-}

module X86Interp where

-- import Debug.Trace (traceM) -- DEBUG: instruction-level tracing.

import qualified Data.Map.Strict as M
import Data.Map.Strict (Map)
import Data.Char (chr, ord)
import Data.List (intercalate, foldl')
import Numeric (showHex)
import Data.Bits ((.&.), (.|.), xor, shiftL, shiftR, complement)
import Data.Word (Word)

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
  | IR15 Int
  | IRIP Int
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
  IRIP address -> maybe (Left (InvalidMemoryAddress address)) Right (M.lookup address (stGlob st))
  IR15 off -> do
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
  IRIP address -> Right st { stGlob = M.insert address v (stGlob st) }
  IR15 offset -> writeClosureCapture st offset v

writeClosureCapture :: State -> Int -> Int -> Interp State
writeClosureCapture state byteOffset newValue
  | byteOffset < 8 || byteOffset `mod` 8 /= 0 =
      Left (RuntimeFailure ("Invalid closure capture offset: " ++ show byteOffset))
  | otherwise = do
      let closureAddress = M.findWithDefault 0 R15 (stRegs state)
          captureIndex = byteOffset `div` 8 - 1
      closure <- readMem closureAddress state
      case closure of
        MemClosure codeAddress capturedValues ->
          case splitAt captureIndex capturedValues of
            (prefix, _ : suffix) ->
              writeMem closureAddress (MemClosure codeAddress (prefix ++ newValue : suffix)) state
            _ -> Left (InvalidElement captureIndex (length capturedValues))
        _ -> Left (InvalidMemoryAddress closureAddress)

readAddr :: State -> Opnd -> Interp Int
readAddr st op = case op of
  S i   -> Right (rbpOf st - (i + 1) * 8)
  L i   -> Right i
  R _   -> Left (WriteToRegister "cannot take address of register")
  IRIP address -> Right address
  IR15 _ -> Left (InvalidMemoryAddress (-1))

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

boxInteger :: Int -> Int
boxInteger value = (value `shiftL` 1) .|. 1

unboxInteger :: String -> Int -> Interp Int
unboxInteger operationName value
  | odd value = Right (value `shiftR` 1)
  | otherwise = Left (RuntimeFailure (operationName ++ ": expected tagged integer"))

noOpBuiltins :: [String]
noOpBuiltins = ["__gc_init", "set_args", "Lbinoperror", "Lbinoperror2"]

builtinSymbols :: [(String, String)]
builtinSymbols =
  [("Lread", "read"), ("Lwrite", "write"), ("Llength", "length"),
   ("Btag", ".tag"), ("failure", "failure"),
   ("Bstring", ".string"), ("Lstring", "string"), ("Belem", ".elem"),
   ("Bsexp", ".sexp"), ("Barray", ".array"), ("Bclosure", ".closure"),
   ("Barray_patt", ".array_patt"), ("Bstring_patt", ".string_patt"),
   ("Bboxed_patt", ".boxed_patt"), ("Bunboxed_patt", ".unboxed_patt"),
   ("Barray_tag_patt", ".array_tag_patt"), ("Bstring_tag_patt", ".string_tag_patt"),
   ("Bsexp_tag_patt", ".sexp_tag_patt"), ("Bclosure_tag_patt", ".closure_tag_patt"),
   ("Bsta", ".sta"), ("Lfailure", "failure"), ("Bmatch_failure", ".match_failure")]
  ++ [(symbolName, symbolName) | symbolName <- noOpBuiltins]

dispatchBuiltin :: ProgConfig -> String -> State -> Interp State
dispatchBuiltin cfg name st0 = case name of
  "read" -> case stInput st0 of
    [] -> Left (RuntimeFailure "read: no input available")
    inputValue : remainingInput ->
      writeInt (st0 { stInput = remainingInput }) (R RAX) (boxInteger inputValue)

  "write" -> do
    argument <- readInt st0 (R RDI)
    outputValue <- unboxInteger "write" argument
    writeInt (st0 { stOutput = stOutput st0 ++ [outputValue] }) (R RAX) 0

  "length" -> do
    objectAddress <- readInt st0 (R RDI)
    object <- readMem objectAddress st0
    let objectLength = case object of
          MemString characters -> length characters
          MemArray elements -> length elements
          MemSexp _ fields -> length fields
          MemClosure _ captures -> 1 + length captures
    writeInt st0 (R RAX) (boxInteger objectLength)

  ".tag" -> do
    value <- readInt st0 (R RDI)
    expectedTag <- readInt st0 (R RSI)
    encodedFieldCount <- readInt st0 (R RDX)
    fieldCount <- unboxInteger ".tag field count" encodedFieldCount
    _ <- unboxInteger ".tag tag" expectedTag
    matches <- if odd value then Right False else do
      object <- readMem value st0
      pure (case object of
        MemSexp actualTag fields -> actualTag == expectedTag && length fields == fieldCount
        _ -> False)
    writeInt st0 (R RAX) (boxInteger (if matches then 1 else 0))

  ".string" -> do
    sourceAddress <- readBuiltinArgument st0 0
    characters <- readConst cfg sourceAddress
    returnAllocated (MemString (takeWhile (/= '\0') characters)) st0

  "string" -> do
    value <- readBuiltinArgument st0 0
    characters <- renderBuiltinValue st0 [] value
    returnAllocated (MemString characters) st0

  ".elem" -> do
    objectAddress <- readInt st0 (R RDI)
    encodedIndex <- readInt st0 (R RSI)
    elementIndex <- unboxInteger ".elem" encodedIndex
    object <- readMem objectAddress st0
    value <- case object of
      MemArray elements -> indexedValue elementIndex elements
      MemSexp _ fields -> indexedValue elementIndex fields
      MemClosure codeAddress captures -> indexedValue elementIndex (codeAddress : captures)
      MemString characters -> boxInteger . ord <$> indexedValue elementIndex characters
    writeInt st0 (R RAX) value

  ".sexp" -> do
    argumentCount <- builtinArgumentCount st0
    if argumentCount < 1 then Left (RuntimeFailure ".sexp: missing tag") else do
      fields <- mapM (readBuiltinArgument st0) [0 .. argumentCount - 2]
      tag <- readBuiltinArgument st0 (argumentCount - 1)
      _ <- unboxInteger ".sexp tag" tag
      returnAllocated (MemSexp tag fields) st0

  ".array" -> do
    argumentCount <- builtinArgumentCount st0
    elements <- mapM (readBuiltinArgument st0) [0 .. argumentCount - 1]
    returnAllocated (MemArray elements) st0

  ".closure" -> do
    captureCount <- builtinArgumentCount st0
    codeAddress <- readBuiltinArgument st0 0
    captures <- mapM (readBuiltinArgument st0) [1 .. captureCount]
    returnAllocated (MemClosure codeAddress captures) st0

  ".array_patt" -> do
    value <- readInt st0 (R RDI)
    encodedLength <- readInt st0 (R RSI)
    expectedLength <- unboxInteger ".array_patt" encodedLength
    matches <- matchObject st0 value (\object -> case object of
      MemArray elements -> length elements == expectedLength
      _ -> False)
    returnBoolean matches st0

  ".string_patt" -> do
    value <- readInt st0 (R RDI)
    patternAddress <- readInt st0 (R RSI)
    patternObject <- readMem patternAddress st0
    case patternObject of
      MemString expected -> do
        matches <- matchObject st0 value (\object -> case object of
          MemString actual -> actual == expected
          _ -> False)
        returnBoolean matches st0
      _ -> Left (RuntimeFailure ".string_patt: expected string pattern")

  ".boxed_patt" -> readInt st0 (R RDI) >>= \value -> returnBoolean (even value) st0
  ".unboxed_patt" -> readInt st0 (R RDI) >>= \value -> returnBoolean (odd value) st0
  ".array_tag_patt" -> objectPattern isArray
  ".string_tag_patt" -> objectPattern isString
  ".sexp_tag_patt" -> objectPattern isSexp
  ".closure_tag_patt" -> objectPattern isClosure

  ".sta" -> do
    objectAddress <- readInt st0 (R RDI)
    encodedIndex <- readInt st0 (R RSI)
    newValue <- readInt st0 (R RDX)
    elementIndex <- unboxInteger ".sta" encodedIndex
    object <- readMem objectAddress st0
    updatedObject <- case object of
      MemArray elements -> MemArray <$> replaceElement elementIndex newValue elements
      MemSexp tag fields -> MemSexp tag <$> replaceElement elementIndex newValue fields
      MemString characters -> do
        characterCode <- unboxInteger ".sta character" newValue
        MemString <$> replaceElement elementIndex (chr (characterCode .&. 255)) characters
      _ -> Left (RuntimeFailure ".sta: expected array, S-expression or string")
    updatedState <- writeMem objectAddress updatedObject st0
    writeInt updatedState (R RAX) newValue

  "failure" -> do
    messageAddress <- readInt st0 (R RDI)
    message <- case M.lookup messageAddress (cfgStrings cfg) of
      Just characters -> Right characters
      Nothing -> do
        object <- readMem messageAddress st0
        case object of
          MemString characters -> Right characters
          _ -> Left (RuntimeFailure "failure: expected message string")
    Left (RuntimeFailure message)

  ".match_failure" -> Left MatchFailure

  _ | name `elem` noOpBuiltins -> Right st0
    | otherwise -> Left (UnknownBuiltin name)
  where
    objectPattern :: (MemObject -> Bool) -> Interp State
    objectPattern predicate = do
      value <- readInt st0 (R RDI)
      matches <- matchObject st0 value predicate
      returnBoolean matches st0

    isArray :: MemObject -> Bool
    isArray (MemArray _) = True
    isArray _ = False

    isString :: MemObject -> Bool
    isString (MemString _) = True
    isString _ = False

    isSexp :: MemObject -> Bool
    isSexp (MemSexp _ _) = True
    isSexp _ = False

    isClosure :: MemObject -> Bool
    isClosure (MemClosure _ _) = True
    isClosure _ = False

readBuiltinArgument :: State -> Int -> Interp Int
readBuiltinArgument state argumentIndex = do
  argumentsAddress <- readInt state (R RDI)
  let slotAddress = argumentsAddress + argumentIndex * 8
  maybe (Left StackUnderflow) Right (M.lookup slotAddress (stkCells (stStack state)))

builtinArgumentCount :: State -> Interp Int
builtinArgumentCount state = do
  encodedCount <- readInt state (R RSI)
  argumentCount <- unboxInteger "builtin argument count" encodedCount
  if argumentCount < 0 then Left (RuntimeFailure "negative builtin argument count")
    else Right argumentCount

returnAllocated :: MemObject -> State -> Interp State
returnAllocated object state =
  let (objectAddress, allocatedState) = alloc object state
  in writeInt allocatedState (R RAX) objectAddress

returnBoolean :: Bool -> State -> Interp State
returnBoolean value state = writeInt state (R RAX) (boxInteger (if value then 1 else 0))

matchObject :: State -> Int -> (MemObject -> Bool) -> Interp Bool
matchObject state value predicate
  | odd value = Right False
  | otherwise = predicate <$> readMem value state

indexedValue :: Int -> [value] -> Interp value
indexedValue elementIndex elements
  | elementIndex < 0 = Left (InvalidElement elementIndex (length elements))
  | otherwise = case drop elementIndex elements of
      value : _ -> Right value
      [] -> Left (InvalidElement elementIndex (length elements))

replaceElement :: Int -> value -> [value] -> Interp [value]
replaceElement elementIndex newValue elements
  | elementIndex < 0 = Left (InvalidElement elementIndex (length elements))
  | otherwise = case splitAt elementIndex elements of
      (prefix, _ : suffix) -> Right (prefix ++ newValue : suffix)
      _ -> Left (InvalidElement elementIndex (length elements))

renderBuiltinValue :: State -> [Int] -> Int -> Interp String
renderBuiltinValue state visited value
  | odd value = show <$> unboxInteger "string" value
  | value `elem` visited = Left (RuntimeFailure "string: cyclic object")
  | otherwise = do
      object <- readMem value state
      let ancestors = value : visited
      case object of
        MemString characters -> Right ("\"" ++ characters ++ "\"")
        MemArray elements -> do
          rendered <- mapM (renderBuiltinValue state ancestors) elements
          Right ("[" ++ intercalate ", " rendered ++ "]")
        MemClosure codeAddress captures -> do
          rendered <- mapM (renderBuiltinValue state ancestors) captures
          Right ("<closure " ++ intercalate ", " (("0x" ++ showHex (fromIntegral codeAddress :: Word) "") : rendered) ++ ">")
        MemSexp encodedTag fields -> do
          tag <- unboxInteger "string tag" encodedTag
          let tagName = decodeTagName tag
          if tagName == "cons" then do
            rendered <- renderListFields state ancestors fields
            Right ("{" ++ intercalate ", " rendered ++ "}")
          else do
            rendered <- mapM (renderBuiltinValue state ancestors) fields
            Right (tagName ++ if null fields then "" else " (" ++ intercalate ", " rendered ++ ")")

renderListFields :: State -> [Int] -> [Int] -> Interp [String]
renderListFields _ _ [] = Right []
renderListFields state visited [firstValue, remainingList] = do
  firstText <- renderBuiltinValue state visited firstValue
  if odd remainingList then Right [firstText]
    else if remainingList `elem` visited then Left (RuntimeFailure "string: cyclic list")
    else do
      object <- readMem remainingList state
      case object of
        MemSexp _ fields -> (firstText :) <$> renderListFields state (remainingList : visited) fields
        _ -> Left (RuntimeFailure "string: invalid list tail")
renderListFields _ _ _ = Left (RuntimeFailure "string: invalid cons fields")

decodeTagName :: Int -> String
decodeTagName tag = decodeDigits (fromIntegral tag :: Word) []
  where
    alphabet :: String
    alphabet = "_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'"

    decodeDigits :: Word -> String -> String
    decodeDigits 0 characters = characters
    decodeDigits remainingTag characters =
      case drop (fromIntegral (remainingTag .&. 63)) alphabet of
        character : _ -> decodeDigits (remainingTag `shiftR` 6) (character : characters)
        [] -> characters

indirectTargetAddress :: State -> Opnd -> Interp Int
indirectTargetAddress state operand = do
  operandValue <- readInt state operand
  pure (case M.lookup operandValue (stMem state) of
    Just (MemClosure codeAddress _) -> codeAddress
    _ -> operandValue)

builtinAtAddress :: ProgConfig -> Int -> Maybe String
builtinAtAddress config targetAddress = do
  labelName <- M.lookup targetAddress (cfgLabels config)
  lookup labelName builtinSymbols

jumpToAddress :: ProgConfig -> State -> Int -> Interp (State, [ExtInst])
jumpToAddress config state targetAddress =
  case builtinAtAddress config targetAddress of
    Just builtinName -> do
      returnedState <- dispatchBuiltin config builtinName state
      (returnAddress, callerState) <- stackPop returnedState
      continuation <- lookupOff config returnAddress
      Right (callerState, continuation)
    Nothing -> do
      target <- lookupOff config targetAddress
      Right (state, target)

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
      "-"    -> writeInt st0 b (vb - va)     >>= \s -> Right (s, is)
      "*"    -> writeInt st0 b (va * vb)     >>= \s -> Right (s, is)
      "&&"   -> writeInt (st0 { stFlags = flagsFromLogic (va .&. vb) }) b (va .&. vb)   >>= \s -> Right (s, is)
      "!!"   -> writeInt (st0 { stFlags = flagsFromLogic (va .|. vb) }) b (va .|. vb)   >>= \s -> Right (s, is)
      "^"    -> writeInt (st0 { stFlags = flagsFromLogic (va `xor` vb) }) b (va `xor` vb) >>= \s -> Right (s, is)
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

  CallI operand -> do
    targetAddress <- indirectTargetAddress st0 operand
    case builtinAtAddress cfg targetAddress of
      Just builtinName -> do
        returnedState <- dispatchBuiltin cfg builtinName st0
        Right (returnedState, is)
      Nothing -> do
        target <- lookupOff cfg targetAddress
        let returnAddress = length (cfgProgram cfg) - length is
        Right (stackPush returnAddress st0, target)

  Ret -> do
    (off, st') <- stackPop st0
    target <- lookupOff cfg off
    Right (st', target)

  CJmp suf off ->
    if evalCond suf (stFlags st0)
      then do target <- lookupOff cfg off
              Right (st0, target)
      else Right (st0, is)

  Jmp targetAddress -> jumpToAddress cfg st0 targetAddress

  JmpI operand -> do
    targetAddress <- indirectTargetAddress st0 operand
    jumpToAddress cfg st0 targetAddress

  Dec op -> do
    v <- readInt st0 op
    writeInt st0 op (v - 1) >>= \s -> Right (s, is)

  Or1 op -> do
    v <- readInt st0 op
    writeInt (st0 { stFlags = flagsFromLogic (v .|. 1) }) op (v .|. 1) >>= \s -> Right (s, is)

  Sal1 op -> do
    v <- readInt st0 op
    writeInt st0 op (v `shiftL` 1) >>= \s -> Right (s, is)

  Sar1 op -> do
    v <- readInt st0 op
    writeInt st0 op (v `shiftR` 1) >>= \s -> Right (s, is)

  Repmovsl -> do
    filledState <- fillStackFromFiller cfg st0
    Right (filledState, is)

step _ _ [] = Left (InvalidMemoryAddress (-1))

fillStackFromFiller :: ProgConfig -> State -> Interp State
fillStackFromFiller config state = do
  wordCount <- readInt state (R RCX)
  sourceAddress <- readInt state (R RSI)
  destinationAddress <- readInt state (R RDI)
  if wordCount < 0 then Left (RuntimeFailure "Repmovsl: negative word count")
    else if wordCount == 0 then Right state
    else if M.lookup sourceAddress (cfgLabels config) /= Just "filler"
      then Left (RuntimeFailure "Repmovsl: expected filler source")
    else do
      fillerValue <- readInt state (IRIP sourceAddress)
      let filledCells = foldl' (\cells wordIndex ->
            M.insert (destinationAddress + wordIndex * 8) fillerValue cells)
            (stkCells (stStack state)) [0 .. wordCount - 1]
          updatedRegisters = M.insert RCX 0
            (M.insert RSI (sourceAddress + wordCount * 8)
              (M.insert RDI (destinationAddress + wordCount * 8) (stRegs state)))
      Right state { stStack = Stack filledCells, stRegs = updatedRegisters }

runInterp :: ProgConfig -> Machine -> Interp State
runInterp _   (Machine [] st) = Right st
runInterp cfg (Machine rest st) = do
  -- traceM ("X86 TRACE next=" ++ show (take 1 rest) ++ " regs=" ++ show (stRegs st) ++ " stack=" ++ show (stStack st) ++ " globals=" ++ show (stGlob st) ++ " flags=" ++ show (stFlags st) ++ " heap=" ++ show (stMem st) ++ " output=" ++ show (stOutput st)) -- DEBUG
  (st', rest') <- step cfg st rest
  runInterp cfg (Machine rest' st')
{-# LANGUAGE LambdaCase #-}

module StackMachine where

-- import Debug.Trace (traceM) -- DEBUG: instruction-level tracing.

import qualified Data.Map.Strict     as M
import qualified Data.IntMap.Strict  as IM
import Data.List (intercalate)

data Patt = StrCmp | PString | PArray | PSexp | Boxed | UnBoxed | PClosure
  deriving (Show, Eq)

data Designation
  = DGlobal String
  | DLocal  Int
  | DArg    Int
  | DAccess Int
  deriving (Show, Eq)

data Value
  = VInt Integer
  | VString Int
  | VArray  Int
  | VSexp   String Int
  | VClosure Int Int
  | VBuiltin String
  | VEmpty
  deriving (Show, Eq)

data Insn
  = BINOP String
  | CONST Integer
  | STRING String
  | SEXP String Int
  | LD Designation
  | ST Designation
  | STA
  | ELEM
  | JMP Int
  | CJMP String Int
  | BEGIN Int Int
  | END
  | CLOSURE Int [Designation]
  | CALLC Int
  | CALL Int Int
  | BUILTIN String Int
  | CALL_TAIL Int Int
  | CALLC_TAIL Int
  | BUILTIN_TAIL String Int
  | RET
  | DROP
  | DUP
  | SWAP
  | TAG String Int
  | ARRAY Int
  | PATT Patt
  | FAIL (Int, Int)
  | LINE Int
  deriving (Show, Eq)

data Prog = Prog
  { programInstructions :: IM.IntMap Insn
  , programEntry :: Int
  , programFunctionNames :: IM.IntMap String
  } deriving (Show, Eq)

data Loc = Loc
  { locArgs    :: IM.IntMap Value
  , locLocals  :: IM.IntMap Value
  , locClosure :: Maybe Int
  } deriving Show

emptyLoc :: Loc
emptyLoc = Loc IM.empty IM.empty Nothing

type Store = IM.IntMap [Value]

data Config = Config
  { cstack :: [(Int, Loc, [Value])]
  , stk    :: [Value]
  , glob   :: M.Map String Value
  , loc    :: Loc
  , inp    :: [Int]
  , out    :: [Int]
  , store  :: Store
  , nextId :: Int
  } deriving Show
-- TODO: inefficiency
initialConfig :: [Int] -> Config
initialConfig i = Config
  { cstack = []
  , stk    = []
  , glob   = M.empty
  , loc    = emptyLoc
  , inp    = i
  , out    = []
  , store  = IM.empty
  , nextId = 0
  }

initialState :: Prog -> [Int] -> SM Config
initialState program inputs = case IM.lookup (programEntry program) (programInstructions program) of
  Just (BEGIN _ _) -> Right (initialConfig inputs)
  _ -> throwSM "main does not point to BEGIN"

finished :: Prog -> Int -> Bool
finished program instructionAddress = instructionAddress == IM.size (programInstructions program)

currentInstruction :: Prog -> Int -> SM Insn
currentInstruction program instructionAddress = case IM.lookup instructionAddress (programInstructions program) of
  Just instruction -> Right instruction
  Nothing -> throwSM ("Invalid instruction address: " ++ show instructionAddress)

type SM = Either String

throwSM :: String -> SM a
throwSM = Left

b2i :: Bool -> Integer
b2i True  = 1
b2i False = 0

toInt :: Value -> SM Integer
toInt (VInt n) = pure n
toInt v        = throwSM ("expected int, got " ++ show v)

splitStack :: Int -> [Value] -> SM ([Value], [Value])
splitStack n xs =
  let (taken, rest) = splitAt n xs
  in if length taken == n
       then pure (taken, rest)
       else throwSM ("stack underflow: need " ++ show n
                     ++ " values, have " ++ show (length xs))

safeIndex :: [a] -> Int -> String -> SM a
safeIndex xs i what
  | i < 0 || i >= length xs = throwSM (what ++ ": index out of bounds: " ++ show i)
  | otherwise               = pure (xs !! i)

sameValue :: Value -> Value -> Bool
sameValue (VInt leftNumber) (VInt rightNumber) = leftNumber == rightNumber
sameValue (VString leftId) (VString rightId) = leftId == rightId
sameValue (VArray leftId) (VArray rightId) = leftId == rightId
sameValue (VSexp _ leftId) (VSexp _ rightId) = leftId == rightId
sameValue (VClosure _ leftId) (VClosure _ rightId) = leftId == rightId
sameValue (VBuiltin leftName) (VBuiltin rightName) = leftName == rightName
sameValue VEmpty VEmpty = True
sameValue _ _ = False

binopFunc :: String -> Integer -> Integer -> SM Integer
binopFunc "+"  a b = pure (a + b)
binopFunc "-"  a b = pure (a - b)
binopFunc "*"  a b = pure (a * b)
binopFunc "/"  a b
  | b == 0    = throwSM "division by zero"
  | otherwise = pure (a `quot` b)
binopFunc "%"  a b
  | b == 0    = throwSM "modulo by zero"
  | otherwise = pure (a `rem` b)
binopFunc "<"  a b = pure (b2i (a <  b))
binopFunc "<=" a b = pure (b2i (a <= b))
binopFunc ">"  a b = pure (b2i (a >  b))
binopFunc ">=" a b = pure (b2i (a >= b))
binopFunc "==" a b = pure (b2i (a == b))
binopFunc "!=" a b = pure (b2i (a /= b))
binopFunc "&&" a b = pure (b2i (a /= 0 && b /= 0))
binopFunc "!!" a b = pure (b2i (a /= 0 || b /= 0))
binopFunc op _ _   = throwSM ("unknown binary operator: " ++ op)

lookupDesignation :: Config -> Designation -> SM Value
lookupDesignation state designation = case designation of
  DGlobal name -> maybe (throwSM ("unbound global: " ++ name)) pure (M.lookup name (glob state))
  DLocal index -> maybe (throwSM ("unbound local: " ++ show index)) pure (IM.lookup index (locLocals (loc state)))
  DArg index -> maybe (throwSM ("unbound argument: " ++ show index)) pure (IM.lookup index (locArgs (loc state)))
  DAccess index -> do
    objectId <- currentClosureId state
    capturedValues <- lookupStore objectId state
    safeIndex capturedValues index "closure access"

currentClosureId :: Config -> SM Int
currentClosureId state = maybe (throwSM "no active closure") pure (locClosure (loc state))

updateDesignation :: Config -> Value -> Designation -> SM Config
updateDesignation state value designation = case designation of
  DGlobal name -> pure state { glob = M.insert name value (glob state) }
  DLocal index -> pure state { loc = (loc state) { locLocals = IM.insert index value (locLocals (loc state)) } }
  DArg index -> pure state { loc = (loc state) { locArgs = IM.insert index value (locArgs (loc state)) } }
  DAccess index -> do
    objectId <- currentClosureId state
    capturedValues <- lookupStore objectId state
    updatedValues <- replaceAtSM index value capturedValues
    updateStore objectId updatedValues state

allocStore :: [Value] -> Config -> (Int, Config)
allocStore vs c =
  let i = nextId c
  in (i, c { nextId = i + 1
           , store  = IM.insert i vs (store c) })

lookupStore :: Int -> Config -> SM [Value]
lookupStore i c = case IM.lookup i (store c) of
  Just vs -> pure vs
  Nothing -> throwSM ("store: missing id " ++ show i)

updateStore :: Int -> [Value] -> Config -> SM Config
updateStore i vs c
  | IM.member i (store c) = pure c { store = IM.insert i vs (store c) }
  | otherwise             = throwSM ("store: missing id " ++ show i)

replaceAtSM :: Int -> a -> [a] -> SM [a]
replaceAtSM i x xs
  | i < 0 || i >= length xs = throwSM ("replaceAt: index out of bounds " ++ show i)
  | otherwise               = pure (take i xs ++ [x] ++ drop (i + 1) xs)

showValue :: Prog -> Config -> Value -> String
showValue program s (VInt n) = show n
showValue program s (VString i) = case IM.lookup i (store s) of
  Nothing -> "<string#?>"
  Just vs -> "\"" ++ concatMap renderChar vs ++ "\""
  where
    renderChar :: Value -> String
    renderChar (VInt c) = [toEnum (fromIntegral c)]
    renderChar _ = "?"
showValue program state (VArray objectId) = case IM.lookup objectId (store state) of
  Nothing -> "<array#?>"
  Just elements -> "[" ++ intercalate ", " (map (showValue program state) elements) ++ "]"
showValue program state (VSexp tag objectId) = case IM.lookup objectId (store state) of
  Nothing -> "<" ++ tag ++ "#?>"
  Just [] -> tag
  Just fields -> tag ++ " (" ++ intercalate ", " (map (showValue program state) fields) ++ ")"
showValue program state (VClosure entryAddress _) =
  "<closure " ++ IM.findWithDefault (show entryAddress) entryAddress (programFunctionNames program) ++ ">"
showValue program _ (VBuiltin n) = "<builtin " ++ n ++ ">"
showValue program s VEmpty = "<empty>"

builtin :: Prog -> String -> [Value] -> Config -> SM Config
builtin program "read" _ c = case inp c of
  (x:xs) -> pure c { inp = xs, stk = VInt (fromIntegral x) : stk c }
  []     -> throwSM "read: no input available"

builtin program "write" [VInt n] c = pure c { out = out c ++ [fromIntegral n], stk = VEmpty : stk c }
builtin program "write" args _     = throwSM ("write: bad args " ++ show args)

builtin program "length" [VString i] c = do
  vs <- lookupStore i c
  pure c { stk = VInt (fromIntegral (length vs)) : stk c }
builtin program "length" [VArray i] c = do
  vs <- lookupStore i c
  pure c { stk = VInt (fromIntegral (length vs)) : stk c }
builtin program "length" [VSexp _ i] c = do
  vs <- lookupStore i c
  pure c { stk = VInt (fromIntegral (length vs)) : stk c }
builtin program "length" args _ = throwSM ("length: bad args " ++ show args)

builtin program "string" [v] c = do
  let str = showValue program c v
      vs  = map (VInt . fromIntegral . fromEnum) str
      (i, c') = allocStore vs c
  pure c' { stk = VString i : stk c }
builtin program "string" args _ = throwSM ("string: bad args " ++ show args)

builtin program ".array" elements config =
  let (arrayId, allocatedConfig) = allocStore elements config
  in pure allocatedConfig { stk = VArray arrayId : stk allocatedConfig }

builtin program name _ _ = throwSM ("unknown builtin: " ++ name)

step :: Prog -> Config -> Int -> SM (Config, Int)
step program state instructionAddress
  | finished program instructionAddress = Right (state, instructionAddress)
  | otherwise = do
      instruction <- currentInstruction program instructionAddress
      executeInstruction program state instruction (instructionAddress + 1)

executeInstruction :: Prog -> Config -> Insn -> Int -> SM (Config, Int)
executeInstruction program conf insn nextAddress = case insn of

  LINE _  -> pure (conf, nextAddress)

  CONST n -> pure (conf { stk = VInt n : stk conf }, nextAddress)

  STRING s -> do
    let vs = map (VInt . fromIntegral . fromEnum) s
        (i, conf') = allocStore vs conf
    pure (conf' { stk = VString i : stk conf }, nextAddress)

  SEXP tag n -> do
    (vs, rest') <- splitStack n (stk conf)
    let (i, conf') = allocStore (reverse vs) conf
    pure (conf' { stk = VSexp tag i : rest' }, nextAddress)

  BINOP "==" -> case stk conf of
    (rightValue : leftValue : remainingStack) ->
      pure (conf { stk = VInt (b2i (sameValue leftValue rightValue)) : remainingStack }, nextAddress)
    _ -> throwSM "BINOP ==: stack underflow"

  BINOP op -> case stk conf of
    (y : x : rest') -> do
      a <- toInt x
      b <- toInt y
      z <- binopFunc op a b
      pure (conf { stk = VInt z : rest' }, nextAddress)
    _ -> throwSM ("BINOP " ++ op ++ ": stack underflow")

  ELEM -> case stk conf of
    (indexValue : container : remainingStack) -> do
      elementIndex <- toInt indexValue
      elements <- case container of
        VArray objectId -> lookupStore objectId conf
        VString objectId -> lookupStore objectId conf
        VSexp _ objectId -> lookupStore objectId conf
        _ -> throwSM ("ELEM: not a container: " ++ show container)
      if elementIndex < 0 || elementIndex > toInteger (maxBound :: Int)
        then throwSM ("ELEM: index out of bounds: " ++ show elementIndex)
        else do
          element <- safeIndex elements (fromInteger elementIndex) "ELEM"
          pure (conf { stk = element : remainingStack }, nextAddress)
    _ -> throwSM "ELEM: stack underflow"

  LD x -> do
    v <- lookupDesignation conf x
    pure (conf { stk = v : stk conf }, nextAddress)

  ST x -> case stk conf of
    (z : rest') -> do
      updatedState <- updateDesignation conf z x
      pure (updatedState, nextAddress)
    _ -> throwSM "ST: stack underflow"

  STA -> case stk conf of
    (z : j : rest') -> case j of
      VInt _ -> case rest' of
        (container : rest'') -> do
          i <- fromIntegral <$> toInt j
          conf' <- case container of
            VArray id -> do
              vs  <- lookupStore id conf
              vs' <- replaceAtSM i z vs
              updateStore id vs' conf
            VString id -> do
              n   <- toInt z
              vs  <- lookupStore id conf
              vs' <- replaceAtSM i (VInt n) vs
              updateStore id vs' conf
            VSexp _ id -> do
              vs  <- lookupStore id conf
              vs' <- replaceAtSM i z vs
              updateStore id vs' conf
            _ -> throwSM ("STA: not a container: " ++ show container)
          pure (conf' { stk = z : rest'' }, nextAddress)
        _ -> throwSM "STA: stack underflow"
      _ -> throwSM "STA: bad stack shape"
    _ -> throwSM "STA: stack underflow"

  JMP l -> do
    p <- jumpTo program l
    pure (conf, p)

  CJMP c l -> case stk conf of
    (x : rest') -> do
      n <- toInt x
      let take_ = (c == "z" && n == 0) || (c == "nz" && n /= 0)
      if take_
        then do
          p <- jumpTo program l
          pure (conf { stk = rest' }, p)
        else
          pure (conf { stk = rest' }, nextAddress)
    _ -> throwSM "CJMP: stack underflow"

  CLOSURE name dgs -> do
    cl <- mapM (capture conf) dgs
    let (ident, conf') = allocStore cl conf
    pure (conf' { stk = VClosure name ident : stk conf }, nextAddress)

  CALL f n -> do
    (args, rest') <- splitStack n (stk conf)
    body <- jumpTo program f
    let argsMap = IM.fromList (zip [0..] (reverse args))
    let newLoc = Loc { locArgs = argsMap
                     , locLocals = IM.empty
                     , locClosure = Nothing }
    pure (conf { cstack = (nextAddress, loc conf, rest') : cstack conf
               , stk = rest'
               , loc = newLoc }, body)

  BUILTIN functionName argumentCount -> do
    (arguments, callerStack) <- splitStack argumentCount (stk conf)
    returnedState <- builtin program functionName (reverse arguments) (conf { stk = callerStack })
    pure (returnedState, nextAddress)

  CALLC n -> do
    (vs, rest') <- splitStack (n + 1) (stk conf)
    case reverse vs of
      (VClosure name ident : args) -> do
        _ <- lookupStore ident conf
        let argsMap = IM.fromList (zip [0..] args)
        let newLoc = Loc { locArgs = argsMap
                         , locLocals = IM.empty
                         , locClosure = Just ident }
        p <- jumpTo program name
        pure (conf { cstack = (nextAddress, loc conf, rest') : cstack conf
                   , stk = rest'
                   , loc = newLoc }, p)
      (VBuiltin name : args) -> do
        c <- builtin program name args (conf { stk = rest' })
        pure (c, nextAddress)
      (f : _) -> throwSM ("CALLC: not callable: " ++ show f)
      [] -> throwSM "CALLC: empty stack"

  CALL_TAIL f n -> do
    (args, rest') <- splitStack n (stk conf)
    body <- jumpTo program f
    let argsMap = IM.fromList (zip [0..] (reverse args))
    let newLoc = Loc { locArgs = argsMap
                     , locLocals = IM.empty
                     , locClosure = Nothing }
    pure (conf { stk = rest', loc = newLoc }, body)

  CALLC_TAIL n -> do
    (vs, rest') <- splitStack (n + 1) (stk conf)
    case reverse vs of
      (VClosure name ident : args) -> do
        _ <- lookupStore ident conf
        let argsMap = IM.fromList (zip [0..] args)
        let newLoc = Loc { locArgs = argsMap
                         , locLocals = IM.empty
                         , locClosure = Just ident }
        p <- jumpTo program name
        pure (conf { stk = rest', loc = newLoc }, p)
      (VBuiltin name : args) -> do
        (returnedState, returnAddress) <- returnFromCall program (conf { stk = rest' })
        c <- builtin program name args returnedState
        pure (c, returnAddress)
      (f : _) -> throwSM ("CALLC_TAIL: not callable: " ++ show f)
      [] -> throwSM "CALLC_TAIL: empty stack"

  BUILTIN_TAIL functionName argumentCount -> do
    (arguments, callerStack) <- splitStack argumentCount (stk conf)
    (returnedState, returnAddress) <- returnFromCall program (conf { stk = callerStack })
    calledState <- builtin program functionName (reverse arguments) returnedState
    pure (calledState, returnAddress)

  BEGIN _ nlocals -> do
    let localsMap = IM.fromList (zip [0..] (replicate nlocals VEmpty))
    pure (conf { loc = (loc conf) { locLocals = localsMap } }, nextAddress)

  END -> returnFromCall program conf
  RET -> returnFromCall program conf

  DROP -> case stk conf of
    (_ : rest') -> pure (conf { stk = rest' }, nextAddress)
    _           -> throwSM "DROP: stack underflow"

  DUP -> case stk conf of
    (x : _) -> pure (conf { stk = x : stk conf }, nextAddress)
    _       -> throwSM "DUP: stack underflow"

  SWAP -> case stk conf of
    (x : y : rest') -> pure (conf { stk = y : x : rest' }, nextAddress)
    _               -> throwSM "SWAP: stack underflow"

  TAG t n -> case stk conf of
    (x : rest') -> do
      v <- case x of
             VSexp t' id | t' == t -> do
               vs <- lookupStore id conf
               pure (b2i (length vs == n))
             _ -> pure 0
      pure (conf { stk = VInt v : rest' }, nextAddress)
    _ -> throwSM "TAG: stack underflow"

  ARRAY n -> case stk conf of
    (x : rest') -> do
      v <- case x of
             VArray id -> do
               vs <- lookupStore id conf
               pure (b2i (length vs == n))
             _ -> pure 0
      pure (conf { stk = VInt v : rest' }, nextAddress)
    _ -> throwSM "ARRAY: stack underflow"

  PATT p -> case p of
    StrCmp -> case stk conf of
      (x : y : rest') -> do
        eq <- case (x, y) of
                (VString i1, VString i2) -> do
                  vs1 <- lookupStore i1 conf
                  vs2 <- lookupStore i2 conf
                  pure (vs1 == vs2)
                _ -> pure False
        pure (conf { stk = VInt (b2i eq) : rest' }, nextAddress)
      _ -> throwSM "PATT StrCmp: stack underflow"
    PArray -> case stk conf of
      (x : rest') ->
        let v = case x of VArray _ -> 1; _ -> 0
        in pure (conf { stk = VInt v : rest' }, nextAddress)
      _ -> throwSM "PATT Array: stack underflow"
    PString -> case stk conf of
      (x : rest') ->
        let v = case x of VString _ -> 1; _ -> 0
        in pure (conf { stk = VInt v : rest' }, nextAddress)
      _ -> throwSM "PATT String: stack underflow"
    PSexp -> case stk conf of
      (x : rest') ->
        let v = case x of VSexp _ _ -> 1; _ -> 0
        in pure (conf { stk = VInt v : rest' }, nextAddress)
      _ -> throwSM "PATT Sexp: stack underflow"
    Boxed -> case stk conf of
      (x : rest') ->
        let v = case x of VInt _ -> 0; _ -> 1
        in pure (conf { stk = VInt v : rest' }, nextAddress)
      _ -> throwSM "PATT Boxed: stack underflow"
    UnBoxed -> case stk conf of
      (x : rest') ->
        let v = case x of VInt _ -> 1; _ -> 0
        in pure (conf { stk = VInt v : rest' }, nextAddress)
      _ -> throwSM "PATT UnBoxed: stack underflow"
    PClosure -> case stk conf of
      (x : rest') ->
        let v = case x of VClosure{} -> 1; _ -> 0
        in pure (conf { stk = VInt v : rest' }, nextAddress)
      _ -> throwSM "PATT Closure: stack underflow"

  FAIL l -> case stk conf of
    (x : _) -> throwSM ("matching value " ++ showValue program conf x
                        ++ " failed at " ++ show l)
    _       -> throwSM "FAIL: empty stack"

returnFromCall :: Prog -> Config -> SM (Config, Int)
returnFromCall program state = case cstack state of
  (returnAddress, callerLocals, _) : remainingFrames ->
    pure (state { cstack = remainingFrames, loc = callerLocals }, returnAddress)
  [] -> pure (state, IM.size (programInstructions program))

jumpTo :: Prog -> Int -> SM Int
jumpTo program targetAddress
  | IM.member targetAddress (programInstructions program) = Right targetAddress
  | otherwise = throwSM ("Invalid instruction address: " ++ show targetAddress)

capture :: Config -> Designation -> SM Value
capture state designation = case designation of
  DGlobal _ -> throwSM "CLOSURE: bad designation"
  _ -> lookupDesignation state designation

eval :: Prog -> Config -> Int -> SM Config
eval program state instructionAddress
  | finished program instructionAddress = pure state
  | otherwise = do
      -- traceM ("SM TRACE next=" ++ show (currentInstruction program instructionAddress) ++ " state=" ++ show state) -- DEBUG
      (nextState, nextAddress) <- step program state instructionAddress
      eval program nextState nextAddress

run :: Prog -> [Int] -> Either String [Int]
run program inputs = out <$> runConfig program inputs

runConfig :: Prog -> [Int] -> Either String Config
runConfig program inputs = do
  entryState <- initialState program inputs
  eval program entryState (programEntry program)

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
  | VClosure String Int
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
  | LABEL String
  | JMP String
  | CJMP String String
  | BEGIN String Int Int
  | END
  | CLOSURE String [Designation]
  | CALLC Int
  | CALL String Int
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

type Prog = [Insn]

data Loc = Loc
  { locArgs    :: IM.IntMap Value
  , locLocals  :: IM.IntMap Value
  , locClosure :: Maybe Int
  } deriving Show

emptyLoc :: Loc
emptyLoc = Loc IM.empty IM.empty Nothing

type Store = IM.IntMap [Value]

data Config = Config
  { cstack :: [(Prog, Loc, [Value])]
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

type LabelEnv = M.Map String Prog

collectLabels :: Prog -> LabelEnv
collectLabels []                = M.empty
collectLabels (LABEL l : rest) = M.insert l rest (collectLabels rest)
collectLabels (_       : rest) = collectLabels rest

initialEnv :: Prog -> LabelEnv
initialEnv = collectLabels

initialState :: Prog -> [Int] -> (LabelEnv, Config)
initialState p i = (collectLabels p, initialConfig i)

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

showValue :: Store -> Value -> String
showValue s (VInt n)    = show n
showValue s (VString i) = case IM.lookup i s of
  Nothing -> "<string#?>"
  Just vs -> "\"" ++ concatMap renderChar vs ++ "\""
  where renderChar (VInt c) = [toEnum (fromIntegral c)]
        renderChar _        = "?"
showValue valueStore (VArray objectId) = case IM.lookup objectId valueStore of
  Nothing -> "<array#?>"
  Just elements -> "[" ++ intercalate ", " (map (showValue valueStore) elements) ++ "]"
showValue valueStore (VSexp tag objectId) = case IM.lookup objectId valueStore of
  Nothing -> "<" ++ tag ++ "#?>"
  Just [] -> tag
  Just fields -> tag ++ " (" ++ intercalate ", " (map (showValue valueStore) fields) ++ ")"
showValue s (VClosure n _) = "<closure " ++ n ++ ">"
showValue _ (VBuiltin n)   = "<builtin " ++ n ++ ">"
showValue s VEmpty         = "<empty>"

builtin :: String -> [Value] -> Config -> SM Config
builtin "read" _ c = case inp c of
  (x:xs) -> pure c { inp = xs, stk = VInt (fromIntegral x) : stk c }
  []     -> throwSM "read: no input available"

builtin "write" [VInt n] c = pure c { out = out c ++ [fromIntegral n], stk = VEmpty : stk c }
builtin "write" args _     = throwSM ("write: bad args " ++ show args)

builtin "length" [VString i] c = do
  vs <- lookupStore i c
  pure c { stk = VInt (fromIntegral (length vs)) : stk c }
builtin "length" [VArray i] c = do
  vs <- lookupStore i c
  pure c { stk = VInt (fromIntegral (length vs)) : stk c }
builtin "length" [VSexp _ i] c = do
  vs <- lookupStore i c
  pure c { stk = VInt (fromIntegral (length vs)) : stk c }
builtin "length" args _ = throwSM ("length: bad args " ++ show args)

builtin "string" [v] c = do
  let str = showValue (store c) v
      vs  = map (VInt . fromIntegral . fromEnum) str
      (i, c') = allocStore vs c
  pure c' { stk = VString i : stk c }
builtin "string" args _ = throwSM ("string: bad args " ++ show args)

builtin ".array" elements config =
  let (arrayId, allocatedConfig) = allocStore elements config
  in pure allocatedConfig { stk = VArray arrayId : stk allocatedConfig }

builtin name _ _ = throwSM ("unknown builtin: " ++ name)

step :: LabelEnv -> Config -> Prog -> SM (Config, Prog)
step _   conf [] = pure (conf, [])
step env conf (insn : rest) = case insn of

  LINE _  -> pure (conf, rest)
  LABEL _ -> pure (conf, rest)

  CONST n -> pure (conf { stk = VInt n : stk conf }, rest)

  STRING s -> do
    let vs = map (VInt . fromIntegral . fromEnum) s
        (i, conf') = allocStore vs conf
    pure (conf' { stk = VString i : stk conf }, rest)

  SEXP tag n -> do
    (vs, rest') <- splitStack n (stk conf)
    let (i, conf') = allocStore (reverse vs) conf
    pure (conf' { stk = VSexp tag i : rest' }, rest)

  BINOP "==" -> case stk conf of
    (rightValue : leftValue : remainingStack) ->
      pure (conf { stk = VInt (b2i (sameValue leftValue rightValue)) : remainingStack }, rest)
    _ -> throwSM "BINOP ==: stack underflow"

  BINOP op -> case stk conf of
    (y : x : rest') -> do
      a <- toInt x
      b <- toInt y
      z <- binopFunc op a b
      pure (conf { stk = VInt z : rest' }, rest)
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
          pure (conf { stk = element : remainingStack }, rest)
    _ -> throwSM "ELEM: stack underflow"

  LD x -> do
    v <- lookupDesignation conf x
    pure (conf { stk = v : stk conf }, rest)

  ST x -> case stk conf of
    (z : rest') -> do
      updatedState <- updateDesignation conf z x
      pure (updatedState, rest)
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
          pure (conf' { stk = z : rest'' }, rest)
        _ -> throwSM "STA: stack underflow"
      _ -> throwSM "STA: bad stack shape"
    _ -> throwSM "STA: stack underflow"

  JMP l -> do
    p <- jumpTo env l
    pure (conf, p)

  CJMP c l -> case stk conf of
    (x : rest') -> do
      n <- toInt x
      let take_ = (c == "z" && n == 0) || (c == "nz" && n /= 0)
      if take_
        then do
          p <- jumpTo env l
          pure (conf { stk = rest' }, p)
        else
          pure (conf { stk = rest' }, rest)
    _ -> throwSM "CJMP: stack underflow"

  CLOSURE name dgs -> do
    cl <- mapM (capture conf) dgs
    let (ident, conf') = allocStore cl conf
    pure (conf' { stk = VClosure name ident : stk conf }, rest)

  CALL f n -> do
    (args, rest') <- splitStack n (stk conf)
    case M.lookup f env of
      Just body -> do
        let argsMap = IM.fromList (zip [0..] (reverse args))
        let newLoc = Loc { locArgs    = argsMap
                         , locLocals  = IM.empty
                         , locClosure = Nothing }
        pure (conf { cstack = (rest, loc conf, rest') : cstack conf
                   , stk    = rest'
                   , loc    = newLoc }, body)
      Nothing -> do
        c <- builtin f (reverse args) (conf { stk = rest' })
        pure (c, rest)

  CALLC n -> do
    (vs, rest') <- splitStack (n + 1) (stk conf)
    case reverse vs of
      (VClosure name ident : args) -> do
        _ <- lookupStore ident conf
        let argsMap = IM.fromList (zip [0..] args)
        let newLoc = Loc { locArgs    = argsMap
                         , locLocals  = IM.empty
                         , locClosure = Just ident }
        p <- jumpTo env name
        pure (conf { cstack = (rest, loc conf, rest') : cstack conf
                   , stk    = rest'
                   , loc    = newLoc }, p)
      (VBuiltin name : args) -> do
        c <- builtin name args (conf { stk = rest' })
        pure (c, rest)
      (f : _) -> throwSM ("CALLC: not callable: " ++ show f)
      []      -> throwSM "CALLC: empty stack"

  BEGIN _ _ nlocals -> do
    let localsMap = IM.fromList (zip [0..] (replicate nlocals VEmpty))
    pure (conf { loc = (loc conf) { locLocals = localsMap } }, rest)

  END -> case cstack conf of
    ((p, l, _) : cs) -> pure (conf { cstack = cs, loc = l }, p)
    []            -> pure (conf, [])

  RET -> case cstack conf of
    ((p, l, _) : cs) -> pure (conf { cstack = cs, loc = l }, p)
    []            -> pure (conf, [])

  DROP -> case stk conf of
    (_ : rest') -> pure (conf { stk = rest' }, rest)
    _           -> throwSM "DROP: stack underflow"

  DUP -> case stk conf of
    (x : _) -> pure (conf { stk = x : stk conf }, rest)
    _       -> throwSM "DUP: stack underflow"

  SWAP -> case stk conf of
    (x : y : rest') -> pure (conf { stk = y : x : rest' }, rest)
    _               -> throwSM "SWAP: stack underflow"

  TAG t n -> case stk conf of
    (x : rest') -> do
      v <- case x of
             VSexp t' id | t' == t -> do
               vs <- lookupStore id conf
               pure (b2i (length vs == n))
             _ -> pure 0
      pure (conf { stk = VInt v : rest' }, rest)
    _ -> throwSM "TAG: stack underflow"

  ARRAY n -> case stk conf of
    (x : rest') -> do
      v <- case x of
             VArray id -> do
               vs <- lookupStore id conf
               pure (b2i (length vs == n))
             _ -> pure 0
      pure (conf { stk = VInt v : rest' }, rest)
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
        pure (conf { stk = VInt (b2i eq) : rest' }, rest)
      _ -> throwSM "PATT StrCmp: stack underflow"
    PArray -> case stk conf of
      (x : rest') ->
        let v = case x of VArray _ -> 1; _ -> 0
        in pure (conf { stk = VInt v : rest' }, rest)
      _ -> throwSM "PATT Array: stack underflow"
    PString -> case stk conf of
      (x : rest') ->
        let v = case x of VString _ -> 1; _ -> 0
        in pure (conf { stk = VInt v : rest' }, rest)
      _ -> throwSM "PATT String: stack underflow"
    PSexp -> case stk conf of
      (x : rest') ->
        let v = case x of VSexp _ _ -> 1; _ -> 0
        in pure (conf { stk = VInt v : rest' }, rest)
      _ -> throwSM "PATT Sexp: stack underflow"
    Boxed -> case stk conf of
      (x : rest') ->
        let v = case x of VInt _ -> 0; _ -> 1
        in pure (conf { stk = VInt v : rest' }, rest)
      _ -> throwSM "PATT Boxed: stack underflow"
    UnBoxed -> case stk conf of
      (x : rest') ->
        let v = case x of VInt _ -> 1; _ -> 0
        in pure (conf { stk = VInt v : rest' }, rest)
      _ -> throwSM "PATT UnBoxed: stack underflow"
    PClosure -> case stk conf of
      (x : rest') ->
        let v = case x of VClosure{} -> 1; _ -> 0
        in pure (conf { stk = VInt v : rest' }, rest)
      _ -> throwSM "PATT Closure: stack underflow"

  FAIL l -> case stk conf of
    (x : _) -> throwSM ("matching value " ++ showValue (store conf) x
                        ++ " failed at " ++ show l)
    _       -> throwSM "FAIL: empty stack"

jumpTo :: LabelEnv -> String -> SM Prog
jumpTo env l = case M.lookup l env of
  Just p  -> pure p
  Nothing -> throwSM ("undefined label: " ++ l)

capture :: Config -> Designation -> SM Value
capture state designation = case designation of
  DGlobal _ -> throwSM "CLOSURE: bad designation"
  _ -> lookupDesignation state designation

eval :: LabelEnv -> Config -> Prog -> SM Config
eval env conf [] = pure conf
eval env conf prog = do
  -- traceM ("SM TRACE next=" ++ show (take 1 prog) ++ " stack=" ++ show (stk conf) ++ " globals=" ++ show (glob conf) ++ " output=" ++ show (out conf) ++ " locals=" ++ show (loc conf) ++ " heap=" ++ show (store conf)) -- DEBUG
  (conf', prog') <- step env conf prog
  eval env conf' prog'

run :: Prog -> [Int] -> Either String [Int]
run p i =
  let (env, conf0) = initialState p i
  in fmap out (eval env conf0 p)

runConfig :: Prog -> [Int] -> Either String Config
runConfig p i =
  let (env, conf0) = initialState p i
  in eval env conf0 p
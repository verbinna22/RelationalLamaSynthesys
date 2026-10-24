module PairedExecution where

-- import Debug.Trace (traceM) -- DEBUG: X86 batch steps.

import qualified AssemblyParser
import qualified BytecodeParser
import Control.Monad (foldM)
import Control.Exception (IOException, displayException, try)
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BSC
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as M
import Data.List (tails, stripPrefix)
import Data.Char (isSpace)
import qualified StackMachine as SM
import qualified StateEquivalence2 as Equivalence
import Text.Read (readMaybe)
import System.Environment (getArgs)
import System.Exit (exitFailure)
import System.IO (hPutStrLn, stderr)
import qualified X86Interp as X

data ParsedPrograms = ParsedPrograms
  { smProgram :: SM.Prog
  , x86Program :: [X.ExtInst]
  , x86Comments :: [String]
  , x86LabelNames :: Map Int String
  , x86StringConstants :: Map Int String
  , x86GlobalInitialValues :: Map Int Int
  , inputValues :: [Int]
  } deriving Show

loadPrograms :: FilePath -> FilePath -> FilePath -> IO (Either String ParsedPrograms)
loadPrograms bytecodePath assemblyPath inputPath = do
  loadedFiles <- try readFiles :: IO (Either IOException (BS.ByteString, BS.ByteString, BS.ByteString))
  pure $ case loadedFiles of
    Left exception -> Left (displayException exception)
    Right (bytecodeBytes, assemblyBytes, inputBytes) ->
      parsePrograms bytecodeBytes (BSC.unpack assemblyBytes) (BSC.unpack inputBytes)
  where
    readFiles :: IO (BS.ByteString, BS.ByteString, BS.ByteString)
    readFiles = do
      bytecodeBytes <- BS.readFile bytecodePath
      assemblyBytes <- BS.readFile assemblyPath
      inputBytes <- BS.readFile inputPath
      pure (bytecodeBytes, assemblyBytes, inputBytes)

parsePrograms :: BS.ByteString -> String -> String -> Either String ParsedPrograms
parsePrograms bytecodeBytes assemblyText inputText = do
  parsedSM <- either (Left . ("Bytecode parse error: " ++) . show) Right
    (BytecodeParser.parseBytecode bytecodeBytes)
  (parsedX86, labelNames, stringConstants, globalInitialValues) <-
    either (Left . ("Assembly parse error: " ++)) Right
      (AssemblyParser.parseAssembly assemblyText)
  parsedInput <- mapM parseInputNumber (zip [1 :: Int ..] (words inputText))
  pure ParsedPrograms
    { smProgram = parsedSM
    , x86Program = parsedX86
    , x86Comments = [comment
                    | sourceLine <- lines assemblyText
                    , Just comment <- [stripPrefix "#" sourceLine]]
    , x86LabelNames = labelNames
    , x86StringConstants = stringConstants
    , x86GlobalInitialValues = globalInitialValues
    , inputValues = parsedInput
    }

parseInputNumber :: (Int, String) -> Either String Int
parseInputNumber (tokenIndex, token) = case readMaybe token :: Maybe Integer of
  Just number
    | number >= toInteger (minBound :: Int)
    , number <= toInteger (maxBound :: Int) -> Right (fromInteger number)
  _ -> Left ("Input: invalid Int at token " ++ show tokenIndex ++ ": " ++ show token)

runPaired :: ParsedPrograms -> Either String ()
runPaired parsedPrograms = do
  let instructions = x86Program parsedPrograms
      labels = x86LabelNames parsedPrograms
  mainAddress <- case [address | (address, "main") <- M.toList labels] of
    [address] | address >= 0 && address < length instructions -> Right address
    _ -> Left "Assembly has no valid main entry"
  -- TODO: only labels
  let offsets = M.fromDistinctAscList (zip [0..] (tails instructions))
      x86Config = X.buildConfig instructions (x86StringConstants parsedPrograms)
        labels mainAddress offsets
      initialX86State = (X.initialState x86Config (inputValues parsedPrograms))
        { X.stGlob = x86GlobalInitialValues parsedPrograms }
      initialX86Machine = X.Machine (drop mainAddress instructions)
        (X.stackPush (length instructions) initialX86State)
  initialSMState <- SM.initialState (smProgram parsedPrograms) (inputValues parsedPrograms)
  (entryNames, globalAddresses) <- comparisonMaps (x86LabelNames parsedPrograms) (x86Comments parsedPrograms)
  runSteps (smProgram parsedPrograms) x86Config entryNames globalAddresses
    initialSMState (SM.programEntry (smProgram parsedPrograms)) initialX86Machine
  where
    runSteps :: SM.Prog -> X.ProgConfig -> Map Int String -> Map String Int
             -> SM.Config -> Int -> X.Machine -> Either String ()
    runSteps program x86Config entryNames globalAddresses smState instructionAddress x86Machine =
      case (SM.finished program instructionAddress, X.mRest x86Machine) of
        (True, []) -> Right ()
        (True, _) -> Left "SM finished before X86"
        (False, _) -> do
          smInstruction <- SM.currentInstruction program instructionAddress
          (nextSMState, nextAddress) <- either
            (Left . (("SM error at " ++ show smInstruction ++ ": ") ++)) Right
            (SM.step program smState instructionAddress)
          case smInstruction of
            SM.LINE _ ->
              runSteps program x86Config entryNames globalAddresses nextSMState nextAddress x86Machine
            SM.DROP ->
              runSteps program x86Config entryNames globalAddresses nextSMState nextAddress x86Machine
            _ | null (X.mRest x86Machine) -> Left "X86 finished before SM"
              | otherwise -> do
                  (nextX86Machine, lastX86Instruction) <- either
                    (Left . ("X86 batch error: " ++) . show) Right
                    (runX86Batch x86Config x86Machine)
                  (comparisonSMState, comparisonAddress) <- runSMLineAndDrop program nextSMState nextAddress
                  checkStates program entryNames globalAddresses smInstruction lastX86Instruction
                    (not (SM.finished program comparisonAddress)) (isFunctionCall smInstruction smState) comparisonSMState (X.mState nextX86Machine)
                  runSteps program x86Config entryNames globalAddresses comparisonSMState comparisonAddress nextX86Machine

runSMLineAndDrop :: SM.Prog -> SM.Config -> Int -> Either String (SM.Config, Int)
runSMLineAndDrop program smState instructionAddress
  | SM.finished program instructionAddress = Right (smState, instructionAddress)
  | otherwise = do
      smInstruction <- SM.currentInstruction program instructionAddress
      case smInstruction of
        SM.LINE _ -> advance smInstruction
        SM.DROP -> advance smInstruction
        _ -> Right (smState, instructionAddress)
  where
    advance :: SM.Insn -> Either String (SM.Config, Int)
    advance smInstruction = do
      (nextSMState, nextAddress) <- either
        (Left . (("SM error at " ++ show smInstruction ++ ": ") ++)) Right
        (SM.step program smState instructionAddress)
      runSMLineAndDrop program nextSMState nextAddress

comparisonMaps :: Map Int String -> [String] -> Either String (Map Int String, Map String Int)
comparisonMaps labelNames comments = do
  names <- foldM collectGlobal M.empty comments
  pure
    ( M.filterWithKey (\address _ -> address >= 0) labelNames
    , M.fromList [("global_" ++ show index, address) | (index, address) <- M.elems names]
    )
  where
    globalAddresses :: Map String Int
    globalAddresses = M.fromList
      [(globalName, address)
      | (address, labelName) <- M.toList labelNames
      , Just globalName <- [stripPrefix "global_" labelName]
      ]

    collectGlobal :: Map String (Int, Int) -> String -> Either String (Map String (Int, Int))
    collectGlobal names comment = case
      [remainingText | prefix <- ["LD (Global (", "ST (Global (", "LDA (Global ("]
                     , Just remainingText <- [stripPrefix prefix (dropWhile isSpace comment)]] of
      [] -> Right names
      remainingText : _ -> case reads remainingText :: [(String, String)] of
        [(name, suffix)] | filter (not . isSpace) suffix == "))" ->
          case M.lookup name globalAddresses of
            Just address -> Right (M.insertWith (\_ previousEntry -> previousEntry)
              name (M.size names, address) names)
            Nothing -> Left ("Missing X86 global label: " ++ name)
        _ -> Left ("Invalid global designation in assembly comment: " ++ comment)

checkStates :: SM.Prog -> Map Int String -> Map String Int
            -> SM.Insn -> X.ExtInst -> Bool -> Bool -> SM.Config -> X.State -> Either String ()
checkStates program entryAddressToFunctionName globalNameToAddress smInstruction lastX86Instruction hasFrames lastInstructionWasCall smState x86State
  | Equivalence.equalsStates program entryAddressToFunctionName globalNameToAddress hasFrames lastInstructionWasCall smState x86State = Right ()
  | otherwise = Left (unlines
      [ "State mismatch"
      , "SM instruction: " ++ show smInstruction
      , "Last X86 batch instruction: " ++ show (fst lastX86Instruction)
      , "X86 comment: " ++ maybe "<none>" (\(lineNumber, comment) -> "line " ++ show lineNumber ++ ": " ++ comment) (snd lastX86Instruction)
      , "SM state: " ++ show smState
      , "X86 state: " ++ show x86State
      ])

isFunctionCall :: SM.Insn -> SM.Config -> Bool
isFunctionCall smInstruction smState = case smInstruction of
  SM.CALL _ _ -> True
  SM.CALL_TAIL _ _ -> True
  SM.CALLC argumentCount -> callsClosure argumentCount
  SM.CALLC_TAIL argumentCount -> callsClosure argumentCount
  _ -> False
  where
    callsClosure :: Int -> Bool
    callsClosure argumentCount = case drop argumentCount (SM.stk smState) of
      SM.VBuiltin _ : _ -> False
      _ -> True

runX86Batch :: X.ProgConfig -> X.Machine -> X.Interp (X.Machine, X.ExtInst)
runX86Batch programConfig machine = runInstructions Nothing machine
  where
    runInstructions :: Maybe X.ExtInst -> X.Machine -> X.Interp (X.Machine, X.ExtInst)
    runInstructions previousInstruction currentMachine = case X.mRest currentMachine of
      [] -> case previousInstruction of
        Just lastInstruction -> Right (currentMachine, lastInstruction)
        Nothing -> Left (X.RuntimeFailure "Cannot start an X86 batch at end of program")
      currentInstruction@(_, currentComment) : _ ->
        case previousInstruction of
          Just lastInstruction@(_, previousComment)
            | endsX86Batch previousComment currentComment
            , not (returnsFromTailBuiltin lastInstruction (X.mState currentMachine) currentComment) -> Right (currentMachine, lastInstruction)
          _ -> do
            (nextState, nextInstructions) <- X.step programConfig
              (X.mState currentMachine) (X.mRest currentMachine)
            -- traceM ("X86 BATCH TRACE instruction=" ++ show currentInstruction ++ " beforeRegs=" ++ show (X.stRegs (X.mState currentMachine)) ++ " beforeStack=" ++ show (X.stStack (X.mState currentMachine)) ++ " afterRegs=" ++ show (X.stRegs nextState) ++ " afterStack=" ++ show (X.stStack nextState)) -- DEBUG
            runInstructions (Just currentInstruction) (X.Machine nextInstructions nextState)

    returnsFromTailBuiltin :: X.ExtInst -> X.State -> Maybe (Int, String) -> Bool
    returnsFromTailBuiltin (instruction, _) state nextComment =
      let returnsToCall = maybe False ((`elem` ["CALL", "CALLC"]) . commentInstructionName . snd) nextComment
      in returnsToCall && case instruction of
        X.Jmp targetAddress -> isBuiltinAddress targetAddress
        X.JmpI operand -> either (const False) isBuiltinAddress (X.indirectTargetAddress state operand)
        _ -> False
      where
        isBuiltinAddress :: Int -> Bool
        isBuiltinAddress targetAddress = case X.builtinAtAddress programConfig targetAddress of
          Just _ -> True
          Nothing -> False

endsX86Batch :: Maybe (Int, String) -> Maybe (Int, String) -> Bool
endsX86Batch currentComment nextComment =
  fmap fst currentComment /= fmap fst nextComment
    && maybe False (isSMInstructionComment . snd) nextComment
    && not (fmap (commentInstructionName . snd) currentComment == Just "END"
      && maybe False ((`elem` ["CALL", "CALLC"]) . commentInstructionName . snd) nextComment)

commentInstructionName :: String -> String
commentInstructionName comment =
  takeWhile (\character -> not (isSpace character) && character /= '(')
    comment

isSMInstructionComment :: String -> Bool
isSMInstructionComment comment =
  let instructionName = commentInstructionName comment
  in instructionName `elem`
      [ "BINOP", "CONST", "STRING", "SEXP", "LD", "ST", "STA", "ELEM"
      , "JMP", "CJMP", "BEGIN", "END", "CLOSURE", "CALLC", "CALL"
      , "RET", "DUP", "SWAP", "TAG", "ARRAY", "PATT", "FAIL"
      ]

main :: IO ()
main = do
  arguments <- getArgs
  case arguments of
    [bytecodePath, assemblyPath, inputPath] -> do
      parsedPrograms <- loadPrograms bytecodePath assemblyPath inputPath
      case parsedPrograms >>= runPaired of
        Left failure -> reportFailure failure
        Right () -> pure ()
    _ -> reportFailure "Usage: paired-execution FILE.bc FILE.s FILE.input"

reportFailure :: String -> IO ()
reportFailure message = do
  hPutStrLn stderr message
  exitFailure

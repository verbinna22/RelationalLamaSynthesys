module Main where

import qualified AssemblyParser as Parser
import Control.Exception (IOException, catch)
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BSC
import qualified X86Interp as X
import qualified Data.Map.Strict as M
import Data.List (tails)
import System.Environment (getArgs)
import System.Exit (exitFailure)
import System.IO (hPutStrLn, stderr)
import Text.Read (readMaybe)

main :: IO ()
main = catch runFromArguments reportIOException

runFromArguments :: IO ()
runFromArguments = do
  arguments <- getArgs
  case arguments of
    [assemblyPath, inputPath, outputPath] -> runTest assemblyPath inputPath outputPath
    _ -> failTest "Usage: run-x86-test FILE.s FILE.input FILE.output"

runTest :: FilePath -> FilePath -> FilePath -> IO ()
runTest assemblyPath inputPath outputPath = do
  assemblyText <- BSC.readFile assemblyPath
  inputText <- BSC.readFile inputPath
  outputText <- BSC.readFile outputPath
  case checkOutput assemblyText inputPath inputText outputPath outputText of
    Left failure -> failTest (assemblyPath ++ ": " ++ failure)
    Right () -> putStrLn ("PASS " ++ assemblyPath)

checkOutput :: BS.ByteString -> FilePath -> BS.ByteString -> FilePath -> BS.ByteString -> Either String ()
checkOutput assemblyText inputPath inputText outputPath outputText = do
  (program, labels, strings, globals) <- either (Left . ("Assembly parse error: " ++)) Right
    (Parser.parseAssembly (BSC.unpack assemblyText))
  mainAddress <- case [address | (address, "main") <- M.toList labels] of
    [address] | address >= 0 && address < length program -> Right address
    _ -> Left "Assembly has no valid main entry"
  let offsets = M.fromDistinctAscList (zip [0..] (tails program))
      config = X.buildConfig program strings labels mainAddress offsets
  inputValues <- parseNumbers inputPath inputText
  expectedOutput <- parseNumbers outputPath outputText
  let initialState = (X.initialState config inputValues) { X.stGlob = globals }
      entryState = X.stackPush (length program) initialState
      machine = X.Machine (drop mainAddress program) entryState
  finalState <- either (Left . ("Interpreter error: " ++) . show) Right (X.runInterp config machine)
  let actualOutput = X.stOutput finalState
  if actualOutput == expectedOutput then Right ()
    else Left ("Output mismatch\nExpected: " ++ show expectedOutput ++ "\nActual:   " ++ show actualOutput)

parseNumbers :: FilePath -> BS.ByteString -> Either String [Int]
parseNumbers filePath contents = mapM parseNumber (zip [1 :: Int ..] (BSC.words contents))
  where
    parseNumber :: (Int, BS.ByteString) -> Either String Int
    parseNumber (tokenIndex, token) =
      case readMaybe (BSC.unpack token) :: Maybe Integer of
        Just value | value >= toInteger (minBound :: Int) && value <= toInteger (maxBound :: Int) ->
          Right (fromInteger value)
        _ -> Left (filePath ++ ": invalid Int at token " ++ show tokenIndex ++ ": " ++ show token)

reportIOException :: IOException -> IO ()
reportIOException exception = failTest (show exception)

failTest :: String -> IO ()
failTest message = do
  hPutStrLn stderr ("FAIL " ++ message)
  exitFailure

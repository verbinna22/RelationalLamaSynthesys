module Main where

import qualified BytecodeParser as Parser
import Control.Exception (IOException, catch)
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BSC
import qualified StackMachine as SM
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
    [bytecodePath, inputPath, outputPath] -> runTest bytecodePath inputPath outputPath
    _ -> failTest "Usage: run-bytecode-test FILE.bc FILE.input FILE.output"

runTest :: FilePath -> FilePath -> FilePath -> IO ()
runTest bytecodePath inputPath outputPath = do
  bytecode <- BS.readFile bytecodePath
  inputText <- BSC.readFile inputPath
  outputText <- BSC.readFile outputPath
  case checkOutput bytecode inputPath inputText outputPath outputText of
    Left failure -> failTest (bytecodePath ++ ": " ++ failure)
    Right () -> putStrLn ("PASS " ++ bytecodePath)

checkOutput :: BS.ByteString -> FilePath -> BS.ByteString -> FilePath -> BS.ByteString -> Either String ()
checkOutput bytecode inputPath inputText outputPath outputText = do
  program <- either (Left . ("Bytecode parse error: " ++) . show) Right (Parser.parseBytecode bytecode)
  inputValues <- parseNumbers inputPath inputText
  expectedOutput <- parseNumbers outputPath outputText
  actualOutput <- either (Left . ("Interpreter error: " ++)) Right (SM.run program inputValues)
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

module BytecodeParser where

import Data.Bits ((.|.), shiftL)
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BSC
import Data.Int (Int32)
import qualified Data.IntMap.Strict as IM
import qualified Data.Map.Strict as M
import qualified Data.Set as Set
import Data.Word (Word8, Word32)
import qualified StackMachine as SM

data ParseError
  = UnexpectedEndOfFile String
  | InvalidBytecode String
  | MissingMain
  deriving (Show, Eq)

data BytecodeHeader = BytecodeHeader
  { stringTableSize :: Word32
  , globalAreaSize :: Word32
  , publicSymbolCount :: Word32
  } deriving (Show, Eq)

data BytecodeFile = BytecodeFile
  { bytecodeHeader :: BytecodeHeader
  , publicSymbolBytes :: BS.ByteString
  , stringTableBytes :: BS.ByteString
  , instructionBytes :: BS.ByteString
  } deriving (Show, Eq)

data PublicSymbol = PublicSymbol
  { publicSymbolName :: String
  , publicCodeOffset :: Int
  } deriving (Show, Eq)

parseBytecode :: BS.ByteString -> Either ParseError SM.Prog
parseBytecode bytecodeBytes = do
  bytecodeFile <- unpackBytecode bytecodeBytes
  publicSymbols <- parsePublicSymbols bytecodeFile
  mainOffset <- findMain publicSymbols
  decodeProgram bytecodeFile publicSymbols mainOffset

unpackBytecode :: BS.ByteString -> Either ParseError BytecodeFile
unpackBytecode bytecodeBytes = do
  (header, sectionBytes) <- parseHeader bytecodeBytes
  (symbolBytes, afterSymbols) <- takeSection "public symbols"
    (toInteger (publicSymbolCount header) * 8) sectionBytes
  (stringBytes, codeBytes) <- takeSection "string table"
    (toInteger (stringTableSize header)) afterSymbols
  if BS.null codeBytes
    then Left (InvalidBytecode "Missing instruction section")
    else if not (BS.null stringBytes) && BS.last stringBytes /= 0
      then Left (InvalidBytecode "String table is not NUL-terminated")
      else Right BytecodeFile
        { bytecodeHeader = header
        , publicSymbolBytes = symbolBytes
        , stringTableBytes = stringBytes
        , instructionBytes = codeBytes
        }

parseHeader :: BS.ByteString -> Either ParseError (BytecodeHeader, BS.ByteString)
parseHeader bytecodeBytes = do
  (stringBytesCount, afterStringSize) <- readWord32LE bytecodeBytes
  (globalWordsCount, afterGlobalSize) <- readWord32LE afterStringSize
  (symbolCount, remainingBytes) <- readWord32LE afterGlobalSize
  pure (BytecodeHeader stringBytesCount globalWordsCount symbolCount, remainingBytes)

readWord32LE :: BS.ByteString -> Either ParseError (Word32, BS.ByteString)
readWord32LE inputBytes = do
  (wordBytes, remainingBytes) <- takeSection "uint32" 4 inputBytes
  pure (BS.foldr appendByte 0 wordBytes, remainingBytes)
  where
    appendByte :: Word8 -> Word32 -> Word32
    appendByte byteValue accumulatedWord =
      fromIntegral byteValue .|. (accumulatedWord `shiftL` 8)

takeSection :: String -> Integer -> BS.ByteString -> Either ParseError (BS.ByteString, BS.ByteString)
takeSection sectionName byteCount inputBytes
  | byteCount < 0 = Left (InvalidBytecode ("Negative size: " ++ sectionName))
  | byteCount > toInteger (BS.length inputBytes) = Left (UnexpectedEndOfFile sectionName)
  | otherwise = Right (BS.splitAt (fromInteger byteCount) inputBytes)

parsePublicSymbols :: BytecodeFile -> Either ParseError [PublicSymbol]
parsePublicSymbols bytecodeFile =
  parseEntries (publicSymbolCount (bytecodeHeader bytecodeFile))
    (publicSymbolBytes bytecodeFile) []
  where
    parseEntries :: Word32 -> BS.ByteString -> [PublicSymbol] -> Either ParseError [PublicSymbol]
    parseEntries remainingCount remainingBytes parsedSymbols
      | remainingCount == 0 =
          if BS.null remainingBytes
            then Right (reverse parsedSymbols)
            else Left (InvalidBytecode "Extra bytes in public symbol table")
      | otherwise = do
          (nameOffset, afterNameOffset) <- readWord32LE remainingBytes
          (codeOffset, afterCodeOffset) <- readWord32LE afterNameOffset
          symbolName <- readPublicName nameOffset
          if toInteger codeOffset >= toInteger (BS.length (instructionBytes bytecodeFile))
            then Left (InvalidBytecode ("Public symbol code offset out of bounds: " ++ show codeOffset))
            else parseEntries (remainingCount - 1) afterCodeOffset
              (PublicSymbol symbolName (fromIntegral codeOffset) : parsedSymbols)

    readPublicName :: Word32 -> Either ParseError String
    readPublicName = readStringAt "Public symbol name" "public symbol name"
      (stringTableBytes bytecodeFile)

findMain :: [PublicSymbol] -> Either ParseError Int
findMain [] = Left MissingMain
findMain (publicSymbol : remainingSymbols)
  | publicSymbolName publicSymbol == "main" = Right (publicCodeOffset publicSymbol)
  | otherwise = findMain remainingSymbols

decodeProgram :: BytecodeFile -> [PublicSymbol] -> Int -> Either ParseError SM.Prog
decodeProgram bytecodeFile publicSymbols mainOffset = do
  decodedInstructions <- decodeInstructions bytecodeFile codeLabel
  let instructionsByOffset = IM.fromDistinctAscList decodedInstructions
      labeledInstructions = [(codeLabel codeOffset, instruction) | (codeOffset, instruction) <- decodedInstructions]
      instructionLabels = Set.fromList (map fst labeledInstructions)
  case IM.lookup mainOffset instructionsByOffset of
    Just (SM.BEGIN _ _ _) -> pure ()
    _ -> Left (InvalidBytecode "main does not point to BEGIN/CBEGIN")
  mapM_ (validatePublicSymbol instructionsByOffset) publicSymbols
  mapM_ (validateTargets instructionLabels . snd) decodedInstructions
  pure (SM.JMP (codeLabel mainOffset) : foldr addLabel [] labeledInstructions)
  where
    publicNames :: IM.IntMap String
    publicNames = IM.fromList [(publicCodeOffset symbol, publicSymbolName symbol) | symbol <- publicSymbols]

    labelPrefix :: String
    labelPrefix = replicate (1 + maximum (0 : map (length . publicSymbolName) publicSymbols)) '$'

    publicNameCounts :: M.Map String Int
    publicNameCounts = M.fromListWith (+) [(name, 1) | name <- IM.elems publicNames]

    uniquePublicNames :: IM.IntMap String
    uniquePublicNames = IM.filter usablePublicName publicNames

    usablePublicName :: String -> Bool
    usablePublicName publicName =
      not (isBuiltinName publicName) && M.lookup publicName publicNameCounts == Just 1

    codeLabel :: Int -> String
    codeLabel codeOffset = IM.findWithDefault (labelPrefix ++ show codeOffset) codeOffset uniquePublicNames

    validatePublicSymbol :: IM.IntMap SM.Insn -> PublicSymbol -> Either ParseError ()
    validatePublicSymbol instructionsByOffset symbol
      | IM.member (publicCodeOffset symbol) instructionsByOffset = Right ()
      | otherwise = Left (InvalidBytecode ("Public symbol is not at an instruction boundary: " ++ publicSymbolName symbol))

    validateTargets :: Set.Set String -> SM.Insn -> Either ParseError ()
    validateTargets instructionLabels instruction = case instruction of
      SM.JMP target -> validateTarget target
      SM.CJMP _ target -> validateTarget target
      SM.CLOSURE target _ -> validateTarget target
      SM.CALL target _ | not (isBuiltinName target) -> validateTarget target
      _ -> Right ()
      where
        validateTarget :: String -> Either ParseError ()
        validateTarget target
          | Set.member target instructionLabels = Right ()
          | otherwise = Left (InvalidBytecode ("Target is not at an instruction boundary: " ++ target))

    addLabel :: (String, SM.Insn) -> SM.Prog -> SM.Prog
    addLabel (labelName, instruction) remainingProgram =
      SM.LABEL labelName : instruction : remainingProgram

decodeInstructions :: BytecodeFile -> (Int -> String) -> Either ParseError [(Int, SM.Insn)]
decodeInstructions bytecodeFile codeLabel = decodeRemaining 0 (instructionBytes bytecodeFile) []
  where
    decodeRemaining :: Int -> BS.ByteString -> [(Int, SM.Insn)] -> Either ParseError [(Int, SM.Insn)]
    decodeRemaining codeOffset remainingBytes decodedInstructions =
      codeOffset `seq` case BS.uncons remainingBytes of
        Nothing -> Left (UnexpectedEndOfFile "bytecode terminator")
        Just (0xff, trailingBytes)
          | BS.null trailingBytes -> Right (reverse decodedInstructions)
          | otherwise -> Left (InvalidBytecode "Bytes after bytecode terminator")
        Just (opcode, operandBytes) -> do
          (instruction, afterInstruction) <- decodeInstruction bytecodeFile codeLabel codeOffset opcode operandBytes
          let instructionSize = BS.length remainingBytes - BS.length afterInstruction
          decodeRemaining (codeOffset + instructionSize) afterInstruction
            ((codeOffset, instruction) : decodedInstructions)

decodeInstruction :: BytecodeFile -> (Int -> String) -> Int -> Word8 -> BS.ByteString
  -> Either ParseError (SM.Insn, BS.ByteString)
decodeInstruction bytecodeFile codeLabel codeOffset opcode operandBytes
  | opcode >= 0x20 && opcode <= 0x23 = designationInstruction SM.LD (opcode - 0x20)
  | opcode >= 0x40 && opcode <= 0x43 = designationInstruction SM.ST (opcode - 0x40)
  | opcode >= 0x30 && opcode <= 0x33 = Left (InvalidBytecode "LDA is not supported by StackMachine")
  | otherwise = case opcode of
      0x01 -> noOperands (SM.BINOP "+")
      0x02 -> noOperands (SM.BINOP "-")
      0x03 -> noOperands (SM.BINOP "*")
      0x04 -> noOperands (SM.BINOP "/")
      0x05 -> noOperands (SM.BINOP "%")
      0x06 -> noOperands (SM.BINOP "<")
      0x07 -> noOperands (SM.BINOP "<=")
      0x08 -> noOperands (SM.BINOP ">")
      0x09 -> noOperands (SM.BINOP ">=")
      0x0a -> noOperands (SM.BINOP "==")
      0x0b -> noOperands (SM.BINOP "!=")
      0x0c -> noOperands (SM.BINOP "&&")
      0x0d -> noOperands (SM.BINOP "!!")
      0x10 -> oneWord (SM.CONST . toInteger . (fromIntegral :: Word32 -> Int32))
      0x11 -> do
        (stringOffset, remainingBytes) <- readWord32LE operandBytes
        stringValue <- readBytecodeString bytecodeFile stringOffset
        pure (SM.STRING stringValue, remainingBytes)
      0x12 -> namedFields SM.SEXP
      0x13 -> Left (InvalidBytecode "STI is not supported by StackMachine")
      0x14 -> noOperands SM.STA
      0x15 -> oneWord (SM.JMP . codeLabel . fromIntegral)
      0x16 -> noOperands SM.END
      0x17 -> noOperands SM.RET
      0x18 -> noOperands SM.DROP
      0x19 -> noOperands SM.DUP
      0x1a -> noOperands SM.SWAP
      0x1b -> noOperands SM.ELEM
      0x50 -> oneWord (SM.CJMP "z" . codeLabel . fromIntegral)
      0x51 -> oneWord (SM.CJMP "nz" . codeLabel . fromIntegral)
      0x52 -> twoWords (SM.BEGIN (codeLabel codeOffset))
      0x53 -> twoWords (SM.BEGIN (codeLabel codeOffset))
      0x54 -> closureInstruction
      0x55 -> oneWord (SM.CALLC . fromIntegral)
      0x56 -> twoWords (SM.CALL . codeLabel)
      0x57 -> namedFields SM.TAG
      0x58 -> oneWord (SM.ARRAY . fromIntegral)
      0x59 -> twoWords (\lineNumber columnNumber -> SM.FAIL (lineNumber, columnNumber))
      0x5a -> oneWord (SM.LINE . fromIntegral)
      0x60 -> noOperands (SM.PATT SM.StrCmp)
      0x61 -> noOperands (SM.PATT SM.PString)
      0x62 -> noOperands (SM.PATT SM.PArray)
      0x63 -> noOperands (SM.PATT SM.PSexp)
      0x64 -> noOperands (SM.PATT SM.Boxed)
      0x65 -> noOperands (SM.PATT SM.UnBoxed)
      0x66 -> noOperands (SM.PATT SM.PClosure)
      0x70 -> noOperands (SM.CALL "read" 0)
      0x71 -> noOperands (SM.CALL "write" 1)
      0x72 -> noOperands (SM.CALL "length" 1)
      0x73 -> noOperands (SM.CALL "string" 1)
      0x74 -> oneWord (SM.CALL ".array" . fromIntegral)
      _ -> invalidOpcode
  where
    invalidOpcode :: Either ParseError (SM.Insn, BS.ByteString)
    invalidOpcode = Left (InvalidBytecode ("Unknown opcode " ++ show opcode ++ " at offset " ++ show codeOffset))

    noOperands :: SM.Insn -> Either ParseError (SM.Insn, BS.ByteString)
    noOperands instruction = Right (instruction, operandBytes)

    oneWord :: (Word32 -> SM.Insn) -> Either ParseError (SM.Insn, BS.ByteString)
    oneWord makeInstruction = do
      (operand, remainingBytes) <- readWord32LE operandBytes
      pure (makeInstruction operand, remainingBytes)

    twoWords :: (Int -> Int -> SM.Insn) -> Either ParseError (SM.Insn, BS.ByteString)
    twoWords makeInstruction = do
      (firstOperand, afterFirst) <- readWord32LE operandBytes
      (secondOperand, remainingBytes) <- readWord32LE afterFirst
      pure (makeInstruction (fromIntegral firstOperand) (fromIntegral secondOperand), remainingBytes)

    namedFields :: (String -> Int -> SM.Insn) -> Either ParseError (SM.Insn, BS.ByteString)
    namedFields makeInstruction = do
      (nameOffset, afterName) <- readWord32LE operandBytes
      (fieldCount, remainingBytes) <- readWord32LE afterName
      name <- readBytecodeString bytecodeFile nameOffset
      pure (makeInstruction name (fromIntegral fieldCount), remainingBytes)

    designationInstruction :: (SM.Designation -> SM.Insn) -> Word8 -> Either ParseError (SM.Insn, BS.ByteString)
    designationInstruction makeInstruction designationKind = do
      (variableIndex, remainingBytes) <- readWord32LE operandBytes
      designation <- decodeDesignation bytecodeFile designationKind variableIndex
      pure (makeInstruction designation, remainingBytes)

    closureInstruction :: Either ParseError (SM.Insn, BS.ByteString)
    closureInstruction = do
      (entryOffset, afterEntry) <- readWord32LE operandBytes
      (captureCount, afterCount) <- readWord32LE afterEntry
      (captures, remainingBytes) <- readCaptures captureCount afterCount []
      pure (SM.CLOSURE (codeLabel (fromIntegral entryOffset)) captures, remainingBytes)

    readCaptures :: Word32 -> BS.ByteString -> [SM.Designation] -> Either ParseError ([SM.Designation], BS.ByteString)
    readCaptures remainingCount remainingBytes captures
      | remainingCount == 0 = Right (reverse captures, remainingBytes)
      | otherwise = case BS.uncons remainingBytes of
          Nothing -> Left (UnexpectedEndOfFile "closure capture")
          Just (designationKind, afterKind) -> do
            (variableIndex, afterIndex) <- readWord32LE afterKind
            designation <- decodeDesignation bytecodeFile designationKind variableIndex
            readCaptures (remainingCount - 1) afterIndex (designation : captures)

decodeDesignation :: BytecodeFile -> Word8 -> Word32 -> Either ParseError SM.Designation
decodeDesignation bytecodeFile designationKind variableIndex = case designationKind of
  0 | variableIndex < globalAreaSize (bytecodeHeader bytecodeFile) ->
        Right (SM.DGlobal ("global_" ++ show variableIndex))
    | otherwise -> Left (InvalidBytecode "Global variable index out of bounds")
  1 -> Right (SM.DLocal (fromIntegral variableIndex))
  2 -> Right (SM.DArg (fromIntegral variableIndex))
  3 -> Right (SM.DAccess (fromIntegral variableIndex))
  _ -> Left (InvalidBytecode ("Unknown designation kind: " ++ show designationKind))

readBytecodeString :: BytecodeFile -> Word32 -> Either ParseError String
readBytecodeString bytecodeFile =
  readStringAt "String" "bytecode string" (stringTableBytes bytecodeFile)

readStringAt :: String -> String -> BS.ByteString -> Word32 -> Either ParseError String
readStringAt offsetDescription stringDescription stringTable stringOffset
  | toInteger stringOffset >= toInteger (BS.length stringTable) =
      Left (InvalidBytecode (offsetDescription ++ " offset out of bounds: " ++ show stringOffset))
  | otherwise =
      let (stringBytes, terminatorAndRest) = BS.break (== 0)
            (BS.drop (fromIntegral stringOffset) stringTable)
      in if BS.null terminatorAndRest
           then Left (InvalidBytecode ("Unterminated " ++ stringDescription))
           else Right (BSC.unpack stringBytes)

isBuiltinName :: String -> Bool
isBuiltinName functionName = functionName `elem` ["read", "write", "length", "string", ".array"]

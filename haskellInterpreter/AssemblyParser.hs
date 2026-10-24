module AssemblyParser where

import Control.Monad (foldM)
import Data.Char (chr, digitToInt, isAlpha, isAlphaNum, isHexDigit, isSpace, toLower)
import Data.List (dropWhileEnd, foldl', isSuffixOf, stripPrefix)
import Text.Read (readMaybe)
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as M
import qualified X86Interp as X

type ParsedAssembly = ([X.ExtInst], Map Int String, Map Int String, Map Int Int)

data AssemblyLabels = AssemblyLabels
  { labelAddresses :: Map String Int
  , labelNames :: Map Int String
  , assemblyConstants :: Map String Int
  , stringConstants :: Map Int String
  , globalInitialValues :: Map Int Int
  , nextDataAddress :: Int
  , nextInstructionOffset :: Int
  , parsedInstructions :: [(ParsedInstruction, Maybe (Int, String))]
  , lastComment :: Maybe (Int, String)
  }

parseAssembly :: String -> Either String ParsedAssembly
parseAssembly sourceText = do
  let sourceLines = zip [1 ..] (lines sourceText)
  labels <- collectLabels sourceLines
  instructions <- decodeInstructions labels
  pure (instructions, labelNames labels, stringConstants labels, globalInitialValues labels)

collectLabels :: [(Int, String)] -> Either String AssemblyLabels
collectLabels sourceLines = do
  labels <- foldM collectLineLabels initialState sourceLines
  pure (registerBuiltinAddresses labels)

registerBuiltinAddresses :: AssemblyLabels -> AssemblyLabels
registerBuiltinAddresses labels = labels
  { labelAddresses = M.union (labelAddresses labels) (M.fromList builtinAddresses)
  , labelNames = M.union (labelNames labels)
      (M.fromList [(address, name) | (name, address) <- builtinAddresses])
  }
  where
    builtinAddresses :: [(String, Int)]
    builtinAddresses = zip
      [name | (name, _) <- builtinSymbols, M.notMember name (labelAddresses labels)]
      [nextInstructionOffset labels + 1 ..]

initialState :: AssemblyLabels
initialState = AssemblyLabels
  { labelAddresses = M.singleton "filler" (-2)
  , labelNames = M.singleton (-2) "filler"
  , assemblyConstants = M.empty
  , stringConstants = M.empty
  , globalInitialValues = M.singleton (-2) 1
  , nextDataAddress = -4
  , nextInstructionOffset = 0
  , parsedInstructions = []
  , lastComment = Nothing
  }

collectLineLabels :: AssemblyLabels -> (Int, String) -> Either String AssemblyLabels
collectLineLabels labels (lineNumber, sourceLine) =
  case span isLabelCharacter (dropWhile isSpace sourceLine) of
    (labelName, ':' : remainingLine) | not (null labelName) ->
      case dropWhile isSpace remainingLine of
        "" -> registerCodeLabel labelName
        '#' : commentText -> do
          updatedLabels <- registerCodeLabel labelName
          pure updatedLabels { lastComment = Just (lineNumber, dropWhile isSpace commentText) }
        contents -> case break isSpace contents of
          (".quad", valueText) -> do
            initialValue <- maybe
              (Left ("Line " ++ show lineNumber ++ ": expected .quad integer")) Right
              (readMachineInt (trim (takeWhile (/= '#') valueText)))
            updatedLabels <- registerDataLabel labels labelName Nothing
            globalAddress <- maybe (Left ("Missing global label: " ++ labelName)) Right
              (M.lookup labelName (labelAddresses updatedLabels))
            pure updatedLabels
              { globalInitialValues = M.insert globalAddress initialValue (globalInitialValues updatedLabels) }

          (".string", literalText) -> do
            stringValue <- parseStringLiteral (lineNumber, dropWhile isSpace literalText)
            registerDataLabel labels labelName (Just stringValue)
          ('.' : _, _) -> Right labels
          _ -> do
            updatedLabels <- registerCodeLabel labelName
            countInstruction updatedLabels (lineNumber, contents)
    _ -> countInstruction labels (lineNumber, sourceLine)
  where
    isLabelCharacter :: Char -> Bool
    isLabelCharacter character = isAlphaNum character || character `elem` "_.$"

    registerCodeLabel :: String -> Either String AssemblyLabels
    registerCodeLabel labelName = do
      let labelAddress = resolveCodeLabelAddress labels
      pure labels
        { labelAddresses = M.insert labelName labelAddress (labelAddresses labels)
        , labelNames = M.insert labelAddress labelName (labelNames labels)
        }

registerDataLabel :: AssemblyLabels -> String -> Maybe String -> Either String AssemblyLabels
registerDataLabel labels labelName stringValue
  | labelName == "filler" && stringValue == Nothing = Right labels
  | M.member labelName (labelAddresses labels) = Left ("Duplicate label: " ++ labelName)
  | otherwise =
      let dataAddress = nextDataAddress labels
      in Right labels
        { labelAddresses = M.insert labelName dataAddress (labelAddresses labels)
        , labelNames = M.insert dataAddress labelName (labelNames labels)
        , stringConstants = case stringValue of
            Nothing -> stringConstants labels
            Just literalValue -> M.insert dataAddress literalValue (stringConstants labels)
        , nextDataAddress = dataAddress - 2
        }

resolveCodeLabelAddress :: AssemblyLabels -> Int
resolveCodeLabelAddress = nextInstructionOffset

countInstruction :: AssemblyLabels -> (Int, String) -> Either String AssemblyLabels
countInstruction labels (lineNumber, sourceLine) =
  case dropWhile isSpace sourceLine of
    "" -> Right labels
    '#' : commentText -> Right labels { lastComment = Just (lineNumber, dropWhile isSpace commentText) }
    directiveText@('.' : _) ->
      case break isSpace (takeWhile (/= '#') directiveText) of
        (".set", argumentsText) -> collectSetConstant labels (lineNumber, argumentsText)
        _ -> Right labels
    instructionText -> do
      let updatedLabels = case break (== '#') instructionText of
            (_, '#' : commentText) -> labels { lastComment = Just (lineNumber, dropWhile isSpace commentText) }
            _ -> labels
      parsedInstruction <- parseInstruction (lineNumber, instructionText)
      case parsedInstruction of
        Nothing -> Right updatedLabels
        Just instruction ->
          let nextOffset = nextInstructionOffset labels + 1
          in nextOffset `seq` Right updatedLabels
            { nextInstructionOffset = nextOffset
            , parsedInstructions = (instruction, lastComment updatedLabels) : parsedInstructions labels
            }

collectSetConstant :: AssemblyLabels -> (Int, String) -> Either String AssemblyLabels
collectSetConstant labels (lineNumber, argumentsText) =
  case map trim (splitOperands argumentsText) of
    [constantName, valueText]
      | validSymbol constantName
      , Just constantValue <- readMachineInt valueText ->
          Right labels { assemblyConstants = M.insert constantName constantValue (assemblyConstants labels) }
    _ -> Left ("Line " ++ show lineNumber ++ ": expected .set name, integer")

type ParsedInstruction = AssemblyLabels -> Either String X.Instr

parseInstruction :: (Int, String) -> Either String (Maybe ParsedInstruction)
parseInstruction (lineNumber, instructionText) =
  case break isSpace (trim (takeWhile (/= '#') instructionText)) of
    ("", _) -> Right Nothing
    (mnemonic, operandText) ->
      let operands = map trim (splitOperands (trim operandText))
      in case mnemonic of
        "movq" -> binary X.Mov True operands
        "mov" -> binary X.Mov True operands
        "leaq" -> addressInstruction operands
        "lea" -> addressInstruction operands
        "addq" -> binary (X.Binop "+") True operands
        "subq" -> binary (X.Binop "-") True operands
        "imulq" -> binary (X.Binop "*") True operands
        "andq" -> binary (X.Binop "&&") True operands
        "orq" | [immediateText, destinationText] <- operands
              , Just numberText <- stripPrefix "$" immediateText
              , readMachineInt numberText == Just 1 -> unary X.Or1 True [destinationText]
        "orq" -> binary (X.Binop "!!") True operands
        "xorq" -> binary (X.Binop "^") True operands
        "cmpq" -> binary (X.Binop "cmp") False operands
        "testq" -> binary (X.Binop "test") False operands
        "test" -> binary (X.Binop "test") False operands
        "idivq" -> unary X.IDiv False operands
        "decq" -> unary X.Dec True operands
        "pushq" -> unary X.Push False operands
        "popq" -> unary X.Pop True operands
        "sarq" -> shiftInstruction X.Sar1 operands
        "salq" -> shiftInstruction X.Sal1 operands
        "shlq" -> shiftInstruction X.Sal1 operands
        "cqo" -> withoutOperands X.Cltd operands
        "cqto" -> withoutOperands X.Cltd operands
        "ret" -> withoutOperands X.Ret operands
        "retq" -> withoutOperands X.Ret operands
        "rep" | operands == ["movsq"] -> Right (Just (const (Right X.Repmovsl)))
        "rep" -> Right Nothing
        "call" -> callInstruction operands
        "callq" -> callInstruction operands
        "jmp" -> jumpInstruction operands
        _ | Just condition <- stripPrefix "set" mnemonic
          , condition `elem` supportedConditions -> setInstruction condition operands
          | Just condition <- stripPrefix "j" mnemonic
          , condition `elem` supportedConditions -> directBranch (X.CJmp condition) operands
          | otherwise -> Right Nothing
  where
    invalidOperands :: Either String (Maybe ParsedInstruction)
    invalidOperands = Left ("Line " ++ show lineNumber ++ ": invalid instruction operands: " ++ instructionText)

    withoutOperands :: X.Instr -> [String] -> Either String (Maybe ParsedInstruction)
    withoutOperands instruction [] = Right (Just (const (Right instruction)))
    withoutOperands _ _ = invalidOperands

    unary :: (X.Opnd -> X.Instr) -> Bool -> [String] -> Either String (Maybe ParsedInstruction)
    unary makeInstruction needsWritable [operandText]
      | needsWritable && not (isWritableOperand operandText) = Right Nothing
      | otherwise = Right $ fmap
          (\resolveOperand labels -> makeInstruction <$> resolveOperand labels)
          (parseOperand lineNumber operandText)
    unary _ _ _ = invalidOperands

    binary :: (X.Opnd -> X.Opnd -> X.Instr) -> Bool -> [String] -> Either String (Maybe ParsedInstruction)
    binary makeInstruction needsWritable [sourceText, destinationText]
      | needsWritable && not (isWritableOperand destinationText) = Right Nothing
      | otherwise = Right $ do
          resolveSource <- parseOperand lineNumber sourceText
          resolveDestination <- parseOperand lineNumber destinationText
          pure (\labels -> makeInstruction <$> resolveSource labels <*> resolveDestination labels)
    binary _ _ _ = invalidOperands

    addressInstruction :: [String] -> Either String (Maybe ParsedInstruction)
    addressInstruction [sourceText, destinationText]
      | not (isWritableOperand destinationText) = Right Nothing
      | Just labelName <- stripSuffix "(%rip)" sourceText = Right $ do
          resolveAddress <- parseAddress lineNumber labelName
          resolveDestination <- parseOperand lineNumber destinationText
          pure (\labels -> X.Lea . X.IRIP <$> resolveAddress labels <*> resolveDestination labels)
      | Just _ <- stackOperand sourceText = binary X.Lea True [sourceText, destinationText]
      | otherwise = Right Nothing
    addressInstruction _ = invalidOperands

    shiftInstruction :: (X.Opnd -> X.Instr) -> [String] -> Either String (Maybe ParsedInstruction)
    shiftInstruction makeInstruction [operandText] = unary makeInstruction True [operandText]
    shiftInstruction makeInstruction [countText, operandText]
      | Just numberText <- stripPrefix "$" countText
      , readMachineInt numberText == Just 1 = unary makeInstruction True [operandText]
      | otherwise = Right Nothing
    shiftInstruction _ _ = invalidOperands

    setInstruction :: String -> [String] -> Either String (Maybe ParsedInstruction)
    setInstruction condition [registerText] =
      Right (fmap (\register -> const (Right (X.Set condition register))) (lookup registerText byteRegisters))
    setInstruction _ _ = invalidOperands

    directBranch :: (Int -> X.Instr) -> [String] -> Either String (Maybe ParsedInstruction)
    directBranch makeInstruction [targetText] = Right $ fmap
      (\resolveTarget labels -> makeInstruction <$> resolveTarget labels)
      (parseAddress lineNumber targetText)
    directBranch _ _ = invalidOperands

    jumpInstruction :: [String] -> Either String (Maybe ParsedInstruction)
    jumpInstruction ['*' : operandText]
      | operandText `elem` ["(%r15)", "0(%r15)"] =
          Right (Just (const (Right (X.JmpI (X.R X.R15)))))
      | otherwise = unary X.JmpI False [operandText]
    jumpInstruction operands = directBranch X.Jmp operands

    callInstruction :: [String] -> Either String (Maybe ParsedInstruction)
    callInstruction ['*' : operandText]
      | operandText `elem` ["(%r15)", "0(%r15)"] =
          Right (Just (const (Right (X.CallI (X.R X.R15)))))
      | otherwise = unary X.CallI False [operandText]
    callInstruction [targetText]
      | Just builtinName <- lookup targetText builtinSymbols =
          Right (Just (const (Right (X.Builtin builtinName))))
      | otherwise = directBranch X.Call [targetText]
    callInstruction _ = invalidOperands

supportedConditions :: [String]
supportedConditions = ["e", "z", "ne", "nz", "l", "le", "g", "ge"]

byteRegisters :: [(String, X.Register)]
byteRegisters = zip
  ["%al", "%dil", "%sil", "%dl", "%cl", "%bpl", "%spl", "%r8b", "%r9b", "%r10b", "%r11b", "%r12b", "%r13b", "%r14b", "%r15b"]
  [X.RAX, X.RDI, X.RSI, X.RDX, X.RCX, X.RBP, X.RSP, X.R8, X.R9, X.R10, X.R11, X.R12, X.R13, X.R14, X.R15]

builtinSymbols :: [(String, String)]
builtinSymbols = X.builtinSymbols

parseOperand :: Int -> String -> Maybe (AssemblyLabels -> Either String X.Opnd)
parseOperand lineNumber operandText
  | Just register <- lookup operandText registers = Just (const (Right (X.R register)))
  | Just numberOrLabel <- stripPrefix "$" operandText =
      fmap (\resolveAddress labels -> X.L <$> resolveAddress labels) (parseAddress lineNumber numberOrLabel)
  | Just labelName <- stripSuffix "(%rip)" operandText =
      fmap (\resolveAddress labels -> X.IRIP <$> resolveAddress labels) (parseAddress lineNumber labelName)
  | Just operand <- stackOperand operandText = Just (const (Right operand))
  | Just displacementText <- stripSuffix "(%r15)" operandText
  , Just displacement <- readMachineInt displacementText
  , displacement >= 8 && displacement `mod` 8 == 0 = Just (const (Right (X.IR15 displacement)))
  | otherwise = Nothing
  where
    registers :: [(String, X.Register)]
    registers = [("%" ++ map toLower (show register), register) | register <- [minBound .. maxBound]]

isWritableOperand :: String -> Bool
isWritableOperand operandText = case parseOperand 0 operandText of
  Nothing -> False
  Just _ -> case operandText of
    '$' : _ -> False
    _ -> True

stackOperand :: String -> Maybe X.Opnd
stackOperand operandText = do
  displacementText <- stripSuffix "(%rbp)" operandText
  displacement <- readMachineInt displacementText
  if displacement `mod` 8 /= 0 then Nothing
    else if displacement < 0 then Just (X.S (negate (displacement `div` 8) - 1))
    else if displacement >= 16 then Just (X.S (1 - displacement `div` 8))
    else Nothing

parseAddress :: Int -> String -> Maybe (AssemblyLabels -> Either String Int)
parseAddress lineNumber addressText
  | Just value <- readMachineInt addressText = Just (const (Right value))
  | validSymbol addressText = Just (\labels ->
      maybe (Left ("Line " ++ show lineNumber ++ ": unknown symbol " ++ addressText)) Right
        (case M.lookup addressText (assemblyConstants labels) of
          Just constantValue -> Just constantValue
          Nothing -> M.lookup addressText (labelAddresses labels)))
  | otherwise = Nothing

validSymbol :: String -> Bool
validSymbol [] = False
validSymbol (firstCharacter : remainingCharacters) =
  (isAlpha firstCharacter || firstCharacter `elem` "_.$") &&
    all (\character -> isAlphaNum character || character `elem` "_.$") remainingCharacters

readMachineInt :: String -> Maybe Int
readMachineInt numberText = do
  value <- readMaybe numberText :: Maybe Integer
  if value < toInteger (minBound :: Int) || value > toInteger (maxBound :: Int)
    then Nothing else Just (fromInteger value)

stripSuffix :: String -> String -> Maybe String
stripSuffix suffix text
  | suffix `isSuffixOf` text = Just (take (length text - length suffix) text)
  | otherwise = Nothing

trim :: String -> String
trim = dropWhileEnd isSpace . dropWhile isSpace

splitOperands :: String -> [String]
splitOperands "" = []
splitOperands operandText = splitRemaining operandText []
  where
    splitRemaining :: String -> [String] -> [String]
    splitRemaining remainingText reversedOperands =
      case break (== ',') remainingText of
        (operand, []) -> reverse (operand : reversedOperands)
        (operand, _ : remainingOperands) ->
          splitRemaining remainingOperands (operand : reversedOperands)

parseStringLiteral :: (Int, String) -> Either String String
parseStringLiteral (lineNumber, literalText) =
  case dropWhile isSpace literalText of
    '"' : remainingText -> readCharacters remainingText []
    _ -> invalidLiteral "expected opening double quote"
  where
    invalidLiteral :: String -> Either String String
    invalidLiteral message = Left ("Line " ++ show lineNumber ++ ": " ++ message)

    readCharacters :: String -> String -> Either String String
    readCharacters remainingText reversedCharacters = case remainingText of
      [] -> invalidLiteral "unterminated string literal"
      '"' : trailingText -> case dropWhile isSpace trailingText of
        "" -> Right (reverse reversedCharacters)
        '#' : _ -> Right (reverse reversedCharacters)
        _ -> invalidLiteral "unexpected text after string literal"
      '\\' : [] -> invalidLiteral "unfinished string escape"
      '\\' : escapeCharacter : afterEscape ->
        case lookup escapeCharacter [('b', '\b'), ('f', '\f'), ('n', '\n'),
              ('r', '\r'), ('t', '\t'), ('\\', '\\'), ('"', '"')] of
          Just decodedCharacter -> readCharacters afterEscape (decodedCharacter : reversedCharacters)
          Nothing
            | escapeCharacter == 'x' || escapeCharacter == 'X' ->
                let (digits, afterDigits) = span isHexDigit afterEscape
                in if null digits
                     then invalidLiteral "expected hexadecimal digits after string escape"
                     else readCharacters afterDigits (decodeByte 16 digits : reversedCharacters)
            | isOctalDigit escapeCharacter ->
                let extraDigits = take 2 (takeWhile isOctalDigit afterEscape)
                    afterDigits = drop (length extraDigits) afterEscape
                in readCharacters afterDigits
                     (decodeByte 8 (escapeCharacter : extraDigits) : reversedCharacters)
            | otherwise -> invalidLiteral ("unsupported string escape: \\" ++ [escapeCharacter])
      character : remainingCharacters -> readCharacters remainingCharacters (character : reversedCharacters)

    isOctalDigit :: Char -> Bool
    isOctalDigit character = character >= '0' && character <= '7'

    decodeByte :: Int -> String -> Char
    decodeByte base digits = chr (foldl' appendDigit 0 digits)
      where
        appendDigit :: Int -> Char -> Int
        appendDigit accumulatedValue digit = (accumulatedValue * base + digitToInt digit) `mod` 256

decodeInstructions :: AssemblyLabels -> Either String [X.ExtInst]
decodeInstructions labels = mapM resolveInstruction (reverse (parsedInstructions labels))
  where
    resolveInstruction :: (ParsedInstruction, Maybe (Int, String)) -> Either String X.ExtInst
    resolveInstruction (parsedInstruction, instructionComment) = do
      instruction <- parsedInstruction labels
      pure (instruction, instructionComment)

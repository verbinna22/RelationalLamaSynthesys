module StateEquivalence2 where

import Control.Monad (foldM, guard)
import Data.Char (ord)
import qualified Data.IntMap.Strict as IM
import Data.Maybe (isJust)
import Data.List (elemIndex, foldl')
import Data.Map.Strict ((!))
import qualified Data.Map.Strict as M
import qualified StackMachine as SM
import qualified X86Interp as X

argumentRegisters :: [X.Register]
argumentRegisters = [X.RDI, X.RSI, X.RDX, X.RCX, X.R8, X.R9]

operandRegisters :: [X.Register]
operandRegisters = [X.R10, X.R11, X.R12, X.R13, X.R14]

x86WordSize :: Int
x86WordSize = 8

advanceStackPointer :: Int -> Int -> Int
advanceStackPointer stackPointer wordCount = stackPointer + wordCount * x86WordSize

frameSlotAddress :: Int -> Int -> Int
frameSlotAddress frameBase slotIndex = frameBase - (slotIndex + 1) * x86WordSize

savedSP :: Int -> Int
savedSP frameBase = advanceStackPointer frameBase 2

stackArgumentAddresses :: Int -> [Int]
stackArgumentAddresses frameBase =
  iterate (`advanceStackPointer` 1) (savedSP frameBase)

operandSpillAddresses :: Int -> Int -> [Int]
operandSpillAddresses frameBase localCount = map (frameSlotAddress frameBase) [localCount ..]

callPaddingWords :: Int -> Int -> Int
callPaddingWords savedRegisterCount stackArgumentCount =
  (savedRegisterCount + stackArgumentCount) `mod` 2

data MemoryAddressMapping = MemoryAddressMapping
  { smToX86Addresses :: M.Map Int Int
  , x86ToSMAddresses :: M.Map Int Int
  } deriving (Show, Eq)

equalsStates :: SM.Prog -> M.Map Int String -> M.Map String Int -> Bool -> Bool -> SM.Config -> X.State -> Bool
equalsStates program entryAddressToFunctionName globalNameToAddress hasFrames lastInstructionWasCall smState x86State =
  isJust $ do
    guard (SM.inp smState == X.stInput x86State)
    guard (SM.out smState == X.stOutput x86State)
    mappingAfterGlobals <- equalGlobals functionNames entryAddressToFunctionName globalNameToAddress
      smState x86State initialAddressMapping
    frameBase <- M.lookup X.RBP (X.stRegs x86State)
    if not hasFrames
      then do
        guard (not lastInstructionWasCall && frameBase == 0)
        Just mappingAfterGlobals
      else if lastInstructionWasCall
        then do
          let callerSMState = returnSMToCaller smState
          guard (IM.null (SM.locLocals (SM.loc smState)))
          guard (length (SM.stk smState) == maybe 0 (length . SM.stk) callerSMState)
          callerX86State <- returnX86BeforePrologue program smState x86State
          case callerSMState of
            Just callerState ->
              equalFrames program entryAddressToFunctionName callerState callerX86State mappingAfterGlobals
            Nothing -> do
              guard (frameBase == 0)
              Just mappingAfterGlobals
        else do
          guard (frameBase /= 0)
          equalFrames program entryAddressToFunctionName smState x86State mappingAfterGlobals
  where
    functionNames :: IM.IntMap String
    functionNames = SM.programFunctionNames program

    initialAddressMapping :: MemoryAddressMapping
    initialAddressMapping = MemoryAddressMapping M.empty M.empty

equalFrames :: SM.Prog -> M.Map Int String -> SM.Config -> X.State
            -> MemoryAddressMapping -> Maybe MemoryAddressMapping
equalFrames program entryAddressToFunctionName smState x86State addressMapping = do
  mappingAfterFrame <- checkStackFrame (SM.programFunctionNames program) entryAddressToFunctionName smState x86State addressMapping
  case (returnSMToCaller smState, returnX86ToCaller program smState x86State) of
    (Just callerSMState, Just callerX86State) ->
      equalFrames program entryAddressToFunctionName callerSMState callerX86State mappingAfterFrame
    (Nothing, Nothing) -> Just mappingAfterFrame
    _ -> Nothing

equalGlobals :: IM.IntMap String -> M.Map Int String -> M.Map String Int -> SM.Config -> X.State
             -> MemoryAddressMapping -> Maybe MemoryAddressMapping
equalGlobals functionNames entryAddressToFunctionName globalNameToAddress smState x86State addressMapping = do
  valuePairs <- traverse globalValuePair (M.toList (SM.glob smState))
  equalValues functionNames entryAddressToFunctionName smState x86State valuePairs addressMapping
  where
    globalValuePair :: (String, SM.Value) -> Maybe (SM.Value, Int)
    globalValuePair (globalName, smValue) = do
      globalAddress <- M.lookup globalName globalNameToAddress
      x86Value <- M.lookup globalAddress (X.stGlob x86State)
      pure (smValue, x86Value)

equalValues :: IM.IntMap String -> M.Map Int String -> SM.Config -> X.State -> [(SM.Value, Int)]
            -> MemoryAddressMapping -> Maybe MemoryAddressMapping
equalValues _ _ _ _ [] addressMapping = Just addressMapping
equalValues functionNames entryAddressToFunctionName smState x86State ((smValue, x86Value) : remainingPairs) addressMapping =
  case smValue of
    SM.VInt number -> continueIf (toInteger x86Value == 2 * number + 1)
    SM.VEmpty -> continueIf (x86Value == 1)
    SM.VBuiltin _ -> do
      guard (even x86Value)
      case M.lookup x86Value (X.stMem x86State) of
        Just (X.MemClosure _ captured) -> continueIf (null captured)
        _ -> Nothing
    SM.VString smAddress -> compareHeapReference smAddress
    SM.VArray smAddress -> compareHeapReference smAddress
    SM.VSexp _ smAddress -> compareHeapReference smAddress
    SM.VClosure _ smAddress -> compareHeapReference smAddress
  where
    continueIf :: Bool -> Maybe MemoryAddressMapping
    continueIf valuesMatch = do
      guard valuesMatch
      equalValues functionNames entryAddressToFunctionName smState x86State remainingPairs addressMapping

    compareHeapReference :: Int -> Maybe MemoryAddressMapping
    compareHeapReference smAddress =
      case (M.lookup smAddress (smToX86Addresses addressMapping),
            M.lookup x86Value (x86ToSMAddresses addressMapping)) of
        (Just mappedX86Address, Just mappedSMAddress) ->
          continueIf (mappedX86Address == x86Value && mappedSMAddress == smAddress)
        (Nothing, Nothing) -> do
          guard (even x86Value)
          let extendedMapping :: MemoryAddressMapping
              extendedMapping = MemoryAddressMapping
                { smToX86Addresses = M.insert smAddress x86Value (smToX86Addresses addressMapping)
                , x86ToSMAddresses = M.insert x86Value smAddress (x86ToSMAddresses addressMapping)
                }
          fieldPairs <- heapFieldPairs smAddress
          equalValues functionNames entryAddressToFunctionName smState x86State
            (fieldPairs ++ remainingPairs) extendedMapping
        _ -> Nothing

    heapFieldPairs :: Int -> Maybe [(SM.Value, Int)]
    heapFieldPairs smAddress = do
      smFields <- IM.lookup smAddress (SM.store smState)
      x86Object <- M.lookup x86Value (X.stMem x86State)
      x86Fields <- case (smValue, x86Object) of
        (SM.VString _, X.MemString text) -> Just (map boxedCharacter text)
        (SM.VArray _, X.MemArray elements) -> Just elements
        (SM.VSexp tag _, X.MemSexp actualTag fields) -> do
          expectedTag <- boxedTag tag
          guard (expectedTag == toInteger actualTag)
          pure fields
        (SM.VClosure _ _, X.MemClosure _ captured) -> pure captured
        _ -> Nothing
      guard (length smFields == length x86Fields)
      pure (zip smFields x86Fields)

    boxedCharacter :: Char -> Int
    boxedCharacter character = 2 * ord character + 1

    boxedTag :: String -> Maybe Integer
    boxedTag tag = do
      tagHash <- foldM appendTagCharacter 0 (take 10 tag)
      pure (2 * tagHash + 1)

    appendTagCharacter :: Integer -> Char -> Maybe Integer
    appendTagCharacter accumulatedHash character = do
      characterIndex <- elemIndex character "_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'"
      pure (accumulatedHash * 64 + toInteger characterIndex)

checkStackFrame :: IM.IntMap String -> M.Map Int String -> SM.Config -> X.State
                 -> MemoryAddressMapping -> Maybe MemoryAddressMapping
checkStackFrame functionNames entryAddressToFunctionName smState x86State addressMapping = do
  frameBase <- M.lookup X.RBP (X.stRegs x86State)
  callerFrameBase <- M.lookup frameBase (X.stkCells (X.stStack x86State))
  guard (callerFrameBase > frameBase)
  mappingAfterLocals <- checkLocals functionNames entryAddressToFunctionName smState x86State addressMapping
  mappingAfterArgs <- checkArgs functionNames entryAddressToFunctionName smState x86State mappingAfterLocals
  mappingAfterClosure <- checkClosure functionNames entryAddressToFunctionName smState x86State mappingAfterArgs
  checkStack functionNames entryAddressToFunctionName smState x86State mappingAfterClosure

checkLocals :: IM.IntMap String -> M.Map Int String -> SM.Config -> X.State -> MemoryAddressMapping -> Maybe MemoryAddressMapping
checkLocals functionNames entryAddressToFunctionName smState x86State addressMapping = do
  frameBase <- M.lookup X.RBP (X.stRegs x86State)
  valuePairs <- traverse (localValuePair frameBase)
    (IM.toList (IM.filter (/= SM.VEmpty) (SM.locLocals (SM.loc smState))))
  equalValues functionNames entryAddressToFunctionName smState x86State valuePairs addressMapping
  where
    localValuePair :: Int -> (Int, SM.Value) -> Maybe (SM.Value, Int)
    localValuePair frameBase (localIndex, smValue) =
      case M.lookup (frameSlotAddress frameBase localIndex) (X.stkCells (X.stStack x86State)) of
        Just x86Value -> Just (smValue, x86Value)
        Nothing -> Nothing

checkArgs :: IM.IntMap String -> M.Map Int String -> SM.Config -> X.State -> MemoryAddressMapping -> Maybe MemoryAddressMapping
checkArgs functionNames entryAddressToFunctionName smState x86State addressMapping
  | null (SM.cstack smState) = Just addressMapping
  | otherwise = equalValues functionNames entryAddressToFunctionName smState x86State
      (zip (IM.elems (SM.locArgs (SM.loc smState))) x86ArgumentValues) addressMapping
  where
    frameBase :: Int
    frameBase = X.stRegs x86State ! X.RBP

    x86ArgumentValues :: [Int]
    x86ArgumentValues =
      map (X.stRegs x86State !) argumentRegisters
        ++ map (X.stkCells (X.stStack x86State) !) (stackArgumentAddresses frameBase)

checkClosure :: IM.IntMap String -> M.Map Int String -> SM.Config -> X.State -> MemoryAddressMapping -> Maybe MemoryAddressMapping
checkClosure functionNames entryAddressToFunctionName smState x86State addressMapping =
  case SM.locClosure (SM.loc smState) of
    Nothing -> Just addressMapping
    Just closureId -> do
      capturedValues <- IM.lookup closureId (SM.store smState)
      if null capturedValues then Just addressMapping else do
        x86ClosureAddress <- M.lookup X.R15 (X.stRegs x86State)
        case M.lookup x86ClosureAddress (X.stMem x86State) of
          Just (X.MemClosure _ x86CapturedValues) -> do
            guard (length capturedValues == length x86CapturedValues)
            mappingAfterClosure <- case
              (M.lookup closureId (smToX86Addresses addressMapping),
               M.lookup x86ClosureAddress (x86ToSMAddresses addressMapping)) of
              (Nothing, Nothing) -> Just addressMapping
                { smToX86Addresses = M.insert closureId x86ClosureAddress (smToX86Addresses addressMapping)
                , x86ToSMAddresses = M.insert x86ClosureAddress closureId (x86ToSMAddresses addressMapping)
                }
              (Just mappedX86, Just mappedSM) -> do
                guard (mappedX86 == x86ClosureAddress && mappedSM == closureId)
                Just addressMapping
              _ -> Nothing
            equalValues functionNames entryAddressToFunctionName smState x86State
              (zip capturedValues x86CapturedValues) mappingAfterClosure
          _ -> Nothing

checkStack :: IM.IntMap String -> M.Map Int String -> SM.Config -> X.State -> MemoryAddressMapping -> Maybe MemoryAddressMapping
checkStack functionNames entryAddressToFunctionName smState x86State addressMapping =
  equalValues functionNames entryAddressToFunctionName smState x86State
    (zip currentFrameOperands x86OperandValues) addressMapping
  where
    callerStackSize :: Int
    callerStackSize = case SM.cstack smState of
      [] -> 0
      (_, _, callerStack) : _ -> length callerStack

    currentFrameOperands :: [SM.Value]
    currentFrameOperands = reverse (take (length (SM.stk smState) - callerStackSize) (SM.stk smState))

    frameBase :: Int
    frameBase = X.stRegs x86State ! X.RBP

    x86OperandValues :: [Int]
    x86OperandValues = map (X.stRegs x86State !) operandRegisters
      ++ map (X.stkCells (X.stStack x86State) !) (operandSpillAddresses frameBase (IM.size (SM.locLocals (SM.loc smState))))

returnSMToCaller :: SM.Config -> Maybe SM.Config
returnSMToCaller smState = case SM.cstack smState of
  [] -> Nothing
  (_, callerLocals, stackBeforeCall) : remainingFrames ->
    Just smState
      { SM.cstack = remainingFrames
      , SM.loc = callerLocals
      , SM.stk = stackBeforeCall
      }

returnX86BeforePrologue :: SM.Prog -> SM.Config -> X.State -> Maybe X.State
returnX86BeforePrologue program smState x86State = do
  stackPointer <- M.lookup X.RSP (X.stRegs x86State)
  frameBase <- M.lookup X.RBP (X.stRegs x86State)
  guard (stackPointer < frameBase)
  (_, callerState) <- either (const Nothing) Just (X.stackPop x86State)
  pure (restoreX86CallerRegistersAndStack program smState callerState)

returnX86ToCaller :: SM.Prog -> SM.Config -> X.State -> Maybe X.State
returnX86ToCaller program smState x86State
  | callerFrameBase == 0 = Nothing
  | otherwise = Just (restoreX86CallerRegistersAndStack program smState stateWithRestoredRBP)
  where
    frameBase :: Int
    frameBase = X.stRegs x86State ! X.RBP

    stackCells :: M.Map Int Int
    stackCells = X.stkCells (X.stStack x86State)

    callerFrameBase :: Int
    callerFrameBase = stackCells ! frameBase

    stateWithRestoredRBP :: X.State
    stateWithRestoredRBP = x86State
      { X.stRegs = M.insert X.RBP callerFrameBase
        (M.insert X.RSP (savedSP frameBase) (X.stRegs x86State))
      }

restoreX86CallerRegistersAndStack :: SM.Prog -> SM.Config -> X.State -> X.State
restoreX86CallerRegistersAndStack program smState stateWithRestoredRBP =
  foldl' restoreSavedRegister stateAfterArguments (reverse savedRegisters)
  where
    savedRegisters :: [X.Register]
    savedRegisters = savedCallerRegisters program smState

    stackArgumentCount :: Int
    stackArgumentCount = callStackArgumentCount smState

    paddingWords :: Int
    paddingWords = callPaddingWords (length savedRegisters) stackArgumentCount

    stateAfterArguments :: X.State
    stateAfterArguments = stateWithRestoredRBP
      { X.stRegs = M.insert X.RSP
          (advanceStackPointer (X.stRegs stateWithRestoredRBP ! X.RSP) (stackArgumentCount + paddingWords))
          (X.stRegs stateWithRestoredRBP)
      }

    restoreSavedRegister :: X.State -> X.Register -> X.State
    restoreSavedRegister currentState savedRegister =
      currentState
        { X.stRegs = M.insert X.RSP (advanceStackPointer stackPointer 1)
            (M.insert savedRegister (stackCells ! stackPointer) (X.stRegs currentState))
        , X.stStack = X.Stack (M.delete stackPointer stackCells)
        }
      where
        stackPointer :: Int
        stackPointer = X.stRegs currentState ! X.RSP

        stackCells :: M.Map Int Int
        stackCells = X.stkCells (X.stStack currentState)

savedCallerRegisters :: SM.Prog -> SM.Config -> [X.Register]
savedCallerRegisters program smState = case SM.cstack smState of
  [] -> []
  (returnAddress, callerLocals, callerStack) : olderFrames ->
    let olderStackSize :: Int
        olderStackSize = case olderFrames of
          [] -> 0
          (_, _, olderStack) : _ -> length olderStack

        savedOperandCount :: Int
        savedOperandCount = length callerStack - olderStackSize
          + case IM.lookup (returnAddress - 1) (SM.programInstructions program) of
              Just (SM.CALLC _) -> 1
              _ -> 0

        callerArgumentCount :: Int
        callerArgumentCount = if null olderFrames then 2 else IM.size (SM.locArgs callerLocals)

        closureRegisters :: [X.Register]
        closureRegisters = if maybe True (null . (SM.store smState IM.!)) (SM.locClosure callerLocals) then [] else [X.R15]
    in closureRegisters
      ++ take callerArgumentCount argumentRegisters
      ++ take savedOperandCount operandRegisters

callStackArgumentCount :: SM.Config -> Int
callStackArgumentCount smState = max 0 (IM.size (SM.locArgs (SM.loc smState)) - length argumentRegisters)

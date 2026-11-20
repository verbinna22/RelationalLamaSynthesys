open GT
open OCanren

module Patt =
  struct

    @type t =
      StrCmp
    | String
    | Array
    | Sexp
    | Boxed
    | UnBoxed
    | Closure with show

    @type logic = t OCanren.logic with show

    let strCmp  () = inj StrCmp
    let string  () = inj String
    let array   () = inj Array
    let sexp    () = inj Sexp
    let boxed   () = inj Boxed
    let unBoxed () = inj UnBoxed
    let closure () = inj Closure

    let reify   = reify
    let prj_exn = prj_exn
    
  end

module Designation =
  struct
    
    @type ('string, 'int) designation_a =
      Global of 'string
    | Local  of 'int
    | Arg    of 'int
    | Access of 'int
    with show, gmap
    
    @type t     = (string          , int          ) designation_a               with show, gmap
    @type logic = (Std.String.logic, Word32.logic) designation_a OCanren.logic with show, gmap

    let fmapt fs fi subj =
      let open Env.Monad in
      return (gmap(designation_a)) <*> fs <*> fi <*> subj

    let prj_exn =
      let open Env.Monad in
      Reifier.fix
        (fun self -> prj_exn <..>
                       (chain (fmapt Std.String.prj_exn
                                     (fun env x -> Word32.to_int @@ Word32.prj_exn env x)
        )))

    let reify =
      let open Env.Monad in
      Reifier.fix
        (fun self ->
          reify <..>
            (chain
               (Reifier.zed
                  (Reifier.rework ~fv:(fmapt Std.String.reify Word32.reify)))))
 
    let global s = inj @@ Global s
    let local  i = inj @@ Local  i
    let arg    i = inj @@ Arg    i
    let access i = inj @@ Access i
    
  end

module ByteString = struct
  @type t = string with show
  @type logic = Word32.logic Std.List.logic with show

  let inj (text : string) : Word32.injected Std.List.groundi =
    Std.list (fun character -> Word32.word (Char.code character))
      (List.of_seq (String.to_seq text))

  let prj_exn =
    Reifier.fmap
      (fun words -> String.of_seq (List.to_seq
        (List.map (fun word -> Char.chr (Word32.to_int word)) words)))
      (Std.List.prj_exn Word32.prj_exn)

  let reify = Std.List.reify Word32.reify
end

module Value =
  struct

    @type ('string, 'int) value_a =
      Int     of 'int
    | String  of 'int
    | Array   of 'int
    | Sexp    of 'string * 'int
    | Closure of 'int * 'int
    | Builtin of 'string
    | Empty    
    with show, gmap

    @type t     = (string          , int          ) value_a               with show
    @type logic = (ByteString.logic, Word32.logic) value_a OCanren.logic with show

    let fmapt fs fi subj =
      let open Env.Monad in
      return (gmap(value_a)) <*> fs <*> fi <*> subj

    let prj_exn =
      let open Env.Monad in
      Reifier.fix
        (fun self -> prj_exn <..>
                       (chain (fmapt ByteString.prj_exn
                                     (fun env x -> Word32.to_int @@ Word32.prj_exn env x)
        )))

    let reify =
      let open Env.Monad in
      Reifier.fix
        (fun self ->
          reify <..>
            (chain
               (Reifier.zed
                  (Reifier.rework ~fv:(fmapt ByteString.reify Word32.reify)))))

    let int     x   = inj @@ Int x
    let string  x   = inj @@ String   x
    let array   x   = inj @@ Array    x
    let sexp    s x = inj @@ Sexp    (s, x)
    let closure x y = inj @@ Closure (x, y)
    let builtin s   = inj @@ Builtin s
    let empty   ()  = inj Empty    

    let kind value result =
      ocanren {
        fresh number, name, entry in
          value == Int number & result == !(Word32.word 0) |
          value == String number & result == !(Word32.word 1) |
          value == Array number & result == !(Word32.word 2) |
          value == Sexp (name, number) & result == !(Word32.word 3) |
          value == Closure (entry, number) & result == !(Word32.word 4) |
          value == Builtin name & result == !(Word32.word 5) |
          value == Empty & result == !(Word32.word 6)
      }

  end

module Insn =
  struct
    
    @type ('string, 'bytes, 'int, 'patt, 'des, 'desList) insn_a =
      BINOP        of 'string
    | CONST        of 'int
    | STRING       of 'bytes
    | SEXP         of 'bytes * 'int
    | LD           of 'des
    | ST           of 'des
    | STA
    | ELEM
    | JMP          of 'int
    | CJMP         of 'string * 'int
    | BEGIN        of 'int * 'int
    | END
    | CLOSURE      of 'int * 'desList
    | CALLC        of 'int
    | CALL         of 'int * 'int
    | BUILTIN      of 'bytes * 'int
    | CALL_TAIL    of 'int * 'int
    | CALLC_TAIL   of 'int
    | BUILTIN_TAIL of 'bytes * 'int
    | RET
    | DROP
    | DUP
    | SWAP
    | TAG          of 'bytes * 'int
    | ARRAY        of 'int
    | PATT         of 'patt
    | FAIL         of 'int * 'int
    | LINE         of 'int
    with show, gmap

    @type t     = (string, string, int, Patt.t, Designation.t, Designation.t list) insn_a with show
    @type logic = (Std.String.logic, ByteString.logic, Word32.logic, Patt.logic, Designation.logic, Designation.logic Std.List.logic) insn_a OCanren.logic with show
    
    let fmapt fs fb fi fp fd fdl subj =
      let open Env.Monad in
      return (gmap(insn_a)) <*> fs <*> fb <*> fi <*> fp <*> fd <*> fdl <*> subj

    let prj_exn env =
      let open Env.Monad in
      Reifier.fix
        (fun self -> prj_exn <..>
                       (chain (fmapt Std.String.prj_exn ByteString.prj_exn
                                     (fun env x -> Word32.to_int @@ Word32.prj_exn env x)
                                      Patt.prj_exn
                                      Designation.prj_exn
                                      (Std.List.prj_exn Designation.prj_exn)
        ))) env 

    let reify env =
      let open Env.Monad in
      Reifier.fix
        (fun self ->
          reify <..>
            (chain
               (Reifier.zed
                  (Reifier.rework ~fv:(fmapt Std.String.reify ByteString.reify
                                             Word32.reify
                                             Patt.reify
                                             Designation.reify
                                             (Std.List.reify Designation.reify)
        ))))) env
    
    let bINOP        s    = inj @@ BINOP         s
    let cONST        n    = inj @@ CONST         n
    let sTRING       s    = inj @@ STRING        s
    let sEXP         s n  = inj @@ SEXP         (s, n)
    let lD           d    = inj @@ LD d
    let sT           d    = inj @@ ST d
    let sTA          ()   = inj @@ STA
    let eLEM         ()   = inj @@ ELEM
    let jMP          n    = inj @@ JMP           n
    let cJMP         s n  = inj @@ CJMP         (s, n)
    let bEGIN        x y  = inj @@ BEGIN        (x, y)
    let eND          ()   = inj @@ END
    let cLOSURE      n ds = inj @@ CLOSURE      (n, ds)
    let cALLC        n    = inj @@ CALLC         n
    let cALL         x y  = inj @@ CALL         (x, y)
    let bUILTIN      s n  = inj @@ BUILTIN      (s, n)
    let cALL_TAIL    x y  = inj @@ CALL_TAIL    (x, y)
    let cALLC_TAIL   n    = inj @@ CALLC_TAIL    n
    let bUILTIN_TAIL s n  = inj @@ BUILTIN_TAIL (s, n)
    let rET          ()   = inj @@ RET
    let dROP         ()   = inj @@ DROP
    let dUP          ()   = inj @@ DUP
    let sWAP         ()   = inj @@ SWAP
    let tAG          s n  = inj @@ TAG          (s, n)
    let aRRAY        n    = inj @@ ARRAY         n
    let pATT         p    = inj @@ PATT          p
    let fAIL         l c  = inj @@ FAIL         (l, c)
    let lINE         n    = inj @@ LINE          n

    let isBegin instruction matches =
      ocanren {
        fresh text, bytes, first, second, pattern, designation, designations in
          instruction == BEGIN (first, second) & matches == true |
          matches == false &
          {instruction == BINOP text |
           instruction == CONST first |
           instruction == STRING bytes |
           instruction == SEXP (bytes, first) |
           instruction == LD designation |
           instruction == ST designation |
           instruction == STA |
           instruction == ELEM |
           instruction == JMP first |
           instruction == CJMP (text, first) |
           instruction == END |
           instruction == CLOSURE (first, designations) |
           instruction == CALLC first |
           instruction == CALL (first, second) |
           instruction == BUILTIN (bytes, first) |
           instruction == CALL_TAIL (first, second) |
           instruction == CALLC_TAIL first |
           instruction == BUILTIN_TAIL (bytes, first) |
           instruction == RET |
           instruction == DROP |
           instruction == DUP |
           instruction == SWAP |
           instruction == TAG (bytes, first) |
           instruction == ARRAY first |
           instruction == PATT pattern |
           instruction == FAIL (first, second) |
           instruction == LINE first}
      }
    
  end

module Prog =
  struct

    @type ('insn, 'int, 'pair) prog_a = MkProg of 'insn * 'int * 'pair with show, gmap

    @type t     = (Insn.t list, int, (int * string) list) prog_a               with show
    @type logic = (Insn.logic Std.List.logic, Word32.logic, (Word32.logic, ByteString.logic) Std.Pair.logic Std.List.logic) prog_a OCanren.logic with show

    let fmapt fil fe fifn subj =
      let open Env.Monad in
      return (gmap(prog_a)) <*> fil <*> fe <*> fifn <*> subj

    let prj_exn =
      let open Env.Monad in
      Reifier.fix
        (fun self -> prj_exn <..>
           (chain (fmapt
              (Std.List.prj_exn Insn.prj_exn)
              (fun env x -> Word32.to_int @@ Word32.prj_exn env x)
              (Std.List.prj_exn (Std.Pair.prj_exn
                 (fun env x -> Word32.to_int @@ Word32.prj_exn env x)
                 ByteString.prj_exn)))))

    let reify =
      let open Env.Monad in
      Reifier.fix
        (fun self -> reify <..>
           (chain (Reifier.zed
              (Reifier.rework ~fv:(fmapt
                 (Std.List.reify Insn.reify)
                 Word32.reify
                 (Std.List.reify (Std.Pair.reify Word32.reify ByteString.reify)))))))

    let rec listLengthFrom values position length =
      ocanren {
        values == [] & Word32.eqo length !(Word32.word position) true |
        fresh value, remaining in
          values == value :: remaining &
          Word32.gto length !(Word32.word position) true &
          listLengthFrom remaining !(position + 1) length
      }

    let listLength values length =
      listLengthFrom values 0 length

    let rec lookupInstructionFrom instructions position address found =
      ocanren {
        instructions == [] & found == None |
        fresh instruction, remaining in
          instructions == instruction :: remaining &
          {Word32.eqo address !(Word32.word position) true & found == Some instruction |
           Word32.gto address !(Word32.word position) true &
           lookupInstructionFrom remaining !(position + 1) address found}
      }

    let finished program instructionAddress =
      ocanren {
        fresh instructions, addr, env in
          program == MkProg (instructions, addr, env) &
        listLength instructions instructionAddress
      }

    let make instructions entry functionNames =
      inj @@ MkProg (instructions, entry, functionNames)

    let lookupInstruction instructions address found =
      lookupInstructionFrom instructions 0 address found

  end

module Loc = struct
  @type ('args, 'locals, 'closure) loc_a = 
    | Loc of 'args * 'locals * 'closure
  with show, gmap

  @type t = ((int * Value.t) list, (int * Value.t) list, int Std.Option.t) loc_a with show
  @type logic = ((Word32.logic, Value.logic) Std.Pair.logic Std.List.logic, 
                 (Word32.logic, Value.logic) Std.Pair.logic Std.List.logic, 
                 Word32.logic Std.Option.logic) loc_a OCanren.logic with show

  let fmapt fa fl fc subj =
    let open Env.Monad in
    return (gmap(loc_a)) <*> fa <*> fl <*> fc <*> subj

  let prj_exn env =
    let open Env.Monad in
    Reifier.fix (fun self ->
      prj_exn <..> (chain (fmapt (Std.List.prj_exn (Std.Pair.prj_exn 
                                                      (fun env x -> Word32.to_int @@ Word32.prj_exn env x)
                                                      Value.prj_exn))
                                 (Std.List.prj_exn (Std.Pair.prj_exn 
                                                      (fun env x -> Word32.to_int @@ Word32.prj_exn env x)
                                                      Value.prj_exn))
                                 (Std.Option.prj_exn (fun env x -> Word32.to_int @@ Word32.prj_exn env x))
                          ))) env

  let reify env =
    let open Env.Monad in
    Reifier.fix (fun self ->
      reify <..> (chain (Reifier.zed (Reifier.rework ~fv:(fmapt (Std.List.reify (Std.Pair.reify Word32.reify Value.reify))
                                                              (Std.List.reify (Std.Pair.reify Word32.reify Value.reify))
                                                              (Std.Option.reify Word32.reify)))))) env
  let loc args locals closure = inj @@ Loc (args, locals, closure)

  let emptyLoc environment =
    ocanren {
      environment == Loc ([], [], None)
    }
end

module Frame = struct
  @type ('int, 'loc, 'values) frame_a = Frame of 'int * 'loc * 'values with show, gmap
  
  @type t = (int, Loc.t, Value.t list) frame_a with show
  @type logic = (Word32.logic, Loc.logic, Value.logic Std.List.logic) frame_a OCanren.logic with show

  let fmapt fi fl fv subj =
    let open Env.Monad in
    return (gmap(frame_a)) <*> fi <*> fl <*> fv <*> subj

  let prj_exn env =
    let open Env.Monad in
    Reifier.fix (fun self ->
      prj_exn <..> (chain (fmapt (fun env x -> Word32.to_int @@ Word32.prj_exn env x)
                                 Loc.prj_exn
                                 (Std.List.prj_exn Value.prj_exn)))) env

  let reify env =
    let open Env.Monad in
    Reifier.fix (fun self ->
      reify <..> (chain (Reifier.zed (Reifier.rework ~fv:(fmapt Word32.reify
                                                              Loc.reify
                                                              (Std.List.reify Value.reify)))))) env

  let frame i l v = inj @@ Frame (i, l, v)
end

module Store = struct
  @type 'a t_a = Store of 'a with show, gmap
  
  @type t = (int * Value.t list) list t_a with show
  @type logic = (Word32.logic, Value.logic Std.List.logic) Std.Pair.logic Std.List.logic t_a OCanren.logic with show

  let fmapt fs subj =
    let open Env.Monad in
    return (gmap(t_a)) <*> fs <*> subj

  let prj_exn env =
    let open Env.Monad in
    Reifier.fix (fun self ->
      prj_exn <..> (chain (fmapt (Std.List.prj_exn (Std.Pair.prj_exn 
                                                      (fun env x -> Word32.to_int @@ Word32.prj_exn env x)
                                                      (Std.List.prj_exn Value.prj_exn)))))) env

  let reify env =
    let open Env.Monad in
    Reifier.fix (fun self ->
      reify <..> (chain (Reifier.zed (Reifier.rework ~fv:(fmapt (Std.List.reify (Std.Pair.reify Word32.reify (Std.List.reify Value.reify)))))))) env

  let store pairs = inj @@ Store pairs
end

module Config = struct
  @type ('frames, 'stk, 'glob, 'loc, 'inp, 'out, 'store, 'nextId) config_a = 
    | Config of 'frames * 'stk * 'glob * 'loc * 'inp * 'out * 'store * 'nextId
  with show, gmap

  @type t = (Frame.t list, Value.t list, (string * Value.t) list, Loc.t, int list, int list, Store.t, int) config_a with show
  @type logic = (Frame.logic Std.List.logic, 
                 Value.logic Std.List.logic, 
                 (Std.String.logic, Value.logic) Std.Pair.logic Std.List.logic, 
                 Loc.logic, 
                 Word32.logic Std.List.logic, 
                 Word32.logic Std.List.logic, 
                 Store.logic, 
                 Word32.logic) config_a OCanren.logic with show

  let fmapt ff fs fg fl fi fo fst fn subj =
    let open Env.Monad in
    return (gmap(config_a)) <*> ff <*> fs <*> fg <*> fl <*> fi <*> fo <*> fst <*> fn <*> subj

  let prj_exn env =
    let open Env.Monad in
    Reifier.fix (fun self ->
      prj_exn <..> (chain (fmapt (Std.List.prj_exn Frame.prj_exn)
                                 (Std.List.prj_exn Value.prj_exn)
                                 (Std.List.prj_exn (Std.Pair.prj_exn Std.String.prj_exn Value.prj_exn))
                                 Loc.prj_exn
                                 (Std.List.prj_exn (fun env x -> Word32.to_int @@ Word32.prj_exn env x))
                                 (Std.List.prj_exn (fun env x -> Word32.to_int @@ Word32.prj_exn env x))
                                 Store.prj_exn
                                 (fun env x -> Word32.to_int @@ Word32.prj_exn env x)))) env

  let reify env =
    let open Env.Monad in
    Reifier.fix (fun self ->
      reify <..> (chain (Reifier.zed (Reifier.rework ~fv:(fmapt (Std.List.reify Frame.reify)
                                                              (Std.List.reify Value.reify)
                                                              (Std.List.reify (Std.Pair.reify Std.String.reify Value.reify))
                                                              Loc.reify
                                                              (Std.List.reify Word32.reify)
                                                              (Std.List.reify Word32.reify)
                                                              Store.reify
                                                              Word32.reify))))) env

  let config cstack stk glob loc inp out store nextId = 
    inj @@ Config (cstack, stk, glob, loc, inp, out, store, nextId)

  let initialConfig inputs state =
    ocanren {
      fresh environment in
        Loc.emptyLoc environment &
        state == Config ([], [], [], environment, inputs, [], Store.Store [], !(Word32.word 0))
    }
end

module SM = struct
  @type ('message, 'value) sm_a =
    | Left of 'message
    | Right of 'value
  with show, gmap

  @type 'value t = (string, 'value) sm_a with show
  @type 'value logic = (Std.String.logic, 'value) sm_a OCanren.logic with show

  let fmapt fm fv subj =
    let open Env.Monad in
    return (gmap(sm_a)) <*> fm <*> fv <*> subj

  let prj_exn value_prj env =
    let open Env.Monad in
    (prj_exn <..> (chain (fmapt Std.String.prj_exn value_prj))) env

  let reify value_reify env =
    let open Env.Monad in
    (reify <..> (chain (Reifier.zed (Reifier.rework
      ~fv:(fmapt Std.String.reify value_reify))))) env

  let throwSM message = Left message

  let throwSM_inj message = inj (throwSM message)

  let rec mapM relation values result =
    ocanren {
      values == [] & result == Right [] |
      fresh value, remaining, currentResult, mappedValue, remainingResult, mappedRemaining, message in
        values == value :: remaining & relation value currentResult &
        {currentResult == Left message & result == Left message |
         currentResult == Right mappedValue &
         {remainingResult == Left message & result == Left message |
          remainingResult == Right mappedRemaining & result == Right (mappedValue :: mappedRemaining)} &
         mapM relation remaining remainingResult}
    }

  let initialState program inputs result =
    ocanren {
      fresh instructions, entry, functionNames, found, instruction, valid, state in
        program == Prog.MkProg (instructions, entry, functionNames) &
        Prog.lookupInstruction instructions entry found &
        {found == None & valid == false |
         found == Some instruction & Insn.isBegin instruction valid} &
        {valid == true & Config.initialConfig inputs state & result == Right state |
         valid == false & result == throwSM_inj !(inj "main does not point to BEGIN")}
    }

  let currentInstruction program instructionAddress result =
    ocanren {
      fresh instructions, entry, functionNames, found, instruction in
        program == Prog.MkProg (instructions, entry, functionNames) &
        Prog.lookupInstruction instructions instructionAddress found &
        {found == Some instruction & result == Right instruction |
         found == None & result == throwSM_inj !(inj "Invalid instruction address")}
    }

  let jumpTo program targetAddress result =
    ocanren {
      fresh instructionResult, instruction, message in
        {instructionResult == Right instruction & result == Right targetAddress |
         instructionResult == Left message & result == Left message} &
        currentInstruction program targetAddress instructionResult
    }

  let b2i boolean number =
    ocanren {
      boolean == true & number == !(Word32.word 1) |
      boolean == false & number == !(Word32.word 0)
    }

  let toInt value result =
    ocanren {
      fresh number, objectId, entry, name in
        value == Value.Int number & result == Right number |
        result == throwSM_inj !(inj "expected int") &
        {value == Value.String objectId |
         value == Value.Array objectId |
         value == Value.Sexp (name, objectId) |
         value == Value.Closure (entry, objectId) |
         value == Value.Builtin name |
         value == Value.Empty}
    }

  let renderChar value result =
    ocanren {
      fresh objectId, entry, name in
        value == Value.Int result |
        result == !(Word32.word 63) &
        {value == Value.String objectId |
         value == Value.Array objectId |
         value == Value.Sexp (name, objectId) |
         value == Value.Closure (entry, objectId) |
         value == Value.Builtin name |
         value == Value.Empty}
    }

  let splitStack count stack result =
    ocanren {
      fresh taken, rest, size in
        result == Right (Std.pair taken rest) &
        Std.List.appendo taken rest stack &
        Prog.listLength taken count |
        result == throwSM_inj !(inj "stack underflow") &
        Word32.gto count size true &
        Prog.listLength stack size
    }

  let safeIndex values index what result =
    ocanren {
      fresh found, value in
        Prog.lookupInstruction values index found &
        {found == Some value & result == Right value |
         found == None & result == throwSM_inj !(inj (what ^ ": index out of bounds"))}
    }

  let replaceAtSM index value values result =
    let rec replaceFrom position values result =
      ocanren {
        values == [] & result == throwSM_inj !(inj "replaceAt: index out of bounds") |
        fresh head, tail, updatedTail, tailResult, message in
          values == head :: tail &
          {Word32.eqo index !(Word32.word position) true & result == Right (value :: tail) |
           Word32.gto index !(Word32.word position) true &
           {result == Left message & tailResult == Left message |
            result == Right (head :: updatedTail) & tailResult == Right updatedTail} &
           replaceFrom !(position + 1) tail tailResult}
      }
    in
    replaceFrom 0 values result

  let sameValue leftValue rightValue same =
    ocanren {
      fresh leftNumber, rightNumber, leftName, rightName, leftEntry, rightEntry,
            leftKind, rightKind in
        {leftValue == Value.Int leftNumber & rightValue == Value.Int rightNumber |
         leftValue == Value.String leftNumber & rightValue == Value.String rightNumber |
         leftValue == Value.Array leftNumber & rightValue == Value.Array rightNumber |
         leftValue == Value.Sexp (leftName, leftNumber) &
         rightValue == Value.Sexp (rightName, rightNumber) |
         leftValue == Value.Closure (leftEntry, leftNumber) &
         rightValue == Value.Closure (rightEntry, rightNumber)} &
        Word32.eqo leftNumber rightNumber same |
        leftValue == Value.Builtin leftName & rightValue == Value.Builtin rightName &
        Std.eqo leftName rightName same |
        leftValue == Value.Empty & rightValue == Value.Empty & same == true |
        same == false &
        Value.kind leftValue leftKind & Value.kind rightValue rightKind &
        Word32.eqo leftKind rightKind false
    }

  let binopFunc operator left right result =
    let supportedOperators = ["+"; "-"; "*"; "/"; "%"; "<"; "<="; ">"; ">="; "=="; "!="; "&&"; "!!"] in
    let unknownOperator = List.fold_right (fun name rest ->
      Std.eqo operator (inj name) (inj false) &&& rest
    ) supportedOperators success in
    ocanren {
      fresh number, quotient, remainder, boolean, opposite, leftTruthy, rightTruthy in
        result == Right number &
        {operator == !(inj "+") & Word32.addo left right number |
         operator == !(inj "-") & Word32.subo left right number |
         operator == !(inj "*") & Word32.mulo left right number |
         {operator == !(inj "/") & number == quotient |
          operator == !(inj "%") & number == remainder} &
         Word32.divmodo left right quotient remainder |
         operator == !(inj "<") & Word32.lto left right boolean & b2i boolean number |
         operator == !(inj "<=") & Std.Bool.noto boolean opposite &
         Word32.gto left right opposite & b2i boolean number |
         operator == !(inj ">") & Word32.gto left right boolean & b2i boolean number |
         operator == !(inj ">=") & Std.Bool.noto boolean opposite &
         Word32.lto left right opposite & b2i boolean number |
         operator == !(inj "==") & Word32.eqo left right boolean & b2i boolean number |
         operator == !(inj "!=") & Std.Bool.noto boolean opposite &
         Word32.eqo left right opposite & b2i boolean number |
         operator == !(inj "&&") & Std.Bool.ando leftTruthy rightTruthy boolean &
         Word32.gto left !(Word32.word 0) leftTruthy &
         Word32.gto right !(Word32.word 0) rightTruthy & b2i boolean number |
         operator == !(inj "!!") & Std.Bool.oro leftTruthy rightTruthy boolean &
         Word32.gto left !(Word32.word 0) leftTruthy &
         Word32.gto right !(Word32.word 0) rightTruthy & b2i boolean number} |
        operator == !(inj "/") & right == !(Word32.word 0) &
        result == throwSM_inj !(inj "division by zero") |
        operator == !(inj "%") & right == !(Word32.word 0) &
        result == throwSM_inj !(inj "modulo by zero") |
        result == throwSM_inj !(inj "unknown binary operator") & unknownOperator
    }

  let currentClosureId state result =
    ocanren {
      fresh callStack, stack, globals, arguments, locals, closure, inputs, outputs,
            store, nextId, objectId in
        state == Config.Config (callStack, stack, globals, Loc.Loc (arguments, locals, closure),
                                inputs, outputs, store, nextId) &
        {closure == None & result == throwSM_inj !(inj "no active closure") |
         closure == Some objectId & result == Right objectId}
    }

  let lookupBinding keyEqual key bindings error result =
    let matches binding same =
      ocanren {
        fresh boundKey, value in
          binding == Std.pair boundKey value & keyEqual key boundKey same
      }
    in
    ocanren {
      fresh found, boundKey, value in
        Std.List.lookupo matches bindings found &
        {found == Some (Std.pair boundKey value) & result == Right value |
         found == None & result == throwSM_inj !(inj error)}
    }

  let rec insertBinding keyEqual key value bindings updatedBindings =
    ocanren {
      bindings == [] & updatedBindings == [(key, value)] |
      fresh boundKey, previousValue, rest, updatedRest in
        bindings == (boundKey, previousValue) :: rest &
        {keyEqual key boundKey true & updatedBindings == (boundKey, value) :: rest |
         keyEqual key boundKey false & updatedBindings == (boundKey, previousValue) :: updatedRest &
         insertBinding keyEqual key value rest updatedRest}
    }

  let allocStore values state result =
    ocanren {
      fresh callStack, stack, globals, environment, inputs, outputs, bindings, objectId,
            updatedBindings, nextId in
        state == Config.Config (callStack, stack, globals, environment,
                                inputs, outputs, Store.Store bindings, objectId) &
        result == Std.pair objectId
          (Config.Config (callStack, stack, globals, environment,
                          inputs, outputs, Store.Store updatedBindings, nextId)) &
        Word32.addo objectId !(Word32.word 1) nextId &
        insertBinding Word32.eqo objectId values bindings updatedBindings
    }

  let lookupStore objectId state result =
    ocanren {
      fresh callStack, stack, globals, environment, inputs, outputs, bindings, nextId in
        state == Config.Config (callStack, stack, globals, environment,
                                inputs, outputs, Store.Store bindings, nextId) &
        lookupBinding Word32.eqo objectId bindings !("store: missing id") result
    }

  let updateStore objectId values state result =
    let updateBinding binding updatedBinding =
      ocanren {
        fresh storedId, storedValues in
          binding == Std.pair storedId storedValues &
          {Word32.eqo objectId storedId true & updatedBinding == Std.pair storedId values |
           Word32.eqo objectId storedId false & updatedBinding == binding}
      }
    in
    ocanren {
      fresh found, previousValues, message, callStack, stack, globals, environment,
            inputs, outputs, bindings, updatedBindings, nextId in
        lookupStore objectId state found &
        {found == Left message & result == Left message |
         found == Right previousValues &
         state == Config.Config (callStack, stack, globals, environment,
                                 inputs, outputs, Store.Store bindings, nextId) &
         Std.List.mapo updateBinding bindings updatedBindings &
         result == Right (Config.Config (callStack, stack, globals, environment,
                                         inputs, outputs, Store.Store updatedBindings, nextId))}
    }

  let lookupDesignation state designation result =
    ocanren {
      fresh callStack, stack, globals, environment, inputs, outputs, store, nextId,
            arguments, locals, closure, name, index, closureResult, storeResult,
            objectId, capturedValues, message in
        state == Config.Config (callStack, stack, globals, environment, inputs, outputs, store, nextId) &
        {designation == Designation.Global name &
         lookupBinding Std.eqo name globals !("unbound global") result |
         designation == Designation.Local index & environment == Loc.Loc (arguments, locals, closure) &
         lookupBinding Word32.eqo index locals !("unbound local") result |
         designation == Designation.Arg index & environment == Loc.Loc (arguments, locals, closure) &
         lookupBinding Word32.eqo index arguments !("unbound argument") result |
         designation == Designation.Access index & currentClosureId state closureResult &
         {closureResult == Left message & result == Left message |
          closureResult == Right objectId & lookupStore objectId state storeResult &
          {storeResult == Left message & result == Left message |
           storeResult == Right capturedValues & safeIndex capturedValues index !("closure access") result}}}
    }

  let capture state designation result =
    ocanren {
      fresh name, index in
        designation == Designation.Global name & result == throwSM_inj !(inj "CLOSURE: bad designation") |
        {designation == Designation.Local index | designation == Designation.Arg index |
         designation == Designation.Access index} & lookupDesignation state designation result
    }

  let returnFromCall program state result =
    ocanren {
      fresh callStack, stack, globals, environment, inputs, outputs, store, nextId,
            returnAddress, callerLocals, savedStack, remainingFrames in
        state == Config.Config (callStack, stack, globals, environment, inputs, outputs, store, nextId) &
        {callStack == (Frame.Frame (returnAddress, callerLocals, savedStack)) :: remainingFrames &
         result == Right (Std.pair
           (Config.Config (remainingFrames, stack, globals, callerLocals, inputs, outputs, store, nextId))
           returnAddress) |
         callStack == [] & result == Right (Std.pair state returnAddress) &
         Prog.finished program returnAddress}
    }

  let updateDesignation state value designation result =
    ocanren {
      fresh callStack, stack, globals, environment, inputs, outputs, store, nextId,
            arguments, locals, closure, name, index, updatedGlobals, updatedArguments, updatedLocals,
            closureResult, storeResult, replacementResult, objectId, capturedValues, updatedValues, message in
        state == Config.Config (callStack, stack, globals, environment, inputs, outputs, store, nextId) &
        {designation == Designation.Global name &
         result == Right (Config.Config (callStack, stack, updatedGlobals, environment,
                                         inputs, outputs, store, nextId)) &
         insertBinding Std.eqo name value globals updatedGlobals |
         designation == Designation.Local index & environment == Loc.Loc (arguments, locals, closure) &
         result == Right (Config.Config (callStack, stack, globals, Loc.Loc (arguments, updatedLocals, closure),
                                         inputs, outputs, store, nextId)) &
         insertBinding Word32.eqo index value locals updatedLocals |
         designation == Designation.Arg index & environment == Loc.Loc (arguments, locals, closure) &
         result == Right (Config.Config (callStack, stack, globals, Loc.Loc (updatedArguments, locals, closure),
                                         inputs, outputs, store, nextId)) &
         insertBinding Word32.eqo index value arguments updatedArguments |
         designation == Designation.Access index & currentClosureId state closureResult &
         {closureResult == Left message & result == Left message |
          closureResult == Right objectId & lookupStore objectId state storeResult &
          {storeResult == Left message & result == Left message |
           storeResult == Right capturedValues & replaceAtSM index value capturedValues replacementResult &
           {replacementResult == Left message & result == Left message |
            replacementResult == Right updatedValues & updateStore objectId updatedValues state result}}}}
    }

  let showValue program state value result =
    let rec show value output tail =
      let showInt number output tail =
        let powers = [|1; 10; 100; 1000; 10000; 100000; 1000000; 10000000; 100000000; 1000000000|] in
        let rec digits count prefix first codes =
          if count = 0 then ocanren { number == !(Word32.word prefix) & codes == [] }
          else
            let place = powers.(count - 1) in
            let candidates = List.init (if first then 9 else 10)
              (fun offset -> offset + if first then 1 else 0) in
            let candidates = List.filter (fun digit ->
              (prefix * 10 + digit) * place <= Word32.max_value) candidates in
            conde (List.map (fun digit ->
              let nextPrefix = prefix * 10 + digit in
              let minimum = nextPrefix * place in
              let maximum = Stdlib.min Word32.max_value (minimum + place - 1) in
              Fresh.one (fun remaining ->
                (codes === Std.List.cons (Word32.word (48 + digit)) remaining) &&&
                Word32.lto number (Word32.word minimum) (inj false) &&&
                Word32.gto number (Word32.word maximum) (inj false) &&&
                digits (count - 1) nextPrefix false remaining)
            ) candidates)
        in
        conde (List.init 10 (fun offset ->
          let count = offset + 1 in
          Fresh.one (fun codes ->
            Std.List.lengtho codes (Std.nat count) &&&
            Std.List.appendo codes tail output &&&
            digits count 0 (count > 1) codes)
        ))
      in
      let rec showFields fields output tail =
        ocanren {
          fields == [] & output == tail |
          fresh field, remaining, afterField, next, rest, afterSeparator in
            fields == field :: remaining & show field output afterField &
            {remaining == [] & afterField == tail |
             remaining == next :: rest &
             afterField == !(Word32.word 44) :: !(Word32.word 32) :: afterSeparator &
             showFields remaining afterSeparator tail}
        }
      in
      let showString objectId =
        let rec showCharacters fields output tail =
          ocanren {
            fields == [] & output == tail |
            fresh field, remaining, code, rest in
              fields == field :: remaining & output == code :: rest &
              renderChar field code &
              showCharacters remaining rest tail
          }
        in
        ocanren {
          fresh found, fields, message, contents in
            lookupStore objectId state found &
            {found == Left message & Std.List.appendo !(ByteString.inj "<string#?>") tail output |
             found == Right fields & output == !(Word32.word 34) :: contents &
             showCharacters fields contents (!(Word32.word 34) :: tail)}
        }
      in
      let showArray objectId =
        ocanren {
          fresh found, fields, message, contents in
            lookupStore objectId state found &
            {found == Left message & Std.List.appendo !(ByteString.inj "<array#?>") tail output |
             found == Right fields & output == !(Word32.word 91) :: contents &
             showFields fields contents (!(Word32.word 93) :: tail)}
        }
      in
      let showSexp name objectId =
        ocanren {
          fresh found, message, afterName, contents, field, remaining in
            lookupStore objectId state found &
            {found == Left message & output == !(Word32.word 60) :: contents &
             Std.List.appendo name afterName contents &
             Std.List.appendo !(ByteString.inj "#?>") tail afterName |
             found == Right [] & Std.List.appendo name tail output |
             found == Right (field :: remaining) &
             Std.List.appendo name afterName output &
             afterName == !(Word32.word 32) :: !(Word32.word 40) :: contents &
             showFields (field :: remaining) contents (!(Word32.word 41) :: tail)}
        }
      in
      let showClosure entryAddress =
        ocanren {
          fresh instructions, entry, names, found, name, message, contents in
            program == Prog.MkProg (instructions, entry, names) &
            lookupBinding Word32.eqo entryAddress names !("function name not found") found &
            Std.List.appendo !(ByteString.inj "<closure ") contents output &
            {found == Right name & Std.List.appendo name (!(Word32.word 62) :: tail) contents |
             found == Left message &
             showInt entryAddress contents (!(Word32.word 62) :: tail)}
        }
      in
      let showBuiltin name =
        ocanren {
          fresh contents in
            Std.List.appendo !(ByteString.inj "<builtin ") contents output &
            Std.List.appendo name (!(Word32.word 62) :: tail) contents
        }
      in
      let showEmpty output tail =
        Std.List.appendo (ByteString.inj "<empty>") tail output
      in
      ocanren {
        fresh number, objectId, name, entryAddress in
          value == Value.Int number & showInt number output tail |
          value == Value.String objectId & showString objectId |
          value == Value.Array objectId & showArray objectId |
          value == Value.Sexp (name, objectId) & showSexp name objectId |
          value == Value.Closure (entryAddress, objectId) & showClosure entryAddress |
          value == Value.Builtin name & showBuiltin name |
          value == Value.Empty & showEmpty output tail
      }
    in
    show value result (Std.List.nil ())

  let builtin program name arguments state result =
    let pushValue value state result =
      ocanren {
        fresh callStack, stack, globals, environment, inputs, outputs, store, nextId in
          state == Config.Config (callStack, stack, globals, environment, inputs, outputs, store, nextId) &
          result == Right (Config.Config (callStack, value :: stack, globals, environment,
                                          inputs, outputs, store, nextId))
      }
    in
    let wrongArity =
      ocanren {
        arguments == [] |
        fresh first, second, remaining in arguments == first :: second :: remaining
      }
    in
    let read state result =
      ocanren {
        fresh callStack, stack, globals, environment, inputs, outputs, store, nextId, number, remaining in
          state == Config.Config (callStack, stack, globals, environment, inputs, outputs, store, nextId) &
          {inputs == [] & result == !(throwSM_inj (inj "read: no input available")) |
           inputs == number :: remaining &
           result == Right (Config.Config (callStack, (Value.Int number) :: stack, globals, environment,
                                           remaining, outputs, store, nextId))}
      }
    in
    let write state result =
      ocanren {
        wrongArity & result == !(throwSM_inj (inj "write: bad args")) |
        fresh value, converted, number, message, callStack, stack, globals, environment,
              inputs, outputs, updatedOutputs, store, nextId in
          arguments == [value] & toInt value converted &
          {converted == Left message & result == !(throwSM_inj (inj "write: bad args")) |
           converted == Right number &
           state == Config.Config (callStack, stack, globals, environment, inputs, outputs, store, nextId) &
           result == Right (Config.Config (callStack, Value.Empty :: stack, globals, environment,
                                           inputs, updatedOutputs, store, nextId)) &
           Std.List.appendo outputs [number] updatedOutputs}
      }
    in
    let length state result =
      ocanren {
        wrongArity & result == !(throwSM_inj (inj "length: bad args")) |
        fresh value, objectId, name, entryAddress, number, found, fields, message in
          arguments == [value] &
          {{value == Value.String objectId | value == Value.Array objectId | value == Value.Sexp (name, objectId)} &
           lookupStore objectId state found &
           {found == Left message & result == Left message |
            found == Right fields & pushValue (Value.Int number) state result & Prog.listLength fields number} |
           {value == Value.Int number | value == Value.Closure (entryAddress, objectId) |
            value == Value.Builtin name | value == Value.Empty} &
           result == !(throwSM_inj (inj "length: bad args"))}
      }
    in
    let string state result =
      ocanren {
        wrongArity & result == !(throwSM_inj (inj "string: bad args")) |
        fresh value, codes, fields, objectId, allocatedState in
          arguments == [value] &
          pushValue (Value.String objectId) allocatedState result &
          allocStore fields state (Std.pair objectId allocatedState) &
          showValue program state value codes &
          Std.List.mapo !(fun code field -> field === Value.int code) codes fields
      }
    in
    let array state result =
      ocanren {
        fresh objectId, allocatedState in
          pushValue (Value.Array objectId) allocatedState result &
          allocStore arguments state (Std.pair objectId allocatedState)
      }
    in
    let unknownName =
      List.fold_right (fun known remaining ->
        Std.eqo name (ByteString.inj known) (inj false) &&& remaining
      ) ["read"; "write"; "length"; "string"; ".array"] success
    in
    ocanren {
      name == !(ByteString.inj "read") & read state result |
      name == !(ByteString.inj "write") & write state result |
      name == !(ByteString.inj "length") & length state result |
      name == !(ByteString.inj "string") & string state result |
      name == !(ByteString.inj ".array") & array state result |
      unknownName & result == !(throwSM_inj (inj "unknown builtin"))
    }
  let executeInstruction program state instruction nextAddress result =
    let finishInstruction updatedState address =
      ocanren { result == Right (Std.pair updatedState address) }
    in
    let error message = result === throwSM_inj (inj message) in
    let bind outcome continuation =
      ocanren {
        fresh value, message in
          outcome == Left message & result == Left message |
          outcome == Right value & continuation value
      }
    in
    let stackOf source stack =
      ocanren {
        fresh frames, globals, environment, inputs, outputs, store, nextId in
          source == Config.Config (frames, stack, globals, environment, inputs, outputs, store, nextId)
      }
    in
    let setStack source stack updatedState =
      ocanren {
        fresh frames, oldStack, globals, environment, inputs, outputs, store, nextId in
          source == Config.Config (frames, oldStack, globals, environment, inputs, outputs, store, nextId) &
          updatedState == Config.Config (frames, stack, globals, environment, inputs, outputs, store, nextId)
      }
    in
    let withStack stack =
      Fresh.one (fun updatedState ->
        finishInstruction updatedState nextAddress &&& setStack state stack updatedState)
    in
    let pushValue value =
      Fresh.one (fun stack -> stackOf state stack &&& withStack (Std.List.cons value stack))
    in
    let pop count message action =
      Fresh.two (fun stack split ->
        stackOf state stack &&& splitStack count stack split &&&
        ocanren {
          fresh taken, remaining, reason in
            split == Left reason & result == Left !(inj message) |
            split == Right (Std.pair taken remaining) & action taken remaining
        })
    in
    let indexValues values bindings =
      let rec enumerate index values bindings =
        ocanren {
          values == [] & bindings == [] |
          fresh value, remaining, rest in
            values == value :: remaining & bindings == (!(Word32.word index), value) :: rest &
            enumerate !(index + 1) remaining rest
        }
      in
      enumerate 0 values bindings
    in
    let emptyLocals count bindings =
      let rec fill index bindings =
        ocanren {
          bindings == [] & Word32.eqo count !(Word32.word index) true |
          fresh remaining in
            bindings == (!(Word32.word index), Value.Empty) :: remaining &
            Word32.gto count !(Word32.word index) true & fill !(index + 1) remaining
        }
      in
      fill 0 bindings
    in
    let containerId value context found =
      ocanren {
        fresh objectId, name, number, entry in
          {value == Value.String objectId | value == Value.Array objectId |
           value == Value.Sexp (name, objectId)} & found == Right objectId |
          {value == Value.Int number | value == Value.Closure (entry, objectId) |
           value == Value.Builtin name | value == Value.Empty} &
          found == Left !(inj (context ^ ": not a container"))
      }
    in
    let allocate fields makeValue remaining =
      Fresh.three (fun objectId allocatedState updatedState ->
        allocStore fields state (Std.pair objectId allocatedState) &&&
        setStack allocatedState (Std.List.cons (makeValue objectId) remaining) updatedState &&&
        finishInstruction updatedState nextAddress)
    in
    let booleanResult boolean remaining =
      Fresh.one (fun number ->
        b2i boolean number &&& withStack (Std.List.cons (Value.int number) remaining))
    in
    let line _ = finishInstruction state nextAddress in
    let const number = pushValue (Value.int number) in
    let string codes =
      Fresh.two (fun fields stack ->
        stackOf state stack &&&
        Std.List.mapo (fun code field -> field === Value.int code) codes fields &&&
        allocate fields Value.string stack)
    in
    let sexp name count =
      pop count "stack underflow" (fun taken remaining ->
        Fresh.one (fun fields ->
          Std.List.reverso fields taken &&& allocate fields (Value.sexp name) remaining))
    in
    let binop operator =
      let equality taken remaining =
        ocanren {
          fresh right, left, same in
            taken == [right; left] & sameValue left right same & booleanResult same remaining
        }
      in
      let arithmetic taken remaining =
        Fresh.three (fun right left leftResult ->
          (ocanren { taken == [right; left] }) &&& toInt left leftResult &&&
          bind leftResult (fun leftNumber ->
            Fresh.one (fun rightResult ->
              toInt right rightResult &&& bind rightResult (fun rightNumber ->
                Fresh.one (fun computed ->
                  binopFunc operator leftNumber rightNumber computed &&&
                  bind computed (fun number -> withStack (Std.List.cons (Value.int number) remaining)))))))
      in
      conde [
        (operator === inj "==") &&& pop (Word32.word 2) "BINOP ==: stack underflow" equality;
        Std.eqo operator (inj "==") (inj false) &&&
        pop (Word32.word 2) "BINOP: stack underflow" arithmetic
      ]
    in
    let elem _ =
      pop (Word32.word 2) "ELEM: stack underflow" (fun taken remaining ->
        Fresh.three (fun indexValue container converted ->
          (ocanren { taken == [indexValue; container] }) &&& toInt indexValue converted &&&
          bind converted (fun index ->
            Fresh.one (fun identified ->
              containerId container "ELEM" identified &&& bind identified (fun objectId ->
                Fresh.one (fun found ->
                  lookupStore objectId state found &&& bind found (fun fields ->
                    Fresh.one (fun selected ->
                      safeIndex fields index "ELEM" selected &&&
                      bind selected (fun value -> withStack (Std.List.cons value remaining))))))))))
    in
    let ld designation =
      Fresh.one (fun found -> lookupDesignation state designation found &&& bind found pushValue)
    in
    let st designation =
      pop (Word32.word 1) "ST: stack underflow" (fun taken remaining ->
        Fresh.two (fun value updated ->
          (ocanren { taken == [value] }) &&& updateDesignation state value designation updated &&&
          bind updated (fun updatedState -> finishInstruction updatedState nextAddress)))
    in
    let sta _ =
      pop (Word32.word 2) "STA: stack underflow" (fun taken remaining ->
        Fresh.three (fun value indexValue kind ->
          (ocanren { taken == [value; indexValue] }) &&&
          conde [
            Value.kind indexValue kind &&& Word32.eqo kind (Word32.word 0) (inj false) &&&
            error "STA: bad stack shape";
            Fresh.one (fun index ->
              (indexValue === Value.int index) &&&
              conde [
                (remaining === Std.List.nil ()) &&& error "STA: stack underflow";
                Fresh.three (fun container rest identified ->
                  (remaining === Std.List.cons container rest) &&&
                  containerId container "STA" identified &&& bind identified (fun objectId ->
                    let update replacement =
                      Fresh.one (fun found ->
                        lookupStore objectId state found &&& bind found (fun fields ->
                          Fresh.one (fun replaced ->
                            replaceAtSM index replacement fields replaced &&& bind replaced (fun updatedFields ->
                              Fresh.one (fun updated ->
                                updateStore objectId updatedFields state updated &&& bind updated (fun allocatedState ->
                                  Fresh.one (fun updatedState ->
                                    setStack allocatedState (Std.List.cons value rest) updatedState &&&
                                    finishInstruction updatedState nextAddress)))))))
                    in
                    conde [
                      (container === Value.string objectId) &&& Fresh.one (fun converted ->
                        toInt value converted &&& bind converted (fun number -> update (Value.int number)));
                      Fresh.one (fun name ->
                        (ocanren { container == Value.Array objectId | container == Value.Sexp (name, objectId) }) &&&
                        update value)
                    ]))
              ])
          ]))
    in
    let jmp target =
      Fresh.one (fun jumped -> jumpTo program target jumped &&& bind jumped (finishInstruction state))
    in
    let cjmp condition target =
      pop (Word32.word 1) "CJMP: stack underflow" (fun taken remaining ->
        Fresh.two (fun value converted ->
          (ocanren { taken == [value] }) &&& toInt value converted &&&
          bind converted (fun number ->
            Fresh.one (fun takeJump ->
              conde [
                (condition === inj "z") &&& Word32.eqo number (Word32.word 0) takeJump;
                (condition === inj "nz") &&& Word32.gto number (Word32.word 0) takeJump;
                Std.eqo condition (inj "z") (inj false) &&&
                Std.eqo condition (inj "nz") (inj false) &&& (takeJump === inj false)
              ] &&& conde [
                (takeJump === inj false) &&& withStack remaining;
                (takeJump === inj true) &&& Fresh.one (fun jumped ->
                  jumpTo program target jumped &&& bind jumped (fun address ->
                    Fresh.one (fun updated -> setStack state remaining updated &&& finishInstruction updated address)))
              ]))))
    in
    let drop _ =
      pop (Word32.word 1) "DROP: stack underflow" (fun taken remaining -> withStack remaining)
    in
    let dup _ =
      pop (Word32.word 1) "DUP: stack underflow" (fun taken remaining ->
        Fresh.one (fun value ->
          (ocanren { taken == [value] }) &&& withStack (Std.List.cons value (Std.List.cons value remaining))))
    in
    let swap _ =
      pop (Word32.word 2) "SWAP: stack underflow" (fun taken remaining ->
        Fresh.two (fun first second ->
          (ocanren { taken == [first; second] }) &&& withStack (Std.List.cons second (Std.List.cons first remaining))))
    in
    let tag name count =
      pop (Word32.word 1) "TAG: stack underflow" (fun taken remaining ->
        Fresh.two (fun value kind ->
          (ocanren { taken == [value] }) &&& conde [
            Value.kind value kind &&& Word32.eqo kind (Word32.word 3) (inj false) &&&
            booleanResult (inj false) remaining;
            Fresh.three (fun actualName objectId sameName ->
              (value === Value.sexp actualName objectId) &&& Std.eqo name actualName sameName &&&
              conde [
                (sameName === inj false) &&& booleanResult (inj false) remaining;
                (sameName === inj true) &&& Fresh.one (fun found ->
                  lookupStore objectId state found &&& bind found (fun fields ->
                    Fresh.two (fun length sameLength ->
                      Prog.listLength fields length &&& Word32.eqo length count sameLength &&&
                      booleanResult sameLength remaining)))
              ])
          ]))
    in
    let array count =
      pop (Word32.word 1) "ARRAY: stack underflow" (fun taken remaining ->
        Fresh.two (fun value kind ->
          (ocanren { taken == [value] }) &&& conde [
            Value.kind value kind &&& Word32.eqo kind (Word32.word 2) (inj false) &&&
            booleanResult (inj false) remaining;
            Fresh.two (fun objectId found ->
              (value === Value.array objectId) &&& lookupStore objectId state found &&&
              bind found (fun fields ->
                Fresh.two (fun length sameLength ->
                  Prog.listLength fields length &&& Word32.eqo length count sameLength &&&
                  booleanResult sameLength remaining)))
          ]))
    in
    let patt pattern =
      let unary label predicate =
        pop (Word32.word 1) ("PATT " ^ label ^ ": stack underflow") (fun taken remaining ->
          Fresh.three (fun value kind matches ->
            (ocanren { taken == [value] }) &&& Value.kind value kind &&&
            predicate kind matches &&& booleanResult matches remaining))
      in
      let strCmp taken remaining =
        Fresh.two (fun first second ->
          (ocanren { taken == [first; second] }) &&&
          Fresh.three (fun firstKind secondKind bothStrings ->
            Value.kind first firstKind &&& Value.kind second secondKind &&&
            Fresh.two (fun firstString secondString ->
              Word32.eqo firstKind (Word32.word 1) firstString &&&
              Word32.eqo secondKind (Word32.word 1) secondString &&&
              Std.Bool.ando firstString secondString bothStrings) &&&
            conde [
              (bothStrings === inj false) &&& booleanResult (inj false) remaining;
              (bothStrings === inj true) &&& Fresh.three (fun firstId secondId firstResult ->
                (first === Value.string firstId) &&& (second === Value.string secondId) &&&
                lookupStore firstId state firstResult &&& bind firstResult (fun firstFields ->
                  Fresh.one (fun secondResult ->
                    lookupStore secondId state secondResult &&& bind secondResult (fun secondFields ->
                      Fresh.one (fun same ->
                        Std.eqo firstFields secondFields same &&& booleanResult same remaining)))))
            ]))
      in
      conde [
        (pattern === Patt.strCmp ()) &&& pop (Word32.word 2) "PATT StrCmp: stack underflow" strCmp;
        (pattern === Patt.array ()) &&& unary "Array" (fun kind same -> Word32.eqo kind (Word32.word 2) same);
        (pattern === Patt.string ()) &&& unary "String" (fun kind same -> Word32.eqo kind (Word32.word 1) same);
        (pattern === Patt.sexp ()) &&& unary "Sexp" (fun kind same -> Word32.eqo kind (Word32.word 3) same);
        (pattern === Patt.boxed ()) &&& unary "Boxed" (fun kind same -> Word32.gto kind (Word32.word 0) same);
        (pattern === Patt.unBoxed ()) &&& unary "UnBoxed" (fun kind same -> Word32.eqo kind (Word32.word 0) same);
        (pattern === Patt.closure ()) &&& unary "Closure" (fun kind same -> Word32.eqo kind (Word32.word 4) same)
      ]
    in
    let fail _line _column =
      pop (Word32.word 1) "FAIL: empty stack" (fun taken remaining -> error "matching value failed")
    in

    let installCall entryAddress arguments callerStack closure isTail =
      Fresh.one (fun jumpResult ->
        jumpTo program entryAddress jumpResult &&&
        bind jumpResult (fun bodyAddress ->
          ocanren {
            fresh argumentBindings, callStack, stack, globals, environment, inputs,
                  outputs, objects, nextId, updatedFrames, updatedState in
              indexValues arguments argumentBindings &
              state == Config.Config (callStack, stack, globals, environment,
                                      inputs, outputs, objects, nextId) &
              {isTail == true & updatedFrames == callStack |
               isTail == false &
               updatedFrames == (Frame.Frame (nextAddress, environment, callerStack)) :: callStack} &
              updatedState == Config.Config (updatedFrames, callerStack, globals,
                Loc.Loc (argumentBindings, [], closure), inputs, outputs, objects, nextId) &
              finishInstruction updatedState bodyAddress
          }))
    in
    let invokeBuiltin functionName arguments callerStack isTail =
      let runBuiltin source address =
        Fresh.one (fun builtinResult ->
          builtin program functionName arguments source builtinResult &&&
          bind builtinResult (fun calledState -> finishInstruction calledState address))
      in
      Fresh.one (fun poppedState ->
        setStack state callerStack poppedState &&&
        conde [
          (isTail === inj false) &&& runBuiltin poppedState nextAddress;
          (isTail === inj true) &&&
          Fresh.one (fun returnResult ->
            returnFromCall program poppedState returnResult &&&
            bind returnResult (fun returned ->
              ocanren {
                fresh returnedState, returnAddress in
                  returned == Std.pair returnedState returnAddress &
                  runBuiltin returnedState returnAddress
              }))
        ])
    in
    let callClosure argumentCount isTail errorMessage =
      pop argumentCount "stack underflow" (fun taken remaining ->
        Fresh.one (fun arguments ->
          Std.List.reverso arguments taken &&&
          ocanren {
            remaining == [] & result == Left !(inj "stack underflow") |
            fresh callable, callerStack, entryAddress, closureId, functionName,
                  closureResult, callableKind in
              remaining == callable :: callerStack &
              {callable == Value.Closure (entryAddress, closureId) &
               lookupStore closureId state closureResult &
               bind closureResult !(fun capturedValues ->
                 installCall entryAddress arguments callerStack (Std.Option.some closureId) isTail) |
               callable == Value.Builtin functionName &
               invokeBuiltin functionName arguments callerStack isTail |
               Value.kind callable callableKind &
               Word32.eqo callableKind !(Word32.word 4) false &
               Word32.eqo callableKind !(Word32.word 5) false &
               result == Left !(inj errorMessage)}
          }))
    in
    let handleClosure entryAddress designations =
      Fresh.one (fun captureResult ->
        mapM (capture state) designations captureResult &&&
        bind captureResult (fun capturedValues ->
          ocanren {
            fresh allocated, closureId, allocatedState, callStack, stack, globals,
                  environment, inputs, outputs, objects, nextId, updatedState in
              allocStore capturedValues state allocated &
              allocated == Std.pair closureId allocatedState &
              allocatedState == Config.Config (callStack, stack, globals, environment,
                                                inputs, outputs, objects, nextId) &
              setStack allocatedState ((Value.Closure (entryAddress, closureId)) :: stack) updatedState &
              finishInstruction updatedState nextAddress
          }))
    in
    let handleCall entryAddress argumentCount =
      pop argumentCount "stack underflow" (fun taken callerStack ->
        Fresh.one (fun arguments ->
          Std.List.reverso arguments taken &&&
          installCall entryAddress arguments callerStack (Std.Option.none ()) (inj false)))
    in
    let handleBuiltin functionName argumentCount =
      pop argumentCount "stack underflow" (fun taken callerStack ->
        Fresh.one (fun arguments ->
          Std.List.reverso arguments taken &&&
          invokeBuiltin functionName arguments callerStack (inj false)))
    in
    let handleCallClosure argumentCount =
      callClosure argumentCount (inj false) "CALLC: not callable"
    in
    let handleCallTail entryAddress argumentCount =
      pop argumentCount "stack underflow" (fun taken callerStack ->
        Fresh.one (fun arguments ->
          Std.List.reverso arguments taken &&&
          installCall entryAddress arguments callerStack (Std.Option.none ()) (inj true)))
    in
    let handleCallClosureTail argumentCount =
      callClosure argumentCount (inj true) "CALLC_TAIL: not callable"
    in
    let handleBuiltinTail functionName argumentCount =
      pop argumentCount "stack underflow" (fun taken callerStack ->
        Fresh.one (fun arguments ->
          Std.List.reverso arguments taken &&&
          invokeBuiltin functionName arguments callerStack (inj true)))
    in
    let handleBegin _argumentCount localCount =
      ocanren {
        fresh callStack, stack, globals, arguments, locals, closure, inputs, outputs,
              objects, nextId, initializedLocals, updatedState in
          state == Config.Config (callStack, stack, globals, Loc.Loc (arguments, locals, closure),
                                  inputs, outputs, objects, nextId) &
          updatedState == Config.Config (callStack, stack, globals,
            Loc.Loc (arguments, initializedLocals, closure), inputs, outputs, objects, nextId) &
          finishInstruction updatedState nextAddress & emptyLocals localCount initializedLocals
      }
    in
    let handleEnd _ = returnFromCall program state result in
    let handleRet _ = returnFromCall program state result in

    ocanren {
      fresh text, bytes, first, second, pattern, designation, designations in
        instruction == Insn.LINE first & line first |
        instruction == Insn.CONST first & const first |
        instruction == Insn.STRING bytes & string bytes |
        instruction == Insn.SEXP (bytes, first) & sexp bytes first |
        instruction == Insn.BINOP text & binop text |
        instruction == Insn.ELEM & elem () |
        instruction == Insn.LD designation & ld designation |
        instruction == Insn.ST designation & st designation |
        instruction == Insn.STA & sta () |
        instruction == Insn.JMP first & jmp first |
        instruction == Insn.CJMP (text, first) & cjmp text first |
        instruction == Insn.CLOSURE (first, designations) & handleClosure first designations |
        instruction == Insn.CALL (first, second) & handleCall first second |
        instruction == Insn.BUILTIN (bytes, first) & handleBuiltin bytes first |
        instruction == Insn.CALLC first & handleCallClosure first |
        instruction == Insn.CALL_TAIL (first, second) & handleCallTail first second |
        instruction == Insn.CALLC_TAIL first & handleCallClosureTail first |
        instruction == Insn.BUILTIN_TAIL (bytes, first) & handleBuiltinTail bytes first |
        instruction == Insn.BEGIN (first, second) & handleBegin first second |
        instruction == Insn.END & handleEnd () |
        instruction == Insn.RET & handleRet () |
        instruction == Insn.DROP & drop () |
        instruction == Insn.DUP & dup () |
        instruction == Insn.SWAP & swap () |
        instruction == Insn.TAG (bytes, first) & tag bytes first |
        instruction == Insn.ARRAY first & array first |
        instruction == Insn.PATT pattern & patt pattern |
        instruction == Insn.FAIL (first, second) & fail first second
    }

  let step program state instructionAddress result =
    ocanren {
      fresh haltAddress, atEnd, instructionResult, instruction, message, nextAddress in
        Prog.finished program haltAddress &
        Word32.eqo instructionAddress haltAddress atEnd &
        {atEnd == true & result == Right (Std.pair state instructionAddress) |
         atEnd == false &
         currentInstruction program instructionAddress instructionResult &
         {instructionResult == Left message & result == Left message |
          instructionResult == Right instruction &
          Word32.addo instructionAddress !(Word32.word 1) nextAddress &
          executeInstruction program state instruction nextAddress result}}
    }

  let rec eval program state instructionAddress result =
    ocanren {
      fresh haltAddress, atEnd, stepResult, nextState, nextAddress, message in
        Prog.finished program haltAddress &
        Word32.eqo instructionAddress haltAddress atEnd &
        {atEnd == true & result == Right state |
         atEnd == false & step program state instructionAddress stepResult &
         {stepResult == Left message & result == Left message |
          stepResult == Right (Std.pair nextState nextAddress) &
          eval program nextState nextAddress result}}
    }

  let runConfig program inputs result =
    ocanren {
      fresh initialResult, state, message, instructions, entry, functionNames in
        initialState program inputs initialResult &
        {initialResult == Left message & result == Left message |
         initialResult == Right state &
         program == Prog.MkProg (instructions, entry, functionNames) &
         eval program state entry result}
    }

  let run program inputs result =
    ocanren {
      fresh configResult, message, frames, stack, globals, environment,
            remainingInputs, outputs, store, nextId in
        runConfig program inputs configResult &
        {configResult == Left message & result == Left message |
         configResult == Right (Config.Config (frames, stack, globals, environment,
                                              remainingInputs, outputs, store, nextId)) &
         result == Right outputs}
    }
end

module Test =
  struct

    let logicalWord value =
      List.fold_right (fun bit tail -> OCanren.Value (Std.List.Cons (OCanren.Value bit, tail)))
        (Word32.of_int value) (OCanren.Value Std.List.Nil)

    let test printer reifier goal () =
      Printf.printf "%s\n" (show(list) (show(printer)) @@ (Stream.take @@ run q goal (fun qs -> qs#reify reifier)))
    let byteInstructions text instruction =
      ocanren {
        instruction == Insn.STRING text |
        instruction == Insn.SEXP (text, !(Word32.word 2)) |
        instruction == Insn.TAG (text, !(Word32.word 2)) |
        instruction == Insn.BUILTIN (text, !(Word32.word 2)) |
        instruction == Insn.BUILTIN_TAIL (text, !(Word32.word 2))
      }

    let tests_prj_exn = [
        test Insn.t Insn.prj_exn (byteInstructions (ByteString.inj "\000\255"));
        test Word32.t Word32.prj_exn (fun q -> q === Word32.word 42);
        test ByteString.t ByteString.prj_exn (fun q ->
          ocanren {fresh program, state in SM.showValue program state (Value.Int !(Word32.word 42)) q});
        test Patt       .t Patt       .prj_exn (fun q -> ocanren {q == Patt.StrCmp | q == Patt.Sexp});
        test Designation.t Designation.prj_exn (fun q -> ocanren {q == Designation.Local !(Word32.word 3)});
        test Value      .t Value      .prj_exn (fun q -> ocanren {q == Value.Empty | q == Value.Int !(Word32.word Word32.max_value)});
        test Insn       .t Insn       .prj_exn (fun q -> ocanren {q == Insn.RET | q == Insn.CONST !(Word32.word Word32.max_value)});
        test Designation.t Designation.prj_exn (fun q -> ocanren {
          q == Designation.Global !(OCanren.inj "main")
        });
        test Prog.t Prog.prj_exn (fun q -> ocanren {
          q == Prog.MkProg ([Insn.CONST !(Word32.word 1); Insn.RET], !(Word32.word 0), [(!(Word32.word 0), !(ByteString.inj "main"))])
        });
        test Loc.t Loc.prj_exn (fun q -> ocanren {
          q == Loc.Loc ([(!(Word32.word 0), Value.Int !(Word32.word 1))], [(!(Word32.word 1), Value.Array !(Word32.word 2))], Some !(Word32.word 3)) |
          Loc.emptyLoc q
        });
        test Frame.t Frame.prj_exn (fun q -> ocanren {
          q == Frame.Frame (!(Word32.word 2), Loc.Loc ([(!(Word32.word 0), Value.Int !(Word32.word 1))], [], None), [Value.Int !(Word32.word 3); Value.Empty])
        });
        test Store.t Store.prj_exn (fun q -> ocanren {
          q == Store.Store [(!(Word32.word 0), [Value.Int !(Word32.word 1); Value.Array !(Word32.word 2)]); (!(Word32.word 2), [])] |
          q == Store.Store []
        });
        test Config.t Config.prj_exn (fun q -> ocanren {
          q == Config.Config (
            [Frame.Frame (!(Word32.word 2), Loc.Loc ([], [], None), [Value.Int !(Word32.word 1)])],
            [Value.Array !(Word32.word 0)], [(!(OCanren.inj "main"), Value.Closure (!(Word32.word 2), !(Word32.word 0)))],
            Loc.Loc ([(!(Word32.word 0), Value.Int !(Word32.word 1))], [(!(Word32.word 1), Value.Empty)], Some !(Word32.word 0)),
            [!(Word32.word 0); !(Word32.word 2)], [!(Word32.word 3)], Store.Store [(!(Word32.word 0), [Value.Int !(Word32.word 1)])], !(Word32.word 1))
        })
    ]
    
    let tests_reify = [
        test Insn.logic Insn.reify (byteInstructions (ByteString.inj "\000\255"));
        test Word32.logic Word32.reify (fun q ->
          let tail = Std.list inj (List.init 31 (fun _ -> false)) in
          ocanren {fresh bit in q == bit :: tail});
        test ByteString.logic ByteString.reify (fun q ->
          ocanren {fresh program, state, code in SM.showValue program state (Value.Builtin [code]) q});
        test Patt       .logic Patt       .reify (fun q -> ocanren {q == Patt.StrCmp | q == Patt.Sexp});
        test Designation.logic Designation.reify (fun q -> ocanren {q == Designation.Local !(Word32.word 3)});
        test Value      .logic Value      .reify (fun q -> ocanren {q == Value.Empty | q == Value.Int !(Word32.word Word32.max_value)});
        test Insn       .logic Insn       .reify (fun q -> ocanren {q == Insn.RET | q == Insn.CONST !(Word32.word Word32.max_value)});
        test Designation.logic Designation.reify (fun q -> ocanren {
          q == Designation.Global !(OCanren.inj "main")
        });
        test Prog.logic Prog.reify (fun q -> ocanren {
          q == Prog.MkProg ([Insn.CONST !(Word32.word 1); Insn.RET], !(Word32.word 0), [(!(Word32.word 0), !(ByteString.inj "main"))])
        });
        test Loc.logic Loc.reify (fun q -> ocanren {
          fresh value, closureId in
            q == Loc.Loc ([(!(Word32.word 0), value)], [(!(Word32.word 1), Value.Array !(Word32.word 2))], Some closureId) |
            Loc.emptyLoc q
        });
        test Frame.logic Frame.reify (fun q -> ocanren {
          fresh address, value in
            q == Frame.Frame (address, Loc.Loc ([(!(Word32.word 0), Value.Int !(Word32.word 1))], [], None), [value; Value.Empty])
        });
        test Store.logic Store.reify (fun q -> ocanren {
          fresh value in
            q == Store.Store [(!(Word32.word 0), [value; Value.Array !(Word32.word 2)]); (!(Word32.word 2), [])] |
            q == Store.Store []
        });
        test Config.logic Config.reify (fun q -> ocanren {
          fresh value, inputs in
            q == Config.Config (
              [Frame.Frame (!(Word32.word 2), Loc.Loc ([], [], None), [value])],
              [Value.Array !(Word32.word 0)], [(!(OCanren.inj "main"), value)],
              Loc.Loc ([(!(Word32.word 0), value)], [(!(Word32.word 1), Value.Empty)], Some !(Word32.word 0)),
              inputs, [!(Word32.word 3)], Store.Store [(!(Word32.word 0), [value])], !(Word32.word 1))
        })
      ]
    
    let test_instruction_bytes () =
      List.iter (fun text ->
        let instructions = Stream.take @@ run q (byteInstructions (ByteString.inj text))
          (fun answer -> answer#reify Insn.prj_exn) in
        assert (instructions = [Insn.STRING text; Insn.SEXP (text, 2); Insn.TAG (text, 2);
          Insn.BUILTIN (text, 2); Insn.BUILTIN_TAIL (text, 2)])) [""; "\000"; "\255"; "A\000\255"];
      Printf.printf "instruction byte fields project empty, NUL and 255 strings: OK\n%!"

    let test_instruction_partial_bytes () =
      let zeroBits = Std.list inj (List.init 31 (fun _ -> false)) in
      let answers = Stream.take @@ run q (fun instruction -> ocanren {
        fresh bit, tail in byteInstructions ((bit :: zeroBits) :: tail) instruction
      }) (fun answer -> answer#reify Insn.reify) in
      let partialBytes = function
        | OCanren.Value (Insn.STRING text)
        | OCanren.Value (Insn.SEXP (text, _))
        | OCanren.Value (Insn.TAG (text, _))
        | OCanren.Value (Insn.BUILTIN (text, _))
        | OCanren.Value (Insn.BUILTIN_TAIL (text, _)) ->
            (match text with
            | OCanren.Value (Std.List.Cons (
                OCanren.Value (Std.List.Cons (OCanren.Var (bitId, []), remainingBits)),
                OCanren.Var (tailId, []))) ->
                bitId <> tailId && remainingBits = List.fold_right
                  (fun bit tail -> OCanren.Value (Std.List.Cons (OCanren.Value bit, tail)))
                  (List.init 31 (fun _ -> false)) (OCanren.Value Std.List.Nil)
            | _ -> false)
        | _ -> false
      in
      assert (List.length answers = 5 && List.for_all partialBytes answers);
      Printf.printf "all five byte fields reify a free bit and independent list tail: OK\n%!"

    let test_sm_prj_exn () =
      let results = Stream.take @@ run q (fun result -> ocanren {
        result == SM.throwSM_inj !(inj "error") |
        result == SM.Right (Value.Int !(Word32.word 1))
      }) (fun qs -> qs#reify (SM.prj_exn Value.prj_exn)) in
      assert (results = [SM.throwSM "error"; SM.Right (Value.Int 1)]);
      Printf.printf "%s\n" (show(list) (show(SM.t) (show(Value.t))) results)

    let test_sm_reify () =
      let results = Stream.take @@ run q (fun result -> ocanren {
        fresh message, value in
          result == SM.throwSM_inj message |
          result == SM.Right (Value.Array value)
      }) (fun qs -> qs#reify (SM.reify Value.reify)) in
      Printf.printf "%s\n" (show(list) (show(SM.logic) (show(Value.logic))) results)

    let test_finished () =
      let g q =
        ocanren {
          Prog.finished (Prog.MkProg ([Insn.CONST !(Word32.word 1); Insn.RET], !(Word32.word 0), [])) q
        }
    in
      Printf.printf "finished 2 = %s\n"
    (show(list) (fun n -> string_of_int (Word32.to_int n)) @@
      (Stream.take @@
          run q g (fun qs -> qs#reify Word32.prj_exn)))

    let test_finished_2 () =
      let g prog =
      ocanren {
        Prog.finished prog !(Word32.word 2)
      }
  in
      Printf.printf "program for address 2 = %s\n"
    (show(Prog.logic) @@
      (Stream.hd @@
          run q g (fun rr -> rr#reify Prog.reify)))

    let test_initialConfig () =
      let g state =
        ocanren {
          Config.initialConfig [] state |
          Config.initialConfig [!(Word32.word 0); !(Word32.word 2); !(Word32.word 1)] state
        }
      in
      let states = Stream.take @@ run q g (fun qs -> qs#reify Config.prj_exn) in
      assert (states = [
        Config.Config ([], [], [], Loc.Loc ([], [], None), [], [], Store.Store [], 0);
        Config.Config ([], [], [], Loc.Loc ([], [], None), [0; 2; 1], [], Store.Store [], 0)
      ]);
      Printf.printf "initialConfig [] / [0; 2; 1] = %s\n"
        (show(list) (show(Config.t)) states)

    let test_initialConfig_2 () =
      let g inputs =
        ocanren {
          Config.initialConfig inputs
            (Config.Config ([], [], [], Loc.Loc ([], [], None), [!(Word32.word 0); !(Word32.word 2); !(Word32.word 1)], [], Store.Store [], !(Word32.word 0)))
        }
      in
      let inputs = Stream.take @@ run q g (fun qs -> qs#reify
        (Std.List.prj_exn (fun env value -> Word32.to_int @@ Word32.prj_exn env value))) in
      assert (inputs = [[0; 2; 1]]);
      Printf.printf "inputs for initialConfig = %s\n"
        (show(list) (show(list) (show(int))) inputs)

    let test_b2i () =
      List.iter (fun (boolean, expected) ->
        let results = Stream.take @@ run q (fun number -> ocanren {
          SM.b2i !(inj boolean) number
        }) (fun qs -> qs#reify Word32.prj_exn) in
        let numbers = List.map Word32.to_int results in
        assert (numbers = [expected]);
        Printf.printf "b2i %b = %s\n" boolean (show(list) (show(int)) numbers)
      ) [(true, 1); (false, 0)]

    let test_b2i_2 () =
      List.iter (fun (number, expected) ->
        let booleans = Stream.take @@ run q (fun boolean -> ocanren {
          SM.b2i boolean !(Word32.word number)
        }) (fun qs -> qs#reify Std.Bool.prj_exn) in
        assert (booleans = expected);
        Printf.printf "booleans for b2i %d = %s\n" number (show(list) (show(bool)) booleans)
      ) [(0, [false]); (1, [true]); (2, [])]

    let test_isBegin () =
      let results = Stream.take @@ run q (fun matches -> ocanren {
        Std.List.mapo Insn.isBegin
          [Insn.BEGIN (!(Word32.word 2), !(Word32.word 3)); Insn.BINOP !(inj "+"); Insn.CONST !(Word32.word 1);
           Insn.STRING !(ByteString.inj "text"); Insn.SEXP (!(ByteString.inj "Tag"), !(Word32.word 0));
           Insn.LD (Designation.Local !(Word32.word 0)); Insn.ST (Designation.Arg !(Word32.word 0));
           Insn.STA; Insn.ELEM; Insn.JMP !(Word32.word 0); Insn.CJMP (!(inj "z"), !(Word32.word 0));
           Insn.END; Insn.CLOSURE (!(Word32.word 0), []); Insn.CALLC !(Word32.word 0); Insn.CALL (!(Word32.word 0), !(Word32.word 0));
           Insn.BUILTIN (!(ByteString.inj "read"), !(Word32.word 0)); Insn.CALL_TAIL (!(Word32.word 0), !(Word32.word 0));
           Insn.CALLC_TAIL !(Word32.word 0); Insn.BUILTIN_TAIL (!(ByteString.inj "read"), !(Word32.word 0));
           Insn.RET; Insn.DROP; Insn.DUP; Insn.SWAP; Insn.TAG (!(ByteString.inj "Tag"), !(Word32.word 0));
           Insn.ARRAY !(Word32.word 0); Insn.PATT Patt.Boxed; Insn.FAIL (!(Word32.word 0), !(Word32.word 0)); Insn.LINE !(Word32.word 0)]
          matches
      }) (fun qs -> qs#reify (Std.List.prj_exn Std.Bool.prj_exn)) in
      assert (results = [true :: List.init 27 (fun _ -> false)]);
      Printf.printf "isBegin = %s\n" (show(list) (show(list) (show(bool))) results)

    let test_initialState () =
      let initial = Config.Config ([], [], [], Loc.Loc ([], [], None), [0; 2; 1], [], Store.Store [], 0) in
      let error = SM.throwSM "main does not point to BEGIN" in
      List.iter (fun (entry, expected) ->
        let results = Stream.take @@ run q (fun result -> ocanren {
          SM.initialState
            (Prog.MkProg ([Insn.RET; Insn.BEGIN (!(Word32.word 2), !(Word32.word 3)); Insn.RET], !(Word32.word entry), []))
            [!(Word32.word 0); !(Word32.word 2); !(Word32.word 1)] result
        }) (fun qs -> qs#reify (SM.prj_exn Config.prj_exn)) in
        assert (results = [expected]);
        Printf.printf "initialState entry %d = %s\n" entry
          (show(list) (show(SM.t) (show(Config.t))) results)
      ) [(0, error); (1, SM.Right initial); (2, error); (3, error); (5, error)];
      let results = Stream.take @@ run q (fun result -> ocanren {
        SM.initialState (Prog.MkProg ([], !(Word32.word 0), [])) [] result
      }) (fun qs -> qs#reify (SM.prj_exn Config.prj_exn)) in
      assert (results = [error]);
      Printf.printf "initialState empty program = %s\n"
        (show(list) (show(SM.t) (show(Config.t))) results)

    let test_initialState_2 () =
      let entries = Stream.take @@ run q (fun entry -> ocanren {
        fresh state in
          Config.initialConfig [] state &
          SM.initialState
            (Prog.MkProg ([Insn.BEGIN (!(Word32.word 0), !(Word32.word 0)); Insn.RET; Insn.BEGIN (!(Word32.word 2), !(Word32.word 3))], entry, []))
            [] (SM.Right state)
      }) (fun qs -> qs#reify Word32.prj_exn) in
      let addresses = List.map Word32.to_int entries in
      assert (addresses = [0; 2]);
      Printf.printf "valid initialState entries = %s\n" (show(list) (show(int)) addresses);
      let instructions = Stream.take @@ run q (fun instruction -> ocanren {
        fresh state in
          Config.initialConfig [] state &
          SM.initialState (Prog.MkProg ([instruction], !(Word32.word 0), [])) [] (SM.Right state)
      }) (fun qs -> qs#reify Insn.reify) in
      assert (match instructions with
        | [OCanren.Value (Insn.BEGIN (OCanren.Var _, OCanren.Var _))] -> true
        | _ -> false);
      Printf.printf "instructions for initialState = %s\n"
        (show(list) (show(Insn.logic)) instructions);
      let rejected = Stream.take @@ run q (fun instruction -> ocanren {
        SM.initialState (Prog.MkProg ([instruction], !(Word32.word 0), [])) []
          (SM.Left !(inj "main does not point to BEGIN")) &
        instruction == Insn.BEGIN (!(Word32.word 2), !(Word32.word 3))
      }) (fun qs -> qs#reify Insn.prj_exn) in
      assert (rejected = []);
      Printf.printf "BEGIN with initialState error = %s\n" (show(list) (show(Insn.t)) rejected)

    let test_currentInstruction () =
      List.iter (fun (address, expected) ->
        let results = Stream.take @@ run q (fun result -> ocanren {
          SM.currentInstruction
            (Prog.MkProg ([Insn.BEGIN (!(Word32.word 2), !(Word32.word 3)); Insn.CONST !(Word32.word 7); Insn.RET], !(Word32.word 1), []))
            !(Word32.word address) result
        }) (fun qs -> qs#reify (SM.prj_exn Insn.prj_exn)) in
        assert (results = [expected]);
        Printf.printf "currentInstruction address %d = %s\n" address
          (show(list) (show(SM.t) (show(Insn.t))) results)
      ) [(0, SM.Right (Insn.BEGIN (2, 3))); (1, SM.Right (Insn.CONST 7));
         (2, SM.Right Insn.RET); (3, SM.throwSM "Invalid instruction address");
         (5, SM.throwSM "Invalid instruction address");
         (12, SM.throwSM "Invalid instruction address")];
      let results = Stream.take @@ run q (fun result -> ocanren {
        SM.currentInstruction (Prog.MkProg ([], !(Word32.word 0), [])) !(Word32.word 0) result
      }) (fun qs -> qs#reify (SM.prj_exn Insn.prj_exn)) in
      assert (results = [SM.throwSM "Invalid instruction address"]);
      Printf.printf "currentInstruction empty program = %s\n"
        (show(list) (show(SM.t) (show(Insn.t))) results)

    let test_currentInstruction_2 () =
      let entries = Stream.take @@ run q (fun address -> ocanren {
        SM.currentInstruction
          (Prog.MkProg ([Insn.RET; Insn.CONST !(Word32.word 7); Insn.RET], !(Word32.word 1), []))
          address (SM.Right Insn.RET)
      }) (fun qs -> qs#reify Word32.prj_exn) in
      let addresses = List.map Word32.to_int entries in
      assert (addresses = [0; 2]);
      Printf.printf "addresses for currentInstruction RET = %s\n"
        (show(list) (show(int)) addresses);
      let rejected = Stream.take @@ run q (fun address -> ocanren {
        SM.currentInstruction
          (Prog.MkProg ([Insn.RET; Insn.CONST !(Word32.word 7); Insn.RET], !(Word32.word 1), []))
          address (SM.Right Insn.DROP)
      }) (fun qs -> qs#reify Word32.prj_exn) in
      assert (rejected = []);
      Printf.printf "addresses for currentInstruction DROP = %s\n"
        (show(list) (show(int)) (List.map Word32.to_int rejected));
      let errorEntries = Stream.take @@ run q (fun address -> ocanren {
        SM.currentInstruction
          (Prog.MkProg ([Insn.RET; Insn.CONST !(Word32.word 7); Insn.RET], !(Word32.word 1), []))
          address (SM.Left !(inj "Invalid instruction address"))
      }) (fun qs -> qs#reify Word32.reify) in
      Word32_tests.expect_ranges "invalid currentInstruction addresses"
        [(3, Word32.max_value)] errorEntries;
      Printf.printf "invalid currentInstruction addresses: %d patterns cover [3, %d]\n"
        (List.length errorEntries) Word32.max_value;
      let instructions = Stream.take @@ run q (fun instruction -> ocanren {
        SM.currentInstruction (Prog.MkProg ([Insn.RET; instruction], !(Word32.word 0), [])) !(Word32.word 1)
          (SM.Right (Insn.CONST !(Word32.word 7)))
      }) (fun qs -> qs#reify Insn.prj_exn) in
      assert (instructions = [Insn.CONST 7]);
      Printf.printf "instructions for currentInstruction = %s\n"
        (show(list) (show(Insn.t)) instructions);
      let results = Stream.take @@ run q (fun result -> ocanren {
        fresh arguments, locals in
          SM.currentInstruction
            (Prog.MkProg ([Insn.RET; Insn.BEGIN (arguments, locals)], !(Word32.word 0), [])) !(Word32.word 1) result
      }) (fun qs -> qs#reify (SM.reify Insn.reify)) in
      assert (match results with
        | [OCanren.Value (SM.Right (OCanren.Value (Insn.BEGIN (OCanren.Var _, OCanren.Var _))))] -> true
        | _ -> false);
      Printf.printf "currentInstruction with free BEGIN parameters = %s\n"
        (show(list) (show(SM.logic) (show(Insn.logic))) results)

    let test_jumpTo_boundaries () =
      List.iter (fun (address, expected) ->
        let results = Stream.take @@ run q (fun result -> ocanren {
          SM.jumpTo
            (Prog.MkProg ([Insn.RET; Insn.CONST !(Word32.word 7); Insn.DROP],
              !(Word32.word 17), [(!(Word32.word 42), !(ByteString.inj "unrelated"))]))
            !(Word32.word address) result
        }) (fun answer -> answer#reify (SM.prj_exn
          (fun environment word -> Word32.to_int (Word32.prj_exn environment word)))) in
        assert (results = [expected])
      ) [(0, SM.Right 0); (1, SM.Right 1); (2, SM.Right 2);
         (3, SM.throwSM "Invalid instruction address");
         (Word32.max_value, SM.throwSM "Invalid instruction address");
         (-1, SM.throwSM "Invalid instruction address")];
      let emptyResults = Stream.take @@ run q (fun result -> ocanren {
        SM.jumpTo (Prog.MkProg ([], !(Word32.word 0), [])) !(Word32.word 0) result
      }) (fun answer -> answer#reify (SM.prj_exn Word32.prj_exn)) in
      assert (emptyResults = [SM.throwSM "Invalid instruction address"]);
      Printf.printf "jumpTo boundaries and unrelated program metadata passed\n"

    let test_jumpTo_backwards () =
      let addresses = Stream.take @@ run q (fun address -> ocanren {
        fresh resultAddress in
          SM.jumpTo
            (Prog.MkProg ([Insn.RET; Insn.CONST !(Word32.word 7); Insn.DROP], !(Word32.word 0), []))
            address (SM.Right resultAddress)
      }) (fun answer -> answer#reify Word32.prj_exn) in
      assert (List.map Word32.to_int addresses = [0; 1; 2]);
      let recovered = Stream.take @@ run q (fun address -> ocanren {
        SM.jumpTo
          (Prog.MkProg ([Insn.RET; Insn.DROP], !(Word32.word 0), []))
          address (SM.Right !(Word32.word 1))
      }) (fun answer -> answer#reify Word32.prj_exn) in
      assert (List.map Word32.to_int recovered = [1]);
      Printf.printf "jumpTo enumerates targets and recovers the returned address\n"

    let test_toInt () =
      let results = Stream.take @@ run q (fun results -> ocanren {
        Std.List.mapo SM.toInt
          [Value.Int !(Word32.word 0); Value.Int !(Word32.word 7); Value.String !(Word32.word 1); Value.Array !(Word32.word 2);
           Value.Sexp (!(ByteString.inj "Tag"), !(Word32.word 3)); Value.Closure (!(Word32.word 1), !(Word32.word 4));
           Value.Builtin !(ByteString.inj "read"); Value.Empty]
          results
      }) (fun qs -> qs#reify (Std.List.prj_exn
        (SM.prj_exn (fun env number -> Word32.to_int @@ Word32.prj_exn env number)))) in
      let error = SM.throwSM "expected int" in
      assert (results = [[SM.Right 0; SM.Right 7; error; error; error; error; error; error]]);
      Printf.printf "toInt for all Value constructors = %s\n"
        (show(list) (show(list) (show(SM.t) (show(int)))) results)

    let test_toInt_2 () =
      let values = Stream.take @@ run q (fun value -> ocanren {
        SM.toInt value (SM.Right !(Word32.word 7))
      }) (fun qs -> qs#reify Value.prj_exn) in
      assert (values = [Value.Int 7]);
      Printf.printf "values for toInt Right 7 = %s\n" (show(list) (show(Value.t)) values);
      let results = Stream.take @@ run q (fun result -> ocanren {
        fresh number in
          SM.toInt (Value.Int number) result
      }) (fun qs -> qs#reify (SM.reify Word32.reify)) in
      assert (match results with
        | [OCanren.Value (SM.Right (OCanren.Var _))] -> true
        | _ -> false);
      Printf.printf "toInt with a free number = %s\n"
        (show(list) (show(SM.logic) (show(Word32.logic))) results);
      let errors = Stream.take @@ run q (fun value -> ocanren {
        SM.toInt value (SM.Left !(inj "expected int"))
      }) (fun qs -> qs#reify Value.reify) in
      assert (match errors with
        | [OCanren.Value (Value.String (OCanren.Var _));
           OCanren.Value (Value.Array (OCanren.Var _));
           OCanren.Value (Value.Sexp (OCanren.Var _, OCanren.Var _));
           OCanren.Value (Value.Closure (OCanren.Var _, OCanren.Var _));
           OCanren.Value (Value.Builtin (OCanren.Var _));
           OCanren.Value Value.Empty] -> true
        | _ -> false);
      Printf.printf "values for toInt error = %s\n" (show(list) (show(Value.logic)) errors);
      let rejected = Stream.take @@ run q (fun number -> ocanren {
        fresh value in
          SM.toInt value (SM.Left !(inj "expected int")) &
          value == Value.Int number
      }) (fun qs -> qs#reify Word32.reify) in
      assert (rejected = []);
      Printf.printf "Int with toInt error = %s\n" (show(list) (show(Word32.logic)) rejected)

    let test_renderChar_bytes () =
      List.iter (fun code ->
        let codes = Stream.take @@ run q (SM.renderChar (Value.int (Word32.word code)))
          (fun answer -> answer#reify (Reifier.fmap Word32.to_int Word32.prj_exn)) in
        assert (codes = [code]);
        Printf.printf "renderChar Int %d = %s\n" code (show(list) (show(int)) codes)
      ) [0; 9; 10; 13; 34; 39; 63; 65; 92; 127; 128; 255]

    let test_renderChar_nonIntegers () =
      List.iter (fun (description, value) ->
        let codes = Stream.take @@ run q (SM.renderChar value)
          (fun answer -> answer#reify (Reifier.fmap Word32.to_int Word32.prj_exn)) in
        assert (codes = [63]);
        Printf.printf "renderChar %s = %s\n" description (show(list) (show(int)) codes)
      ) [("String 0", Value.string (Word32.word 0));
         ("Array 256", Value.array (Word32.word 256));
         ("Sexp Tag 7", Value.sexp (ByteString.inj "Tag") (Word32.word 7));
         ("Closure 42 max_value", Value.closure (Word32.word 42) (Word32.word Word32.max_value));
         ("Builtin read", Value.builtin (ByteString.inj "read"));
         ("Empty", Value.empty ())]

    let test_renderChar_backwards () =
      List.iter (fun code ->
        let values = Stream.take @@ run q (fun value -> SM.renderChar value (Word32.word code))
          (fun answer -> answer#reify Value.prj_exn) in
        assert (values = [Value.Int code]);
        Printf.printf "values rendered as code %d = %s\n" code (show(list) (show(Value.t)) values)
      ) [0; 65; 92; 255]

    let test_splitStack () =
      let reifier = SM.prj_exn (Std.Pair.prj_exn
        (Std.List.prj_exn Value.prj_exn) (Std.List.prj_exn Value.prj_exn)) in
      let printer = show(SM.t) (show(Std.Pair.t)
        (show(list) (show(Value.t))) (show(list) (show(Value.t)))) in
      let stack = [Value.Int 7; Value.Empty; Value.Array 2] in
      let error = SM.throwSM "stack underflow" in
      List.iter (fun (count, expected) ->
        let results = Stream.take @@ run q (fun result -> ocanren {
          SM.splitStack !(Word32.word count) [Value.Int !(Word32.word 7); Value.Empty; Value.Array !(Word32.word 2)] result
        }) (fun qs -> qs#reify reifier) in
        assert (results = [expected]);
        Printf.printf "splitStack %d = %s\n" count (show(list) printer results)
      ) [(0, SM.Right ([], stack));
         (1, SM.Right ([Value.Int 7], [Value.Empty; Value.Array 2]));
         (2, SM.Right ([Value.Int 7; Value.Empty], [Value.Array 2]));
         (3, SM.Right (stack, [])); (4, error); (6, error)];
      List.iter (fun (count, expected) ->
        let results = Stream.take @@ run q (fun result -> ocanren {
          SM.splitStack !(Word32.word count) [] result
        }) (fun qs -> qs#reify reifier) in
        assert (results = [expected]);
        Printf.printf "splitStack %d empty stack = %s\n" count (show(list) printer results)
      ) [(0, SM.Right ([], [])); (1, error)]

    let test_splitStack_2 () =
      let counts = Stream.take @@ run q (fun count -> ocanren {
        fresh taken, rest in
          SM.splitStack count [Value.Int !(Word32.word 7); Value.Empty; Value.Array !(Word32.word 2)]
            (SM.Right (Std.pair taken rest))
      }) (fun qs -> qs#reify Word32.prj_exn) in
      let numbers = List.map Word32.to_int counts in
      assert (numbers = [0; 1; 2; 3]);
      Printf.printf "valid splitStack counts = %s\n" (show(list) (show(int)) numbers);
      let stacks = Stream.take @@ run q (fun stack -> ocanren {
        SM.splitStack !(Word32.word 2) stack
          (SM.Right (Std.pair [Value.Int !(Word32.word 7); Value.Empty] [Value.Array !(Word32.word 2)]))
      }) (fun qs -> qs#reify (Std.List.prj_exn Value.prj_exn)) in
      assert (stacks = [[Value.Int 7; Value.Empty; Value.Array 2]]);
      Printf.printf "stacks for splitStack = %s\n"
        (show(list) (show(list) (show(Value.t))) stacks);
      let rejected = Stream.take @@ run q (fun stack -> ocanren {
        SM.splitStack !(Word32.word 2) stack
          (SM.Right (Std.pair [Value.Int !(Word32.word 7)] [Value.Empty]))
      }) (fun qs -> qs#reify (Std.List.prj_exn Value.prj_exn)) in
      assert (rejected = []);
      Printf.printf "splitStack with a wrong prefix length = %s\n"
        (show(list) (show(list) (show(Value.t))) rejected);
      let results = Stream.take @@ run q (fun result -> ocanren {
        fresh value in
          SM.splitStack !(Word32.word 1) [value; value] result
      }) (fun qs -> qs#reify (SM.reify (Std.Pair.reify
        (Std.List.reify Value.reify) (Std.List.reify Value.reify)))) in
      assert (match results with
        | [OCanren.Value (SM.Right (OCanren.Value (
            OCanren.Value (Std.List.Cons ((OCanren.Var _ as takenValue), OCanren.Value Std.List.Nil)),
            OCanren.Value (Std.List.Cons ((OCanren.Var _ as restValue), OCanren.Value Std.List.Nil)))))] ->
              takenValue = restValue
        | _ -> false);
      Printf.printf "splitStack with a shared free value = %s\n"
        (show(list) (show(SM.logic) (show(Std.Pair.logic)
          (show(Std.List.logic) (show(Value.logic)))
          (show(Std.List.logic) (show(Value.logic))))) results);
      let invalidCounts = Stream.take @@ run q (fun count -> ocanren {
        SM.splitStack count [Value.Int !(Word32.word 7); Value.Empty; Value.Array !(Word32.word 2)]
          (SM.Left !(inj "stack underflow"))
      }) (fun qs -> qs#reify Word32.reify) in
      Word32_tests.expect_ranges "splitStack underflow counts"
        [(4, Word32.max_value)] invalidCounts;
      Printf.printf "splitStack underflow counts: %d patterns cover [4, %d]\n"
        (List.length invalidCounts) Word32.max_value;
      let shortStacks = Stream.take @@ run q (fun stack -> ocanren {
        SM.splitStack !(Word32.word 2) stack (SM.Left !(inj "stack underflow"))
      }) (fun qs -> qs#reify (Std.List.reify Value.reify)) in
      assert (match shortStacks with
        | [OCanren.Value Std.List.Nil;
           OCanren.Value (Std.List.Cons (OCanren.Var (_, []), OCanren.Value Std.List.Nil))] -> true
        | _ -> false);
      Printf.printf "stacks for splitStack 2 underflow = %s\n"
        (show(list) (show(Std.List.logic) (show(Value.logic))) shortStacks);
      let zeroUnderflows = Stream.take @@ run q (fun stack -> ocanren {
        SM.splitStack !(Word32.word 0) stack (SM.Left !(inj "stack underflow"))
      }) (fun qs -> qs#reify (Std.List.reify Value.reify)) in
      assert (zeroUnderflows = [])

    let test_safeIndex () =
      let error = SM.throwSM "ELEM: index out of bounds" in
      List.iter (fun (index, expected) ->
        let results = Stream.take @@ run q (fun result -> ocanren {
          SM.safeIndex [Value.Int !(Word32.word 7); Value.Empty; Value.Array !(Word32.word 2)]
            !(Word32.word index) !("ELEM") result
        }) (fun qs -> qs#reify (SM.prj_exn Value.prj_exn)) in
        assert (results = [expected]);
        Printf.printf "safeIndex %d = %s\n" index
          (show(list) (show(SM.t) (show(Value.t))) results)
      ) [(0, SM.Right (Value.Int 7)); (1, SM.Right Value.Empty);
         (2, SM.Right (Value.Array 2)); (3, error); (5, error)];
      List.iter (fun (what, expected) ->
        let results = Stream.take @@ run q (fun result -> ocanren {
          SM.safeIndex [] !(Word32.word 0) what result
        }) (fun qs -> qs#reify (SM.prj_exn Value.prj_exn)) in
        assert (results = [SM.throwSM expected]);
        Printf.printf "safeIndex empty list (%s) = %s\n" what
          (show(list) (show(SM.t) (show(Value.t))) results)
      ) [("ELEM", "ELEM: index out of bounds");
         ("closure access", "closure access: index out of bounds")];
      let results = Stream.take @@ run q (fun result -> ocanren {
        SM.safeIndex [!(Word32.word 3); !(Word32.word 8)] !(Word32.word 1) !("numbers") result
      }) (fun qs -> qs#reify (SM.prj_exn
        (fun env number -> Word32.to_int @@ Word32.prj_exn env number))) in
      assert (results = [SM.Right 8]);
      Printf.printf "safeIndex for Word32 numbers = %s\n"
        (show(list) (show(SM.t) (show(int))) results)

    let test_safeIndex_2 () =
      let indices = Stream.take @@ run q (fun index -> ocanren {
        SM.safeIndex [Value.Int !(Word32.word 7); Value.Empty; Value.Int !(Word32.word 7)] index !("ELEM")
          (SM.Right (Value.Int !(Word32.word 7)))
      }) (fun qs -> qs#reify Word32.prj_exn) in
      let numbers = List.map Word32.to_int indices in
      assert (numbers = [0; 2]);
      Printf.printf "indices for safeIndex Int 7 = %s\n" (show(list) (show(int)) numbers);
      let rejected = Stream.take @@ run q (fun index -> ocanren {
        SM.safeIndex [Value.Int !(Word32.word 7); Value.Empty; Value.Int !(Word32.word 7)] index !("ELEM")
          (SM.Right (Value.Int !(Word32.word 8)))
      }) (fun qs -> qs#reify Word32.prj_exn) in
      assert (rejected = []);
      Printf.printf "indices for safeIndex Int 8 = %s\n"
        (show(list) (show(int)) (List.map Word32.to_int rejected));
      let lists = Stream.take @@ run q (fun values -> ocanren {
        SM.safeIndex values !(Word32.word 1) !("ELEM") (SM.Right Value.Empty)
      }) (fun qs -> qs#reify (Std.List.reify Value.reify)) in
      assert (match lists with
        | [OCanren.Value (Std.List.Cons (OCanren.Var _,
            OCanren.Value (Std.List.Cons (OCanren.Value Value.Empty, OCanren.Var _))))] -> true
        | _ -> false);
      Printf.printf "lists for safeIndex Empty at 1 = %s\n"
        (show(list) (show(Std.List.logic) (show(Value.logic))) lists);
      let results = Stream.take @@ run q (fun result -> ocanren {
        fresh value in
          SM.safeIndex [Value.Empty; value] !(Word32.word 1) !("ELEM") result
      }) (fun qs -> qs#reify (SM.reify Value.reify)) in
      assert (match results with
        | [OCanren.Value (SM.Right (OCanren.Var _))] -> true
        | _ -> false);
      Printf.printf "safeIndex with a free value = %s\n"
        (show(list) (show(SM.logic) (show(Value.logic))) results);
      let errors = Stream.take @@ run q (fun index -> ocanren {
        SM.safeIndex [Value.Int !(Word32.word 7); Value.Empty; Value.Array !(Word32.word 2)] index !("ELEM")
          (SM.Left !(inj "ELEM: index out of bounds"))
      }) (fun qs -> qs#reify Word32.reify) in
      Word32_tests.expect_ranges "invalid safeIndex indices"
        [(3, Word32.max_value)] errors;
      Printf.printf "invalid safeIndex indices: %d patterns cover [3, %d]\n"
        (List.length errors) Word32.max_value

    let test_replaceAtSM () =
      let error = SM.Left "replaceAt: index out of bounds" in
      List.iter (fun (description, index, expected) ->
        let answers = Stream.take @@ run q (fun result -> ocanren {
          SM.replaceAtSM !(Word32.word index) (Value.Int !(Word32.word 11))
            [Value.Int !(Word32.word 7); Value.Empty; Value.Array !(Word32.word 2)] result
        }) (fun answer -> answer#reify (SM.prj_exn (Std.List.prj_exn Value.prj_exn))) in
        assert (answers = [expected]);
        Printf.printf "replaceAtSM %s: OK\n%!" description
      ) [("replace first element", 0, SM.Right [Value.Int 11; Value.Empty; Value.Array 2]);
         ("replace middle element", 1, SM.Right [Value.Int 7; Value.Int 11; Value.Array 2]);
         ("replace last element", 2, SM.Right [Value.Int 7; Value.Empty; Value.Int 11]);
         ("index equal to length fails", 3, error);
         ("index beyond length fails", 5, error);
         ("maximum unsigned index fails", Word32.max_value, error)]

    let test_replaceAtSM_empty () =
      List.iter (fun index ->
        let answers = Stream.take @@ run q (fun result -> ocanren {
          SM.replaceAtSM !(Word32.word index) Value.Empty [] result
        }) (fun answer -> answer#reify (SM.prj_exn (Std.List.prj_exn Value.prj_exn))) in
        assert (answers = [SM.Left "replaceAt: index out of bounds"]);
        Printf.printf "replaceAtSM empty list at %d: OK\n%!" index
      ) [0; Word32.max_value]

    let test_replaceAtSM_backwards () =
      let indices = Stream.take @@ run q (fun index -> ocanren {
        SM.replaceAtSM index (Value.Int !(Word32.word 11))
          [Value.Int !(Word32.word 7); Value.Empty; Value.Array !(Word32.word 2)]
          (SM.Right [Value.Int !(Word32.word 7); Value.Int !(Word32.word 11); Value.Array !(Word32.word 2)])
      }) (fun answer -> answer#reify (Reifier.fmap Word32.to_int Word32.prj_exn)) in
      assert (indices = [1]);
      Printf.printf "replaceAtSM recovers the replaced index: OK\n%!";
      let replacements = Stream.take @@ run q (fun replacement -> ocanren {
        SM.replaceAtSM !(Word32.word 1) replacement
          [Value.Int !(Word32.word 7); Value.Empty; Value.Array !(Word32.word 2)]
          (SM.Right [Value.Int !(Word32.word 7); Value.Builtin !(ByteString.inj "write"); Value.Array !(Word32.word 2)])
      }) (fun answer -> answer#reify Value.prj_exn) in
      assert (replacements = [Value.Builtin "write"]);
      Printf.printf "replaceAtSM recovers the replacement value: OK\n%!"

    let test_sameValue () =
      let values = [
        Value.int (Word32.word 1); Value.string (Word32.word 1); Value.array (Word32.word 1);
        Value.sexp (ByteString.inj "Tag") (Word32.word 1); Value.closure (Word32.word 2) (Word32.word 1);
        Value.builtin (ByteString.inj "read"); Value.empty ()
      ] in
      List.iteri (fun leftIndex leftValue ->
        List.iteri (fun rightIndex rightValue ->
          let results = Stream.take @@ run q (SM.sameValue leftValue rightValue)
            (fun qs -> qs#reify Std.Bool.prj_exn) in
          assert (results = [leftIndex = rightIndex])
        ) values
      ) values;
      Printf.printf "sameValue constructor pairs: %d checked\n" (List.length values * List.length values);
      List.iter (fun (description, leftValue, rightValue, expected) ->
        let results = Stream.take @@ run q (SM.sameValue leftValue rightValue)
          (fun qs -> qs#reify Std.Bool.prj_exn) in
        assert (results = [expected]);
        Printf.printf "sameValue %s = %s\n" description (show(list) (show(bool)) results)
      ) [
        ("different integers", Value.int (Word32.word 1), Value.int (Word32.word 2), false);
        ("different string IDs", Value.string (Word32.word 1), Value.string (Word32.word 2), false);
        ("different array IDs", Value.array (Word32.word 1), Value.array (Word32.word 2), false);
        ("different Sexp IDs", Value.sexp (ByteString.inj "Tag") (Word32.word 1), Value.sexp (ByteString.inj "Tag") (Word32.word 2), false);
        ("different Sexp tags", Value.sexp (ByteString.inj "Left") (Word32.word 1), Value.sexp (ByteString.inj "Right") (Word32.word 1), true);
        ("different closure IDs", Value.closure (Word32.word 2) (Word32.word 1), Value.closure (Word32.word 2) (Word32.word 3), false);
        ("different closure entries", Value.closure (Word32.word 2) (Word32.word 1), Value.closure (Word32.word 3) (Word32.word 1), true);
        ("different builtin names", Value.builtin (ByteString.inj "read"), Value.builtin (ByteString.inj "write"), false)
      ]

    let test_sameValue_2 () =
      let values = Stream.take @@ run q (fun value -> ocanren {
        SM.sameValue (Value.Int !(Word32.word 7)) value true
      }) (fun qs -> qs#reify Value.prj_exn) in
      assert (values = [Value.Int 7]);
      Printf.printf "values equal to Int 7 = %s\n" (show(list) (show(Value.t)) values);
      let sexps = Stream.take @@ run q (fun value -> ocanren {
        SM.sameValue (Value.Sexp (!(ByteString.inj "Tag"), !(Word32.word 0))) value true
      }) (fun qs -> qs#reify Value.reify) in
      assert (match sexps with
        | [OCanren.Value (Value.Sexp (OCanren.Var _, objectId))] -> objectId = logicalWord 0
        | _ -> false);
      Printf.printf "values equal to Sexp Tag 0 = %s\n" (show(list) (show(Value.logic)) sexps);
      let closures = Stream.take @@ run q (fun value -> ocanren {
        SM.sameValue (Value.Closure (!(Word32.word 2), !(Word32.word 0))) value true
      }) (fun qs -> qs#reify Value.reify) in
      assert (match closures with
        | [OCanren.Value (Value.Closure (OCanren.Var _, objectId))] -> objectId = logicalWord 0
        | _ -> false);
      Printf.printf "values equal to Closure 2 0 = %s\n" (show(list) (show(Value.logic)) closures);
      let names = Stream.take @@ run q (fun name -> ocanren {
        SM.sameValue (Value.Builtin !(ByteString.inj "read")) (Value.Builtin name) true
      }) (fun qs -> qs#reify ByteString.prj_exn) in
      assert (names = ["read"]);
      Printf.printf "builtin names equal to read = %s\n" (show(list) (show(string)) names);
      let unequal = Stream.take @@ run q (fun number -> ocanren {
        SM.sameValue (Value.Int !(Word32.word 0)) (Value.Int number) false
      }) (fun qs -> qs#reify Word32.reify) in
      Word32_tests.expect_ranges "numbers unequal to Int 0"
        [(1, Word32.max_value)] unequal;
      Printf.printf "numbers unequal to Int 0: %d patterns cover [1, %d]\n"
        (List.length unequal) Word32.max_value;
      List.iter (fun (same, expected) ->
        let answers = Stream.take @@ run q (fun number -> ocanren {
          SM.sameValue (Value.Int !(Word32.word 0)) (Value.Int number) !(inj same) &
          {number == !(Word32.word 0) | number == !(Word32.word 2)}
        }) (fun qs -> qs#reify Word32.prj_exn) in
        let numbers = List.map Word32.to_int answers in
        assert (numbers = expected);
        Printf.printf "numbers for sameValue Int 0 %b = %s\n" same (show(list) (show(int)) numbers)
      ) [(true, [0]); (false, [2])];
      let tags = Stream.take @@ run q (fun tag -> ocanren {
        SM.sameValue (Value.Sexp (!(ByteString.inj "Tag"), !(Word32.word 0))) (Value.Sexp (tag, !(Word32.word 0))) false
      }) (fun qs -> qs#reify ByteString.reify) in
      assert (tags = []);
      Printf.printf "tags making the same Sexp ID unequal = %s\n"
        (show(list) (show(ByteString.logic)) tags);
      let entries = Stream.take @@ run q (fun entry -> ocanren {
        SM.sameValue (Value.Closure (!(Word32.word 2), !(Word32.word 0))) (Value.Closure (entry, !(Word32.word 0))) false
      }) (fun qs -> qs#reify Word32.reify) in
      assert (entries = []);
      Printf.printf "entries making the same closure ID unequal = %s\n"
        (show(list) (show(Word32.logic)) entries);
      List.iter (fun goal ->
        let values = Stream.take @@ run q goal (fun qs -> qs#reify Value.reify) in
        let kinds = List.map (function
          | OCanren.Value (Value.Int (OCanren.Var (_, []))) -> "Int"
          | OCanren.Value (Value.String (OCanren.Var (_, []))) -> "String"
          | OCanren.Value (Value.Array (OCanren.Var (_, []))) -> "Array"
          | OCanren.Value (Value.Sexp (OCanren.Var (_, []), OCanren.Var (_, []))) -> "Sexp"
          | OCanren.Value (Value.Closure (OCanren.Var (_, []), OCanren.Var (_, []))) -> "Closure"
          | OCanren.Value (Value.Builtin (OCanren.Var (_, []))) -> "Builtin"
          | _ -> failwith "sameValue: expected a nonempty constructor with free fields"
        ) values in
        assert (List.sort Stdlib.compare kinds = ["Array"; "Builtin"; "Closure"; "Int"; "Sexp"; "String"])
      ) [(fun value -> ocanren { SM.sameValue Value.Empty value false });
         (fun value -> ocanren { SM.sameValue value Value.Empty false })];
      let contradictory = Stream.take @@ run q (fun value -> ocanren {
        SM.sameValue value value false
      }) (fun qs -> qs#reify Value.reify) in
      assert (contradictory = []);
      Printf.printf "sameValue reverse constructor search and self inequality: OK\n"

    let check_binop description operator ~left ~right expected =
      let number_prj = Reifier.fmap Word32.to_int Word32.prj_exn in
      let answers = Stream.take @@ run q
        (SM.binopFunc (inj operator) (Word32.word left) (Word32.word right))
        (fun answer -> answer#reify (SM.prj_exn number_prj)) in
      if answers <> [expected] then
        failwith (Printf.sprintf "%s: expected %s, got %s" description
          (show(SM.t) (show(int)) expected)
          (show(list) (show(SM.t) (show(int))) answers));
      Printf.printf "binopFunc %s: OK\n%!" description

    let test_binopArithmetic () =
      check_binop "addition: 7 + 2 = 9" "+" ~left:7 ~right:2 (SM.Right 9);
      check_binop "addition wraps at 2^32" "+" ~left:0xffff_ffff ~right:1 (SM.Right 0);
      check_binop "subtraction keeps operand order: 7 - 2 = 5" "-" ~left:7 ~right:2 (SM.Right 5);
      check_binop "subtraction wraps below zero" "-" ~left:0 ~right:1 (SM.Right 0xffff_ffff);
      check_binop "multiplication: 6 * 7 = 42" "*" ~left:6 ~right:7 (SM.Right 42);
      check_binop "multiplication discards overflow" "*" ~left:0x8000_0000 ~right:2 (SM.Right 0);
      check_binop "division: 17 / 5 = 3" "/" ~left:17 ~right:5 (SM.Right 3);
      check_binop "division is unsigned" "/" ~left:0xffff_ffff ~right:2 (SM.Right 0x7fff_ffff);
      check_binop "remainder: 17 % 5 = 2" "%" ~left:17 ~right:5 (SM.Right 2);
      check_binop "remainder is unsigned" "%" ~left:0xffff_ffff ~right:0x8000_0000 (SM.Right 0x7fff_ffff)

    let test_binopComparisons () =
      check_binop "less than: smaller operand" "<" ~left:2 ~right:7 (SM.Right 1);
      check_binop "less than: equal operands" "<" ~left:7 ~right:7 (SM.Right 0);
      check_binop "less than: larger operand" "<" ~left:7 ~right:2 (SM.Right 0);
      check_binop "less or equal: smaller operand" "<=" ~left:2 ~right:7 (SM.Right 1);
      check_binop "less or equal: equal operands" "<=" ~left:7 ~right:7 (SM.Right 1);
      check_binop "less or equal: larger operand" "<=" ~left:7 ~right:2 (SM.Right 0);
      check_binop "greater than: larger operand" ">" ~left:7 ~right:2 (SM.Right 1);
      check_binop "greater than: equal operands" ">" ~left:7 ~right:7 (SM.Right 0);
      check_binop "greater than: smaller operand" ">" ~left:2 ~right:7 (SM.Right 0);
      check_binop "greater or equal: larger operand" ">=" ~left:7 ~right:2 (SM.Right 1);
      check_binop "greater or equal: equal operands" ">=" ~left:7 ~right:7 (SM.Right 1);
      check_binop "greater or equal: smaller operand" ">=" ~left:2 ~right:7 (SM.Right 0);
      check_binop "equality: equal operands" "==" ~left:7 ~right:7 (SM.Right 1);
      check_binop "equality: different operands" "==" ~left:7 ~right:2 (SM.Right 0);
      check_binop "inequality: equal operands" "!=" ~left:7 ~right:7 (SM.Right 0);
      check_binop "inequality: different operands" "!=" ~left:7 ~right:2 (SM.Right 1);
      check_binop "top bit does not make a word negative" ">" ~left:0x8000_0000 ~right:0x7fff_ffff (SM.Right 1);
      check_binop "maximum is not below zero" "<" ~left:0xffff_ffff ~right:0 (SM.Right 0)

    let test_binopBooleans () =
      check_binop "AND: both operands are zero" "&&" ~left:0 ~right:0 (SM.Right 0);
      check_binop "AND: only left operand is zero" "&&" ~left:0 ~right:7 (SM.Right 0);
      check_binop "AND: only right operand is zero" "&&" ~left:7 ~right:0 (SM.Right 0);
      check_binop "AND: any nonzero operands mean true" "&&" ~left:7 ~right:0x8000_0000 (SM.Right 1);
      check_binop "OR: both operands are zero" "!!" ~left:0 ~right:0 (SM.Right 0);
      check_binop "OR: only right operand is nonzero" "!!" ~left:0 ~right:7 (SM.Right 1);
      check_binop "OR: only left operand is nonzero" "!!" ~left:7 ~right:0 (SM.Right 1);
      check_binop "OR: both operands are nonzero" "!!" ~left:7 ~right:0x8000_0000 (SM.Right 1)

    let test_binopErrors () =
      check_binop "division by zero" "/" ~left:7 ~right:0 (SM.Left "division by zero");
      check_binop "modulo by zero" "%" ~left:7 ~right:0 (SM.Left "modulo by zero");
      check_binop "unknown operator" "^" ~left:7 ~right:2 (SM.Left "unknown binary operator");
      check_binop "OR is spelled !!, not ||" "||" ~left:7 ~right:2 (SM.Left "unknown binary operator")

    let check_binopWords description expected goal =
      let number_prj = Reifier.fmap Word32.to_int Word32.prj_exn in
      let answers = Stream.take @@ run q goal (fun answer -> answer#reify number_prj) in
      if List.sort Stdlib.compare answers <> List.sort Stdlib.compare expected then
        failwith (Printf.sprintf "%s: expected %s, got %s" description
          (show(list) (show(int)) expected) (show(list) (show(int)) answers));
      Printf.printf "binopFunc %s: OK\n%!" description

    let test_binopBackwards () =
      check_binopWords "recover left operand: ? + 5 = 12" [7] (fun left -> ocanren {
        SM.binopFunc !(inj "+") left !(Word32.word 5) (SM.Right !(Word32.word 12))
      });
      check_binopWords "recover right operand: 7 - ? = 2" [5] (fun right -> ocanren {
        SM.binopFunc !(inj "-") !(Word32.word 7) right (SM.Right !(Word32.word 2))
      });
      check_binopWords "even multiplier has two modular solutions: 2 * ? = 6" [3; 0x8000_0003] (fun right -> ocanren {
        SM.binopFunc !(inj "*") !(Word32.word 2) right (SM.Right !(Word32.word 6))
      });
      check_binopWords "recover every dividend: ? / 5 = 3" [15; 16; 17; 18; 19] (fun left -> ocanren {
        SM.binopFunc !(inj "/") left !(Word32.word 5) (SM.Right !(Word32.word 3))
      });
      check_binopWords "recover divisors with remainder two: 17 % ? = 2" [3; 5; 15] (fun right -> ocanren {
        SM.binopFunc !(inj "%") !(Word32.word 17) right (SM.Right !(Word32.word 2))
      });
      check_binopWords "equality recovers the other operand" [7] (fun right -> ocanren {
        SM.binopFunc !(inj "==") !(Word32.word 7) right (SM.Right !(Word32.word 1))
      });
      check_binopWords "no unsigned word is less than zero" [] (fun left -> ocanren {
        SM.binopFunc !(inj "<") left !(Word32.word 0) (SM.Right !(Word32.word 1))
      });
      check_binopWords "AND with a nonzero operand is false only for zero" [0] (fun left -> ocanren {
        SM.binopFunc !(inj "&&") left !(Word32.word 7) (SM.Right !(Word32.word 0))
      });
      check_binopWords "division error recovers the zero divisor" [0] (fun right -> ocanren {
        SM.binopFunc !(inj "/") !(Word32.word 7) right (SM.Left !(inj "division by zero"))
      })

    let check_binopOperators description expected goal =
      let answers = Stream.take @@ run q goal (fun answer -> answer#reify Std.String.prj_exn) in
      if List.sort Stdlib.compare answers <> List.sort Stdlib.compare expected then
        failwith (Printf.sprintf "%s: expected %s, got %s" description
          (show(list) (show(string)) expected) (show(list) (show(string)) answers));
      Printf.printf "binopFunc %s: OK\n%!" description

    let test_binopOperators () =
      check_binopOperators "find the operator: 7 ? 2 = 9" ["+"] (fun operator -> ocanren {
        SM.binopFunc operator !(Word32.word 7) !(Word32.word 2) (SM.Right !(Word32.word 9))
      });
      check_binopOperators "find every operator: 7 ? 2 = 1" ["%"; ">"; ">="; "!="; "&&"; "!!"] (fun operator -> ocanren {
        SM.binopFunc operator !(Word32.word 7) !(Word32.word 2) (SM.Right !(Word32.word 1))
      });
      check_binopOperators "unknown-operator answer excludes supported operators" [""; "^"] (fun operator -> ocanren {
        SM.binopFunc operator !(Word32.word 7) !(Word32.word 2) (SM.Left !(inj "unknown binary operator")) &
        {operator == !(inj "^") | operator == !(inj "+") | operator == !(inj "")}
      })

    let test_currentClosureId () =
      let number_prj = Reifier.fmap Word32.to_int Word32.prj_exn in
      List.iter (fun (description, closure, expected) ->
        let results = Stream.take @@ run q (fun result -> ocanren {
          SM.currentClosureId
            (Config.Config ([], [], [], Loc.Loc ([], [], closure), [], [], Store.Store [], !(Word32.word 0)))
            result
        }) (fun answer -> answer#reify (SM.prj_exn number_prj)) in
        if results <> [expected] then failwith ("currentClosureId " ^ description);
        Printf.printf "currentClosureId %s with an empty store: OK\n%!" description
      ) [("None returns no active closure", Std.Option.none (), SM.Left "no active closure");
         ("Some 0 returns Right 0", Std.Option.some (Word32.word 0), SM.Right 0);
         ("Some 7 returns Right 7", Std.Option.some (Word32.word 7), SM.Right 7);
         ("Some max returns Right max", Std.Option.some (Word32.word 0xffff_ffff), SM.Right 0xffff_ffff)]

    let test_currentClosureId_backwards () =
      let number_prj = Reifier.fmap Word32.to_int Word32.prj_exn in
      List.iter (fun (description, result, expected) ->
        let closures = Stream.take @@ run q (fun closure -> ocanren {
          fresh callStack, stack, globals, arguments, locals, inputs, outputs, store, nextId in
            SM.currentClosureId
              (Config.Config (callStack, stack, globals, Loc.Loc (arguments, locals, closure),
                              inputs, outputs, store, nextId)) result
        }) (fun answer -> answer#reify (Std.Option.prj_exn number_prj)) in
        if closures <> [expected] then failwith ("currentClosureId " ^ description);
        Printf.printf "currentClosureId %s: OK\n%!" description
      ) [("Right 7 restores Some 7", inj (SM.Right (Word32.word 7)), Some 7);
         ("no active closure restores None", SM.throwSM_inj (inj "no active closure"), None)]

    let lookupState ?(objects = []) () =
      let bindings = Std.list (fun (objectId, fields) ->
        ocanren { (!(Word32.word objectId), !(Std.list Fun.id fields)) }) objects in
      ocanren {
        Config.Config ([], [], [], Loc.Loc ([], [], None), [], [], Store.Store bindings, !(Word32.word 0))
      }

    let lookupFixture () =
      lookupState
        ~objects:[(42, [Value.int (Word32.word 99)]);
                  (0xffff_ffff, [Value.string (Word32.word 8); Value.empty ()]); (0, [])] ()

    let check_lookupStore description state objectId expected =
      let answers = Stream.take @@ run q (SM.lookupStore (Word32.word objectId) state)
        (fun answer -> answer#reify (SM.prj_exn (Std.List.prj_exn Value.prj_exn))) in
      if answers <> [expected] then failwith ("lookupStore " ^ description);
      Printf.printf "lookupStore %s: OK\n%!" description

    let test_lookupStore () =
      let state = lookupFixture () in
      check_lookupStore "object 42 contains Int 99" state 42 (SM.Right [Value.Int 99]);
      check_lookupStore "maximum object ID preserves its fields" state 0xffff_ffff
        (SM.Right [Value.String 8; Value.Empty]);
      check_lookupStore "object zero exists with no fields" state 0 (SM.Right []);
      check_lookupStore "object ID is not a list position" state 1 (SM.Left "store: missing id");
      check_lookupStore "empty heap has no object zero" (lookupState ()) 0 (SM.Left "store: missing id");
      let objectIds = Stream.take @@ run q (fun objectId -> ocanren {
        SM.lookupStore objectId state (SM.Right [])
      }) (fun answer -> answer#reify (Reifier.fmap Word32.to_int Word32.prj_exn)) in
      assert (objectIds = [0]);
      Printf.printf "lookupStore recovers ID zero from empty fields: OK\n%!"

    let check_updateStore description state objectId values expected =
      let answers = Stream.take @@ run q (fun result -> ocanren {
        SM.updateStore !(Word32.word objectId) values state result
      }) (fun answer -> answer#reify (SM.prj_exn Config.prj_exn)) in
      let objects = List.map (function
        | SM.Left message -> SM.Left message
        | SM.Right (Config.Config (_, _, _, _, _, _, Store.Store objects, _)) -> SM.Right objects
      ) answers in
      if objects <> [expected] then failwith ("updateStore " ^ description);
      Printf.printf "updateStore %s: OK\n%!" description

    let test_updateStore () =
      let state = lookupFixture () in
      check_updateStore "replace the first object's complete field list" state 42
        (ocanren { [Value.Int !(Word32.word 7); Value.Empty] })
        (SM.Right [(42, [Value.Int 7; Value.Empty]);
                   (0xffff_ffff, [Value.String 8; Value.Empty]); (0, [])]);
      check_updateStore "replace the middle object at maximum ID with empty fields" state 0xffff_ffff
        (ocanren { [] })
        (SM.Right [(42, [Value.Int 99]); (0xffff_ffff, []); (0, [])]);
      check_updateStore "replace the last object's empty fields at ID zero" state 0
        (ocanren { [Value.Array !(Word32.word 9)] })
        (SM.Right [(42, [Value.Int 99]);
                   (0xffff_ffff, [Value.String 8; Value.Empty]); (0, [Value.Array 9])]);
      check_updateStore "missing ID is not inserted or treated as a list position" state 1
        (ocanren { [Value.Empty] }) (SM.Left "store: missing id");
      check_updateStore "empty heap does not gain an object" (lookupState ()) 0
        (ocanren { [] }) (SM.Left "store: missing id")

    let test_updateStore_preservesState () =
      let state = ocanren {
        Config.Config (
          [Frame.Frame (!(Word32.word 11), Loc.Loc ([], [], None), [Value.Int !(Word32.word 1)])],
          [Value.Int !(Word32.word 2)], [(!(inj "g"), Value.Int !(Word32.word 3))],
          Loc.Loc ([(!(Word32.word 4), Value.Int !(Word32.word 5))],
                   [(!(Word32.word 6), Value.Int !(Word32.word 7))], Some !(Word32.word 42)),
          [!(Word32.word 8)], [!(Word32.word 9)],
          Store.Store [(!(Word32.word 42), [Value.Int !(Word32.word 10)]);
                       (!(Word32.word 17), [Value.Empty])], !(Word32.word 100))
      } in
      let answers = Stream.take @@ run q (fun result -> ocanren {
        SM.updateStore !(Word32.word 42) [Value.Array !(Word32.word 0)] state result
      }) (fun answer -> answer#reify (SM.prj_exn Config.prj_exn)) in
      let expected = Config.Config (
        [Frame.Frame (11, Loc.Loc ([], [], None), [Value.Int 1])],
        [Value.Int 2], [("g", Value.Int 3)],
        Loc.Loc ([(4, Value.Int 5)], [(6, Value.Int 7)], Some 42),
        [8], [9], Store.Store [(42, [Value.Array 0]); (17, [Value.Empty])], 100) in
      assert (answers = [SM.Right expected]);
      Printf.printf "updateStore preserves every other Config field, nextId and neighbouring object: OK\n%!"

    let test_updateStore_backwards () =
      let state = lookupFixture () in
      let changedFirst = lookupState
        ~objects:[(42, [Value.array (Word32.word 9)]);
                  (0xffff_ffff, [Value.string (Word32.word 8); Value.empty ()]); (0, [])] () in
      let objectIds = Stream.take @@ run q (fun objectId -> ocanren {
        SM.updateStore objectId [Value.Array !(Word32.word 9)] state (SM.Right changedFirst)
      }) (fun answer -> answer#reify (Reifier.fmap Word32.to_int Word32.prj_exn)) in
      assert (objectIds = [42]);
      Printf.printf "updateStore restores ID 42 from the changed state: OK\n%!";
      let changedLast = lookupState
        ~objects:[(42, [Value.int (Word32.word 99)]);
                  (0xffff_ffff, [Value.string (Word32.word 8); Value.empty ()]);
                  (0, [Value.array (Word32.word 9); Value.int (Word32.word 7)])] () in
      let fields = Stream.take @@ run q (fun values -> ocanren {
        SM.updateStore !(Word32.word 0) values state (SM.Right changedLast)
      }) (fun answer -> answer#reify (Std.List.prj_exn Value.prj_exn)) in
      assert (fields = [[Value.Array 9; Value.Int 7]]);
      Printf.printf "updateStore restores the complete new field list: OK\n%!"

    let designationState ?(globals = []) ?(arguments = []) ?(locals = []) ?closure ?(objects = []) () =
      let globals = Std.list (fun (name, value) -> ocanren { (!(inj name), value) }) globals in
      let arguments = Std.list (fun (index, value) -> ocanren { (!(Word32.word index), value) }) arguments in
      let locals = Std.list (fun (index, value) -> ocanren { (!(Word32.word index), value) }) locals in
      let closure = match closure with
        | None -> ocanren { None }
        | Some objectId -> ocanren { Some !(Word32.word objectId) }
      in
      let bindings = Std.list (fun (objectId, fields) ->
        ocanren { (!(Word32.word objectId), !(Std.list Fun.id fields)) }) objects in
      ocanren {
        Config.Config ([], [], globals, Loc.Loc (arguments, locals, closure), [], [],
                       Store.Store bindings, !(Word32.word 0))
      }

    let designationFixture () =
      designationState
        ~globals:[("g", Value.int (Word32.word 10)); ("empty", Value.empty ())]
        ~arguments:[(7, Value.int (Word32.word 20)); (0, Value.empty ())]
        ~locals:[(7, Value.int (Word32.word 30)); (0xffff_ffff, Value.empty ())]
        ~closure:0xffff_ffff
        ~objects:[(42, [Value.int (Word32.word 99)]);
                  (0xffff_ffff, [Value.string (Word32.word 8); Value.empty ()]); (0, [])] ()

    let check_lookupDesignation description state designation expected =
      let answers = Stream.take @@ run q (SM.lookupDesignation state designation)
        (fun answer -> answer#reify (SM.prj_exn Value.prj_exn)) in
      if answers <> [expected] then
        failwith (Printf.sprintf "%s: expected %s, got %s" description
          (show(SM.t) (show(Value.t)) expected)
          (show(list) (show(SM.t) (show(Value.t))) answers));
      Printf.printf "lookupDesignation %s: OK\n%!" description

    let test_lookupDesignation () =
      let state = designationFixture () in
      check_lookupDesignation "global g contains Int 10" state
        (Designation.global (inj "g")) (SM.Right (Value.Int 10));
      check_lookupDesignation "local key 7 contains Int 30" state
        (Designation.local (Word32.word 7)) (SM.Right (Value.Int 30));
      check_lookupDesignation "argument key 7 contains Int 20" state
        (Designation.arg (Word32.word 7)) (SM.Right (Value.Int 20));
      check_lookupDesignation "maximum local key is present" state
        (Designation.local (Word32.word 0xffff_ffff)) (SM.Right Value.Empty);
      check_lookupDesignation "argument key zero is present" state
        (Designation.arg (Word32.word 0)) (SM.Right Value.Empty);
      check_lookupDesignation "capture zero comes from the maximum closure ID" state
        (Designation.access (Word32.word 0)) (SM.Right (Value.String 8));
      check_lookupDesignation "capture one is Empty, not missing" state
        (Designation.access (Word32.word 1)) (SM.Right Value.Empty);
      check_lookupDesignation "zero closure ID and capture index are valid"
        (designationState ~closure:0 ~objects:[(0, [Value.int (Word32.word 0)])] ())
        (Designation.access (Word32.word 0)) (SM.Right (Value.Int 0))

    let test_lookupDesignation_errors () =
      let state = designationFixture () in
      let empty = designationState () in
      check_lookupDesignation "missing global name" state
        (Designation.global (inj "absent")) (SM.Left "unbound global");
      check_lookupDesignation "local key is not a list position" state
        (Designation.local (Word32.word 1)) (SM.Left "unbound local");
      check_lookupDesignation "local lookup does not fall back to arguments" state
        (Designation.local (Word32.word 0)) (SM.Left "unbound local");
      check_lookupDesignation "argument lookup does not fall back to locals" state
        (Designation.arg (Word32.word 0xffff_ffff)) (SM.Left "unbound argument");
      check_lookupDesignation "empty globals" empty
        (Designation.global (inj "g")) (SM.Left "unbound global");
      check_lookupDesignation "empty locals" empty
        (Designation.local (Word32.word 7)) (SM.Left "unbound local");
      check_lookupDesignation "empty arguments" empty
        (Designation.arg (Word32.word 7)) (SM.Left "unbound argument");
      check_lookupDesignation "capture index equal to length is out of bounds" state
        (Designation.access (Word32.word 2)) (SM.Left "closure access: index out of bounds");
      check_lookupDesignation "maximum capture index is out of bounds" state
        (Designation.access (Word32.word 0xffff_ffff)) (SM.Left "closure access: index out of bounds");
      check_lookupDesignation "missing closure takes precedence over heap and index errors" empty
        (Designation.access (Word32.word 0xffff_ffff)) (SM.Left "no active closure");
      check_lookupDesignation "missing heap object takes precedence over index error"
        (designationState ~closure:42 ())
        (Designation.access (Word32.word 0xffff_ffff)) (SM.Left "store: missing id");
      check_lookupDesignation "empty captures mean bounds error, not missing object"
        (designationState ~closure:0 ~objects:[(0, [])] ())
        (Designation.access (Word32.word 0)) (SM.Left "closure access: index out of bounds")

    let test_lookupDesignation_backwards () =
      let state = designationFixture () in
      let designations = Stream.take @@ run q (fun designation -> ocanren {
        SM.lookupDesignation state designation (SM.Right Value.Empty)
      }) (fun answer -> answer#reify Designation.prj_exn) in
      let expected = [Designation.Global "empty"; Designation.Local 0xffff_ffff;
                      Designation.Arg 0; Designation.Access 1] in
      assert (List.sort Stdlib.compare designations = List.sort Stdlib.compare expected);
      Printf.printf "lookupDesignation finds every designation containing Empty: OK\n%!";
      let indices = Stream.take @@ run q (fun index -> ocanren {
        SM.lookupDesignation state (Designation.Local index) (SM.Right (Value.Int !(Word32.word 30)))
      }) (fun answer -> answer#reify (Reifier.fmap Word32.to_int Word32.prj_exn)) in
      assert (indices = [7]);
      Printf.printf "lookupDesignation restores local key 7 from Int 30: OK\n%!"

    let test_capture () =
      let state = designationFixture () in
      List.iter (fun (description, state, designation, expected) ->
        let answers = Stream.take @@ run q (SM.capture state designation)
          (fun answer -> answer#reify (SM.prj_exn Value.prj_exn)) in
        assert (answers = [expected]);
        Printf.printf "capture %s: OK\n%!" description
      ) [("rejects an existing global", state, Designation.global (inj "g"),
          SM.Left "CLOSURE: bad designation");
         ("reads a local without confusing it with an argument", state,
          Designation.local (Word32.word 7), SM.Right (Value.Int 30));
         ("reads an argument without confusing it with a local", state,
          Designation.arg (Word32.word 7), SM.Right (Value.Int 20));
         ("reads capture zero from the maximum closure ID", state,
          Designation.access (Word32.word 0), SM.Right (Value.String 8));
         ("forwards an unbound local", state, Designation.local (Word32.word 0), SM.Left "unbound local");
         ("forwards an unbound argument at the maximum key", state,
          Designation.arg (Word32.word 0xffff_ffff), SM.Left "unbound argument");
         ("forwards a missing active closure", designationState (),
          Designation.access (Word32.word 0), SM.Left "no active closure");
         ("forwards a missing closure object", designationState ~closure:42 (),
          Designation.access (Word32.word 0), SM.Left "store: missing id");
         ("forwards a capture index equal to length", state,
          Designation.access (Word32.word 2), SM.Left "closure access: index out of bounds");
         ("forwards index zero for empty captures", designationState ~closure:0 ~objects:[(0, [])] (),
          Designation.access (Word32.word 0), SM.Left "closure access: index out of bounds")]

    let test_capture_backwards () =
      let state = designationFixture () in
      let designations = Stream.take @@ run q (fun designation -> ocanren {
        SM.capture state designation (SM.Right Value.Empty)
      }) (fun answer -> answer#reify Designation.prj_exn) in
      let expected = [Designation.Local 0xffff_ffff; Designation.Arg 0; Designation.Access 1] in
      assert (List.sort Stdlib.compare designations = List.sort Stdlib.compare expected);
      Printf.printf "capture finds every allowed designation containing Empty and excludes Global: OK\n%!"

    let test_mapM_toInt () =
      List.iter (fun (values, expected) ->
        let results = Stream.take @@ run q (SM.mapM SM.toInt (Std.list Fun.id values))
          (fun answer -> answer#reify (SM.prj_exn
            (Std.List.prj_exn (Reifier.fmap Word32.to_int Word32.prj_exn)))) in
        assert (results = [expected])
      ) [([], SM.Right []);
         ([Value.int (Word32.word 0); Value.int (Word32.word 0xffff_ffff);
           Value.int (Word32.word 7)], SM.Right [0; 0xffff_ffff; 7]);
         ([Value.int (Word32.word 7); Value.empty (); Value.int (Word32.word 9)],
          SM.Left "expected int")];
      Printf.printf "mapM toInt preserves order, accepts empty input and forwards errors: OK\n%!"

    let test_mapM_capture_firstError () =
      let state = designationFixture () in
      let valid = Designation.local (Word32.word 7) in
      let global = Designation.global (inj "g") in
      let missingArgument = Designation.arg (Word32.word 0xffff_ffff) in
      List.iter (fun (designations, expected) ->
        let results = Stream.take @@ run q
          (SM.mapM (SM.capture state) (Std.list Fun.id designations))
          (fun answer -> answer#reify (SM.prj_exn (Std.List.prj_exn Value.prj_exn))) in
        assert (results = [expected])
      ) [([valid; global; missingArgument], SM.Left "CLOSURE: bad designation");
         ([valid; missingArgument; global], SM.Left "unbound argument");
         ([valid; Designation.arg (Word32.word 7)], SM.Right [Value.Int 30; Value.Int 20])];
      Printf.printf "mapM capture returns the first error in input order: OK\n%!"

    let test_mapM_toInt_backwards () =
      List.iter (fun (numbers, expected) ->
        let values = Stream.take @@ run q (fun values ->
          SM.mapM SM.toInt values (inj (SM.Right (Std.list Word32.word numbers))))
          (fun answer -> answer#reify (Std.List.prj_exn Value.prj_exn)) in
        assert (values = [expected])
      ) [([], []); ([0; 0xffff_ffff; 7], [Value.Int 0; Value.Int 0xffff_ffff; Value.Int 7])];
      Printf.printf "mapM toInt reconstructs the complete input list from Right: OK\n%!"

    let test_mapM_error_freeTail () =
      let answers = Stream.take @@ run q (fun answer -> ocanren {
        fresh tail, result in
          SM.mapM SM.toInt ((Value.Int !(Word32.word 7)) :: Value.Empty :: tail) result &
          answer == (tail, result)
      }) (fun answer -> answer#reify
        (Std.Pair.reify (Std.List.reify Value.reify) (SM.reify (Std.List.reify Word32.reify)))) in
      assert (match answers with
        | [OCanren.Value (OCanren.Var (_, []),
            OCanren.Value (SM.Left (OCanren.Value "expected int")))] -> true
        | _ -> false);
      Printf.printf "mapM terminates after the first error and leaves the remaining tail free: OK\n%!"

    let returnState callStack environment =
      ocanren {
        Config.Config (callStack, [Value.Int !(Word32.word 91); Value.Empty],
          [(!(inj "g"), Value.Array !(Word32.word 8))], environment,
          [!(Word32.word 12)], [!(Word32.word 13)],
          Store.Store [(!(Word32.word 8), [Value.Int !(Word32.word 14)])], !(Word32.word 9))
      }

    let test_returnFromCall_caller () =
      let caller = ocanren { Loc.Loc ([(!(Word32.word 0), Value.Int !(Word32.word 21))], [], Some !(Word32.word 8)) } in
      let current = ocanren { Loc.Loc ([], [(!(Word32.word 3), Value.Empty)], None) } in
      let tail = ocanren { Frame.Frame (!(Word32.word 17), Loc.Loc ([], [], None), []) } in
      List.iter (fun address ->
        let state = returnState
          (ocanren { [Frame.Frame (!(Word32.word address), caller, [Value.Int !(Word32.word 999)]); tail] }) current in
        let answers = Stream.take @@ run q (fun result -> ocanren {
          fresh program in SM.returnFromCall program state result
        }) (fun answer -> answer#reify (SM.prj_exn (Std.Pair.prj_exn Config.prj_exn
          (Reifier.fmap Word32.to_int Word32.prj_exn)))) in
        assert (answers = [SM.Right (Config.Config (
          [Frame.Frame (17, Loc.Loc ([], [], None), [])], [Value.Int 91; Value.Empty],
          [("g", Value.Array 8)], Loc.Loc ([(0, Value.Int 21)], [], Some 8),
          [12], [13], Store.Store [(8, [Value.Int 14])], 9), address)]);
        Printf.printf "returnFromCall restores caller at %d and preserves all other fields: OK\n%!" address
      ) [0; Word32.max_value]

    let test_returnFromCall_main () =
      let state = returnState (ocanren { [] }) (ocanren { Loc.Loc ([], [], None) }) in
      List.iter (fun (instructions, expectedAddress) ->
        let program = Prog.make (Std.list Fun.id instructions) (Word32.word 77)
          (ocanren { [(!(Word32.word 55), !(ByteString.inj "unused"))] }) in
        let answers = Stream.take @@ run q (SM.returnFromCall program state)
          (fun answer -> answer#reify (SM.prj_exn (Std.Pair.prj_exn Config.prj_exn
            (Reifier.fmap Word32.to_int Word32.prj_exn)))) in
        assert (answers = [SM.Right (Config.Config ([], [Value.Int 91; Value.Empty],
          [("g", Value.Array 8)], Loc.Loc ([], [], None), [12], [13],
          Store.Store [(8, [Value.Int 14])], 9), expectedAddress)]);
        Printf.printf "returnFromCall main halts at instruction count %d without changing state: OK\n%!" expectedAddress
      ) [([], 0); ([ocanren { Insn.CONST !(Word32.word 4) }; ocanren { Insn.RET }], 2)]

    let test_returnFromCall_backwards () =
      let caller = ocanren { Loc.Loc ([], [(!(Word32.word 2), Value.Int !(Word32.word 6))], None) } in
      let current = ocanren { Loc.Loc ([], [], Some !(Word32.word 8)) } in
      let expectedState = returnState (ocanren { [] }) caller in
      let frames = Stream.take @@ run q (fun frame ->
        Fresh.three (fun program address environment ->
          (frame === Frame.frame address environment (ocanren { [Value.Empty] })) &&&
          SM.returnFromCall program (returnState (Std.list Fun.id [frame]) current)
            (ocanren { SM.Right (Std.pair expectedState !(Word32.word 42)) })))
        (fun answer -> answer#reify Frame.prj_exn) in
      assert (frames = [Frame.Frame (42, Loc.Loc ([], [(2, Value.Int 6)], None), [Value.Empty])]);
      Printf.printf "returnFromCall recovers return address and caller environment from result: OK\n%!"

    let test_updateDesignation () =
      let state = designationFixture () in
      let empty = designationState () in
      let globals = [("g", Value.Int 10); ("empty", Value.Empty)] in
      let arguments = [(7, Value.Int 20); (0, Value.Empty)] in
      let locals = [(7, Value.Int 30); (0xffff_ffff, Value.Empty)] in
      let objects = [(42, [Value.Int 99]);
                     (0xffff_ffff, [Value.String 8; Value.Empty]); (0, [])] in
      let expected ?(globals = globals) ?(arguments = arguments) ?(locals = locals)
          ?(objects = objects) () =
        SM.Right (Config.Config ([], [], globals, Loc.Loc (arguments, locals, Some 0xffff_ffff),
                                 [], [], Store.Store objects, 0))
      in
      List.iter (fun (description, input, designation, expected) ->
        let answers = Stream.take @@ run q (fun result -> ocanren {
          SM.updateDesignation input (Value.Int !(Word32.word 11)) designation result
        }) (fun answer -> answer#reify (SM.prj_exn Config.prj_exn)) in
        assert (answers = [expected]);
        Printf.printf "updateDesignation %s: OK\n%!" description
      ) [("replace global in place", state, Designation.global (inj "g"),
          expected ~globals:[("g", Value.Int 11); ("empty", Value.Empty)] ());
         ("append missing global", state, Designation.global (inj "new"),
          expected ~globals:[("g", Value.Int 10); ("empty", Value.Empty); ("new", Value.Int 11)] ());
         ("insert into empty globals", empty, Designation.global (inj "new"),
          SM.Right (Config.Config ([], [], [("new", Value.Int 11)], Loc.Loc ([], [], None),
                                   [], [], Store.Store [], 0)));
         ("replace maximum local key in place", state, Designation.local (Word32.word 0xffff_ffff),
          expected ~locals:[(7, Value.Int 30); (0xffff_ffff, Value.Int 11)] ());
         ("append local zero without changing argument zero", state, Designation.local (Word32.word 0),
          expected ~locals:[(7, Value.Int 30); (0xffff_ffff, Value.Empty); (0, Value.Int 11)] ());
         ("insert maximum key into empty locals", empty, Designation.local (Word32.word 0xffff_ffff),
          SM.Right (Config.Config ([], [], [], Loc.Loc ([], [(0xffff_ffff, Value.Int 11)], None),
                                   [], [], Store.Store [], 0)));
         ("replace argument without changing local at the same key", state, Designation.arg (Word32.word 7),
          expected ~arguments:[(7, Value.Int 11); (0, Value.Empty)] ());
         ("append maximum argument key without changing local", state, Designation.arg (Word32.word 0xffff_ffff),
          expected ~arguments:[(7, Value.Int 20); (0, Value.Empty); (0xffff_ffff, Value.Int 11)] ());
         ("insert zero into empty arguments", empty, Designation.arg (Word32.word 0),
          SM.Right (Config.Config ([], [], [], Loc.Loc ([(0, Value.Int 11)], [], None),
                                   [], [], Store.Store [], 0)));
         ("replace first capture at maximum closure ID", state, Designation.access (Word32.word 0),
          expected ~objects:[(42, [Value.Int 99]);
                             (0xffff_ffff, [Value.Int 11; Value.Empty]); (0, [])] ());
         ("replace last capture without extending the object", state, Designation.access (Word32.word 1),
          expected ~objects:[(42, [Value.Int 99]);
                             (0xffff_ffff, [Value.String 8; Value.Int 11]); (0, [])] ());
         ("replace capture zero at closure ID zero",
          designationState ~closure:0 ~objects:[(0, [Value.empty ()])] (),
          Designation.access (Word32.word 0),
          SM.Right (Config.Config ([], [], [], Loc.Loc ([], [], Some 0),
                                   [], [], Store.Store [(0, [Value.Int 11])], 0)))]

    let test_updateDesignation_errors () =
      List.iter (fun (description, state, index, message) ->
        let answers = Stream.take @@ run q (fun result -> ocanren {
          SM.updateDesignation state Value.Empty (Designation.Access !(Word32.word index)) result
        }) (fun answer -> answer#reify (SM.prj_exn Config.prj_exn)) in
        assert (answers = [SM.Left message]);
        Printf.printf "updateDesignation %s: OK\n%!" description
      ) [("missing closure precedes missing object and invalid index", designationState (),
          Word32.max_value, "no active closure");
         ("missing object precedes invalid index", designationState ~closure:42 (),
          Word32.max_value, "store: missing id");
         ("empty captures cannot gain a field", designationState ~closure:0 ~objects:[(0, [])] (),
          0, "replaceAt: index out of bounds");
         ("capture index equal to length fails", designationFixture (),
          2, "replaceAt: index out of bounds");
         ("maximum capture index fails", designationFixture (),
          Word32.max_value, "replaceAt: index out of bounds")]

    let test_updateDesignation_preservesState () =
      let state = ocanren {
        Config.Config (
          [Frame.Frame (!(Word32.word 11), Loc.Loc ([], [], Some !(Word32.word 42)),
                        [Value.Closure (!(Word32.word 12), !(Word32.word 42))])],
          [Value.Closure (!(Word32.word 12), !(Word32.word 42)); Value.Int !(Word32.word 2)],
          [(!(inj "g"), Value.Int !(Word32.word 3))],
          Loc.Loc ([(!(Word32.word 4), Value.Int !(Word32.word 5))],
                   [(!(Word32.word 6), Value.Int !(Word32.word 7))], Some !(Word32.word 42)),
          [!(Word32.word 8)], [!(Word32.word 9)],
          Store.Store [(!(Word32.word 42), [Value.Int !(Word32.word 10); Value.String !(Word32.word 17); Value.Empty]);
                       (!(Word32.word 17), [Value.Int !(Word32.word 65)])], !(Word32.word 100))
      } in
      let answers = Stream.take @@ run q (fun result -> ocanren {
        SM.updateDesignation state (Value.Array !(Word32.word 17)) (Designation.Access !(Word32.word 1)) result
      }) (fun answer -> answer#reify (SM.prj_exn Config.prj_exn)) in
      let expected = Config.Config (
        [Frame.Frame (11, Loc.Loc ([], [], Some 42), [Value.Closure (12, 42)])],
        [Value.Closure (12, 42); Value.Int 2], [("g", Value.Int 3)],
        Loc.Loc ([(4, Value.Int 5)], [(6, Value.Int 7)], Some 42), [8], [9],
        Store.Store [(42, [Value.Int 10; Value.Array 17; Value.Empty]); (17, [Value.Int 65])], 100) in
      assert (answers = [SM.Right expected]);
      Printf.printf "updateDesignation changes only the shared closure field and preserves every other Config field: OK\n%!"

    let test_updateDesignation_backwards () =
      let state = designationState ~arguments:[(7, Value.int (Word32.word 20))]
        ~locals:[(7, Value.int (Word32.word 30))] () in
      let updated = designationState ~arguments:[(7, Value.int (Word32.word 20))]
        ~locals:[(7, Value.int (Word32.word 11))] () in
      let designations = Stream.take @@ run q (fun designation -> ocanren {
        SM.updateDesignation state (Value.Int !(Word32.word 11)) designation (SM.Right updated)
      }) (fun answer -> answer#reify Designation.prj_exn) in
      assert (designations = [Designation.Local 7]);
      Printf.printf "updateDesignation recovers Local 7 without confusing the argument at key 7: OK\n%!";
      let state = designationState ~closure:42
        ~objects:[(42, [Value.empty (); Value.int (Word32.word 30); Value.empty ()])] () in
      let updated = designationState ~closure:42
        ~objects:[(42, [Value.empty (); Value.int (Word32.word 11); Value.empty ()])] () in
      let indices = Stream.take @@ run q (fun index -> ocanren {
        SM.updateDesignation state (Value.Int !(Word32.word 11)) (Designation.Access index) (SM.Right updated)
      }) (fun answer -> answer#reify (Reifier.fmap Word32.to_int Word32.prj_exn)) in
      assert (indices = [1]);
      Printf.printf "updateDesignation recovers capture index 1 from the changed heap: OK\n%!"

    let test_allocStore () =
      List.iter (fun (description, bindings, nextId, values, expectedId, expectedBindings, expectedNextId) ->
        let answers = Stream.take @@ run q (fun result -> ocanren {
          SM.allocStore values
            (Config.Config ([], [], [], Loc.Loc ([], [], None), [], [], Store.Store bindings,
                            !(Word32.word nextId))) result
        }) (fun answer -> answer#reify
          (Std.Pair.prj_exn (Reifier.fmap Word32.to_int Word32.prj_exn) Config.prj_exn)) in
        let expected = (expectedId, Config.Config ([], [], [], Loc.Loc ([], [], None), [], [],
                                                  Store.Store expectedBindings, expectedNextId)) in
        assert (answers = [expected]);
        Printf.printf "allocStore %s: OK\n%!" description
      ) [("allocate object zero in an empty heap", (ocanren { [] }), 0,
          (ocanren { [Value.Int !(Word32.word 7)] }), 0, [(0, [Value.Int 7])], 1);
         ("append a sparse high ID without changing existing objects",
          (ocanren { [(!(Word32.word 42), [Value.String !(Word32.word 8)]);
                      (!(Word32.word 3), [Value.Empty])] }), 0x8000_0000,
          (ocanren { [Value.Array !(Word32.word 42); Value.Int !(Word32.word 9)] }),
          0x8000_0000, [(42, [Value.String 8]); (3, [Value.Empty]);
                       (0x8000_0000, [Value.Array 42; Value.Int 9])], 0x8000_0001);
         ("allocate an object with no fields", (ocanren { [] }), 12,
          (ocanren { [] }), 12, [(12, [])], 13);
         ("replace a colliding first binding in place",
          (ocanren { [(!(Word32.word 9), [Value.Int !(Word32.word 1)]);
                      (!(Word32.word 4), [Value.Empty])] }), 9,
          (ocanren { [Value.Builtin !(ByteString.inj "write")] }),
          9, [(9, [Value.Builtin "write"]); (4, [Value.Empty])], 10);
         ("replace a colliding middle binding with empty fields",
          (ocanren { [(!(Word32.word 2), [Value.Empty]);
                      (!(Word32.word 9), [Value.Int !(Word32.word 1)]);
                      (!(Word32.word 4), [Value.Array !(Word32.word 2)])] }), 9,
          (ocanren { [] }), 9, [(2, [Value.Empty]); (9, []); (4, [Value.Array 2])], 10);
         ("replace a colliding last binding without appending a duplicate",
          (ocanren { [(!(Word32.word 2), []); (!(Word32.word 9), [Value.Empty])] }), 9,
          (ocanren { [Value.Int !(Word32.word 6)] }), 9, [(2, []); (9, [Value.Int 6])], 10);
         ("maximum ID is returned before nextId wraps to zero", (ocanren { [] }), 0xffff_ffff,
          (ocanren { [Value.Empty] }), 0xffff_ffff, [(0xffff_ffff, [Value.Empty])], 0)]

    let test_allocStore_preservesState () =
      let state = ocanren {
        Config.Config (
          [Frame.Frame (!(Word32.word 11), Loc.Loc ([], [], Some !(Word32.word 42)),
                        [Value.Closure (!(Word32.word 12), !(Word32.word 42))])],
          [Value.Array !(Word32.word 17); Value.Int !(Word32.word 2)],
          [(!(inj "g"), Value.Closure (!(Word32.word 12), !(Word32.word 42)))],
          Loc.Loc ([(!(Word32.word 4), Value.Int !(Word32.word 5))],
                   [(!(Word32.word 6), Value.String !(Word32.word 17))], Some !(Word32.word 42)),
          [!(Word32.word 8); !(Word32.word 0xffff_ffff)], [!(Word32.word 9)],
          Store.Store [(!(Word32.word 42), [Value.String !(Word32.word 17)]);
                       (!(Word32.word 17), [Value.Int !(Word32.word 65)])], !(Word32.word 100))
      } in
      let answers = Stream.take @@ run q (fun result -> ocanren {
        SM.allocStore
          [Value.Closure (!(Word32.word 12), !(Word32.word 42)); Value.Array !(Word32.word 100);
           Value.String !(Word32.word 17); Value.Sexp (!(ByteString.inj "Node"), !(Word32.word 42));
           Value.Builtin !(ByteString.inj "write"); Value.Empty; Value.Int !(Word32.word 0xffff_ffff)] state result
      }) (fun answer -> answer#reify
        (Std.Pair.prj_exn (Reifier.fmap Word32.to_int Word32.prj_exn) Config.prj_exn)) in
      let expected = (100, Config.Config (
        [Frame.Frame (11, Loc.Loc ([], [], Some 42), [Value.Closure (12, 42)])],
        [Value.Array 17; Value.Int 2], [("g", Value.Closure (12, 42))],
        Loc.Loc ([(4, Value.Int 5)], [(6, Value.String 17)], Some 42),
        [8; 0xffff_ffff], [9], Store.Store [(42, [Value.String 17]); (17, [Value.Int 65]);
          (100, [Value.Closure (12, 42); Value.Array 100; Value.String 17; Value.Sexp ("Node", 42);
                 Value.Builtin "write"; Value.Empty; Value.Int 0xffff_ffff])], 101)) in
      assert (answers = [expected]);
      Printf.printf "allocStore preserves every other Config field and all stored value constructors: OK\n%!"

    let test_allocStore_backwardsId () =
      let number_prj = Reifier.fmap Word32.to_int Word32.prj_exn in
      List.iter (fun (description, successor, expected) ->
        let answers = Stream.take @@ run q (fun answer -> ocanren {
          fresh previousNextId, allocatedId, storedId in
            SM.allocStore [Value.Empty]
              (Config.Config ([], [], [], Loc.Loc ([], [], None), [], [], Store.Store [], previousNextId))
              (Std.pair allocatedId
                (Config.Config ([], [], [], Loc.Loc ([], [], None), [], [],
                                Store.Store [(storedId, [Value.Empty])], !(Word32.word successor)))) &
            answer == Std.pair previousNextId (Std.pair allocatedId storedId)
        }) (fun answer -> answer#reify (Std.Pair.prj_exn number_prj (Std.Pair.prj_exn number_prj number_prj))) in
        assert (answers = [expected]);
        Printf.printf "allocStore %s: OK\n%!" description
      ) [("successor eight recovers the old, returned and stored IDs", 8, (7, (7, 7)));
         ("successor zero recovers maximum IDs through inverse wrap", 0,
          (0xffff_ffff, (0xffff_ffff, 0xffff_ffff)))]

    let test_showValue_integers () =
      let program = Prog.make (Std.List.nil ()) (Word32.word 0) (Std.List.nil ()) in
      List.iter (fun (number, expected) ->
        let outputs = Stream.take @@ run q (SM.showValue program (lookupState ())
          (Value.int (Word32.word number)))
          (fun answer -> answer#reify ByteString.prj_exn) in
        assert (outputs = [expected]);
        Printf.printf "showValue Int %d = %S: OK\n%!" number expected
      ) [(0, "0"); (9, "9"); (10, "10"); (99, "99"); (100, "100");
         (0x8000_0000, "2147483648"); (Word32.max_value, "4294967295")];
      let number_prj = Reifier.fmap Word32.to_int Word32.prj_exn in
      let codes = Stream.take @@ run q (SM.showValue program (lookupState ()) (Value.int (Word32.word 42)))
        (fun answer -> answer#reify (Std.List.prj_exn number_prj)) in
      assert (codes = [[52; 50]])

    let test_showValue_strings () =
      let program = Prog.make (Std.List.nil ()) (Word32.word 0) (Std.List.nil ()) in
      let state = lookupState ~objects:[(0, []); (7,
        [Value.int (Word32.word 0); Value.int (Word32.word 34); Value.int (Word32.word 92);
         Value.int (Word32.word 255); Value.string (Word32.word 99); Value.array (Word32.word 99);
         Value.sexp (ByteString.inj "Tag") (Word32.word 99);
         Value.closure (Word32.word 0) (Word32.word 99); Value.builtin (ByteString.inj "read");
         Value.empty ()])] () in
      List.iter (fun (objectId, expected) ->
        let outputs = Stream.take @@ run q (SM.showValue program state
          (Value.string (Word32.word objectId)))
          (fun answer -> answer#reify ByteString.prj_exn) in
        assert (outputs = [expected]);
        Printf.printf "showValue String %d = %S: OK\n%!" objectId expected
      ) [(0, "\"\""); (7, "\"\000\"\\\255??????\""); (99, "<string#?>")]

    let test_showValue_arrays () =
      let program = Prog.make (Std.List.nil ()) (Word32.word 0) (Std.List.nil ()) in
      let state = lookupState ~objects:
        [(0, []); (1, [Value.int (Word32.word 7)]);
         (2, [Value.int (Word32.word 1); Value.empty (); Value.builtin (ByteString.inj "read")]);
         (3, [Value.string (Word32.word 4); Value.sexp (ByteString.inj "Node") (Word32.word 5);
              Value.array (Word32.word 1)]);
         (4, [Value.int (Word32.word 65)]); (5, [Value.int (Word32.word 2); Value.array (Word32.word 0)]);
         (6, [Value.sexp (ByteString.inj "") (Word32.word 0); Value.int (Word32.word 42)])] () in
      List.iter (fun (objectId, expected) ->
        let outputs = Stream.take @@ run q (SM.showValue program state
          (Value.array (Word32.word objectId)))
          (fun answer -> answer#reify ByteString.prj_exn) in
        assert (outputs = [expected]);
        Printf.printf "showValue Array %d = %S: OK\n%!" objectId expected
      ) [(0, "[]"); (1, "[7]"); (2, "[1, <empty>, <builtin read>]");
         (3, "[\"A\", Node (2, []), [7]]"); (6, "[, 42]"); (99, "<array#?>")]


    let test_showValue_sexps () =
      let program = Prog.make (Std.List.nil ()) (Word32.word 0) (Std.List.nil ()) in
      let state = lookupState ~objects:[(0, []); (1, [Value.int (Word32.word 7); Value.empty ()])] () in
      List.iter (fun (tag, objectId, expected) ->
        let outputs = Stream.take @@ run q (SM.showValue program state
          (Value.sexp (ByteString.inj tag) (Word32.word objectId)))
          (fun answer -> answer#reify ByteString.prj_exn) in
        assert (outputs = [expected]);
        Printf.printf "showValue Sexp %S %d = %S: OK\n%!" tag objectId expected
      ) [("Tag", 99, "<Tag#?>"); ("", 99, "<#?>"); ("Tag", 0, "Tag");
         ("", 0, ""); ("Tag", 1, "Tag (7, <empty>)"); ("", 1, " (7, <empty>)");
         ("A (B)\000\255", 0, "A (B)\000\255")]

    let test_showValue_closures () =
      let names = Std.list (fun (address, name) -> Std.pair (Word32.word address) (ByteString.inj name))
        [(7, "worker"); (8, ""); (9, "two words>\255")] in
      let program = Prog.make (Std.List.nil ()) (Word32.word 0) names in
      List.iter (fun (entryAddress, expected) ->
        let outputs = Stream.take @@ run q (SM.showValue program (lookupState ())
          (Value.closure (Word32.word entryAddress) (Word32.word 99)))
          (fun answer -> answer#reify ByteString.prj_exn) in
        assert (outputs = [expected]);
        Printf.printf "showValue Closure %d = %S: OK\n%!" entryAddress expected
      ) [(7, "<closure worker>"); (8, "<closure >"); (9, "<closure two words>\255>");
         (0, "<closure 0>"); (Word32.max_value, "<closure 4294967295>")]

    let test_showValue_builtinsAndEmpty () =
      let program = Prog.make (Std.List.nil ()) (Word32.word 0) (Std.List.nil ()) in
      List.iter (fun (value, expected) ->
        let outputs = Stream.take @@ run q (SM.showValue program (lookupState ()) value)
          (fun answer -> answer#reify ByteString.prj_exn) in
        assert (outputs = [expected]);
        Printf.printf "showValue builtin/empty = %S: OK\n%!" expected
      ) [(Value.builtin (ByteString.inj "read"), "<builtin read>");
         (Value.builtin (ByteString.inj ""), "<builtin >");
         (Value.builtin (ByteString.inj "a > (b)\000\255"), "<builtin a > (b)\000\255>");
         (Value.empty (), "<empty>")]

    let test_showValue_integersBackwards () =
      let program = Prog.make (Std.List.nil ()) (Word32.word 0) (Std.List.nil ()) in
      let state = lookupState () in
      let number_prj = Reifier.fmap Word32.to_int Word32.prj_exn in
      List.iter (fun (text, expected) ->
        let numbers = Stream.take @@ run q (fun number -> ocanren {
          SM.showValue program state (Value.Int number) !(ByteString.inj text)
        }) (fun answer -> answer#reify number_prj) in
        assert (numbers = [expected]);
        Printf.printf "showValue backwards from %S gives Int %d: OK\n%!" text expected
      ) [("0", 0); ("9", 9); ("10", 10); ("100", 100);
         ("2147483648", 0x8000_0000); ("4294967295", Word32.max_value)]

    let test_showValue_arraysBackwards () =
      let program = Prog.make (Std.List.nil ()) (Word32.word 0) (Std.List.nil ()) in
      let number_prj = Reifier.fmap Word32.to_int Word32.prj_exn in
      let numbers = Stream.take @@ run q (fun number ->
        let state = lookupState ~objects:[(7, [Value.int number; Value.empty ()])] () in
        SM.showValue program state (Value.array (Word32.word 7)) (ByteString.inj "[42, <empty>]")
      ) (fun answer -> answer#reify number_prj) in
      assert (numbers = [42]);
      let state = lookupState ~objects:
        [(7, [Value.int (Word32.word 42)]); (8, [Value.int (Word32.word 42)]); (9, [])] () in
      let objectIds = Stream.take @@ run q (fun objectId -> ocanren {
        SM.showValue program state (Value.Array objectId) !(ByteString.inj "[42]")
      }) (fun answer -> answer#reify number_prj) in
      assert (List.sort Stdlib.compare objectIds = [7; 8]);
      Printf.printf "showValue Array backwards restores its Int field and both matching object IDs: OK\n%!"

    let test_showValue_rejectedQueries () =
      let program = Prog.make (Std.List.nil ()) (Word32.word 0) (Std.List.nil ()) in
      let state = lookupState () in
      List.iter (fun text ->
        let numbers = Stream.take @@ run q (fun number -> ocanren {
          SM.showValue program state (Value.Int number) !(ByteString.inj text)
        }) (fun answer -> answer#reify Word32.reify) in
        assert (numbers = []);
        Printf.printf "showValue rejects Int text %S: OK\n%!" text
      ) [""; "00"; "01"; "+1"; "-1"; "1 "; "4294967296"; "10000000000"];
      let state = lookupState ~objects:[(0, []);
        (8, [Value.int (Word32.word 1); Value.int (Word32.word 2)]);
        (9, [Value.int (Word32.word 34)])] () in
      List.iter (fun (description, query) ->
        let outputs = Stream.take @@ run q query (fun answer -> answer#reify ByteString.prj_exn) in
        assert (outputs = []);
        Printf.printf "showValue rejects %s: OK\n%!" description
      ) [("missing Array rendered as []", (fun output ->
           SM.showValue program state (Value.array (Word32.word 99)) output &&& (output === ByteString.inj "[]")));
         ("Array separator without a space", (fun output ->
           SM.showValue program state (Value.array (Word32.word 8)) output &&& (output === ByteString.inj "[1,2]")));
         ("escaped String quotation mark", (fun output ->
           SM.showValue program state (Value.string (Word32.word 9)) output &&& (output === ByteString.inj "\"\\\"\"")))]

    let builtinProgram () =
      Prog.make (Std.List.nil ()) (Word32.word 0)
        (Std.list Fun.id [Std.pair (Word32.word 7) (ByteString.inj "worker")])

    let test_builtin_read () =
      List.iter (fun (description, inputs, arguments, expected) ->
        let state = ocanren {
          Config.Config (
            [Frame.Frame (!(Word32.word 12), Loc.Loc ([], [], Some !(Word32.word 3)), [Value.Empty])],
            [Value.Int !(Word32.word 8)], [(!(inj "g"), Value.Array !(Word32.word 3))],
            Loc.Loc ([(!(Word32.word 2), Value.Empty)], [], Some !(Word32.word 3)),
            !(Std.list Word32.word inputs), [!(Word32.word 9)],
            Store.Store [(!(Word32.word 3), [Value.Int !(Word32.word 65)])], !(Word32.word 4))
        } in
        let answers = Stream.take @@ run q
          (SM.builtin (builtinProgram ()) (ByteString.inj "read") (Std.list Fun.id arguments) state)
          (fun answer -> answer#reify (SM.prj_exn Config.prj_exn)) in
        assert (answers = [expected]);
        Printf.printf "builtin read %s: OK\n%!" description
      ) [("consumes the first input and preserves every unrelated state field", [42; 7], [],
          SM.Right (Config.Config (
            [Frame.Frame (12, Loc.Loc ([], [], Some 3), [Value.Empty])],
            [Value.Int 42; Value.Int 8], [("g", Value.Array 3)],
            Loc.Loc ([(2, Value.Empty)], [], Some 3), [7], [9],
            Store.Store [(3, [Value.Int 65])], 4)));
         ("accepts zero and ignores arguments", [0], [Value.empty (); Value.array (Word32.word 99)],
          SM.Right (Config.Config (
            [Frame.Frame (12, Loc.Loc ([], [], Some 3), [Value.Empty])],
            [Value.Int 0; Value.Int 8], [("g", Value.Array 3)],
            Loc.Loc ([(2, Value.Empty)], [], Some 3), [], [9],
            Store.Store [(3, [Value.Int 65])], 4)));
         ("reports exhausted input", [], [Value.int (Word32.word 7)],
          SM.Left "read: no input available")]

    let builtinState ?(stack = []) ?(inputs = []) ?(outputs = []) ?(objects = []) ?(nextId = 0) () =
      let bindings = Std.list (fun (objectId, fields) ->
        Std.pair (Word32.word objectId) (Std.list Fun.id fields)) objects in
      ocanren {
        Config.Config ([], !(Std.list Fun.id stack), [], Loc.Loc ([], [], None),
          !(Std.list Word32.word inputs), !(Std.list Word32.word outputs), Store.Store bindings,
          !(Word32.word nextId))
      }

    let test_builtin_write () =
      let program = builtinProgram () in
      List.iter (fun (number, previousOutput, expectedOutput) ->
        let state = builtinState ~stack:[Value.int (Word32.word 8)]
          ~inputs:[6] ~outputs:previousOutput ~objects:[(3, [Value.empty ()])] ~nextId:4 () in
        let answers = Stream.take @@ run q (fun result -> ocanren {
          SM.builtin program !(ByteString.inj "write")
            [Value.Int !(Word32.word number)] state result
        }) (fun answer -> answer#reify (SM.prj_exn Config.prj_exn)) in
        assert (answers = [SM.Right (Config.Config ([], [Value.Empty; Value.Int 8], [],
          Loc.Loc ([], [], None), [6], expectedOutput, Store.Store [(3, [Value.Empty])], 4))]);
        Printf.printf "builtin write appends unsigned word %d after the existing output: OK\n%!" number
      ) [(0, [], [0]); (42, [5; 7], [5; 7; 42]);
         (Word32.max_value, [9], [9; Word32.max_value])]

    let test_builtin_argumentErrors () =
      let wrongWriteTypes =
        [Value.string (Word32.word 3); Value.array (Word32.word 3);
         Value.sexp (ByteString.inj "Tag") (Word32.word 3);
         Value.closure (Word32.word 7) (Word32.word 3);
         Value.builtin (ByteString.inj "read"); Value.empty ()] in
      let wrongLengthTypes =
        [Value.int (Word32.word 7); Value.closure (Word32.word 7) (Word32.word 3);
         Value.builtin (ByteString.inj "read"); Value.empty ()] in
      let cases =
        [("write", [], "write: bad args");
         ("write", [Value.int (Word32.word 1); Value.int (Word32.word 2)], "write: bad args");
         ("length", [], "length: bad args");
         ("length", [Value.array (Word32.word 3); Value.array (Word32.word 3)], "length: bad args");
         ("string", [], "string: bad args");
         ("string", [Value.empty (); Value.empty ()], "string: bad args")] @
        List.map (fun value -> ("write", [value], "write: bad args")) wrongWriteTypes @
        List.map (fun value -> ("length", [value], "length: bad args")) wrongLengthTypes in
      List.iter (fun (name, arguments, message) ->
        let answers = Stream.take @@ run q
          (SM.builtin (builtinProgram ()) (ByteString.inj name) (Std.list Fun.id arguments)
            (builtinState ~objects:[(3, [Value.empty ()])] ()))
          (fun answer -> answer#reify (SM.prj_exn Config.prj_exn)) in
        assert (answers = [SM.Left message]);
        Printf.printf "builtin %s rejects invalid arguments with %S: OK\n%!" name message
      ) cases

    let test_builtin_length () =
      let state = builtinState ~stack:[Value.empty ()] ~inputs:[6] ~outputs:[9]
        ~objects:[(0, []); (7, [Value.int (Word32.word 65); Value.empty (); Value.array (Word32.word 99)]);
                  (Word32.max_value, [Value.int (Word32.word 0)])] ~nextId:8 () in
      List.iter (fun (kind, container) ->
        List.iter (fun (objectId, expected) ->
          let answers = Stream.take @@ run q
            (SM.builtin (builtinProgram ()) (ByteString.inj "length")
              (Std.list Fun.id [container (Word32.word objectId)]) state)
            (fun answer -> answer#reify (SM.prj_exn Config.prj_exn)) in
          let expectedResult = match expected with
            | Some length -> SM.Right (Config.Config ([], [Value.Int length; Value.Empty], [],
                Loc.Loc ([], [], None), [6], [9], Store.Store
                  [(0, []); (7, [Value.Int 65; Value.Empty; Value.Array 99]);
                   (Word32.max_value, [Value.Int 0])], 8))
            | None -> SM.Left "store: missing id" in
          assert (answers = [expectedResult]);
          Printf.printf "builtin length %s object %d counts its fields or reports a missing ID: OK\n%!"
            kind objectId
        ) [(0, Some 0); (7, Some 3); (Word32.max_value, Some 1); (99, None)]
      ) [("String", Value.string); ("Array", Value.array);
         ("Sexp", Value.sexp (ByteString.inj "long tag"))]

    let test_builtin_unknownName () =
      List.iter (fun name ->
        let answers = Stream.take @@ run q
          (SM.builtin (builtinProgram ()) (ByteString.inj name)
            (Std.list Fun.id [Value.int (Word32.word 42)]) (builtinState ~inputs:[7] ()))
          (fun answer -> answer#reify (SM.prj_exn Config.prj_exn)) in
        assert (answers = [SM.Left "unknown builtin"]);
        Printf.printf "builtin rejects unknown or non-exact name %S: OK\n%!" name
      ) [""; "Read"; ".Array"; "read\000"; "write "; "lengths"; "custom"]

    let test_builtin_array () =
      List.iter (fun (description, nextId, arguments, expectedStack, expectedObjects, expectedNextId) ->
        let state = builtinState ~stack:[Value.empty ()] ~inputs:[2] ~outputs:[9]
          ~objects:[(3, [Value.int (Word32.word 65)])] ~nextId () in
        let answers = Stream.take @@ run q
          (SM.builtin (builtinProgram ()) (ByteString.inj ".array") (Std.list Fun.id arguments) state)
          (fun answer -> answer#reify (SM.prj_exn Config.prj_exn)) in
        assert (answers = [SM.Right (Config.Config ([], expectedStack, [], Loc.Loc ([], [], None),
          [2], [9], Store.Store expectedObjects, expectedNextId))]);
        Printf.printf "builtin .array %s: OK\n%!" description
      ) [("allocates an empty array at ID zero", 0, [], [Value.Array 0; Value.Empty],
          [(3, [Value.Int 65]); (0, [])], 1);
         ("keeps argument order and every value constructor", 4,
          [Value.int (Word32.word Word32.max_value); Value.string (Word32.word 3);
           Value.array (Word32.word 3); Value.sexp (ByteString.inj "Node") (Word32.word 3);
           Value.closure (Word32.word 7) (Word32.word 3); Value.builtin (ByteString.inj "write");
           Value.empty (); Value.array (Word32.word 3)],
          [Value.Array 4; Value.Empty],
          [(3, [Value.Int 65]); (4, [Value.Int Word32.max_value; Value.String 3; Value.Array 3;
             Value.Sexp ("Node", 3); Value.Closure (7, 3); Value.Builtin "write"; Value.Empty; Value.Array 3])], 5);
         ("replaces a colliding object using the supplied arguments", 3,
          [Value.array (Word32.word 3); Value.int (Word32.word 7)], [Value.Array 3; Value.Empty],
          [(3, [Value.Array 3; Value.Int 7])], 4);
         ("returns the maximum ID before the allocation counter wraps", Word32.max_value,
          [Value.empty ()], [Value.Array Word32.max_value; Value.Empty],
          [(3, [Value.Int 65]); (Word32.max_value, [Value.Empty])], 0)]

    let test_builtin_string () =
      let state = builtinState ~stack:[Value.empty ()] ~inputs:[2] ~outputs:[9]
        ~objects:[(3, [Value.int (Word32.word 65)]);
                  (5, [Value.int (Word32.word 0); Value.int (Word32.word 255)]);
                  (6, []); (8, [Value.string (Word32.word 3); Value.int (Word32.word 42)])]
        ~nextId:10 () in
      List.iter (fun (description, value, text) ->
        let answers = Stream.take @@ run q
          (SM.builtin (builtinProgram ()) (ByteString.inj "string") (Std.list Fun.id [value]) state)
          (fun answer -> answer#reify (SM.prj_exn Config.prj_exn)) in
        let fields = List.map (fun character -> Value.Int (Char.code character))
          (List.of_seq (String.to_seq text)) in
        assert (answers = [SM.Right (Config.Config ([], [Value.String 10; Value.Empty], [],
          Loc.Loc ([], [], None), [2], [9], Store.Store
            [(3, [Value.Int 65]); (5, [Value.Int 0; Value.Int 255]); (6, []);
             (8, [Value.String 3; Value.Int 42]); (10, fields)], 11))]);
        Printf.printf "builtin string allocates %s as %S: OK\n%!" description text
      ) [("zero", Value.int (Word32.word 0), "0");
         ("the maximum unsigned word", Value.int (Word32.word Word32.max_value), "4294967295");
         ("a String with quotes", Value.string (Word32.word 3), "\"A\"");
         ("raw zero and maximum byte", Value.string (Word32.word 5), "\"\000\255\"");
         ("a missing String placeholder", Value.string (Word32.word 99), "<string#?>");
         ("a nested Array", Value.array (Word32.word 8), "[\"A\", 42]");
         ("a Sexp with fields", Value.sexp (ByteString.inj "Node") (Word32.word 3), "Node (65)");
         ("an empty-tag Sexp as an empty string", Value.sexp (ByteString.inj "") (Word32.word 6), "");
         ("a named Closure", Value.closure (Word32.word 7) (Word32.word 99), "<closure worker>");
         ("an unnamed Closure", Value.closure (Word32.word 9) (Word32.word 99), "<closure 9>");
         ("a Builtin", Value.builtin (ByteString.inj "read"), "<builtin read>");
         ("Empty", Value.empty (), "<empty>")]

    let test_builtin_stringAllocation () =
      List.iter (fun (description, nextId, expectedObjects, expectedNextId) ->
        let state = builtinState ~stack:[Value.empty ()]
          ~objects:[(3, [Value.int (Word32.word 65)])] ~nextId () in
        let answers = Stream.take @@ run q
          (SM.builtin (builtinProgram ()) (ByteString.inj "string")
            (Std.list Fun.id [Value.string (Word32.word 3)]) state)
          (fun answer -> answer#reify (SM.prj_exn Config.prj_exn)) in
        assert (answers = [SM.Right (Config.Config ([], [Value.String nextId; Value.Empty], [],
          Loc.Loc ([], [], None), [], [], Store.Store expectedObjects, expectedNextId))]);
        Printf.printf "builtin string %s: OK\n%!" description
      ) [("renders the original object before replacing its colliding ID", 3,
          [(3, [Value.Int 34; Value.Int 65; Value.Int 34])], 4);
         ("allocates the maximum ID and wraps the counter", Word32.max_value,
          [(3, [Value.Int 65]); (Word32.max_value, [Value.Int 34; Value.Int 65; Value.Int 34])], 0)]

    let test_builtin_preservesState () =
      let state = ocanren {
        Config.Config (
          [Frame.Frame (!(Word32.word 12), Loc.Loc ([], [], Some !(Word32.word 3)), [Value.Empty])],
          [Value.Int !(Word32.word 8)], [(!(inj "g"), Value.Array !(Word32.word 3))],
          Loc.Loc ([(!(Word32.word 2), Value.Empty)],
            [(!(Word32.word 5), Value.String !(Word32.word 3))], Some !(Word32.word 3)),
          [!(Word32.word 6)], [!(Word32.word 9)],
          Store.Store [(!(Word32.word 3), [Value.Int !(Word32.word 65)])], !(Word32.word 4))
      } in
      List.iter (fun (name, arguments, expectedStack, expectedOutput, expectedStore, expectedNextId) ->
        let answers = Stream.take @@ run q
          (SM.builtin (builtinProgram ()) (ByteString.inj name) (Std.list Fun.id arguments) state)
          (fun answer -> answer#reify (SM.prj_exn Config.prj_exn)) in
        assert (answers = [SM.Right (Config.Config (
          [Frame.Frame (12, Loc.Loc ([], [], Some 3), [Value.Empty])], expectedStack,
          [("g", Value.Array 3)], Loc.Loc ([(2, Value.Empty)], [(5, Value.String 3)], Some 3),
          [6], expectedOutput, Store.Store expectedStore, expectedNextId))]);
        Printf.printf "builtin %s preserves the complete caller state outside its specified effects: OK\n%!" name
      ) [("write", [Value.int (Word32.word 42)], [Value.Empty; Value.Int 8], [9; 42],
          [(3, [Value.Int 65])], 4);
         ("length", [Value.string (Word32.word 3)], [Value.Int 1; Value.Int 8], [9],
          [(3, [Value.Int 65])], 4);
         ("string", [Value.string (Word32.word 3)], [Value.String 4; Value.Int 8], [9],
          [(3, [Value.Int 65]); (4, [Value.Int 34; Value.Int 65; Value.Int 34])], 5);
         (".array", [Value.array (Word32.word 3)], [Value.Array 4; Value.Int 8], [9],
          [(3, [Value.Int 65]); (4, [Value.Array 3])], 5)]

    let test_builtin_readWriteBackwards () =
      let program = builtinProgram () in
      let inputs = Stream.take @@ run q (fun inputs -> ocanren {
        SM.builtin program !(ByteString.inj "read") []
          (Config.Config ([], [Value.Empty], [], Loc.Loc ([], [], None), inputs, [],
            Store.Store [], !(Word32.word 0)))
          (SM.Right (Config.Config ([], [Value.Int !(Word32.word Word32.max_value); Value.Empty], [],
            Loc.Loc ([], [], None), [!(Word32.word 7)], [], Store.Store [], !(Word32.word 0))))
      }) (fun answer -> answer#reify (Std.List.prj_exn (Reifier.fmap Word32.to_int Word32.prj_exn))) in
      assert (inputs = [[Word32.max_value; 7]]);
      let arguments = Stream.take @@ run q (fun arguments -> ocanren {
        SM.builtin program !(ByteString.inj "write") arguments
          (Config.Config ([], [Value.Int !(Word32.word 8)], [], Loc.Loc ([], [], None), [],
            [!(Word32.word 7)], Store.Store [], !(Word32.word 0)))
          (SM.Right (Config.Config ([], [Value.Empty; Value.Int !(Word32.word 8)], [],
            Loc.Loc ([], [], None), [], [!(Word32.word 7); !(Word32.word Word32.max_value)],
            Store.Store [], !(Word32.word 0))))
      }) (fun answer -> answer#reify (Std.List.prj_exn Value.prj_exn)) in
      assert (arguments = [[Value.Int Word32.max_value]]);
      Printf.printf "builtin read/write backwards restore the consumed input and written argument: OK\n%!"

    let test_builtin_nameBackwards () =
      let program = builtinProgram () in
      List.iter (fun (expectedName, arguments, state, expectedState) ->
        let names = Stream.take @@ run q (fun name -> ocanren {
          SM.builtin program name arguments state (SM.Right expectedState)
        }) (fun answer -> answer#reify ByteString.prj_exn) in
        assert (names = [expectedName]);
        Printf.printf "builtin recovers the exact logical name %S from its state transition: OK\n%!" expectedName
      ) [("read", Std.List.nil (), builtinState ~inputs:[42] (),
          builtinState ~stack:[Value.int (Word32.word 42)] ());
         ("write", Std.list Fun.id [Value.int (Word32.word 42)], builtinState (),
          builtinState ~stack:[Value.empty ()] ~outputs:[42] ());
         ("length", Std.list Fun.id [Value.array (Word32.word 3)],
          builtinState ~objects:[(3, [Value.empty ()])] (),
          builtinState ~stack:[Value.int (Word32.word 1)] ~objects:[(3, [Value.empty ()])] ());
         ("string", Std.list Fun.id [Value.int (Word32.word 7)], builtinState (),
          builtinState ~stack:[Value.string (Word32.word 0)]
            ~objects:[(0, [Value.int (Word32.word 55)])] ~nextId:1 ());
         (".array", Std.list Fun.id [Value.int (Word32.word 7)], builtinState (),
          builtinState ~stack:[Value.array (Word32.word 0)]
            ~objects:[(0, [Value.int (Word32.word 7)])] ~nextId:1 ())]

    let executeNumberPrj = Reifier.fmap Word32.to_int Word32.prj_exn

    let executeValue = function
      | Value.Int number -> Value.int (Word32.word number)
      | Value.String objectId -> Value.string (Word32.word objectId)
      | Value.Array objectId -> Value.array (Word32.word objectId)
      | Value.Sexp (tag, objectId) -> Value.sexp (ByteString.inj tag) (Word32.word objectId)
      | Value.Closure (entry, objectId) -> Value.closure (Word32.word entry) (Word32.word objectId)
      | Value.Builtin name -> Value.builtin (ByteString.inj name)
      | Value.Empty -> Value.empty ()

    let executeLoc (Loc.Loc (arguments, locals, closure)) =
      let bindings = Std.list (fun (index, value) -> Std.pair (Word32.word index) (executeValue value)) in
      Loc.loc (bindings arguments) (bindings locals) (match closure with
        | None -> Std.Option.none () | Some objectId -> Std.Option.some (Word32.word objectId))

    let executeState (Config.Config (frames, stack, globals, environment, inputs, outputs, Store.Store objects, nextId)) =
      Config.config
        (Std.list (fun (Frame.Frame (address, caller, savedStack)) ->
          Frame.frame (Word32.word address) (executeLoc caller) (Std.list executeValue savedStack)) frames)
        (Std.list executeValue stack)
        (Std.list (fun (name, value) -> Std.pair (inj name) (executeValue value)) globals)
        (executeLoc environment) (Std.list Word32.word inputs) (Std.list Word32.word outputs)
        (Store.store (Std.list (fun (objectId, fields) ->
          Std.pair (Word32.word objectId) (Std.list executeValue fields)) objects)) (Word32.word nextId)

    let executeFixture ?(frames = []) ?(stack = []) ?(globals = [("g", Value.Int 31)])
        ?(environment = Loc.Loc ([(0, Value.Int 21)], [(0, Value.Int 11)], None))
        ?(inputs = [71; 72]) ?(outputs = [61]) ?(objects = [(4, [Value.Int 65; Value.Int 66])])
        ?(nextId = 5) () =
      Config.Config (frames, stack, globals, environment, inputs, outputs, Store.Store objects, nextId)

    let executeProgram () =
      Prog.make (Std.list Fun.id [Insn.lINE (Word32.word 1); Insn.rET (); Insn.eND ()])
        (Word32.word 0) (Std.List.nil ())

    let checkExecute description state instruction expected =
      let answers = Stream.take @@ run q
        (SM.executeInstruction (executeProgram ()) (executeState state) instruction (Word32.word 17))
        (fun answer -> answer#reify (SM.prj_exn (Std.Pair.prj_exn Config.prj_exn executeNumberPrj))) in
      if answers <> [expected] then
        Printf.printf "executeInstruction %s: unexpected %s\n%!" description
          (show(list) (show(SM.t) (show(Std.Pair.t) (show(Config.t)) (show(int)))) answers);
      assert (answers = [expected]);
      Printf.printf "executeInstruction %s: OK\n%!" description

    let test_executeInstruction_stackAndArithmetic () =
      let check description instruction before after =
        checkExecute description (executeFixture ~stack:before ()) instruction
          (SM.Right (executeFixture ~stack:after (), 17)) in
      List.iter (fun (description, instruction, before, after) -> check description instruction before after)
        [("LINE preserves state", Insn.lINE (Word32.word 99), [Value.Empty], [Value.Empty]);
         ("CONST pushes maximum word", Insn.cONST (Word32.word Word32.max_value), [Value.Empty], [Value.Int Word32.max_value; Value.Empty]);
         ("DROP removes top", Insn.dROP (), [Value.Int 3; Value.Empty], [Value.Empty]);
         ("DUP shares reference", Insn.dUP (), [Value.Array 4; Value.Empty], [Value.Array 4; Value.Array 4; Value.Empty]);
         ("SWAP exchanges only two top values", Insn.sWAP (), [Value.Int 1; Value.Int 2; Value.Empty], [Value.Int 2; Value.Int 1; Value.Empty]);
         ("BINOP subtraction preserves operand order", Insn.bINOP (inj "-"), [Value.Int 3; Value.Int 7; Value.Empty], [Value.Int 4; Value.Empty]);
         ("BINOP equality uses reference identity", Insn.bINOP (inj "=="), [Value.Sexp ("A", 4); Value.Sexp ("B", 4)], [Value.Int 1]);
         ("BINOP equality distinguishes value kinds", Insn.bINOP (inj "=="), [Value.String 4; Value.Array 4], [Value.Int 0])];
      List.iter (fun (instruction, stack, error) ->
        checkExecute error (executeFixture ~stack ()) instruction (SM.Left error))
        [(Insn.sWAP (), [Value.Empty], "SWAP: stack underflow");
         (Insn.bINOP (inj "=="), [Value.Empty], "BINOP ==: stack underflow");
         (Insn.bINOP (inj "+"), [Value.Empty], "BINOP: stack underflow");
         (Insn.bINOP (inj "+"), [Value.Int 2; Value.Empty], "expected int");
         (Insn.bINOP (inj "/"), [Value.Int 0; Value.Int 2], "division by zero");
         (Insn.fAIL (Word32.word 1) (Word32.word 2), [], "FAIL: empty stack");
         (Insn.fAIL (Word32.word 1) (Word32.word 2), [Value.Array 999], "matching value failed")]

    let test_executeInstruction_patterns () =
      List.iter (fun (name, pattern, value, expected) ->
        checkExecute ("PATT " ^ name) (executeFixture ~stack:[value; Value.Empty] ())
          (Insn.pATT pattern) (SM.Right (executeFixture ~stack:[Value.Int expected; Value.Empty] (), 17)))
        [("String accepts string", Patt.string (), Value.String 4, 1);
         ("String rejects integer", Patt.string (), Value.Int 4, 0);
         ("Array accepts array", Patt.array (), Value.Array 4, 1);
         ("Array rejects string", Patt.array (), Value.String 4, 0);
         ("Sexp accepts tagged value", Patt.sexp (), Value.Sexp ("A", 4), 1);
         ("Sexp rejects array", Patt.sexp (), Value.Array 4, 0);
         ("Closure accepts closure", Patt.closure (), Value.Closure (1, 4), 1);
         ("Closure rejects builtin", Patt.closure (), Value.Builtin "read", 0);
         ("Boxed accepts empty value", Patt.boxed (), Value.Empty, 1);
         ("Boxed rejects integer", Patt.boxed (), Value.Int 4, 0);
         ("UnBoxed accepts integer", Patt.unBoxed (), Value.Int 4, 1);
         ("UnBoxed rejects empty value", Patt.unBoxed (), Value.Empty, 0)];
      List.iter (fun (description, leftFields, rightFields, expected) ->
        let objects = [(4, leftFields); (5, rightFields)] in
        checkExecute description (executeFixture ~objects ~stack:[Value.String 4; Value.String 5; Value.Empty] ())
          (Insn.pATT (Patt.strCmp ()))
          (SM.Right (executeFixture ~objects ~stack:[Value.Int expected; Value.Empty] (), 17)))
        [("StrCmp equal contents different references", [Value.Int 65], [Value.Int 65], 1);
         ("StrCmp compares tags structurally", [Value.Sexp ("A", 9)], [Value.Sexp ("B", 9)], 0)];
      checkExecute "StrCmp nonstrings skip invalid heap" (executeFixture ~stack:[Value.Int 0; Value.String 999] ())
        (Insn.pATT (Patt.strCmp ())) (SM.Right (executeFixture ~stack:[Value.Int 0] (), 17));
      List.iter (fun (description, instruction, value, expected) ->
        checkExecute description (executeFixture ~stack:[value; Value.Empty] ()) instruction
          (SM.Right (executeFixture ~stack:[Value.Int expected; Value.Empty] (), 17)))
        [("TAG matching tag/count", Insn.tAG (ByteString.inj "A") (Word32.word 2), Value.Sexp ("A", 4), 1);
         ("TAG wrong count", Insn.tAG (ByteString.inj "A") (Word32.word 1), Value.Sexp ("A", 4), 0);
         ("TAG wrong tag skips missing object", Insn.tAG (ByteString.inj "B") (Word32.word 2), Value.Sexp ("A", 999), 0);
         ("ARRAY matching count", Insn.aRRAY (Word32.word 2), Value.Array 4, 1);
         ("ARRAY wrong count", Insn.aRRAY (Word32.word 1), Value.Array 4, 0);
         ("ARRAY wrong kind skips missing object", Insn.aRRAY (Word32.word 2), Value.String 999, 0)]

    let test_executeInstruction_memory () =
      List.iter (fun text ->
        let fields = List.map (fun character -> Value.Int (Char.code character)) (List.of_seq (String.to_seq text)) in
        checkExecute "STRING allocates byte contents" (executeFixture ~stack:[Value.Empty] ())
          (Insn.sTRING (ByteString.inj text))
          (SM.Right (executeFixture ~stack:[Value.String 5; Value.Empty]
            ~objects:[(4, [Value.Int 65; Value.Int 66]); (5, fields)] ~nextId:6 (), 17)))
        [""; "A\000\255"];
      List.iter (fun (count, before, fields, remaining) ->
        checkExecute "SEXP reverses popped fields" (executeFixture ~stack:before ())
          (Insn.sEXP (ByteString.inj "Tag") (Word32.word count))
          (SM.Right (executeFixture ~stack:(Value.Sexp ("Tag", 5) :: remaining)
            ~objects:[(4, [Value.Int 65; Value.Int 66]); (5, fields)] ~nextId:6 (), 17)))
        [(0, [Value.Empty], [], [Value.Empty]); (2, [Value.Int 2; Value.Int 1; Value.Empty], [Value.Int 1; Value.Int 2], [Value.Empty])];
      List.iter (fun container ->
        checkExecute "ELEM reads index before container" (executeFixture ~stack:[Value.Int 1; container; Value.Empty] ())
          (Insn.eLEM ()) (SM.Right (executeFixture ~stack:[Value.Int 66; Value.Empty] (), 17));
        checkExecute "STA replaces field and retains assigned value" (executeFixture ~stack:[Value.Int 99; Value.Int 1; container; Value.Empty] ())
          (Insn.sTA ()) (SM.Right (executeFixture ~stack:[Value.Int 99; Value.Empty]
            ~objects:[(4, [Value.Int 65; Value.Int 99])] (), 17)))
        [Value.Array 4; Value.String 4; Value.Sexp ("A", 4)];
      List.iter (fun (instruction, stack, error) -> checkExecute error (executeFixture ~stack ()) instruction (SM.Left error))
        [(Insn.eLEM (), [Value.Empty; Value.Int 0], "expected int");
         (Insn.sTA (), [Value.Empty; Value.Int 0], "STA: stack underflow");
         (Insn.sTA (), [Value.Empty; Value.Empty], "STA: bad stack shape");
         (Insn.sTA (), [Value.Empty; Value.Int 0; Value.String 99], "expected int")];
      checkExecute "LD pushes designated value" (executeFixture ~stack:[Value.Empty] ())
        (Insn.lD (Designation.global (inj "g")))
        (SM.Right (executeFixture ~stack:[Value.Int 31; Value.Empty] (), 17));
      let active = Loc.Loc ([], [], Some 4) in
      checkExecute "ST keeps complete operand stack" (executeFixture ~stack:[Value.Int 9; Value.Empty] ())
        (Insn.sT (Designation.global (inj "g")))
        (SM.Right (executeFixture ~stack:[Value.Int 9; Value.Empty] ~globals:[("g", Value.Int 9)] (), 17));
      checkExecute "ST capture changes shared store" (executeFixture ~environment:active ~stack:[Value.Int 9] ())
        (Insn.sT (Designation.access (Word32.word 1)))
        (SM.Right (executeFixture ~environment:active ~stack:[Value.Int 9] ~objects:[(4, [Value.Int 65; Value.Int 9])] (), 17));
      checkExecute "ST underflow precedes designation error" (executeFixture ())
        (Insn.sT (Designation.access (Word32.word 0))) (SM.Left "ST: stack underflow");
      checkExecute "CLOSURE stores captures in designation order" (executeFixture ~stack:[Value.Empty] ())
        (Insn.cLOSURE (Word32.word 99) (Std.list Fun.id [Designation.local (Word32.word 0); Designation.arg (Word32.word 0)]))
        (SM.Right (executeFixture ~stack:[Value.Closure (99, 5); Value.Empty]
          ~objects:[(4, [Value.Int 65; Value.Int 66]); (5, [Value.Int 11; Value.Int 21])] ~nextId:6 (), 17))

    let test_executeInstruction_control () =
      checkExecute "JMP uses target address" (executeFixture ()) (Insn.jMP (Word32.word 2))
        (SM.Right (executeFixture (), 2));
      List.iter (fun (condition, number, target, expectedAddress) ->
        checkExecute "CJMP pops condition and chooses address" (executeFixture ~stack:[Value.Int number; Value.Empty] ())
          (Insn.cJMP (inj condition) (Word32.word target))
          (SM.Right (executeFixture ~stack:[Value.Empty] (), expectedAddress)))
        [("z", 0, 2, 2); ("z", 1, 99, 17); ("nz", 1, 2, 2); ("nz", 0, 99, 17);
         ("unknown", 0, 99, 17); ("nz", Word32.max_value, 1, 1)];
      List.iter (fun (stack, error) -> checkExecute error (executeFixture ~stack ())
        (Insn.cJMP (inj "z") (Word32.word 99)) (SM.Left error))
        [([], "CJMP: stack underflow"); ([Value.Empty], "expected int"); ([Value.Int 0], "Invalid instruction address")];
      List.iter (fun count ->
        let environment = Loc.Loc ([(0, Value.Int 21)], List.init count (fun index -> (index, Value.Empty)), None) in
        checkExecute "BEGIN replaces locals and ignores argument count" (executeFixture ~stack:[Value.Empty] ())
          (Insn.bEGIN (Word32.word 999) (Word32.word count))
          (SM.Right (executeFixture ~stack:[Value.Empty] ~environment (), 17))) [0; 3];
      let caller = Loc.Loc ([], [(2, Value.Int 32)], Some 4) in
      let frames = [Frame.Frame (2, caller, [Value.Int 999])] in
      List.iter (fun instruction ->
        checkExecute "return restores caller but preserves current operand stack"
          (executeFixture ~frames ~stack:[Value.Int 7; Value.Empty] ()) instruction
          (SM.Right (executeFixture ~environment:caller ~stack:[Value.Int 7; Value.Empty] (), 2));
        checkExecute "return from main uses program length" (executeFixture ~stack:[Value.Int 7] ()) instruction
          (SM.Right (executeFixture ~stack:[Value.Int 7] (), 3))) [Insn.rET (); Insn.eND ()]

    let test_executeInstruction_calls () =
      let caller = Loc.Loc ([(0, Value.Int 21)], [(0, Value.Int 11)], None) in
      let outer = Frame.Frame (2, Loc.Loc ([], [], None), [Value.Int 999]) in
      List.iter (fun tail ->
        let frames = [outer] in
        let expectedFrames = if tail then frames else Frame.Frame (17, caller, [Value.Empty]) :: frames in
        let environment = Loc.Loc ([(0, Value.Int 1); (1, Value.Int 2)], [], None) in
        let instruction = if tail then Insn.cALL_TAIL (Word32.word 1) (Word32.word 2)
          else Insn.cALL (Word32.word 1) (Word32.word 2) in
        checkExecute "CALL orders arguments and saves only remaining stack"
          (executeFixture ~frames ~stack:[Value.Int 2; Value.Int 1; Value.Empty] ()) instruction
          (SM.Right (executeFixture ~frames:expectedFrames ~stack:[Value.Empty] ~environment (), 1));
        let closureInstruction = if tail then Insn.cALLC_TAIL (Word32.word 2) else Insn.cALLC (Word32.word 2) in
        checkExecute "CALLC finds closure below arguments and preserves caller tail"
          (executeFixture ~frames ~stack:[Value.Int 2; Value.Int 1; Value.Closure (1, 4); Value.Empty] ()) closureInstruction
          (SM.Right (executeFixture ~frames:expectedFrames ~stack:[Value.Empty]
            ~environment:(Loc.Loc ([(0, Value.Int 1); (1, Value.Int 2)], [], Some 4)) (), 1));
        List.iter (fun (stack, error) -> checkExecute error (executeFixture ~stack ()) closureInstruction (SM.Left error))
          [([Value.Int 1; Value.Closure (1, 4)], "stack underflow");
           ([Value.Int 2; Value.Int 1; Value.Empty], if tail then "CALLC_TAIL: not callable" else "CALLC: not callable");
           ([Value.Int 2; Value.Int 1; Value.Closure (99, 999)], "store: missing id");
           ([Value.Int 2; Value.Int 1; Value.Closure (99, 4)], "Invalid instruction address")];
        let maximumCount = if tail then Insn.cALLC_TAIL (Word32.word Word32.max_value) else Insn.cALLC (Word32.word Word32.max_value) in
        checkExecute "CALLC maximum count cannot wrap" (executeFixture ()) maximumCount (SM.Left "stack underflow");
        let direct = if tail then Insn.cALL_TAIL (Word32.word 99) (Word32.word 1) else Insn.cALL (Word32.word 99) (Word32.word 1) in
        checkExecute "CALL underflow before target validation" (executeFixture ()) direct (SM.Left "stack underflow");
        checkExecute "CALL invalid target after valid split" (executeFixture ~stack:[Value.Empty] ()) direct (SM.Left "Invalid instruction address")) [false; true];
      List.iter (fun indirect ->
        let instruction = if indirect then Insn.cALLC (Word32.word 1) else Insn.bUILTIN (ByteString.inj "write") (Word32.word 1) in
        let stack = if indirect then [Value.Int 42; Value.Builtin "write"; Value.Empty] else [Value.Int 42; Value.Empty] in
        checkExecute "builtin call keeps caller environment and next address" (executeFixture ~stack ()) instruction
          (SM.Right (executeFixture ~stack:[Value.Empty; Value.Empty] ~outputs:[61; 42] (), 17));
        let instruction = if indirect then Insn.cALLC_TAIL (Word32.word 1) else Insn.bUILTIN_TAIL (ByteString.inj "write") (Word32.word 1) in
        checkExecute "tail builtin restores caller before dispatch and preserves actual stack"
          (executeFixture ~frames:[outer] ~stack ()) instruction
          (SM.Right (executeFixture ~environment:(Loc.Loc ([], [], None))
            ~stack:[Value.Empty; Value.Empty] ~outputs:[61; 42] (), 2));
        checkExecute "tail builtin from main halts at instruction count" (executeFixture ~stack ()) instruction
          (SM.Right (executeFixture ~stack:[Value.Empty; Value.Empty] ~outputs:[61; 42] (), 3))) [false; true];
      checkExecute "BUILTIN split underflow before dispatch" (executeFixture ())
        (Insn.bUILTIN (ByteString.inj "unknown") (Word32.word 1)) (SM.Left "stack underflow")

    let test_executeInstruction_emptyCalls () =
      let caller = Loc.Loc ([(0, Value.Int 21)], [(0, Value.Int 11)], None) in
      List.iter (fun tail ->
        let frames = if tail then [] else [Frame.Frame (17, caller, [Value.Empty])] in
        let instruction = if tail then Insn.cALLC_TAIL (Word32.word 0) else Insn.cALLC (Word32.word 0) in
        checkExecute "CALLC zero arguments retains empty closure identity"
          (executeFixture ~objects:[(4, [])] ~stack:[Value.Closure (1, 4); Value.Empty] ()) instruction
          (SM.Right (executeFixture ~objects:[(4, [])] ~frames ~stack:[Value.Empty]
            ~environment:(Loc.Loc ([], [], Some 4)) (), 1))) [false; true];
      checkExecute "BEGIN preserves active closure and arguments"
        (executeFixture ~environment:(Loc.Loc ([(0, Value.Int 21)], [(0, Value.Int 11)], Some 4)) ())
        (Insn.bEGIN (Word32.word 0) (Word32.word 1))
        (SM.Right (executeFixture ~environment:(Loc.Loc ([(0, Value.Int 21)], [(0, Value.Empty)], Some 4)) (), 17))

    let test_executeInstruction_callsBackwards () =
      let result stack address = inj (SM.Right (Std.pair (executeState (executeFixture ~stack ())) (Word32.word address))) in
      let program = executeProgram () in
      let initial = executeState (executeFixture ~stack:[Value.Int 7; Value.Empty] ()) in
      let expected = executeState (executeFixture ~stack:[Value.Empty]
        ~frames:[Frame.Frame (17, Loc.Loc ([(0, Value.Int 21)], [(0, Value.Int 11)], None), [Value.Empty])]
        ~environment:(Loc.Loc ([(0, Value.Int 7)], [], None)) ()) in
      let parameters = Stream.take @@ run q (fun pair -> ocanren {
        fresh target, count in pair == (target, count) &
          SM.executeInstruction program initial (Insn.CALL (target, count)) !(Word32.word 17)
            (SM.Right (Std.pair expected !(Word32.word 1)))
      }) (fun answer -> answer#reify (Std.Pair.prj_exn executeNumberPrj executeNumberPrj)) in
      assert (parameters = [(1, 1)]);
      let conditions = Stream.take @@ run q (fun condition ->
        SM.executeInstruction (executeProgram ()) (executeState (executeFixture ~stack:[Value.Int 0] ()))
          (Insn.cJMP condition (Word32.word 2)) (Word32.word 17) (result [] 2))
        (fun answer -> answer#reify Std.String.prj_exn) in
      assert (conditions = ["z"]);
      Printf.printf "executeInstruction reconstructs CALL parameters and CJMP condition: OK\n%!"

    let test_executeInstruction_instructionBackwards () =
      let program = executeProgram () in
      let state = executeState (executeFixture ()) in
      let expected = inj (SM.Right (Std.pair
        (executeState (executeFixture ~stack:[Value.Int 42] ())) (Word32.word 17))) in
      let instructions = Stream.take @@ run q (fun instruction -> ocanren {
        fresh number in
          {instruction == Insn.CONST number | instruction == Insn.DROP} &
          SM.executeInstruction program state instruction !(Word32.word 17) expected
      }) (fun answer -> answer#reify Insn.prj_exn) in
      assert (instructions = [Insn.CONST 42]);
      Printf.printf "executeInstruction infers CONST 42 within finite CONST/DROP domain: OK\n%!"

    let stepProgram instructions =
      Prog.make (Std.list Fun.id instructions) (Word32.word 0) (Std.List.nil ())

    let checkStep description instructions state address expected =
      let answers = Stream.take @@ run q
        (SM.step (stepProgram instructions) (executeState state) (Word32.word address))
        (fun answer -> answer#reify (SM.prj_exn (Std.Pair.prj_exn Config.prj_exn executeNumberPrj))) in
      assert (answers = [expected]);
      Printf.printf "step %s: OK\n%!" description

    let test_step_haltAndInvalidAddresses () =
      let state = executeFixture ~stack:[Value.Int 9] () in
      List.iter (fun (description, address, expected) ->
        checkStep description [Insn.dROP ()] state address expected)
        [("end address preserves complete state", 1, SM.Right (state, 1));
         ("address beyond end is invalid", 2, SM.Left "Invalid instruction address")]

    let test_step_execution () =
      let state = executeFixture ~stack:[Value.Int 9] () in
      List.iter (fun (description, instructions, address, expected) ->
        checkStep description instructions state address expected)
        [("CONST pushes value and increments address", [Insn.cONST (Word32.word 42)], 0,
            SM.Right (executeFixture ~stack:[Value.Int 42; Value.Int 9] (), 1));
         ("LINE advances from nonzero address", [Insn.dROP (); Insn.lINE (Word32.word 80)], 1,
            SM.Right (state, 2));
         ("JMP uses its target instead of fallthrough", [Insn.jMP (Word32.word 0)], 0,
            SM.Right (state, 0));
         ("instruction error is forwarded", [Insn.bINOP (inj "+")], 0,
            SM.Left "BINOP: stack underflow")]

    let test_step_callReturnAddress () =
      let state = executeFixture ~stack:[Value.Int 9] () in
      let caller = Loc.Loc ([(0, Value.Int 21)], [(0, Value.Int 11)], None) in
      let expected = executeFixture ~stack:[Value.Int 9]
        ~frames:[Frame.Frame (1, caller, [Value.Int 9])]
        ~environment:(Loc.Loc ([], [], None)) () in
      checkStep "CALL saves incremented return address"
        [Insn.cALL (Word32.word 2) (Word32.word 0); Insn.dROP (); Insn.bEGIN (Word32.word 0) (Word32.word 0)]
        state 0 (SM.Right (expected, 2))

    let test_step_backwards () =
      let state = executeState (executeFixture ()) in
      let expected address = inj (SM.Right (Std.pair
        (executeState (executeFixture ~stack:[Value.Int 42] ())) (Word32.word address))) in
      let addresses = Stream.take @@ run q (fun address ->
        SM.step (stepProgram [Insn.lINE (Word32.word 5); Insn.cONST (Word32.word 42)])
          state address (expected 2))
        (fun answer -> answer#reify executeNumberPrj) in
      assert (addresses = [1]);
      Printf.printf "step reconstructs instruction address: OK\n%!"

    let checkEval description instructions state address expected =
      let answers = Stream.take @@ run q
        (SM.eval (stepProgram instructions) (executeState state) (Word32.word address))
        (fun answer -> answer#reify (SM.prj_exn Config.prj_exn)) in
      assert (answers = [expected]);
      Printf.printf "eval %s: OK\n%!" description

    let test_eval_haltAndErrors () =
      let state = executeFixture ~stack:[Value.Int 9] () in
      checkEval "empty program preserves state" [] state 0 (SM.Right state);
      checkEval "later instruction error stops evaluation"
        [Insn.dROP (); Insn.dROP (); Insn.cONST (Word32.word 42)] state 0
        (SM.Left "DROP: stack underflow")

    let test_eval_multipleInstructions () =
      let state = executeFixture ~stack:[Value.Int 9] () in
      checkEval "CONST and subtraction execute in order"
        [Insn.cONST (Word32.word 10); Insn.cONST (Word32.word 3); Insn.bINOP (inj "-")]
        state 0 (SM.Right (executeFixture ~stack:[Value.Int 7; Value.Int 9] ()));
      checkEval "JMP skips a failing instruction"
        [Insn.jMP (Word32.word 2); Insn.fAIL (Word32.word 1) (Word32.word 1); Insn.cONST (Word32.word 42)]
        state 0 (SM.Right (executeFixture ~stack:[Value.Int 42; Value.Int 9] ()))

    let test_eval_callAndReturn () =
      let state = executeFixture ~stack:[Value.Int 9] () in
      checkEval "CALL returns to caller and END finishes main"
        [Insn.cALL (Word32.word 3) (Word32.word 0); Insn.cONST (Word32.word 7); Insn.eND ();
         Insn.bEGIN (Word32.word 0) (Word32.word 0); Insn.cONST (Word32.word 42); Insn.rET ()]
        state 0 (SM.Right (executeFixture ~stack:[Value.Int 7; Value.Int 42; Value.Int 9] ()))

    let runProgram entry instructions =
      Prog.make (Std.list Fun.id instructions) (Word32.word entry) (Std.List.nil ())

    let checkRun description program inputs expected =
      let answers = Stream.take @@ run q (SM.run program (Std.list Word32.word inputs))
        (fun answer -> answer#reify (SM.prj_exn (Std.List.prj_exn executeNumberPrj))) in
      assert (answers = [expected]);
      Printf.printf "run %s: OK\n%!" description

    let test_run_resultsAndErrors () =
      let beginMain = Insn.bEGIN (Word32.word 0) (Word32.word 0) in
      List.iter (fun (description, program, expected) -> checkRun description program [] expected)
        [("BEGIN and END produce no output", runProgram 0 [beginMain; Insn.eND ()], SM.Right []);
         ("nonzero entry skips FAIL", runProgram 1 [Insn.fAIL (Word32.word 1) (Word32.word 1); beginMain;
             Insn.cONST (Word32.word 42); Insn.bUILTIN (ByteString.inj "write") (Word32.word 1); Insn.eND ()], SM.Right [42]);
         ("initialization error is forwarded", runProgram 0 [], SM.Left "main does not point to BEGIN");
         ("execution error is forwarded", runProgram 0 [beginMain; Insn.dROP ()], SM.Left "DROP: stack underflow")]

    let runReadWriteProgram () =
      runProgram 0 [Insn.bEGIN (Word32.word 0) (Word32.word 2);
        Insn.bUILTIN (ByteString.inj "read") (Word32.word 0);
        Insn.bUILTIN (ByteString.inj "write") (Word32.word 1); Insn.dROP ();
        Insn.bUILTIN (ByteString.inj "read") (Word32.word 0);
        Insn.bUILTIN (ByteString.inj "write") (Word32.word 1); Insn.eND ()]

    let test_runConfig_finalState () =
      let answers = Stream.take @@ run q
        (SM.runConfig (runReadWriteProgram ()) (Std.list Word32.word [17; 23; 99]))
        (fun answer -> answer#reify (SM.prj_exn Config.prj_exn)) in
      let expected = Config.Config ([], [Value.Empty], [],
        Loc.Loc ([], [(0, Value.Empty); (1, Value.Empty)], None), [99], [17; 23], Store.Store [], 0) in
      assert (answers = [SM.Right expected]);
      Printf.printf "runConfig preserves complete final state and unused input: OK\n%!";
      checkRun "read/write preserve input and output order" (runReadWriteProgram ()) [17; 23; 99] (SM.Right [17; 23])

    let test_run_backwards () =
      let program = runProgram 0 [Insn.bEGIN (Word32.word 0) (Word32.word 0);
        Insn.bUILTIN (ByteString.inj "read") (Word32.word 0);
        Insn.bUILTIN (ByteString.inj "write") (Word32.word 1); Insn.eND ()] in
      let answers = Stream.take @@ run q (fun number ->
        SM.run program (Std.list Fun.id [number]) (inj (SM.Right (Std.list Word32.word [42]))))
        (fun answer -> answer#reify executeNumberPrj) in
      assert (answers = [42]);
      Printf.printf "run reconstructs input from output: OK\n%!"

    let run_test =
      List.iter (fun t -> t ()) tests_prj_exn;
      test_sm_prj_exn ();
      test_instruction_bytes ();
      test_instruction_partial_bytes ();
      List.iter (fun t -> t ()) tests_reify;
      test_sm_reify ();
      test_finished ();
      test_finished_2 ();
      test_initialConfig ();
      test_initialConfig_2 ();
      test_b2i ();
      test_b2i_2 ();
      test_isBegin ();
      test_initialState ();
      test_initialState_2 ();
      test_currentInstruction ();
      test_currentInstruction_2 ();
      test_jumpTo_boundaries ();
      test_jumpTo_backwards ();
      test_toInt ();
      test_toInt_2 ();
      test_renderChar_bytes ();
      test_renderChar_nonIntegers ();
      test_renderChar_backwards ();
      test_splitStack ();
      test_splitStack_2 ();
      test_safeIndex ();
      test_safeIndex_2 ();
      test_replaceAtSM ();
      test_replaceAtSM_empty ();
      test_replaceAtSM_backwards ();
      test_sameValue ();
      test_sameValue_2 ();
      test_binopComparisons ();
      test_binopBooleans ();
      test_currentClosureId ();
      test_currentClosureId_backwards ();
      test_lookupStore ();
      test_updateStore ();
      test_updateStore_preservesState ();
      test_updateStore_backwards ();
      test_lookupDesignation ();
      test_lookupDesignation_errors ();
      test_lookupDesignation_backwards ();
      test_capture ();
      test_capture_backwards ();
      test_mapM_toInt ();
      test_mapM_capture_firstError ();
      test_mapM_toInt_backwards ();
      test_mapM_error_freeTail ();
      test_returnFromCall_caller ();
      test_returnFromCall_main ();
      test_returnFromCall_backwards ();
      test_updateDesignation ();
      test_updateDesignation_errors ();
      test_updateDesignation_preservesState ();
      test_updateDesignation_backwards ();
      test_allocStore ();
      test_allocStore_preservesState ();
      test_allocStore_backwardsId ();
      test_binopArithmetic ();
      test_binopErrors ();
      test_binopBackwards ();
      test_binopOperators ();
      test_showValue_integers ();
      test_showValue_strings ();
      test_showValue_arrays ();
      test_showValue_sexps ();
      test_showValue_closures ();
      test_showValue_builtinsAndEmpty ();
      test_showValue_integersBackwards ();
      test_showValue_arraysBackwards ();
      test_showValue_rejectedQueries ();
      test_builtin_read ();
      test_builtin_write ();
      test_builtin_argumentErrors ();
      test_builtin_length ();
      test_builtin_unknownName ();
      test_builtin_array ();
      test_builtin_string ();
      test_builtin_stringAllocation ();
      test_builtin_preservesState ();
      test_builtin_readWriteBackwards ();
      test_builtin_nameBackwards ();
      test_executeInstruction_stackAndArithmetic ();
      test_executeInstruction_patterns ();
      test_executeInstruction_memory ();
      test_executeInstruction_control ();
      test_executeInstruction_calls ();
      test_executeInstruction_emptyCalls ();
      test_executeInstruction_callsBackwards ();
      test_executeInstruction_instructionBackwards ();
      test_step_haltAndInvalidAddresses ();
      test_step_execution ();
      test_step_callReturnAddress ();
      test_step_backwards ();
      test_eval_haltAndErrors ();
      test_eval_multipleInstructions ();
      test_eval_callAndReturn ();
      test_run_resultsAndErrors ();
      test_runConfig_finalState ();
      test_run_backwards ();
      Word32_tests.run_tests ()
  end

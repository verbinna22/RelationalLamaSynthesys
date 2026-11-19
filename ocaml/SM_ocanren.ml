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
    @type logic = (Std.String.logic, Std.Nat.logic) designation_a OCanren.logic with show, gmap

    let fmapt fs fi subj =
      let open Env.Monad in
      return (gmap(designation_a)) <*> fs <*> fi <*> subj

    let prj_exn =
      let open Env.Monad in
      Reifier.fix
        (fun self -> prj_exn <..>
                       (chain (fmapt Std.String.prj_exn
                                     (fun env x -> Std.Nat.to_int @@ Std.Nat.prj_exn env x)
        )))

    let reify =
      let open Env.Monad in
      Reifier.fix
        (fun self ->
          reify <..>
            (chain
               (Reifier.zed
                  (Reifier.rework ~fv:(fmapt Std.String.reify Std.Nat.reify)))))
 
    let global s = inj @@ Global s
    let local  i = inj @@ Local  i
    let arg    i = inj @@ Arg    i
    let access i = inj @@ Access i
    
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
    @type logic = (Std.String.logic, Std.Nat.logic) value_a OCanren.logic with show

    let fmapt fs fi subj =
      let open Env.Monad in
      return (gmap(value_a)) <*> fs <*> fi <*> subj

    let prj_exn =
      let open Env.Monad in
      Reifier.fix
        (fun self -> prj_exn <..>
                       (chain (fmapt Std.String.prj_exn
                                     (fun env x -> Std.Nat.to_int @@ Std.Nat.prj_exn env x)
        )))

    let reify =
      let open Env.Monad in
      Reifier.fix
        (fun self ->
          reify <..>
            (chain
               (Reifier.zed
                  (Reifier.rework ~fv:(fmapt Std.String.reify Std.Nat.reify)))))

    let int     x   = inj @@ Int x
    let string  x   = inj @@ String   x
    let array   x   = inj @@ Array    x
    let sexp    s x = inj @@ Sexp    (s, x)
    let closure x y = inj @@ Closure (x, y)
    let builtin s   = inj @@ Builtin s
    let empty   ()  = inj Empty    

  end

module Insn =
  struct
    
    @type ('string, 'int, 'patt, 'des, 'desList) insn_a =
      BINOP        of 'string
    | CONST        of 'int
    | STRING       of 'string
    | SEXP         of 'string * 'int
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
    | BUILTIN      of 'string * 'int
    | CALL_TAIL    of 'int * 'int
    | CALLC_TAIL   of 'int
    | BUILTIN_TAIL of 'string * 'int
    | RET
    | DROP
    | DUP
    | SWAP
    | TAG          of 'string * 'int
    | ARRAY        of 'int
    | PATT         of 'patt
    | FAIL         of 'int * 'int
    | LINE         of 'int
    with show, gmap

    @type t     = (string          , int          , Patt.t    , Designation.t    , Designation.t    list           ) insn_a               with show
    @type logic = (Std.String.logic, Std.Nat.logic, Patt.logic, Designation.logic, Designation.logic Std.List.logic) insn_a OCanren.logic with show
    
    let fmapt fs fi fp fd fdl subj =
      let open Env.Monad in
      return (gmap(insn_a)) <*> fs <*> fi <*> fp <*> fd <*> fdl <*> subj

    let prj_exn env =
      let open Env.Monad in
      Reifier.fix
        (fun self -> prj_exn <..>
                       (chain (fmapt Std.String.prj_exn                                     
                                     (fun env x -> Std.Nat.to_int @@ Std.Nat.prj_exn env x)
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
                  (Reifier.rework ~fv:(fmapt Std.String.reify
                                             Std.Nat.reify
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
        fresh text, first, second, pattern, designation, designations in
          instruction == BEGIN (first, second) & matches == true |
          matches == false &
          {instruction == BINOP text |
           instruction == CONST first |
           instruction == STRING text |
           instruction == SEXP (text, first) |
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
           instruction == BUILTIN (text, first) |
           instruction == CALL_TAIL (first, second) |
           instruction == CALLC_TAIL first |
           instruction == BUILTIN_TAIL (text, first) |
           instruction == RET |
           instruction == DROP |
           instruction == DUP |
           instruction == SWAP |
           instruction == TAG (text, first) |
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
    @type logic = (Insn.logic Std.List.logic, Std.Nat.logic, (Std.Nat.logic, Std.String.logic) Std.Pair.logic Std.List.logic) prog_a OCanren.logic with show

    let fmapt fil fe fifn subj =
      let open Env.Monad in
      return (gmap(prog_a)) <*> fil <*> fe <*> fifn <*> subj

    let prj_exn =
      let open Env.Monad in
      Reifier.fix
        (fun self -> prj_exn <..>
           (chain (fmapt
              (Std.List.prj_exn Insn.prj_exn)
              (fun env x -> Std.Nat.to_int @@ Std.Nat.prj_exn env x)
              (Std.List.prj_exn (Std.Pair.prj_exn
                 (fun env x -> Std.Nat.to_int @@ Std.Nat.prj_exn env x)
                 Std.String.prj_exn)))))

    let reify =
      let open Env.Monad in
      Reifier.fix
        (fun self -> reify <..>
           (chain (Reifier.zed
              (Reifier.rework ~fv:(fmapt
                 (Std.List.reify Insn.reify)
                 Std.Nat.reify
                 (Std.List.reify (Std.Pair.reify Std.Nat.reify Std.String.reify)))))))

    let finished program instructionAddress =
      let open Std.List in
      ocanren {
        fresh instructions, addr, env in
          program == MkProg (instructions, addr, env) &
        lengtho instructions instructionAddress
      }

    let make instructions entry functionNames =
      inj @@ MkProg (instructions, entry, functionNames)

    let rec lookupInstruction instructions address found =
      ocanren {
        instructions == [] & found == None |
        fresh instruction, remaining in
          instructions == instruction :: remaining &
          {address == 0 & found == Some instruction |
           fresh previous in
             address == Std.Nat.S previous &
             lookupInstruction remaining previous found}
      }

  end

module Loc = struct
  @type ('args, 'locals, 'closure) loc_a = 
    | Loc of 'args * 'locals * 'closure
  with show, gmap

  @type t = ((int * Value.t) list, (int * Value.t) list, int Std.Option.t) loc_a with show
  @type logic = ((Std.Nat.logic, Value.logic) Std.Pair.logic Std.List.logic, 
                 (Std.Nat.logic, Value.logic) Std.Pair.logic Std.List.logic, 
                 Std.Nat.logic Std.Option.logic) loc_a OCanren.logic with show

  let fmapt fa fl fc subj =
    let open Env.Monad in
    return (gmap(loc_a)) <*> fa <*> fl <*> fc <*> subj

  let prj_exn env =
    let open Env.Monad in
    Reifier.fix (fun self ->
      prj_exn <..> (chain (fmapt (Std.List.prj_exn (Std.Pair.prj_exn 
                                                      (fun env x -> Std.Nat.to_int @@ Std.Nat.prj_exn env x)
                                                      Value.prj_exn))
                                 (Std.List.prj_exn (Std.Pair.prj_exn 
                                                      (fun env x -> Std.Nat.to_int @@ Std.Nat.prj_exn env x)
                                                      Value.prj_exn))
                                 (Std.Option.prj_exn (fun env x -> Std.Nat.to_int @@ Std.Nat.prj_exn env x))
                          ))) env

  let reify env =
    let open Env.Monad in
    Reifier.fix (fun self ->
      reify <..> (chain (Reifier.zed (Reifier.rework ~fv:(fmapt (Std.List.reify (Std.Pair.reify Std.Nat.reify Value.reify))
                                                              (Std.List.reify (Std.Pair.reify Std.Nat.reify Value.reify))
                                                              (Std.Option.reify Std.Nat.reify)))))) env
  let loc args locals closure = inj @@ Loc (args, locals, closure)

  let emptyLoc environment =
    ocanren {
      environment == Loc ([], [], None)
    }
end

module Frame = struct
  @type ('int, 'loc, 'values) frame_a = Frame of 'int * 'loc * 'values with show, gmap
  
  @type t = (int, Loc.t, Value.t list) frame_a with show
  @type logic = (Std.Nat.logic, Loc.logic, Value.logic Std.List.logic) frame_a OCanren.logic with show

  let fmapt fi fl fv subj =
    let open Env.Monad in
    return (gmap(frame_a)) <*> fi <*> fl <*> fv <*> subj

  let prj_exn env =
    let open Env.Monad in
    Reifier.fix (fun self ->
      prj_exn <..> (chain (fmapt (fun env x -> Std.Nat.to_int @@ Std.Nat.prj_exn env x)
                                 Loc.prj_exn
                                 (Std.List.prj_exn Value.prj_exn)))) env

  let reify env =
    let open Env.Monad in
    Reifier.fix (fun self ->
      reify <..> (chain (Reifier.zed (Reifier.rework ~fv:(fmapt Std.Nat.reify
                                                              Loc.reify
                                                              (Std.List.reify Value.reify)))))) env

  let frame i l v = inj @@ Frame (i, l, v)
end

module Store = struct
  @type 'a t_a = Store of 'a with show, gmap
  
  @type t = (int * Value.t list) list t_a with show
  @type logic = (Std.Nat.logic, Value.logic Std.List.logic) Std.Pair.logic Std.List.logic t_a OCanren.logic with show

  let fmapt fs subj =
    let open Env.Monad in
    return (gmap(t_a)) <*> fs <*> subj

  let prj_exn env =
    let open Env.Monad in
    Reifier.fix (fun self ->
      prj_exn <..> (chain (fmapt (Std.List.prj_exn (Std.Pair.prj_exn 
                                                      (fun env x -> Std.Nat.to_int @@ Std.Nat.prj_exn env x)
                                                      (Std.List.prj_exn Value.prj_exn)))))) env

  let reify env =
    let open Env.Monad in
    Reifier.fix (fun self ->
      reify <..> (chain (Reifier.zed (Reifier.rework ~fv:(fmapt (Std.List.reify (Std.Pair.reify Std.Nat.reify (Std.List.reify Value.reify)))))))) env

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
                 Std.Nat.logic Std.List.logic, 
                 Std.Nat.logic Std.List.logic, 
                 Store.logic, 
                 Std.Nat.logic) config_a OCanren.logic with show

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
                                 (Std.List.prj_exn (fun env x -> Std.Nat.to_int @@ Std.Nat.prj_exn env x))
                                 (Std.List.prj_exn (fun env x -> Std.Nat.to_int @@ Std.Nat.prj_exn env x))
                                 Store.prj_exn
                                 (fun env x -> Std.Nat.to_int @@ Std.Nat.prj_exn env x)))) env

  let reify env =
    let open Env.Monad in
    Reifier.fix (fun self ->
      reify <..> (chain (Reifier.zed (Reifier.rework ~fv:(fmapt (Std.List.reify Frame.reify)
                                                              (Std.List.reify Value.reify)
                                                              (Std.List.reify (Std.Pair.reify Std.String.reify Value.reify))
                                                              Loc.reify
                                                              (Std.List.reify Std.Nat.reify)
                                                              (Std.List.reify Std.Nat.reify)
                                                              Store.reify
                                                              Std.Nat.reify))))) env

  let config cstack stk glob loc inp out store nextId = 
    inj @@ Config (cstack, stk, glob, loc, inp, out, store, nextId)

  let initialConfig inputs state =
    ocanren {
      fresh environment in
        Loc.emptyLoc environment &
        state == Config ([], [], [], environment, inputs, [], Store.Store [], 0)
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

  let b2i boolean number =
    ocanren {
      boolean == true & number == 1 |
      boolean == false & number == 0
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

  let splitStack count stack result =
    ocanren {
      fresh taken, rest, size in
        result == Right (Std.pair taken rest) &
        Std.List.appendo taken rest stack &
        Std.List.lengtho taken count |
        result == throwSM_inj !(inj "stack underflow") &
        Std.List.lengtho stack size &
        Std.Nat.lto size count true
    }

  let safeIndex values index what result =
    ocanren {
      fresh found, value in
        Prog.lookupInstruction values index found &
        {found == Some value & result == Right value |
         found == None & result == throwSM_inj !(inj (what ^ ": index out of bounds"))}
    }

  let sameValue leftValue rightValue same =
    ocanren {
      fresh leftNumber, rightNumber, leftId, rightId, leftName, rightName, leftEntry, rightEntry in
        {leftValue == Value.Int leftNumber |
         leftValue == Value.String leftId |
         leftValue == Value.Array leftId |
         leftValue == Value.Builtin leftName |
         leftValue == Value.Empty} &
        Std.eqo leftValue rightValue same |
        {leftValue == Value.Sexp (leftName, leftId) &
         rightValue == Value.Sexp (rightName, rightId) |
         leftValue == Value.Closure (leftEntry, leftId) &
         rightValue == Value.Closure (rightEntry, rightId)} &
        Std.eqo leftId rightId same |
        same == false &
        {{leftValue == Value.Sexp (leftName, leftId) |
          leftValue == Value.Closure (leftEntry, leftId)} &
         {rightValue == Value.Int rightNumber |
          rightValue == Value.String rightId |
          rightValue == Value.Array rightId |
          rightValue == Value.Builtin rightName |
          rightValue == Value.Empty} |
         leftValue == Value.Sexp (leftName, leftId) &
         rightValue == Value.Closure (rightEntry, rightId) |
         leftValue == Value.Closure (leftEntry, leftId) &
         rightValue == Value.Sexp (rightName, rightId)}
    }
end

module Test =
  struct

    let test printer reifier goal () =
      Printf.printf "%s\n" (show(list) (show(printer)) @@ (Stream.take @@ run q goal (fun qs -> qs#reify reifier)))
    let tests_prj_exn = [
        test Word32.t Word32.prj_exn (fun q -> q === Word32.word 42);
        test Patt       .t Patt       .prj_exn (fun q -> ocanren {q == Patt.StrCmp | q == Patt.Sexp});
        test Designation.t Designation.prj_exn (fun q -> ocanren {q == Designation.Local 3});
        test Value      .t Value      .prj_exn (fun q -> ocanren {q == Value.Empty});
        test Insn       .t Insn       .prj_exn (fun q -> ocanren {q == Insn.RET});
        test Designation.t Designation.prj_exn (fun q -> ocanren {
          q == Designation.Global !(OCanren.inj "main")
        });
        test Prog.t Prog.prj_exn (fun q -> ocanren {
          q == Prog.MkProg ([Insn.CONST 1; Insn.RET], 0, [(0, !(OCanren.inj "main"))])
        });
        test Loc.t Loc.prj_exn (fun q -> ocanren {
          q == Loc.Loc ([(0, Value.Int 1)], [(1, Value.Array 2)], Some 3) |
          Loc.emptyLoc q
        });
        test Frame.t Frame.prj_exn (fun q -> ocanren {
          q == Frame.Frame (2, Loc.Loc ([(0, Value.Int 1)], [], None), [Value.Int 3; Value.Empty])
        });
        test Store.t Store.prj_exn (fun q -> ocanren {
          q == Store.Store [(0, [Value.Int 1; Value.Array 2]); (2, [])] |
          q == Store.Store []
        });
        test Config.t Config.prj_exn (fun q -> ocanren {
          q == Config.Config (
            [Frame.Frame (2, Loc.Loc ([], [], None), [Value.Int 1])],
            [Value.Array 0], [(!(OCanren.inj "main"), Value.Closure (2, 0))],
            Loc.Loc ([(0, Value.Int 1)], [(1, Value.Empty)], Some 0),
            [0; 2], [3], Store.Store [(0, [Value.Int 1])], 1)
        })
    ]
    
    let tests_reify = [
        test Word32.logic Word32.reify (fun q ->
          let tail = Std.list inj (List.init 31 (fun _ -> false)) in
          ocanren {fresh bit in q == bit :: tail});
        test Patt       .logic Patt       .reify (fun q -> ocanren {q == Patt.StrCmp | q == Patt.Sexp});
        test Designation.logic Designation.reify (fun q -> ocanren {q == Designation.Local 3});
        test Value      .logic Value      .reify (fun q -> ocanren {q == Value.Empty});
        test Insn       .logic Insn       .reify (fun q -> ocanren {q == Insn.RET});
        test Designation.logic Designation.reify (fun q -> ocanren {
          q == Designation.Global !(OCanren.inj "main")
        });
        test Prog.logic Prog.reify (fun q -> ocanren {
          q == Prog.MkProg ([Insn.CONST 1; Insn.RET], 0, [(0, !(OCanren.inj "main"))])
        });
        test Loc.logic Loc.reify (fun q -> ocanren {
          fresh value, closureId in
            q == Loc.Loc ([(0, value)], [(1, Value.Array 2)], Some closureId) |
            Loc.emptyLoc q
        });
        test Frame.logic Frame.reify (fun q -> ocanren {
          fresh address, value in
            q == Frame.Frame (address, Loc.Loc ([(0, Value.Int 1)], [], None), [value; Value.Empty])
        });
        test Store.logic Store.reify (fun q -> ocanren {
          fresh value in
            q == Store.Store [(0, [value; Value.Array 2]); (2, [])] |
            q == Store.Store []
        });
        test Config.logic Config.reify (fun q -> ocanren {
          fresh value, inputs in
            q == Config.Config (
              [Frame.Frame (2, Loc.Loc ([], [], None), [value])],
              [Value.Array 0], [(!(OCanren.inj "main"), value)],
              Loc.Loc ([(0, value)], [(1, Value.Empty)], Some 0),
              inputs, [3], Store.Store [(0, [value])], 1)
        })
      ]
    
    let test_sm_prj_exn () =
      let results = Stream.take @@ run q (fun result -> ocanren {
        result == SM.throwSM_inj !(inj "error") |
        result == SM.Right (Value.Int 1)
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
          Prog.finished (Prog.MkProg ([Insn.CONST 1; Insn.RET], 0, [])) q
        }
    in
      Printf.printf "finished 2 = %s\n"
    (show(list) (fun n -> string_of_int (OCanren.Std.Nat.to_int n)) @@
      (Stream.take @@
          run q g (fun qs -> qs#reify Std.Nat.prj_exn)))

    let test_finished_2 () =
      let g prog =
      ocanren {
        Prog.finished prog 2
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
          Config.initialConfig [0; 2; 1] state
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
            (Config.Config ([], [], [], Loc.Loc ([], [], None), [0; 2; 1], [], Store.Store [], 0))
        }
      in
      let inputs = Stream.take @@ run q g (fun qs -> qs#reify
        (Std.List.prj_exn (fun env value -> Std.Nat.to_int @@ Std.Nat.prj_exn env value))) in
      assert (inputs = [[0; 2; 1]]);
      Printf.printf "inputs for initialConfig = %s\n"
        (show(list) (show(list) (show(int))) inputs)

    let test_b2i () =
      List.iter (fun (boolean, expected) ->
        let results = Stream.take @@ run q (fun number -> ocanren {
          SM.b2i !(inj boolean) number
        }) (fun qs -> qs#reify Std.Nat.prj_exn) in
        let numbers = List.map Std.Nat.to_int results in
        assert (numbers = [expected]);
        Printf.printf "b2i %b = %s\n" boolean (show(list) (show(int)) numbers)
      ) [(true, 1); (false, 0)]

    let test_b2i_2 () =
      List.iter (fun (number, expected) ->
        let booleans = Stream.take @@ run q (fun boolean -> ocanren {
          SM.b2i boolean !(Std.nat number)
        }) (fun qs -> qs#reify Std.Bool.prj_exn) in
        assert (booleans = expected);
        Printf.printf "booleans for b2i %d = %s\n" number (show(list) (show(bool)) booleans)
      ) [(0, [false]); (1, [true]); (2, [])]

    let test_isBegin () =
      let results = Stream.take @@ run q (fun matches -> ocanren {
        Std.List.mapo Insn.isBegin
          [Insn.BEGIN (2, 3); Insn.BINOP !(inj "+"); Insn.CONST 1;
           Insn.STRING !(inj "text"); Insn.SEXP (!(inj "Tag"), 0);
           Insn.LD (Designation.Local 0); Insn.ST (Designation.Arg 0);
           Insn.STA; Insn.ELEM; Insn.JMP 0; Insn.CJMP (!(inj "z"), 0);
           Insn.END; Insn.CLOSURE (0, []); Insn.CALLC 0; Insn.CALL (0, 0);
           Insn.BUILTIN (!(inj "read"), 0); Insn.CALL_TAIL (0, 0);
           Insn.CALLC_TAIL 0; Insn.BUILTIN_TAIL (!(inj "read"), 0);
           Insn.RET; Insn.DROP; Insn.DUP; Insn.SWAP; Insn.TAG (!(inj "Tag"), 0);
           Insn.ARRAY 0; Insn.PATT Patt.Boxed; Insn.FAIL (0, 0); Insn.LINE 0]
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
            (Prog.MkProg ([Insn.RET; Insn.BEGIN (2, 3); Insn.RET], !(Std.nat entry), []))
            [0; 2; 1] result
        }) (fun qs -> qs#reify (SM.prj_exn Config.prj_exn)) in
        assert (results = [expected]);
        Printf.printf "initialState entry %d = %s\n" entry
          (show(list) (show(SM.t) (show(Config.t))) results)
      ) [(0, error); (1, SM.Right initial); (2, error); (3, error); (5, error)];
      let results = Stream.take @@ run q (fun result -> ocanren {
        SM.initialState (Prog.MkProg ([], 0, [])) [] result
      }) (fun qs -> qs#reify (SM.prj_exn Config.prj_exn)) in
      assert (results = [error]);
      Printf.printf "initialState empty program = %s\n"
        (show(list) (show(SM.t) (show(Config.t))) results)

    let test_initialState_2 () =
      let entries = Stream.take @@ run q (fun entry -> ocanren {
        fresh state in
          Config.initialConfig [] state &
          SM.initialState
            (Prog.MkProg ([Insn.BEGIN (0, 0); Insn.RET; Insn.BEGIN (2, 3)], entry, []))
            [] (SM.Right state)
      }) (fun qs -> qs#reify Std.Nat.prj_exn) in
      let addresses = List.map Std.Nat.to_int entries in
      assert (addresses = [0; 2]);
      Printf.printf "valid initialState entries = %s\n" (show(list) (show(int)) addresses);
      let instructions = Stream.take @@ run q (fun instruction -> ocanren {
        fresh state in
          Config.initialConfig [] state &
          SM.initialState (Prog.MkProg ([instruction], 0, [])) [] (SM.Right state)
      }) (fun qs -> qs#reify Insn.reify) in
      assert (match instructions with
        | [OCanren.Value (Insn.BEGIN (OCanren.Var _, OCanren.Var _))] -> true
        | _ -> false);
      Printf.printf "instructions for initialState = %s\n"
        (show(list) (show(Insn.logic)) instructions);
      let rejected = Stream.take @@ run q (fun instruction -> ocanren {
        SM.initialState (Prog.MkProg ([instruction], 0, [])) []
          (SM.Left !(inj "main does not point to BEGIN")) &
        instruction == Insn.BEGIN (2, 3)
      }) (fun qs -> qs#reify Insn.prj_exn) in
      assert (rejected = []);
      Printf.printf "BEGIN with initialState error = %s\n" (show(list) (show(Insn.t)) rejected)

    let test_currentInstruction () =
      List.iter (fun (address, expected) ->
        let results = Stream.take @@ run q (fun result -> ocanren {
          SM.currentInstruction
            (Prog.MkProg ([Insn.BEGIN (2, 3); Insn.CONST 7; Insn.RET], 1, []))
            !(Std.nat address) result
        }) (fun qs -> qs#reify (SM.prj_exn Insn.prj_exn)) in
        assert (results = [expected]);
        Printf.printf "currentInstruction address %d = %s\n" address
          (show(list) (show(SM.t) (show(Insn.t))) results)
      ) [(0, SM.Right (Insn.BEGIN (2, 3))); (1, SM.Right (Insn.CONST 7));
         (2, SM.Right Insn.RET); (3, SM.throwSM "Invalid instruction address");
         (5, SM.throwSM "Invalid instruction address");
         (12, SM.throwSM "Invalid instruction address")];
      let results = Stream.take @@ run q (fun result -> ocanren {
        SM.currentInstruction (Prog.MkProg ([], 0, [])) 0 result
      }) (fun qs -> qs#reify (SM.prj_exn Insn.prj_exn)) in
      assert (results = [SM.throwSM "Invalid instruction address"]);
      Printf.printf "currentInstruction empty program = %s\n"
        (show(list) (show(SM.t) (show(Insn.t))) results)

    let test_currentInstruction_2 () =
      let entries = Stream.take @@ run q (fun address -> ocanren {
        SM.currentInstruction
          (Prog.MkProg ([Insn.RET; Insn.CONST 7; Insn.RET], 1, []))
          address (SM.Right Insn.RET)
      }) (fun qs -> qs#reify Std.Nat.prj_exn) in
      let addresses = List.map Std.Nat.to_int entries in
      assert (addresses = [0; 2]);
      Printf.printf "addresses for currentInstruction RET = %s\n"
        (show(list) (show(int)) addresses);
      let rejected = Stream.take @@ run q (fun address -> ocanren {
        SM.currentInstruction
          (Prog.MkProg ([Insn.RET; Insn.CONST 7; Insn.RET], 1, []))
          address (SM.Right Insn.DROP)
      }) (fun qs -> qs#reify Std.Nat.prj_exn) in
      assert (rejected = []);
      Printf.printf "addresses for currentInstruction DROP = %s\n"
        (show(list) (show(int)) (List.map Std.Nat.to_int rejected));
      let errorEntries = Stream.take @@ run q (fun address -> ocanren {
        SM.currentInstruction
          (Prog.MkProg ([Insn.RET; Insn.CONST 7; Insn.RET], 1, []))
          address (SM.Left !(inj "Invalid instruction address"))
      }) (fun qs -> qs#reify Std.Nat.reify) in
      assert (match errorEntries with
        | [OCanren.Value (Std.Nat.S (OCanren.Value (Std.Nat.S (OCanren.Value (Std.Nat.S (OCanren.Var _))))))] -> true
        | _ -> false);
      Printf.printf "invalid currentInstruction addresses = %s\n"
        (show(list) (show(Std.Nat.logic)) errorEntries);
      let instructions = Stream.take @@ run q (fun instruction -> ocanren {
        SM.currentInstruction (Prog.MkProg ([Insn.RET; instruction], 0, [])) 1
          (SM.Right (Insn.CONST 7))
      }) (fun qs -> qs#reify Insn.prj_exn) in
      assert (instructions = [Insn.CONST 7]);
      Printf.printf "instructions for currentInstruction = %s\n"
        (show(list) (show(Insn.t)) instructions);
      let results = Stream.take @@ run q (fun result -> ocanren {
        fresh arguments, locals in
          SM.currentInstruction
            (Prog.MkProg ([Insn.RET; Insn.BEGIN (arguments, locals)], 0, [])) 1 result
      }) (fun qs -> qs#reify (SM.reify Insn.reify)) in
      assert (match results with
        | [OCanren.Value (SM.Right (OCanren.Value (Insn.BEGIN (OCanren.Var _, OCanren.Var _))))] -> true
        | _ -> false);
      Printf.printf "currentInstruction with free BEGIN parameters = %s\n"
        (show(list) (show(SM.logic) (show(Insn.logic))) results)

    let test_toInt () =
      let results = Stream.take @@ run q (fun results -> ocanren {
        Std.List.mapo SM.toInt
          [Value.Int 0; Value.Int 7; Value.String 1; Value.Array 2;
           Value.Sexp (!(inj "Tag"), 3); Value.Closure (1, 4);
           Value.Builtin !(inj "read"); Value.Empty]
          results
      }) (fun qs -> qs#reify (Std.List.prj_exn
        (SM.prj_exn (fun env number -> Std.Nat.to_int @@ Std.Nat.prj_exn env number)))) in
      let error = SM.throwSM "expected int" in
      assert (results = [[SM.Right 0; SM.Right 7; error; error; error; error; error; error]]);
      Printf.printf "toInt for all Value constructors = %s\n"
        (show(list) (show(list) (show(SM.t) (show(int)))) results)

    let test_toInt_2 () =
      let values = Stream.take @@ run q (fun value -> ocanren {
        SM.toInt value (SM.Right 7)
      }) (fun qs -> qs#reify Value.prj_exn) in
      assert (values = [Value.Int 7]);
      Printf.printf "values for toInt Right 7 = %s\n" (show(list) (show(Value.t)) values);
      let results = Stream.take @@ run q (fun result -> ocanren {
        fresh number in
          SM.toInt (Value.Int number) result
      }) (fun qs -> qs#reify (SM.reify Std.Nat.reify)) in
      assert (match results with
        | [OCanren.Value (SM.Right (OCanren.Var _))] -> true
        | _ -> false);
      Printf.printf "toInt with a free number = %s\n"
        (show(list) (show(SM.logic) (show(Std.Nat.logic))) results);
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
      }) (fun qs -> qs#reify Std.Nat.reify) in
      assert (rejected = []);
      Printf.printf "Int with toInt error = %s\n" (show(list) (show(Std.Nat.logic)) rejected)

    let test_splitStack () =
      let reifier = SM.prj_exn (Std.Pair.prj_exn
        (Std.List.prj_exn Value.prj_exn) (Std.List.prj_exn Value.prj_exn)) in
      let printer = show(SM.t) (show(Std.Pair.t)
        (show(list) (show(Value.t))) (show(list) (show(Value.t)))) in
      let stack = [Value.Int 7; Value.Empty; Value.Array 2] in
      let error = SM.throwSM "stack underflow" in
      List.iter (fun (count, expected) ->
        let results = Stream.take @@ run q (fun result -> ocanren {
          SM.splitStack !(Std.nat count) [Value.Int 7; Value.Empty; Value.Array 2] result
        }) (fun qs -> qs#reify reifier) in
        assert (results = [expected]);
        Printf.printf "splitStack %d = %s\n" count (show(list) printer results)
      ) [(0, SM.Right ([], stack));
         (1, SM.Right ([Value.Int 7], [Value.Empty; Value.Array 2]));
         (2, SM.Right ([Value.Int 7; Value.Empty], [Value.Array 2]));
         (3, SM.Right (stack, [])); (4, error); (6, error)];
      List.iter (fun (count, expected) ->
        let results = Stream.take @@ run q (fun result -> ocanren {
          SM.splitStack !(Std.nat count) [] result
        }) (fun qs -> qs#reify reifier) in
        assert (results = [expected]);
        Printf.printf "splitStack %d empty stack = %s\n" count (show(list) printer results)
      ) [(0, SM.Right ([], [])); (1, error)]

    let test_splitStack_2 () =
      let counts = Stream.take @@ run q (fun count -> ocanren {
        fresh taken, rest in
          SM.splitStack count [Value.Int 7; Value.Empty; Value.Array 2]
            (SM.Right (Std.pair taken rest))
      }) (fun qs -> qs#reify Std.Nat.prj_exn) in
      let numbers = List.map Std.Nat.to_int counts in
      assert (numbers = [0; 1; 2; 3]);
      Printf.printf "valid splitStack counts = %s\n" (show(list) (show(int)) numbers);
      let stacks = Stream.take @@ run q (fun stack -> ocanren {
        SM.splitStack 2 stack
          (SM.Right (Std.pair [Value.Int 7; Value.Empty] [Value.Array 2]))
      }) (fun qs -> qs#reify (Std.List.prj_exn Value.prj_exn)) in
      assert (stacks = [[Value.Int 7; Value.Empty; Value.Array 2]]);
      Printf.printf "stacks for splitStack = %s\n"
        (show(list) (show(list) (show(Value.t))) stacks);
      let rejected = Stream.take @@ run q (fun stack -> ocanren {
        SM.splitStack 2 stack
          (SM.Right (Std.pair [Value.Int 7] [Value.Empty]))
      }) (fun qs -> qs#reify (Std.List.prj_exn Value.prj_exn)) in
      assert (rejected = []);
      Printf.printf "splitStack with a wrong prefix length = %s\n"
        (show(list) (show(list) (show(Value.t))) rejected);
      let results = Stream.take @@ run q (fun result -> ocanren {
        fresh value in
          SM.splitStack 1 [value; value] result
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
          (show(Std.List.logic) (show(Value.logic))))) results)

    let test_safeIndex () =
      let error = SM.throwSM "ELEM: index out of bounds" in
      List.iter (fun (index, expected) ->
        let results = Stream.take @@ run q (fun result -> ocanren {
          SM.safeIndex [Value.Int 7; Value.Empty; Value.Array 2]
            !(Std.nat index) !("ELEM") result
        }) (fun qs -> qs#reify (SM.prj_exn Value.prj_exn)) in
        assert (results = [expected]);
        Printf.printf "safeIndex %d = %s\n" index
          (show(list) (show(SM.t) (show(Value.t))) results)
      ) [(0, SM.Right (Value.Int 7)); (1, SM.Right Value.Empty);
         (2, SM.Right (Value.Array 2)); (3, error); (5, error)];
      List.iter (fun (what, expected) ->
        let results = Stream.take @@ run q (fun result -> ocanren {
          SM.safeIndex [] 0 what result
        }) (fun qs -> qs#reify (SM.prj_exn Value.prj_exn)) in
        assert (results = [SM.throwSM expected]);
        Printf.printf "safeIndex empty list (%s) = %s\n" what
          (show(list) (show(SM.t) (show(Value.t))) results)
      ) [("ELEM", "ELEM: index out of bounds");
         ("closure access", "closure access: index out of bounds")];
      let results = Stream.take @@ run q (fun result -> ocanren {
        SM.safeIndex [3; 8] 1 !("numbers") result
      }) (fun qs -> qs#reify (SM.prj_exn
        (fun env number -> Std.Nat.to_int @@ Std.Nat.prj_exn env number))) in
      assert (results = [SM.Right 8]);
      Printf.printf "safeIndex for natural numbers = %s\n"
        (show(list) (show(SM.t) (show(int))) results)

    let test_safeIndex_2 () =
      let indices = Stream.take @@ run q (fun index -> ocanren {
        SM.safeIndex [Value.Int 7; Value.Empty; Value.Int 7] index !("ELEM")
          (SM.Right (Value.Int 7))
      }) (fun qs -> qs#reify Std.Nat.prj_exn) in
      let numbers = List.map Std.Nat.to_int indices in
      assert (numbers = [0; 2]);
      Printf.printf "indices for safeIndex Int 7 = %s\n" (show(list) (show(int)) numbers);
      let rejected = Stream.take @@ run q (fun index -> ocanren {
        SM.safeIndex [Value.Int 7; Value.Empty; Value.Int 7] index !("ELEM")
          (SM.Right (Value.Int 8))
      }) (fun qs -> qs#reify Std.Nat.prj_exn) in
      assert (rejected = []);
      Printf.printf "indices for safeIndex Int 8 = %s\n"
        (show(list) (show(int)) (List.map Std.Nat.to_int rejected));
      let lists = Stream.take @@ run q (fun values -> ocanren {
        SM.safeIndex values 1 !("ELEM") (SM.Right Value.Empty)
      }) (fun qs -> qs#reify (Std.List.reify Value.reify)) in
      assert (match lists with
        | [OCanren.Value (Std.List.Cons (OCanren.Var _,
            OCanren.Value (Std.List.Cons (OCanren.Value Value.Empty, OCanren.Var _))))] -> true
        | _ -> false);
      Printf.printf "lists for safeIndex Empty at 1 = %s\n"
        (show(list) (show(Std.List.logic) (show(Value.logic))) lists);
      let results = Stream.take @@ run q (fun result -> ocanren {
        fresh value in
          SM.safeIndex [Value.Empty; value] 1 !("ELEM") result
      }) (fun qs -> qs#reify (SM.reify Value.reify)) in
      assert (match results with
        | [OCanren.Value (SM.Right (OCanren.Var _))] -> true
        | _ -> false);
      Printf.printf "safeIndex with a free value = %s\n"
        (show(list) (show(SM.logic) (show(Value.logic))) results);
      let errors = Stream.take @@ run q (fun index -> ocanren {
        SM.safeIndex [Value.Int 7; Value.Empty; Value.Array 2] index !("ELEM")
          (SM.Left !(inj "ELEM: index out of bounds"))
      }) (fun qs -> qs#reify Std.Nat.reify) in
      assert (match errors with
        | [OCanren.Value (Std.Nat.S (OCanren.Value (Std.Nat.S (OCanren.Value (Std.Nat.S (OCanren.Var _))))))] -> true
        | _ -> false);
      Printf.printf "invalid safeIndex indices = %s\n" (show(list) (show(Std.Nat.logic)) errors)

    let test_sameValue () =
      let values = [
        Value.int (Std.nat 1); Value.string (Std.nat 1); Value.array (Std.nat 1);
        Value.sexp (inj "Tag") (Std.nat 1); Value.closure (Std.nat 2) (Std.nat 1);
        Value.builtin (inj "read"); Value.empty ()
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
        ("different integers", Value.int (Std.nat 1), Value.int (Std.nat 2), false);
        ("different string IDs", Value.string (Std.nat 1), Value.string (Std.nat 2), false);
        ("different array IDs", Value.array (Std.nat 1), Value.array (Std.nat 2), false);
        ("different Sexp IDs", Value.sexp (inj "Tag") (Std.nat 1), Value.sexp (inj "Tag") (Std.nat 2), false);
        ("different Sexp tags", Value.sexp (inj "Left") (Std.nat 1), Value.sexp (inj "Right") (Std.nat 1), true);
        ("different closure IDs", Value.closure (Std.nat 2) (Std.nat 1), Value.closure (Std.nat 2) (Std.nat 3), false);
        ("different closure entries", Value.closure (Std.nat 2) (Std.nat 1), Value.closure (Std.nat 3) (Std.nat 1), true);
        ("different builtin names", Value.builtin (inj "read"), Value.builtin (inj "write"), false)
      ]

    let test_sameValue_2 () =
      let values = Stream.take @@ run q (fun value -> ocanren {
        SM.sameValue (Value.Int 7) value true
      }) (fun qs -> qs#reify Value.prj_exn) in
      assert (values = [Value.Int 7]);
      Printf.printf "values equal to Int 7 = %s\n" (show(list) (show(Value.t)) values);
      let sexps = Stream.take @@ run q (fun value -> ocanren {
        SM.sameValue (Value.Sexp (!(inj "Tag"), 0)) value true
      }) (fun qs -> qs#reify Value.reify) in
      assert (match sexps with
        | [OCanren.Value (Value.Sexp (OCanren.Var _, OCanren.Value Std.Nat.O))] -> true
        | _ -> false);
      Printf.printf "values equal to Sexp Tag 0 = %s\n" (show(list) (show(Value.logic)) sexps);
      let closures = Stream.take @@ run q (fun value -> ocanren {
        SM.sameValue (Value.Closure (2, 0)) value true
      }) (fun qs -> qs#reify Value.reify) in
      assert (match closures with
        | [OCanren.Value (Value.Closure (OCanren.Var _, OCanren.Value Std.Nat.O))] -> true
        | _ -> false);
      Printf.printf "values equal to Closure 2 0 = %s\n" (show(list) (show(Value.logic)) closures);
      let names = Stream.take @@ run q (fun name -> ocanren {
        SM.sameValue (Value.Builtin !(inj "read")) (Value.Builtin name) true
      }) (fun qs -> qs#reify Std.String.prj_exn) in
      assert (names = ["read"]);
      Printf.printf "builtin names equal to read = %s\n" (show(list) (show(string)) names);
      let unequal = Stream.take @@ run q (fun number -> ocanren {
        SM.sameValue (Value.Int 0) (Value.Int number) false
      }) (fun qs -> qs#reify Std.Nat.reify) in
      assert (match unequal with
        | [OCanren.Var (_, [OCanren.Value Std.Nat.O])] -> true
        | _ -> false);
      Printf.printf "numbers unequal to Int 0 = %s\n" (show(list) (show(Std.Nat.logic)) unequal);
      List.iter (fun (same, expected) ->
        let answers = Stream.take @@ run q (fun number -> ocanren {
          SM.sameValue (Value.Int 0) (Value.Int number) !(inj same) &
          {number == 0 | number == 2}
        }) (fun qs -> qs#reify Std.Nat.prj_exn) in
        let numbers = List.map Std.Nat.to_int answers in
        assert (numbers = expected);
        Printf.printf "numbers for sameValue Int 0 %b = %s\n" same (show(list) (show(int)) numbers)
      ) [(true, [0]); (false, [2])];
      let tags = Stream.take @@ run q (fun tag -> ocanren {
        SM.sameValue (Value.Sexp (!(inj "Tag"), 0)) (Value.Sexp (tag, 0)) false
      }) (fun qs -> qs#reify Std.String.reify) in
      assert (tags = []);
      Printf.printf "tags making the same Sexp ID unequal = %s\n"
        (show(list) (show(Std.String.logic)) tags);
      let entries = Stream.take @@ run q (fun entry -> ocanren {
        SM.sameValue (Value.Closure (2, 0)) (Value.Closure (entry, 0)) false
      }) (fun qs -> qs#reify Std.Nat.reify) in
      assert (entries = []);
      Printf.printf "entries making the same closure ID unequal = %s\n"
        (show(list) (show(Std.Nat.logic)) entries)

    let run_test =
      List.iter (fun t -> t ()) tests_prj_exn;
      test_sm_prj_exn ();
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
      test_toInt ();
      test_toInt_2 ();
      test_splitStack ();
      test_splitStack_2 ();
      test_safeIndex ();
      test_safeIndex_2 ();
      test_sameValue ();
      test_sameValue_2 ();
      Word32_tests.run_tests ()
  end

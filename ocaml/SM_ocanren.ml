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
end

module Test =
  struct

    let test printer reifier goal () =
      Printf.printf "%s\n" (show(list) (show(printer)) @@ (Stream.take @@ run q goal (fun qs -> qs#reify reifier)))
    let tests_prj_exn = [
        test Patt       .t Patt       .prj_exn (fun q -> ocanren {q == Patt.StrCmp | q == Patt.Sexp});
        test Designation.t Designation.prj_exn (fun q -> ocanren {q == Designation.Local 3});
        test Value      .t Value      .prj_exn (fun q -> ocanren {q == Value.Empty});
        test Insn       .t Insn       .prj_exn (fun q -> ocanren {q == Insn.RET});
        test Designation.t Designation.prj_exn (fun q -> ocanren {
          q == Designation.Global !(OCanren.inj "main")
        });
        test Prog.t Prog.prj_exn (fun q -> ocanren {
          q == Prog.MkProg ([Insn.CONST 1; Insn.RET], 0, [(0, !(OCanren.inj "main"))])
        })
    ]
    
    let tests_reify = [
        test Patt       .logic Patt       .reify (fun q -> ocanren {q == Patt.StrCmp | q == Patt.Sexp});
        test Designation.logic Designation.reify (fun q -> ocanren {q == Designation.Local 3});
        test Value      .logic Value      .reify (fun q -> ocanren {q == Value.Empty});
        test Insn       .logic Insn       .reify (fun q -> ocanren {q == Insn.RET});
        test Designation.logic Designation.reify (fun q -> ocanren {
          q == Designation.Global !(OCanren.inj "main")
        });
        test Prog.logic Prog.reify (fun q -> ocanren {
          q == Prog.MkProg ([Insn.CONST 1; Insn.RET], 0, [(0, !(OCanren.inj "main"))])
        })
      ]
    
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

    let run_test =
      List.iter (fun t -> t ()) tests_prj_exn;
      List.iter (fun t -> t ()) tests_reify;
      test_finished ();
      test_finished_2 ()
  end

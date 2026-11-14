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

module Test =
  struct

    let test printer reifier goal () =
      Printf.printf "%s\n" (show(list) (show(printer)) @@ (Stream.take @@ run q goal (fun qs -> qs#reify reifier)))
        
    let tests_prj_exn = [
        test Patt       .t Patt       .prj_exn (fun q -> ocanren {q == Patt.StrCmp | q == Patt.Sexp});
        test Designation.t Designation.prj_exn (fun q -> ocanren {q == Designation.Local 3});
        test Value      .t Value      .prj_exn (fun q -> ocanren {q == Value.Empty});
        test Insn       .t Insn       .prj_exn (fun q -> ocanren {q == Insn.RET})
    ]
    
    let tests_reify = [
        test Patt       .logic Patt       .reify (fun q -> ocanren {q == Patt.StrCmp | q == Patt.Sexp});
        test Designation.logic Designation.reify (fun q -> ocanren {q == Designation.Local 3});
        test Value      .logic Value      .reify (fun q -> ocanren {q == Value.Empty});
        test Insn       .logic Insn       .reify (fun q -> ocanren {q == Insn.RET})
      ]

    let run_test =
      List.iter (fun t -> t ()) tests_prj_exn;
      List.iter (fun t -> t ()) tests_reify
    
  end

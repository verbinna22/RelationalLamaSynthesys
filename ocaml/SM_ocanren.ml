open GT
open OCanren

@type patt =
  StrCmp
| PString
| PArray
| PSexp
| Boxed
| UnBoxed
| PClosure with show

@type patt_l = patt logic with show

let strCmp   () = inj StrCmp
let pString  () = inj PString
let pArray   () = inj PArray
let pSexp    () = inj PSexp
let boxed    () = inj Boxed
let unBoxed  () = inj UnBoxed
let pClosure () = inj PClosure;;    

@type ('string, 'int) designation_a =
  DGlobal of 'string
| DLocal  of 'int
| DArg    of 'int
| DAccess of 'int
with show, gmap

@type designation   = (string, int) designation_a with show, gmap
@type designation_l = (string logic, int logic) designation_a logic with show, gmap

let dGlobal s = inj @@ DGlobal s
let dLocal  i = inj @@ DLocal  i
let dArg    i = inj @@ DArg    i
let dAccess i = inj @@ DAccess i


@type value =
  VInt     of int
| VString  of int
| VArray   of int
| VSexp    of string * int
| VClosure of int * int
| VBuiltin of string
| VEmpty
with show

@type insn =
  BINOP        of string
| CONST        of int
| STRING       of string
| SEXP         of string * int
| LD           of designation
| ST           of designation
| STA
| ELEM
| JMP          of int
| CJMP         of string * int
| BEGIN        of int * int
| END
| CLOSURE      of int * designation list
| CALLC        of int
| CALL         of int * int
| BUILTIN      of string * int
| CALL_TAIL    of int * int
| CALLC_TAIL   of int
| BUILTIN_TAIL of string * int
| RET
| DROP
| DUP
| SWAP
| TAG          of string * int
| ARRAY        of int
| PATT         of patt
| FAIL         of int* int
| LINE         of int
with show

let testPatt        x = ocanren { x == StrCmp | x == PSexp }
let testDesignation x = ocanren { fresh i in x == DLocal i}

let _ =
  match Stream.take @@ run q (fun q -> testPatt q) (fun qs -> qs#reify reify) with
  | l -> Printf.printf "%s\n" @@ (show(list) (show(patt_l))) l

let _ =
  match Stream.take @@ run q (fun q -> testDesignation q) (fun qs -> qs#reify prj_designation) with
  | l -> () (* Printf.printf "%s\n" @@ (show(list) (show(designation))) l *)

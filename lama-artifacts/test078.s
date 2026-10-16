	.file "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test078/test078.lama"

	.stabs "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test078/test078.lama",100,0,0,.Ltext

	.globl	main

	.data

string_0:	.string	"Function %s called with incorrect arguments count. Expected: %d. Actual: %d\n"

string_3:	.string	"append"

string_1:	.string	"printList"

string_2:	.string	"test078.lama"

init:	.quad 0

	.section custom_data,"aw",@progbits

filler:	.fill	2, 8, 1

	.stabs "n:S1",40,0,0,global_n

global_n:	.quad	1

	.stabs "x:S1",40,0,0,global_x

global_x:	.quad	1

	.stabs "y:S1",40,0,0,global_y

global_y:	.quad	1

	.text

.Ltext:

	.stabs "data:t1=r1;0;4294967295;",128,0,0,0

# IMPORT ("Std")

# PUBLIC ("main")

# EXTERN ("Llowercase")

# EXTERN ("Luppercase")

# EXTERN ("LtagHash")

# EXTERN ("LflatCompare")

# EXTERN ("LcompareTags")

# EXTERN ("LkindOf")

# EXTERN ("Ltime")

# EXTERN ("Lrandom")

# EXTERN ("LdisableGC")

# EXTERN ("LenableGC")

# EXTERN ("Ls__Infix_37")

# EXTERN ("Ls__Infix_47")

# EXTERN ("Ls__Infix_42")

# EXTERN ("Ls__Infix_45")

# EXTERN ("Ls__Infix_43")

# EXTERN ("Ls__Infix_62")

# EXTERN ("Ls__Infix_6261")

# EXTERN ("Ls__Infix_60")

# EXTERN ("Ls__Infix_6061")

# EXTERN ("Ls__Infix_3361")

# EXTERN ("Ls__Infix_6161")

# EXTERN ("Ls__Infix_3838")

# EXTERN ("Ls__Infix_3333")

# EXTERN ("Ls__Infix_58")

# EXTERN ("Li__Infix_4343")

# EXTERN ("Lcompare")

# EXTERN ("Lwrite")

# EXTERN ("Lread")

# EXTERN ("Lfailure")

# EXTERN ("Lfexists")

# EXTERN ("Lfwrite")

# EXTERN ("Lfread")

# EXTERN ("Lfclose")

# EXTERN ("Lfopen")

# EXTERN ("Lfprintf")

# EXTERN ("Lprintf")

# EXTERN ("LmakeString")

# EXTERN ("Lsprintf")

# EXTERN ("LregexpMatch")

# EXTERN ("Lregexp")

# EXTERN ("Lsubstring")

# EXTERN ("LmatchSubString")

# EXTERN ("Lstringcat")

# EXTERN ("LreadLine")

# EXTERN ("Ltl")

# EXTERN ("Lhd")

# EXTERN ("Lsnd")

# EXTERN ("Lfst")

# EXTERN ("Lhash")

# EXTERN ("Lclone")

# EXTERN ("Llength")

# EXTERN ("Lstring")

# EXTERN ("LmakeArray")

# EXTERN ("LstringInt")

# EXTERN ("global_sysargs")

# EXTERN ("Lsystem")

# EXTERN ("LgetEnv")

# EXTERN ("Lassert")

# LABEL ("main")

main:

# BEGIN ("main", 2, 0, [], [], [])

	.type main, @function

	.cfi_startproc

	movq	init(%rip),	%rax
	test	%rax,	%rax
	jz	continue
	ret
_ERROR:

	call	Lbinoperror
	ret
_ERROR2:

	call	Lbinoperror2
	ret
continue:

	movq	$1,	init(%rip)
	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$Lmain_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSmain_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
	movq	$15,	%rax
	test	%rsp,	%rax
	jz	ALIGNED
	pushq	filler(%rip)
ALIGNED:

	pushq	%rdi
	pushq	%rsi
	call	__gc_init
	popq	%rsi
	popq	%rdi
	call	set_args
# SLABEL ("L1")

L1:

# LINE (17)

	.stabn 68,0,17,.L0

.L0:

# CALL ("Lread", 0, false)

	pushq	%rdi
	pushq	%rsi
	movq	$0,	%r11
	call	Lread
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# LINE (15)

	.stabn 68,0,15,.L1

.L1:

# ST (Global ("n"))

	movq	%r10,	global_n(%rip)
# DROP

# CONST (1)

	movq	$3,	%r10
# CONST (2)

	movq	$5,	%r11
# SEXP ("Nil", 0)

	movq	$328857,	%r12
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	pushq	filler(%rip)
	pushq	%r12
	movq	%rsp,	%rdi
	movq	$3,	%rsi
	call	Bsexp
	addq	$16,	%rsp
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# SEXP ("Cons", 2)

	movq	$15329063,	%r13
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r13
	pushq	%r12
	pushq	%r11
	movq	%rsp,	%rdi
	movq	$7,	%rsi
	call	Bsexp
	addq	$24,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# SEXP ("Cons", 2)

	movq	$15329063,	%r12
	pushq	%rdi
	pushq	%rsi
	pushq	filler(%rip)
	pushq	%r12
	pushq	%r11
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$7,	%rsi
	call	Bsexp
	addq	$32,	%rsp
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# ST (Global ("x"))

	movq	%r10,	global_x(%rip)
# DROP

# CONST (3)

	movq	$7,	%r10
# CONST (4)

	movq	$9,	%r11
# SEXP ("Nil", 0)

	movq	$328857,	%r12
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	pushq	filler(%rip)
	pushq	%r12
	movq	%rsp,	%rdi
	movq	$3,	%rsi
	call	Bsexp
	addq	$16,	%rsp
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# SEXP ("Cons", 2)

	movq	$15329063,	%r13
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r13
	pushq	%r12
	pushq	%r11
	movq	%rsp,	%rdi
	movq	$7,	%rsi
	call	Bsexp
	addq	$24,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# SEXP ("Cons", 2)

	movq	$15329063,	%r12
	pushq	%rdi
	pushq	%rsi
	pushq	filler(%rip)
	pushq	%r12
	pushq	%r11
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$7,	%rsi
	call	Bsexp
	addq	$32,	%rsp
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# LINE (19)

	.stabn 68,0,19,.L2

.L2:

# ST (Global ("y"))

	movq	%r10,	global_y(%rip)
# DROP

# LINE (20)

	.stabn 68,0,20,.L3

.L3:

# LINE (22)

	.stabn 68,0,22,.L4

.L4:

# LD (Global ("x"))

	movq	global_x(%rip),	%r10
# CALL ("LprintList", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	LprintList
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LINE (23)

	.stabn 68,0,23,.L5

.L5:

# LD (Global ("y"))

	movq	global_y(%rip),	%r10
# CALL ("LprintList", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	LprintList
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LINE (24)

	.stabn 68,0,24,.L6

.L6:

# LD (Global ("x"))

	movq	global_x(%rip),	%r10
# LD (Global ("y"))

	movq	global_y(%rip),	%r11
# CALL ("Lappend", 2, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$2,	%r11
	call	Lappend
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# CALL ("LprintList", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	LprintList
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LINE (25)

	.stabn 68,0,25,.L7

.L7:

# LD (Global ("y"))

	movq	global_y(%rip),	%r10
# LD (Global ("x"))

	movq	global_x(%rip),	%r11
# CALL ("Lappend", 2, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$2,	%r11
	call	Lappend
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# CALL ("LprintList", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	LprintList
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# SLABEL ("L2")

L2:

# END

	movq	%r10,	%rax
Lmain_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	xorq	%rax,	%rax
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	Lmain_SIZE,	0

	.set	LSmain_SIZE,	0

	.size main, .-main

# LABEL ("LprintList")

LprintList:

# BEGIN ("LprintList", 1, 2, [], ["x"], [{ blab="L37"; elab="L38"; names=[]; subs=[{ blab="L40"; elab="L41"; names=[]; subs=[{ blab="L54"; elab="L55"; names=[("h", 1); ("t", 0)]; subs=[{ blab="L56"; elab="L57"; names=[]; subs=[]; }]; }; { blab="L47"; elab="L48"; names=[]; subs=[{ blab="L49"; elab="L50"; names=[]; subs=[]; }]; }]; }]; }])

	.type printList, @function

	.stabs "printList:F1",36,0,0,LprintList

	.stabs "h:1",128,0,0,-16

	.stabs "t:1",128,0,0,-8

	.stabn 192,0,0,L54-LprintList

	.stabn 224,0,0,L55-LprintList

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLprintList_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLprintList_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$1,	%r11
	je	LprintList_argc_correct
	movq	%r11,	%r13
	movq	$1,	%r12
	leaq	string_1(%rip),	%r11
	leaq	string_0(%rip),	%r10
	pushq	%rdi
	pushq	%rsi
	movq	%r13,	%rcx
	movq	%r12,	%rdx
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$4,	%r11
	call	failure
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
LprintList_argc_correct:

# SLABEL ("L37")

L37:

# SLABEL ("L40")

L40:

# LINE (11)

	.stabn 68,0,11,0

	.stabn 68,0,11,.L8-LprintList

.L8:

# LD (Arg (0))

	movq	%rdi,	%r10
# DUP

	movq	%r10,	%r11
# SLABEL ("L47")

L47:

# DUP

	movq	%r11,	%r12
# TAG ("Nil", 0)

	movq	$328857,	%r13
	movq	$1,	%r14
	pushq	%rdi
	pushq	%r10
	pushq	%r11
	pushq	filler(%rip)
	movq	%r14,	%rdx
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$3,	%r11
	call	Btag
	addq	$8,	%rsp
	popq	%r11
	popq	%r10
	popq	%rdi
	movq	%rax,	%r12
# CJMP ("nz", "L45")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L45
# LABEL ("L46")

L46:

# DROP

# JMP ("L44")

	jmp	L44
# LABEL ("L45")

L45:

# DROP

# DROP

# SLABEL ("L49")

L49:

# CONST (0)

	movq	$1,	%r10
# SLABEL ("L50")

L50:

# JMP ("L39")

	jmp	L39
# SLABEL ("L48")

L48:

# SLABEL ("L54")

L54:

# LABEL ("L44")

L44:

# DUP

	movq	%r10,	%r11
# DUP

	movq	%r11,	%r12
# TAG ("Cons", 2)

	movq	$15329063,	%r13
	movq	$5,	%r14
	pushq	%rdi
	pushq	%r10
	pushq	%r11
	pushq	filler(%rip)
	movq	%r14,	%rdx
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$3,	%r11
	call	Btag
	addq	$8,	%rsp
	popq	%r11
	popq	%r10
	popq	%rdi
	movq	%rax,	%r12
# CJMP ("nz", "L52")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L52
# LABEL ("L53")

L53:

# DROP

# JMP ("L42")

	jmp	L42
# LABEL ("L52")

L52:

# DUP

	movq	%r11,	%r12
# CONST (0)

	movq	$1,	%r13
# ELEM

	pushq	%rdi
	pushq	%r10
	pushq	%r11
	pushq	filler(%rip)
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	addq	$8,	%rsp
	popq	%r11
	popq	%r10
	popq	%rdi
	movq	%rax,	%r12
# DROP

# DUP

	movq	%r11,	%r12
# CONST (1)

	movq	$3,	%r13
# ELEM

	pushq	%rdi
	pushq	%r10
	pushq	%r11
	pushq	filler(%rip)
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	addq	$8,	%rsp
	popq	%r11
	popq	%r10
	popq	%rdi
	movq	%rax,	%r12
# DROP

# DROP

# DUP

	movq	%r10,	%r11
# CONST (0)

	movq	$1,	%r12
# ELEM

	pushq	%rdi
	pushq	%r10
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r10
	popq	%rdi
	movq	%rax,	%r11
# ST (Local (1))

	movq	%r11,	-16(%rbp)
# DROP

# DUP

	movq	%r10,	%r11
# CONST (1)

	movq	$3,	%r12
# ELEM

	pushq	%rdi
	pushq	%r10
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r10
	popq	%rdi
	movq	%rax,	%r11
# ST (Local (0))

	movq	%r11,	-8(%rbp)
# DROP

# DROP

# SLABEL ("L56")

L56:

# LINE (13)

	.stabn 68,0,13,.L9-LprintList

.L9:

# LD (Local (1))

	movq	-16(%rbp),	%r10
# CALL ("Lwrite", 1, false)

	pushq	%rdi
	pushq	filler(%rip)
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	addq	$8,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LD (Local (0))

	movq	-8(%rbp),	%r10
# CALL ("LprintList", 1, true)

	movq	%r10,	%rdi
	movq	%rbp,	%rsp
	popq	%rbp
	movq	$1,	%r11
	jmp	LprintList
# SLABEL ("L57")

L57:

# SLABEL ("L55")

L55:

# JMP ("L39")

	jmp	L39
# LABEL ("L42")

L42:

# FAIL ((11, 9), true)

	movq	$19,	%r14
	movq	$23,	%r13
	leaq	string_2(%rip),	%r12
	movq	%r10,	%r11
	pushq	%rdi
	pushq	%r10
	movq	%r14,	%rcx
	movq	%r13,	%rdx
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$4,	%r11
	call	Bmatch_failure
	popq	%r10
	popq	%rdi
	movq	%rax,	%r11
# JMP ("L39")

	jmp	L39
# SLABEL ("L41")

L41:

# LABEL ("L39")

L39:

# SLABEL ("L38")

L38:

# END

	movq	%r10,	%rax
LLprintList_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLprintList_SIZE,	16

	.set	LSLprintList_SIZE,	2

	.size LprintList, .-LprintList

# LABEL ("Lappend")

Lappend:

# BEGIN ("Lappend", 2, 2, [], ["x"; "y"], [{ blab="L62"; elab="L63"; names=[]; subs=[{ blab="L65"; elab="L66"; names=[]; subs=[{ blab="L78"; elab="L79"; names=[("h", 1); ("t", 0)]; subs=[{ blab="L80"; elab="L81"; names=[]; subs=[]; }]; }; { blab="L72"; elab="L73"; names=[]; subs=[{ blab="L74"; elab="L75"; names=[]; subs=[]; }]; }]; }]; }])

	.type append, @function

	.stabs "append:F1",36,0,0,Lappend

	.stabs "h:1",128,0,0,-16

	.stabs "t:1",128,0,0,-8

	.stabn 192,0,0,L78-Lappend

	.stabn 224,0,0,L79-Lappend

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLappend_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLappend_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$2,	%r11
	je	Lappend_argc_correct
	movq	%r11,	%r13
	movq	$2,	%r12
	leaq	string_3(%rip),	%r11
	leaq	string_0(%rip),	%r10
	pushq	%rdi
	pushq	filler(%rip)
	movq	%r13,	%rcx
	movq	%r12,	%rdx
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$4,	%r11
	call	failure
	addq	$8,	%rsp
	popq	%rdi
	movq	%rax,	%r10
Lappend_argc_correct:

# SLABEL ("L62")

L62:

# SLABEL ("L65")

L65:

# LINE (4)

	.stabn 68,0,4,0

	.stabn 68,0,4,.L10-Lappend

.L10:

# LD (Arg (0))

	movq	%rdi,	%r10
# DUP

	movq	%r10,	%r11
# SLABEL ("L72")

L72:

# DUP

	movq	%r11,	%r12
# TAG ("Nil", 0)

	movq	$328857,	%r13
	movq	$1,	%r14
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r14,	%rdx
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$3,	%r11
	call	Btag
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CJMP ("nz", "L70")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L70
# LABEL ("L71")

L71:

# DROP

# JMP ("L69")

	jmp	L69
# LABEL ("L70")

L70:

# DROP

# DROP

# SLABEL ("L74")

L74:

# LINE (5)

	.stabn 68,0,5,.L11-Lappend

.L11:

# LD (Arg (1))

	movq	%rsi,	%r10
# SLABEL ("L75")

L75:

# JMP ("L64")

	jmp	L64
# SLABEL ("L73")

L73:

# SLABEL ("L78")

L78:

# LABEL ("L69")

L69:

# DUP

	movq	%r10,	%r11
# DUP

	movq	%r11,	%r12
# TAG ("Cons", 2)

	movq	$15329063,	%r13
	movq	$5,	%r14
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r14,	%rdx
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$3,	%r11
	call	Btag
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CJMP ("nz", "L76")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L76
# LABEL ("L77")

L77:

# DROP

# JMP ("L67")

	jmp	L67
# LABEL ("L76")

L76:

# DUP

	movq	%r11,	%r12
# CONST (0)

	movq	$1,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# DROP

# DUP

	movq	%r11,	%r12
# CONST (1)

	movq	$3,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# DROP

# DROP

# DUP

	movq	%r10,	%r11
# CONST (0)

	movq	$1,	%r12
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$2,	%r11
	call	Belem
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# ST (Local (1))

	movq	%r11,	-16(%rbp)
# DROP

# DUP

	movq	%r10,	%r11
# CONST (1)

	movq	$3,	%r12
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$2,	%r11
	call	Belem
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# ST (Local (0))

	movq	%r11,	-8(%rbp)
# DROP

# DROP

# SLABEL ("L80")

L80:

# LINE (6)

	.stabn 68,0,6,.L12-Lappend

.L12:

# LD (Local (1))

	movq	-16(%rbp),	%r10
# LD (Local (0))

	movq	-8(%rbp),	%r11
# LD (Arg (1))

	movq	%rsi,	%r12
# CALL ("Lappend", 2, false)

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$2,	%r11
	call	Lappend
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# SEXP ("Cons", 2)

	movq	$15329063,	%r12
	pushq	%rdi
	pushq	%rsi
	pushq	filler(%rip)
	pushq	%r12
	pushq	%r11
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$7,	%rsi
	call	Bsexp
	addq	$32,	%rsp
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# SLABEL ("L81")

L81:

# SLABEL ("L79")

L79:

# JMP ("L64")

	jmp	L64
# LABEL ("L67")

L67:

# FAIL ((4, 9), true)

	movq	$19,	%r14
	movq	$9,	%r13
	leaq	string_2(%rip),	%r12
	movq	%r10,	%r11
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r14,	%rcx
	movq	%r13,	%rdx
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$4,	%r11
	call	Bmatch_failure
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# JMP ("L64")

	jmp	L64
# SLABEL ("L66")

L66:

# LABEL ("L64")

L64:

# SLABEL ("L63")

L63:

# END

	movq	%r10,	%rax
LLappend_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLappend_SIZE,	16

	.set	LSLappend_SIZE,	2

	.size Lappend, .-Lappend


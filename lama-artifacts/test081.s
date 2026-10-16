	.file "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test081/test081.lama"

	.stabs "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test081/test081.lama",100,0,0,.Ltext

	.globl	main

	.data

string_1:	.string	"Function %s called with incorrect arguments count. Expected: %d. Actual: %d\n"

string_2:	.string	"printList"

string_0:	.string	"test081.lama"

string_3:	.string	"unzip"

string_4:	.string	"zip"

init:	.quad 0

	.section custom_data,"aw",@progbits

filler:	.fill	6, 8, 1

	.stabs "x:S1",40,0,0,global_x

global_x:	.quad	1

	.stabs "y:S1",40,0,0,global_y

global_y:	.quad	1

	.stabs "z:S1",40,0,0,global_z

global_z:	.quad	1

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

# BEGIN ("main", 2, 2, [], [], [])

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

# LINE (32)

	.stabn 68,0,32,.L0

.L0:

# CALL ("Lread", 0, false)

	pushq	%rdi
	pushq	%rsi
	movq	$0,	%r11
	call	Lread
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# LINE (30)

	.stabn 68,0,30,.L1

.L1:

# ST (Global ("z"))

	movq	%r10,	global_z(%rip)
# DROP

# CONST (1)

	movq	$3,	%r10
# CONST (2)

	movq	$5,	%r11
# CONST (3)

	movq	$7,	%r12
# SEXP ("Nil", 0)

	movq	$328857,	%r13
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	pushq	%r12
	pushq	%r13
	movq	%rsp,	%rdi
	movq	$3,	%rsi
	call	Bsexp
	addq	$8,	%rsp
	popq	%r12
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r13
# SEXP ("Cons", 2)

	movq	$15329063,	%r14
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	pushq	filler(%rip)
	pushq	%r14
	pushq	%r13
	pushq	%r12
	movq	%rsp,	%rdi
	movq	$7,	%rsi
	call	Bsexp
	addq	$32,	%rsp
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

# CONST (100)

	movq	$201,	%r10
# CONST (200)

	movq	$401,	%r11
# CONST (300)

	movq	$601,	%r12
# SEXP ("Nil", 0)

	movq	$328857,	%r13
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	pushq	%r12
	pushq	%r13
	movq	%rsp,	%rdi
	movq	$3,	%rsi
	call	Bsexp
	addq	$8,	%rsp
	popq	%r12
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r13
# SEXP ("Cons", 2)

	movq	$15329063,	%r14
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	pushq	filler(%rip)
	pushq	%r14
	pushq	%r13
	pushq	%r12
	movq	%rsp,	%rdi
	movq	$7,	%rsi
	call	Bsexp
	addq	$32,	%rsp
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
# LINE (34)

	.stabn 68,0,34,.L2

.L2:

# ST (Global ("y"))

	movq	%r10,	global_y(%rip)
# DROP

# LINE (37)

	.stabn 68,0,37,.L3

.L3:

# LD (Global ("x"))

	movq	global_x(%rip),	%r10
# LD (Global ("y"))

	movq	global_y(%rip),	%r11
# SEXP ("Pair", 2)

	movq	$22029477,	%r12
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
# CALL ("Lzip", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lzip
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# CALL ("Lunzip", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lunzip
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DUP

	movq	%r10,	%r11
# SLABEL ("L35")

L35:

# DUP

	movq	%r11,	%r12
# TAG ("Pair", 2)

	movq	$22029477,	%r13
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
# CJMP ("nz", "L33")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L33
# LABEL ("L34")

L34:

# DROP

# JMP ("L27")

	jmp	L27
# LABEL ("L33")

L33:

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

# SLABEL ("L37")

L37:

# LINE (38)

	.stabn 68,0,38,.L4

.L4:

# LD (Local (1))

	movq	-16(%rbp),	%r10
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

# LD (Local (0))

	movq	-8(%rbp),	%r10
# CALL ("LprintList", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	LprintList
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# SLABEL ("L38")

L38:

# SLABEL ("L36")

L36:

# JMP ("L0")

	jmp	L0
# LABEL ("L27")

L27:

# FAIL ((37, 5), true)

	movq	$11,	%r14
	movq	$75,	%r13
	leaq	string_0(%rip),	%r12
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
# JMP ("L0")

	jmp	L0
# SLABEL ("L2")

L2:

# LABEL ("L0")

L0:

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

	.set	Lmain_SIZE,	16

	.set	LSmain_SIZE,	2

	.size main, .-main

# LABEL ("LprintList")

LprintList:

# BEGIN ("LprintList", 1, 2, [], ["l"], [{ blab="L43"; elab="L44"; names=[]; subs=[{ blab="L46"; elab="L47"; names=[]; subs=[{ blab="L60"; elab="L61"; names=[("x", 1); ("xs", 0)]; subs=[{ blab="L62"; elab="L63"; names=[]; subs=[]; }]; }; { blab="L53"; elab="L54"; names=[]; subs=[{ blab="L55"; elab="L56"; names=[]; subs=[]; }]; }]; }]; }])

	.type printList, @function

	.stabs "printList:F1",36,0,0,LprintList

	.stabs "x:1",128,0,0,-16

	.stabs "xs:1",128,0,0,-8

	.stabn 192,0,0,L60-LprintList

	.stabn 224,0,0,L61-LprintList

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
	leaq	string_2(%rip),	%r11
	leaq	string_1(%rip),	%r10
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

# SLABEL ("L43")

L43:

# SLABEL ("L46")

L46:

# LINE (26)

	.stabn 68,0,26,0

	.stabn 68,0,26,.L5-LprintList

.L5:

# LD (Arg (0))

	movq	%rdi,	%r10
# DUP

	movq	%r10,	%r11
# SLABEL ("L53")

L53:

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
# CJMP ("nz", "L51")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L51
# LABEL ("L52")

L52:

# DROP

# JMP ("L50")

	jmp	L50
# LABEL ("L51")

L51:

# DROP

# DROP

# SLABEL ("L55")

L55:

# CONST (0)

	movq	$1,	%r10
# SLABEL ("L56")

L56:

# JMP ("L45")

	jmp	L45
# SLABEL ("L54")

L54:

# SLABEL ("L60")

L60:

# LABEL ("L50")

L50:

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
# CJMP ("nz", "L58")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L58
# LABEL ("L59")

L59:

# DROP

# JMP ("L48")

	jmp	L48
# LABEL ("L58")

L58:

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

# SLABEL ("L62")

L62:

# LINE (28)

	.stabn 68,0,28,.L6-LprintList

.L6:

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
# SLABEL ("L63")

L63:

# SLABEL ("L61")

L61:

# JMP ("L45")

	jmp	L45
# LABEL ("L48")

L48:

# FAIL ((26, 7), true)

	movq	$15,	%r14
	movq	$53,	%r13
	leaq	string_0(%rip),	%r12
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
# JMP ("L45")

	jmp	L45
# SLABEL ("L47")

L47:

# LABEL ("L45")

L45:

# SLABEL ("L44")

L44:

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

# LABEL ("Lunzip")

Lunzip:

# BEGIN ("Lunzip", 1, 5, [], ["x"], [{ blab="L68"; elab="L69"; names=[]; subs=[{ blab="L71"; elab="L72"; names=[]; subs=[{ blab="L90"; elab="L91"; names=[("x", 2); ("y", 1); ("tl", 0)]; subs=[{ blab="L92"; elab="L93"; names=[]; subs=[{ blab="L99"; elab="L100"; names=[("xs", 4); ("ys", 3)]; subs=[{ blab="L101"; elab="L102"; names=[]; subs=[]; }]; }]; }]; }; { blab="L78"; elab="L79"; names=[]; subs=[{ blab="L80"; elab="L81"; names=[]; subs=[]; }]; }]; }]; }])

	.type unzip, @function

	.stabs "unzip:F1",36,0,0,Lunzip

	.stabs "x:1",128,0,0,-24

	.stabs "y:1",128,0,0,-16

	.stabs "tl:1",128,0,0,-8

	.stabn 192,0,0,L90-Lunzip

	.stabs "xs:1",128,0,0,-40

	.stabs "ys:1",128,0,0,-32

	.stabn 192,0,0,L99-Lunzip

	.stabn 224,0,0,L100-Lunzip

	.stabn 224,0,0,L91-Lunzip

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLunzip_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLunzip_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$1,	%r11
	je	Lunzip_argc_correct
	movq	%r11,	%r13
	movq	$1,	%r12
	leaq	string_3(%rip),	%r11
	leaq	string_1(%rip),	%r10
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
Lunzip_argc_correct:

# SLABEL ("L68")

L68:

# SLABEL ("L71")

L71:

# LINE (16)

	.stabn 68,0,16,0

	.stabn 68,0,16,.L7-Lunzip

.L7:

# LD (Arg (0))

	movq	%rdi,	%r10
# DUP

	movq	%r10,	%r11
# SLABEL ("L78")

L78:

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
# CJMP ("nz", "L76")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L76
# LABEL ("L77")

L77:

# DROP

# JMP ("L75")

	jmp	L75
# LABEL ("L76")

L76:

# DROP

# DROP

# SLABEL ("L80")

L80:

# SEXP ("Nil", 0)

	movq	$328857,	%r10
	pushq	%rdi
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$3,	%rsi
	call	Bsexp
	addq	$8,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# SEXP ("Nil", 0)

	movq	$328857,	%r11
	pushq	%rdi
	pushq	%r10
	pushq	filler(%rip)
	pushq	%r11
	movq	%rsp,	%rdi
	movq	$3,	%rsi
	call	Bsexp
	addq	$16,	%rsp
	popq	%r10
	popq	%rdi
	movq	%rax,	%r11
# SEXP ("Pair", 2)

	movq	$22029477,	%r12
	pushq	%rdi
	pushq	%r12
	pushq	%r11
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$7,	%rsi
	call	Bsexp
	addq	$24,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# SLABEL ("L81")

L81:

# JMP ("L70")

	jmp	L70
# SLABEL ("L79")

L79:

# SLABEL ("L90")

L90:

# LABEL ("L75")

L75:

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
# CJMP ("nz", "L86")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L86
# LABEL ("L87")

L87:

# DROP

# JMP ("L73")

	jmp	L73
# LABEL ("L86")

L86:

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
# DUP

	movq	%r12,	%r13
# TAG ("Pair", 2)

	movq	$22029477,	%r14
	movq	$5,	-48(%rbp)
	pushq	%rdi
	pushq	%r10
	pushq	%r11
	pushq	%r12
	movq	-48(%rbp),	%rdx
	movq	%r14,	%rsi
	movq	%r13,	%rdi
	movq	$3,	%r11
	call	Btag
	popq	%r12
	popq	%r11
	popq	%r10
	popq	%rdi
	movq	%rax,	%r13
# CJMP ("nz", "L88")

	sarq	%r13
	cmpq	$0,	%r13
	jnz	L88
# LABEL ("L89")

L89:

# DROP

# JMP ("L87")

	jmp	L87
# LABEL ("L88")

L88:

# DUP

	movq	%r12,	%r13
# CONST (0)

	movq	$1,	%r14
# ELEM

	pushq	%rdi
	pushq	%r10
	pushq	%r11
	pushq	%r12
	movq	%r14,	%rsi
	movq	%r13,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r12
	popq	%r11
	popq	%r10
	popq	%rdi
	movq	%rax,	%r13
# DROP

# DUP

	movq	%r12,	%r13
# CONST (1)

	movq	$3,	%r14
# ELEM

	pushq	%rdi
	pushq	%r10
	pushq	%r11
	pushq	%r12
	movq	%r14,	%rsi
	movq	%r13,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r12
	popq	%r11
	popq	%r10
	popq	%rdi
	movq	%rax,	%r13
# DROP

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
# ST (Local (2))

	movq	%r11,	-24(%rbp)
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

# SLABEL ("L92")

L92:

# LINE (19)

	.stabn 68,0,19,.L8-Lunzip

.L8:

# LD (Local (0))

	movq	-8(%rbp),	%r10
# CALL ("Lunzip", 1, false)

	pushq	%rdi
	pushq	filler(%rip)
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lunzip
	addq	$8,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# DUP

	movq	%r10,	%r11
# SLABEL ("L99")

L99:

# DUP

	movq	%r11,	%r12
# TAG ("Pair", 2)

	movq	$22029477,	%r13
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
# CJMP ("nz", "L97")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L97
# LABEL ("L98")

L98:

# DROP

# JMP ("L94")

	jmp	L94
# LABEL ("L97")

L97:

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
# ST (Local (4))

	movq	%r11,	-40(%rbp)
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
# ST (Local (3))

	movq	%r11,	-32(%rbp)
# DROP

# DROP

# SLABEL ("L101")

L101:

# LINE (20)

	.stabn 68,0,20,.L9-Lunzip

.L9:

# LD (Local (2))

	movq	-24(%rbp),	%r10
# LD (Local (4))

	movq	-40(%rbp),	%r11
# SEXP ("Cons", 2)

	movq	$15329063,	%r12
	pushq	%rdi
	pushq	%r12
	pushq	%r11
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$7,	%rsi
	call	Bsexp
	addq	$24,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# LD (Local (1))

	movq	-16(%rbp),	%r11
# LD (Local (3))

	movq	-32(%rbp),	%r12
# SEXP ("Cons", 2)

	movq	$15329063,	%r13
	pushq	%rdi
	pushq	%r10
	pushq	filler(%rip)
	pushq	%r13
	pushq	%r12
	pushq	%r11
	movq	%rsp,	%rdi
	movq	$7,	%rsi
	call	Bsexp
	addq	$32,	%rsp
	popq	%r10
	popq	%rdi
	movq	%rax,	%r11
# SEXP ("Pair", 2)

	movq	$22029477,	%r12
	pushq	%rdi
	pushq	%r12
	pushq	%r11
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$7,	%rsi
	call	Bsexp
	addq	$24,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# SLABEL ("L102")

L102:

# SLABEL ("L100")

L100:

# JMP ("L70")

	jmp	L70
# LABEL ("L94")

L94:

# FAIL ((19, 12), true)

	movq	$25,	%r14
	movq	$39,	%r13
	leaq	string_0(%rip),	%r12
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
# JMP ("L70")

	jmp	L70
# SLABEL ("L93")

L93:

# SLABEL ("L91")

L91:

# JMP ("L70")

# LABEL ("L73")

L73:

# FAIL ((16, 7), true)

	movq	$15,	%r14
	movq	$33,	%r13
	leaq	string_0(%rip),	%r12
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
# JMP ("L70")

	jmp	L70
# SLABEL ("L72")

L72:

# LABEL ("L70")

L70:

# SLABEL ("L69")

L69:

# END

	movq	%r10,	%rax
LLunzip_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLunzip_SIZE,	48

	.set	LSLunzip_SIZE,	6

	.size Lunzip, .-Lunzip

# LABEL ("Lzip")

Lzip:

# BEGIN ("Lzip", 1, 6, [], ["x"], [{ blab="L109"; elab="L110"; names=[]; subs=[{ blab="L112"; elab="L113"; names=[]; subs=[{ blab="L118"; elab="L119"; names=[("x", 1); ("y", 0)]; subs=[{ blab="L120"; elab="L121"; names=[]; subs=[{ blab="L134"; elab="L135"; names=[("x", 3); ("xs", 2)]; subs=[{ blab="L136"; elab="L137"; names=[]; subs=[{ blab="L150"; elab="L151"; names=[("y", 5); ("ys", 4)]; subs=[{ blab="L152"; elab="L153"; names=[]; subs=[]; }]; }; { blab="L143"; elab="L144"; names=[]; subs=[{ blab="L145"; elab="L146"; names=[]; subs=[]; }]; }]; }]; }; { blab="L127"; elab="L128"; names=[]; subs=[{ blab="L129"; elab="L130"; names=[]; subs=[]; }]; }]; }]; }]; }]; }])

	.type zip, @function

	.stabs "zip:F1",36,0,0,Lzip

	.stabs "x:1",128,0,0,-16

	.stabs "y:1",128,0,0,-8

	.stabn 192,0,0,L118-Lzip

	.stabs "x:1",128,0,0,-32

	.stabs "xs:1",128,0,0,-24

	.stabn 192,0,0,L134-Lzip

	.stabs "y:1",128,0,0,-48

	.stabs "ys:1",128,0,0,-40

	.stabn 192,0,0,L150-Lzip

	.stabn 224,0,0,L151-Lzip

	.stabn 224,0,0,L135-Lzip

	.stabn 224,0,0,L119-Lzip

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLzip_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLzip_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$1,	%r11
	je	Lzip_argc_correct
	movq	%r11,	%r13
	movq	$1,	%r12
	leaq	string_4(%rip),	%r11
	leaq	string_1(%rip),	%r10
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
Lzip_argc_correct:

# SLABEL ("L109")

L109:

# SLABEL ("L112")

L112:

# LINE (4)

	.stabn 68,0,4,0

	.stabn 68,0,4,.L10-Lzip

.L10:

# LD (Arg (0))

	movq	%rdi,	%r10
# DUP

	movq	%r10,	%r11
# SLABEL ("L118")

L118:

# DUP

	movq	%r11,	%r12
# TAG ("Pair", 2)

	movq	$22029477,	%r13
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
# CJMP ("nz", "L116")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L116
# LABEL ("L117")

L117:

# DROP

# JMP ("L114")

	jmp	L114
# LABEL ("L116")

L116:

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

# SLABEL ("L120")

L120:

# LINE (5)

	.stabn 68,0,5,.L11-Lzip

.L11:

# LD (Local (1))

	movq	-16(%rbp),	%r10
# DUP

	movq	%r10,	%r11
# SLABEL ("L127")

L127:

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
# CJMP ("nz", "L125")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L125
# LABEL ("L126")

L126:

# DROP

# JMP ("L124")

	jmp	L124
# LABEL ("L125")

L125:

# DROP

# DROP

# SLABEL ("L129")

L129:

# SEXP ("Nil", 0)

	movq	$328857,	%r10
	pushq	%rdi
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$3,	%rsi
	call	Bsexp
	addq	$8,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# SLABEL ("L130")

L130:

# JMP ("L111")

	jmp	L111
# SLABEL ("L128")

L128:

# SLABEL ("L134")

L134:

# LABEL ("L124")

L124:

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
# CJMP ("nz", "L132")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L132
# LABEL ("L133")

L133:

# DROP

# JMP ("L122")

	jmp	L122
# LABEL ("L132")

L132:

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
# ST (Local (3))

	movq	%r11,	-32(%rbp)
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
# ST (Local (2))

	movq	%r11,	-24(%rbp)
# DROP

# DROP

# SLABEL ("L136")

L136:

# LINE (7)

	.stabn 68,0,7,.L12-Lzip

.L12:

# LD (Local (0))

	movq	-8(%rbp),	%r10
# DUP

	movq	%r10,	%r11
# SLABEL ("L143")

L143:

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
# CJMP ("nz", "L141")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L141
# LABEL ("L142")

L142:

# DROP

# JMP ("L140")

	jmp	L140
# LABEL ("L141")

L141:

# DROP

# DROP

# SLABEL ("L145")

L145:

# SEXP ("Nil", 0)

	movq	$328857,	%r10
	pushq	%rdi
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$3,	%rsi
	call	Bsexp
	addq	$8,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# SLABEL ("L146")

L146:

# JMP ("L111")

	jmp	L111
# SLABEL ("L144")

L144:

# SLABEL ("L150")

L150:

# LABEL ("L140")

L140:

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
# CJMP ("nz", "L148")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L148
# LABEL ("L149")

L149:

# DROP

# JMP ("L138")

	jmp	L138
# LABEL ("L148")

L148:

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
# ST (Local (5))

	movq	%r11,	-48(%rbp)
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
# ST (Local (4))

	movq	%r11,	-40(%rbp)
# DROP

# DROP

# SLABEL ("L152")

L152:

# LINE (9)

	.stabn 68,0,9,.L13-Lzip

.L13:

# LD (Local (3))

	movq	-32(%rbp),	%r10
# LD (Local (5))

	movq	-48(%rbp),	%r11
# SEXP ("Pair", 2)

	movq	$22029477,	%r12
	pushq	%rdi
	pushq	%r12
	pushq	%r11
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$7,	%rsi
	call	Bsexp
	addq	$24,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# LD (Local (2))

	movq	-24(%rbp),	%r11
# LD (Local (4))

	movq	-40(%rbp),	%r12
# SEXP ("Pair", 2)

	movq	$22029477,	%r13
	pushq	%rdi
	pushq	%r10
	pushq	filler(%rip)
	pushq	%r13
	pushq	%r12
	pushq	%r11
	movq	%rsp,	%rdi
	movq	$7,	%rsi
	call	Bsexp
	addq	$32,	%rsp
	popq	%r10
	popq	%rdi
	movq	%rax,	%r11
# CALL ("Lzip", 1, false)

	pushq	%rdi
	pushq	%r10
	movq	%r11,	%rdi
	movq	$1,	%r11
	call	Lzip
	popq	%r10
	popq	%rdi
	movq	%rax,	%r11
# SEXP ("Cons", 2)

	movq	$15329063,	%r12
	pushq	%rdi
	pushq	%r12
	pushq	%r11
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$7,	%rsi
	call	Bsexp
	addq	$24,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# SLABEL ("L153")

L153:

# SLABEL ("L151")

L151:

# JMP ("L111")

	jmp	L111
# LABEL ("L138")

L138:

# FAIL ((7, 27), true)

	movq	$55,	%r14
	movq	$15,	%r13
	leaq	string_0(%rip),	%r12
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
# JMP ("L111")

	jmp	L111
# SLABEL ("L137")

L137:

# SLABEL ("L135")

L135:

# JMP ("L111")

# LABEL ("L122")

L122:

# FAIL ((5, 9), true)

	movq	$19,	%r14
	movq	$11,	%r13
	leaq	string_0(%rip),	%r12
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
# JMP ("L111")

	jmp	L111
# SLABEL ("L121")

L121:

# SLABEL ("L119")

L119:

# JMP ("L111")

# LABEL ("L114")

L114:

# FAIL ((4, 7), true)

	movq	$15,	%r14
	movq	$9,	%r13
	leaq	string_0(%rip),	%r12
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
# JMP ("L111")

	jmp	L111
# SLABEL ("L113")

L113:

# LABEL ("L111")

L111:

# SLABEL ("L110")

L110:

# END

	movq	%r10,	%rax
LLzip_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLzip_SIZE,	48

	.set	LSLzip_SIZE,	6

	.size Lzip, .-Lzip


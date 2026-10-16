	.file "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test094/test094.lama"

	.stabs "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test094/test094.lama",100,0,0,.Ltext

	.globl	main

	.data

string_0:	.string	"Function %s called with incorrect arguments count. Expected: %d. Actual: %d\n"

string_1:	.string	"a"

string_2:	.string	"lambda_0_4"

init:	.quad 0

	.section custom_data,"aw",@progbits

filler:	.fill	3, 8, 1

	.stabs "x:S1",40,0,0,global_x

global_x:	.quad	1

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

# CALL ("Lread", 0, false)

	pushq	%rdi
	pushq	%rsi
	movq	$0,	%r11
	call	Lread
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# LINE (20)

	.stabn 68,0,20,.L0

.L0:

# ST (Global ("x"))

	movq	%r10,	global_x(%rip)
# DROP

# CONST (5)

	movq	$11,	%r10
# CONST (7)

	movq	$15,	%r11
# CALL ("La", 2, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$2,	%r11
	call	La
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# CALLC (0, false)

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r10,	%r15
	movq	$0,	%r11
	call	*(%r15)
	addq	$8,	%rsp
	popq	%r10
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

# LABEL ("La")

La:

# BEGIN ("La", 2, 3, [], ["x"; "y"], [{ blab="L10"; elab="L11"; names=[]; subs=[{ blab="L13"; elab="L14"; names=[("a", 1); ("b", 0)]; subs=[{ blab="L25"; elab="L26"; names=[("f", 2)]; subs=[]; }]; }]; }])

	.type a, @function

	.stabs "a:F1",36,0,0,La

	.stabs "a:1",128,0,0,-16

	.stabs "b:1",128,0,0,-8

	.stabn 192,0,0,L13-La

	.stabs "f:1",128,0,0,-24

	.stabn 192,0,0,L25-La

	.stabn 224,0,0,L26-La

	.stabn 224,0,0,L14-La

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLa_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLa_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$2,	%r11
	je	La_argc_correct
	movq	%r11,	%r13
	movq	$2,	%r12
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
La_argc_correct:

# SLABEL ("L10")

L10:

# SLABEL ("L13")

L13:

# LD (Arg (0))

	movq	%rdi,	%r10
# LD (Arg (1))

	movq	%rsi,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# LINE (2)

	.stabn 68,0,2,0

	.stabn 68,0,2,.L1-La

.L1:

# ST (Local (1))

	movq	%r10,	-16(%rbp)
# DROP

# LD (Arg (0))

	movq	%rdi,	%r10
# LD (Arg (1))

	movq	%rsi,	%r11
# BINOP ("-")

	subq	%r11,	%r10
	orq	$0x0001,	%r10
# ST (Local (0))

	movq	%r10,	-8(%rbp)
# DROP

# SLABEL ("L25")

L25:

# CLOSURE ("Llambda_0_4", [Arg (0); Arg (1); Local (1); Local (0)])

	movq	-8(%rbp),	%r14
	movq	-16(%rbp),	%r13
	movq	%rsi,	%r12
	movq	%rdi,	%r11
	leaq	Llambda_0_4(%rip),	%r10
	pushq	%rdi
	pushq	%rsi
	pushq	filler(%rip)
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r11
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$9,	%rsi
	call	Bclosure
	addq	$48,	%rsp
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# LINE (4)

	.stabn 68,0,4,.L2-La

.L2:

# ST (Local (2))

	movq	%r10,	-24(%rbp)
# DROP

# CONST (100)

	movq	$201,	%r10
# LINE (9)

	.stabn 68,0,9,.L3-La

.L3:

# ST (Local (1))

	movq	%r10,	-16(%rbp)
# DROP

# CONST (200)

	movq	$401,	%r10
# LINE (11)

	.stabn 68,0,11,.L4-La

.L4:

# ST (Local (0))

	movq	%r10,	-8(%rbp)
# DROP

# CONST (800)

	movq	$1601,	%r10
# LINE (12)

	.stabn 68,0,12,.L5-La

.L5:

# ST (Arg (0))

	movq	%r10,	%rdi
# DROP

# CONST (1000)

	movq	$2001,	%r10
# LINE (13)

	.stabn 68,0,13,.L6-La

.L6:

# ST (Arg (1))

	movq	%r10,	%rsi
# DROP

# LINE (14)

	.stabn 68,0,14,.L7-La

.L7:

# LD (Local (2))

	movq	-24(%rbp),	%r10
# SLABEL ("L26")

L26:

# SLABEL ("L14")

L14:

# LABEL ("L12")

L12:

# SLABEL ("L11")

L11:

# END

	movq	%r10,	%rax
LLa_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLa_SIZE,	32

	.set	LSLa_SIZE,	3

	.size La, .-La

# LABEL ("Llambda_0_4")

Llambda_0_4:

# BEGIN ("Llambda_0_4", 0, 0, [Arg (0); Arg (1); Local (1); Local (0)], [], [{ blab="L42"; elab="L43"; names=[]; subs=[{ blab="L45"; elab="L46"; names=[]; subs=[]; }]; }])

	.type lambda_0_4, @function

	.stabs "lambda_0_4:F1",36,0,0,Llambda_0_4

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLlambda_0_4_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLlambda_0_4_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$0,	%r11
	je	Llambda_0_4_argc_correct
	movq	%r11,	%r13
	movq	$0,	%r12
	leaq	string_2(%rip),	%r11
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
Llambda_0_4_argc_correct:

# SLABEL ("L42")

L42:

# SLABEL ("L45")

L45:

# LINE (4)

	.stabn 68,0,4,0

	.stabn 68,0,4,.L8-Llambda_0_4

.L8:

# LINE (5)

	.stabn 68,0,5,.L9-Llambda_0_4

.L9:

# LD (Access (0))

	movq	8(%r15),	%r10
# CALL ("Lwrite", 1, false)

	pushq	%r15
	pushq	filler(%rip)
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	addq	$8,	%rsp
	popq	%r15
	movq	%rax,	%r10
# DROP

# LINE (6)

	.stabn 68,0,6,.L10-Llambda_0_4

.L10:

# LD (Access (1))

	movq	16(%r15),	%r10
# CALL ("Lwrite", 1, false)

	pushq	%r15
	pushq	filler(%rip)
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	addq	$8,	%rsp
	popq	%r15
	movq	%rax,	%r10
# DROP

# LINE (7)

	.stabn 68,0,7,.L11-Llambda_0_4

.L11:

# LD (Access (2))

	movq	24(%r15),	%r10
# CALL ("Lwrite", 1, false)

	pushq	%r15
	pushq	filler(%rip)
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	addq	$8,	%rsp
	popq	%r15
	movq	%rax,	%r10
# DROP

# LINE (8)

	.stabn 68,0,8,.L12-Llambda_0_4

.L12:

# LD (Access (3))

	movq	32(%r15),	%r10
# CALL ("Lwrite", 1, true)

	pushq	%r15
	pushq	filler(%rip)
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	addq	$8,	%rsp
	popq	%r15
	movq	%rax,	%r10
# SLABEL ("L46")

L46:

# LABEL ("L44")

L44:

# SLABEL ("L43")

L43:

# END

	movq	%r10,	%rax
LLlambda_0_4_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLlambda_0_4_SIZE,	0

	.set	LSLlambda_0_4_SIZE,	0

	.size Llambda_0_4, .-Llambda_0_4


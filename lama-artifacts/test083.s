	.file "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test083/test083.lama"

	.stabs "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test083/test083.lama",100,0,0,.Ltext

	.globl	main

	.data

string_0:	.string	"Function %s called with incorrect arguments count. Expected: %d. Actual: %d\n"

string_1:	.string	"test"

init:	.quad 0

	.section custom_data,"aw",@progbits

filler:	.fill	3, 8, 1

	.stabs "n:S1",40,0,0,global_n

global_n:	.quad	1

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

# LINE (10)

	.stabn 68,0,10,.L0

.L0:

# CALL ("Lread", 0, false)

	pushq	%rdi
	pushq	%rsi
	movq	$0,	%r11
	call	Lread
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# LINE (8)

	.stabn 68,0,8,.L1

.L1:

# ST (Global ("n"))

	movq	%r10,	global_n(%rip)
# DROP

# CONST (1)

	movq	$3,	%r10
# SLABEL ("L12")

L12:

# CONST (2)

	movq	$5,	%r11
# SLABEL ("L16")

L16:

# CONST (3)

	movq	$7,	%r12
# SLABEL ("L20")

L20:

# CONST (4)

	movq	$9,	%r13
# SLABEL ("L24")

L24:

# CONST (5)

	movq	$11,	%r14
# SLABEL ("L28")

L28:

# CONST (6)

	movq	$13,	-8(%rbp)
# LINE (11)

	.stabn 68,0,11,.L2

.L2:

# CONST (7)

	movq	$15,	-16(%rbp)
# CONST (7)

	movq	$15,	-24(%rbp)
# CALL ("Ltest", 2, false)

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	filler(%rip)
	movq	-24(%rbp),	%rsi
	movq	-16(%rbp),	%rdi
	movq	$2,	%r11
	call	Ltest
	addq	$8,	%rsp
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L29")

L29:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L25")

L25:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L21")

L21:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L17")

L17:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L13")

L13:

# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# ST (Global ("y"))

	movq	%r10,	global_y(%rip)
# DROP

# LINE (12)

	.stabn 68,0,12,.L3

.L3:

# LD (Global ("y"))

	movq	global_y(%rip),	%r10
# CALL ("Lwrite", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
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

	.set	Lmain_SIZE,	32

	.set	LSmain_SIZE,	3

	.size main, .-main

# LABEL ("Ltest")

Ltest:

# BEGIN ("Ltest", 2, 2, [], ["n"; "m"], [{ blab="L35"; elab="L36"; names=[]; subs=[{ blab="L38"; elab="L39"; names=[("i", 1); ("s", 0)]; subs=[]; }]; }])

	.type test, @function

	.stabs "test:F1",36,0,0,Ltest

	.stabs "i:1",128,0,0,-16

	.stabs "s:1",128,0,0,-8

	.stabn 192,0,0,L38-Ltest

	.stabn 224,0,0,L39-Ltest

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLtest_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLtest_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$2,	%r11
	je	Ltest_argc_correct
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
Ltest_argc_correct:

# SLABEL ("L35")

L35:

# SLABEL ("L38")

L38:

# LINE (4)

	.stabn 68,0,4,0

	.stabn 68,0,4,.L4-Ltest

.L4:

# LINE (5)

	.stabn 68,0,5,.L5-Ltest

.L5:

# LD (Arg (0))

	movq	%rdi,	%r10
# CALL ("Lwrite", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LINE (6)

	.stabn 68,0,6,.L6-Ltest

.L6:

# LD (Arg (1))

	movq	%rsi,	%r10
# CALL ("Lwrite", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LD (Arg (0))

	movq	%rdi,	%r10
# SLABEL ("L39")

L39:

# LABEL ("L37")

L37:

# SLABEL ("L36")

L36:

# END

	movq	%r10,	%rax
LLtest_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLtest_SIZE,	16

	.set	LSLtest_SIZE,	2

	.size Ltest, .-Ltest


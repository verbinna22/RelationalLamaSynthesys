	.file "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test027/test027.lama"

	.stabs "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test027/test027.lama",100,0,0,.Ltext

	.globl	main

	.data

string_0:	.string	"Function %s called with incorrect arguments count. Expected: %d. Actual: %d\n"

string_3:	.string	"print"

string_2:	.string	"test1"

string_1:	.string	"test2"

init:	.quad 0

	.section custom_data,"aw",@progbits

filler:	.fill	0, 8, 1

	.stabs "a:S1",40,0,0,global_a

global_a:	.quad	1

	.stabs "b:S1",40,0,0,global_b

global_b:	.quad	1

	.stabs "c:S1",40,0,0,global_c

global_c:	.quad	1

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

# LINE (26)

	.stabn 68,0,26,.L0

.L0:

# CALL ("Lread", 0, false)

	pushq	%rdi
	pushq	%rsi
	movq	$0,	%r11
	call	Lread
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# LINE (24)

	.stabn 68,0,24,.L1

.L1:

# ST (Global ("x"))

	movq	%r10,	global_x(%rip)
# DROP

# CONST (100)

	movq	$201,	%r10
# ST (Global ("a"))

	movq	%r10,	global_a(%rip)
# DROP

# CONST (200)

	movq	$401,	%r10
# LINE (28)

	.stabn 68,0,28,.L2

.L2:

# ST (Global ("b"))

	movq	%r10,	global_b(%rip)
# DROP

# CONST (300)

	movq	$601,	%r10
# LINE (29)

	.stabn 68,0,29,.L3

.L3:

# ST (Global ("c"))

	movq	%r10,	global_c(%rip)
# DROP

# LINE (30)

	.stabn 68,0,30,.L4

.L4:

# CONST (1)

	movq	$3,	%r10
# CALL ("Ltest1", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Ltest1
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

# LABEL ("Ltest2")

Ltest2:

# BEGIN ("Ltest2", 1, 0, [], ["b"], [{ blab="L17"; elab="L18"; names=[]; subs=[{ blab="L20"; elab="L21"; names=[]; subs=[]; }]; }])

	.type test2, @function

	.stabs "test2:F1",36,0,0,Ltest2

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLtest2_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLtest2_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$1,	%r11
	je	Ltest2_argc_correct
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
Ltest2_argc_correct:

# SLABEL ("L17")

L17:

# SLABEL ("L20")

L20:

# LINE (19)

	.stabn 68,0,19,0

	.stabn 68,0,19,.L5-Ltest2

.L5:

# LINE (20)

	.stabn 68,0,20,.L6-Ltest2

.L6:

# LD (Arg (0))

	movq	%rdi,	%r10
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

# CALL ("Lprint", 0, false)

	pushq	%rdi
	pushq	filler(%rip)
	movq	$0,	%r11
	call	Lprint
	addq	$8,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LINE (21)

	.stabn 68,0,21,.L7-Ltest2

.L7:

# LINE (22)

	.stabn 68,0,22,.L8-Ltest2

.L8:

# LD (Arg (0))

	movq	%rdi,	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# CALL ("Ltest1", 1, false)

	pushq	%rdi
	pushq	filler(%rip)
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Ltest1
	addq	$8,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# DROP

# CALL ("Lprint", 0, true)

	pushq	%rdi
	pushq	filler(%rip)
	movq	$0,	%r11
	call	Lprint
	addq	$8,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# SLABEL ("L21")

L21:

# LABEL ("L19")

L19:

# SLABEL ("L18")

L18:

# END

	movq	%r10,	%rax
LLtest2_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLtest2_SIZE,	0

	.set	LSLtest2_SIZE,	0

	.size Ltest2, .-Ltest2

# LABEL ("Ltest1")

Ltest1:

# BEGIN ("Ltest1", 1, 0, [], ["a"], [{ blab="L34"; elab="L35"; names=[]; subs=[{ blab="L37"; elab="L38"; names=[]; subs=[{ blab="L52"; elab="L53"; names=[]; subs=[]; }]; }]; }])

	.type test1, @function

	.stabs "test1:F1",36,0,0,Ltest1

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLtest1_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLtest1_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$1,	%r11
	je	Ltest1_argc_correct
	movq	%r11,	%r13
	movq	$1,	%r12
	leaq	string_2(%rip),	%r11
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
Ltest1_argc_correct:

# SLABEL ("L34")

L34:

# SLABEL ("L37")

L37:

# LINE (9)

	.stabn 68,0,9,0

	.stabn 68,0,9,.L9-Ltest1

.L9:

# LINE (10)

	.stabn 68,0,10,.L10-Ltest1

.L10:

# LD (Arg (0))

	movq	%rdi,	%r10
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

# CALL ("Lprint", 0, false)

	pushq	%rdi
	pushq	filler(%rip)
	movq	$0,	%r11
	call	Lprint
	addq	$8,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LINE (11)

	.stabn 68,0,11,.L11-Ltest1

.L11:

# LINE (12)

	.stabn 68,0,12,.L12-Ltest1

.L12:

# LD (Arg (0))

	movq	%rdi,	%r10
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

# LINE (13)

	.stabn 68,0,13,.L13-Ltest1

.L13:

# LD (Arg (0))

	movq	%rdi,	%r10
# CONST (4)

	movq	$9,	%r11
# BINOP ("<")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setl	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("z", "L49")

	sarq	%r10
	cmpq	$0,	%r10
	jz	L49
# SLABEL ("L52")

L52:

# LINE (14)

	.stabn 68,0,14,.L14-Ltest1

.L14:

# LD (Arg (0))

	movq	%rdi,	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# CALL ("Ltest2", 1, false)

	pushq	%rdi
	pushq	filler(%rip)
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Ltest2
	addq	$8,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# DROP

# CALL ("Lprint", 0, true)

	pushq	%rdi
	pushq	filler(%rip)
	movq	$0,	%r11
	call	Lprint
	addq	$8,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# SLABEL ("L53")

L53:

# JMP ("L36")

	jmp	L36
# LABEL ("L49")

L49:

# CONST (0)

	movq	$1,	%r10
# JMP ("L36")

	jmp	L36
# SLABEL ("L38")

L38:

# LABEL ("L36")

L36:

# SLABEL ("L35")

L35:

# END

	movq	%r10,	%rax
LLtest1_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLtest1_SIZE,	0

	.set	LSLtest1_SIZE,	0

	.size Ltest1, .-Ltest1

# LABEL ("Lprint")

Lprint:

# BEGIN ("Lprint", 0, 0, [], [], [{ blab="L61"; elab="L62"; names=[]; subs=[{ blab="L64"; elab="L65"; names=[]; subs=[]; }]; }])

	.type print, @function

	.stabs "print:F1",36,0,0,Lprint

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLprint_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLprint_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$0,	%r11
	je	Lprint_argc_correct
	movq	%r11,	%r13
	movq	$0,	%r12
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
Lprint_argc_correct:

# SLABEL ("L61")

L61:

# SLABEL ("L64")

L64:

# LINE (3)

	.stabn 68,0,3,0

	.stabn 68,0,3,.L15-Lprint

.L15:

# LINE (4)

	.stabn 68,0,4,.L16-Lprint

.L16:

# LD (Global ("a"))

	movq	global_a(%rip),	%r10
# CALL ("Lwrite", 1, false)

	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	movq	%rax,	%r10
# DROP

# LINE (5)

	.stabn 68,0,5,.L17-Lprint

.L17:

# LD (Global ("b"))

	movq	global_b(%rip),	%r10
# CALL ("Lwrite", 1, false)

	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	movq	%rax,	%r10
# DROP

# LINE (6)

	.stabn 68,0,6,.L18-Lprint

.L18:

# LD (Global ("c"))

	movq	global_c(%rip),	%r10
# CALL ("Lwrite", 1, true)

	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	movq	%rax,	%r10
# SLABEL ("L65")

L65:

# LABEL ("L63")

L63:

# SLABEL ("L62")

L62:

# END

	movq	%r10,	%rax
LLprint_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLprint_SIZE,	0

	.set	LSLprint_SIZE,	0

	.size Lprint, .-Lprint


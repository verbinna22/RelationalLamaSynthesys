	.file "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test099/test099.lama"

	.stabs "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test099/test099.lama",100,0,0,.Ltext

	.globl	main

	.data

string_0:	.string	"Function %s called with incorrect arguments count. Expected: %d. Actual: %d\n"

string_1:	.string	"lambda_0"

string_3:	.string	"lambda_1_5"

string_2:	.string	"makeLazy"

init:	.quad 0

	.section custom_data,"aw",@progbits

filler:	.fill	2, 8, 1

	.stabs "l:S1",40,0,0,global_l

global_l:	.quad	1

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

# CLOSURE ("Llambda_0", [])

	leaq	Llambda_0(%rip),	%r10
	pushq	%rdi
	pushq	%rsi
	pushq	filler(%rip)
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$1,	%rsi
	call	Bclosure
	addq	$16,	%rsp
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# CALL ("LmakeLazy", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	LmakeLazy
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# LINE (15)

	.stabn 68,0,15,.L0

.L0:

# ST (Global ("l"))

	movq	%r10,	global_l(%rip)
# DROP

# CALL ("Lread", 0, false)

	pushq	%rdi
	pushq	%rsi
	movq	$0,	%r11
	call	Lread
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# LINE (16)

	.stabn 68,0,16,.L1

.L1:

# ST (Global ("x"))

	movq	%r10,	global_x(%rip)
# DROP

# LD (Global ("l"))

	movq	global_l(%rip),	%r10
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

# LD (Global ("l"))

	movq	global_l(%rip),	%r10
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

	.set	Lmain_SIZE,	0

	.set	LSmain_SIZE,	0

	.size main, .-main

# LABEL ("Llambda_0")

Llambda_0:

# BEGIN ("Llambda_0", 0, 0, [], [], [{ blab="L17"; elab="L18"; names=[]; subs=[{ blab="L20"; elab="L21"; names=[]; subs=[]; }]; }])

	.type lambda_0, @function

	.stabs "lambda_0:F1",36,0,0,Llambda_0

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLlambda_0_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLlambda_0_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$0,	%r11
	je	Llambda_0_argc_correct
	movq	%r11,	%r13
	movq	$0,	%r12
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
Llambda_0_argc_correct:

# SLABEL ("L17")

L17:

# SLABEL ("L20")

L20:

# LINE (15)

	.stabn 68,0,15,0

	.stabn 68,0,15,.L2-Llambda_0

.L2:

# CONST (1)

	movq	$3,	%r10
# CALL ("Lwrite", 1, false)

	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	movq	%rax,	%r10
# DROP

# CONST (800)

	movq	$1601,	%r10
# SLABEL ("L21")

L21:

# LABEL ("L19")

L19:

# SLABEL ("L18")

L18:

# END

	movq	%r10,	%rax
LLlambda_0_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLlambda_0_SIZE,	0

	.set	LSLlambda_0_SIZE,	0

	.size Llambda_0, .-Llambda_0

# LABEL ("LmakeLazy")

LmakeLazy:

# BEGIN ("LmakeLazy", 1, 2, [], ["f"], [{ blab="L25"; elab="L26"; names=[]; subs=[{ blab="L28"; elab="L29"; names=[("flag", 1); ("value", 0)]; subs=[]; }]; }])

	.type makeLazy, @function

	.stabs "makeLazy:F1",36,0,0,LmakeLazy

	.stabs "flag:1",128,0,0,-16

	.stabs "value:1",128,0,0,-8

	.stabn 192,0,0,L28-LmakeLazy

	.stabn 224,0,0,L29-LmakeLazy

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLmakeLazy_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLmakeLazy_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$1,	%r11
	je	LmakeLazy_argc_correct
	movq	%r11,	%r13
	movq	$1,	%r12
	leaq	string_2(%rip),	%r11
	leaq	string_0(%rip),	%r10
	movq	%r13,	%rcx
	movq	%r12,	%rdx
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$4,	%r11
	call	failure
	movq	%rax,	%r10
LmakeLazy_argc_correct:

# SLABEL ("L25")

L25:

# SLABEL ("L28")

L28:

# CONST (0)

	movq	$1,	%r10
# LINE (2)

	.stabn 68,0,2,0

	.stabn 68,0,2,.L3-LmakeLazy

.L3:

# ST (Local (1))

	movq	%r10,	-16(%rbp)
# DROP

# CONST (0)

	movq	$1,	%r10
# ST (Local (0))

	movq	%r10,	-8(%rbp)
# DROP

# CLOSURE ("Llambda_1_5", [Local (1); Local (0); Arg (0)])

	movq	%rdi,	%r13
	movq	-8(%rbp),	%r12
	movq	-16(%rbp),	%r11
	leaq	Llambda_1_5(%rip),	%r10
	pushq	%rdi
	pushq	filler(%rip)
	pushq	%r13
	pushq	%r12
	pushq	%r11
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$7,	%rsi
	call	Bclosure
	addq	$40,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# SLABEL ("L29")

L29:

# LABEL ("L27")

L27:

# SLABEL ("L26")

L26:

# END

	movq	%r10,	%rax
LLmakeLazy_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLmakeLazy_SIZE,	16

	.set	LSLmakeLazy_SIZE,	2

	.size LmakeLazy, .-LmakeLazy

# LABEL ("Llambda_1_5")

Llambda_1_5:

# BEGIN ("Llambda_1_5", 0, 0, [Local (1); Local (0); Arg (0)], [], [{ blab="L36"; elab="L37"; names=[]; subs=[{ blab="L39"; elab="L40"; names=[]; subs=[{ blab="L45"; elab="L46"; names=[]; subs=[]; }; { blab="L43"; elab="L44"; names=[]; subs=[]; }]; }]; }])

	.type lambda_1_5, @function

	.stabs "lambda_1_5:F1",36,0,0,Llambda_1_5

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLlambda_1_5_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLlambda_1_5_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$0,	%r11
	je	Llambda_1_5_argc_correct
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
Llambda_1_5_argc_correct:

# SLABEL ("L36")

L36:

# SLABEL ("L39")

L39:

# LINE (5)

	.stabn 68,0,5,0

	.stabn 68,0,5,.L4-Llambda_1_5

.L4:

# LD (Access (0))

	movq	8(%r15),	%r10
# CJMP ("z", "L42")

	sarq	%r10
	cmpq	$0,	%r10
	jz	L42
# SLABEL ("L43")

L43:

# LINE (6)

	.stabn 68,0,6,.L5-Llambda_1_5

.L5:

# LD (Access (1))

	movq	16(%r15),	%r10
# SLABEL ("L44")

L44:

# JMP ("L38")

	jmp	L38
# LABEL ("L42")

L42:

# SLABEL ("L45")

L45:

# LD (Access (2))

	movq	24(%r15),	%r10
# CALLC (0, false)

	pushq	%r15
	pushq	%r10
	movq	%r10,	%r15
	movq	$0,	%r11
	call	*(%r15)
	popq	%r10
	popq	%r15
	movq	%rax,	%r10
# LINE (7)

	.stabn 68,0,7,.L6-Llambda_1_5

.L6:

# ST (Access (1))

	movq	%r10,	16(%r15)
# DROP

# CONST (1)

	movq	$3,	%r10
# ST (Access (0))

	movq	%r10,	8(%r15)
# DROP

# LINE (9)

	.stabn 68,0,9,.L7-Llambda_1_5

.L7:

# LD (Access (1))

	movq	16(%r15),	%r10
# SLABEL ("L46")

L46:

# JMP ("L38")

	jmp	L38
# SLABEL ("L40")

L40:

# LABEL ("L38")

L38:

# SLABEL ("L37")

L37:

# END

	movq	%r10,	%rax
LLlambda_1_5_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLlambda_1_5_SIZE,	0

	.set	LSLlambda_1_5_SIZE,	0

	.size Llambda_1_5, .-Llambda_1_5


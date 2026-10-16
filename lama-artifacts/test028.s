	.file "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test028/test028.lama"

	.stabs "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test028/test028.lama",100,0,0,.Ltext

	.globl	main

	.data

string_0:	.string	"Function %s called with incorrect arguments count. Expected: %d. Actual: %d\n"

string_1:	.string	"fact"

init:	.quad 0

	.section custom_data,"aw",@progbits

filler:	.fill	0, 8, 1

	.stabs "i:S1",40,0,0,global_i

global_i:	.quad	1

	.stabs "n:S1",40,0,0,global_n

global_n:	.quad	1

	.stabs "result:S1",40,0,0,global_result

global_result:	.quad	1

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

# LINE (12)

	.stabn 68,0,12,.L0

.L0:

# CALL ("Lread", 0, false)

	pushq	%rdi
	pushq	%rsi
	movq	$0,	%r11
	call	Lread
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# LINE (10)

	.stabn 68,0,10,.L1

.L1:

# ST (Global ("n"))

	movq	%r10,	global_n(%rip)
# DROP

# SLABEL ("L8")

L8:

# LD (Global ("n"))

	movq	global_n(%rip),	%r10
# LINE (14)

	.stabn 68,0,14,.L2

.L2:

# ST (Global ("i"))

	movq	%r10,	global_i(%rip)
# DROP

# JMP ("L15")

	jmp	L15
# FLABEL ("L14")

L14:

# SLABEL ("L19")

L19:

# LINE (15)

	.stabn 68,0,15,.L3

.L3:

# LD (Global ("i"))

	movq	global_i(%rip),	%r10
# CALL ("Lfact", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lfact
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LINE (16)

	.stabn 68,0,16,.L4

.L4:

# LD (Global ("i"))

	movq	global_i(%rip),	%r10
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

# LINE (17)

	.stabn 68,0,17,.L5

.L5:

# LD (Global ("result"))

	movq	global_result(%rip),	%r10
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

# SLABEL ("L20")

L20:

# LD (Global ("i"))

	movq	global_i(%rip),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("-")

	subq	%r11,	%r10
	orq	$0x0001,	%r10
# LINE (14)

	.stabn 68,0,14,.L6

.L6:

# ST (Global ("i"))

	movq	%r10,	global_i(%rip)
# DROP

# LABEL ("L15")

L15:

# LD (Global ("i"))

	movq	global_i(%rip),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP (">=")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setge	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("nz", "L14")

	sarq	%r10
	cmpq	$0,	%r10
	jnz	L14
# SLABEL ("L9")

L9:

# CONST (0)

	movq	$1,	%r10
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

# LABEL ("Lfact")

Lfact:

# BEGIN ("Lfact", 1, 0, [], ["n"], [{ blab="L33"; elab="L34"; names=[]; subs=[{ blab="L36"; elab="L37"; names=[]; subs=[{ blab="L45"; elab="L46"; names=[]; subs=[]; }; { blab="L42"; elab="L43"; names=[]; subs=[]; }]; }]; }])

	.type fact, @function

	.stabs "fact:F1",36,0,0,Lfact

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLfact_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLfact_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$1,	%r11
	je	Lfact_argc_correct
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
Lfact_argc_correct:

# SLABEL ("L33")

L33:

# SLABEL ("L36")

L36:

# LINE (4)

	.stabn 68,0,4,0

	.stabn 68,0,4,.L7-Lfact

.L7:

# LD (Arg (0))

	movq	%rdi,	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("<=")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setle	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("z", "L39")

	sarq	%r10
	cmpq	$0,	%r10
	jz	L39
# SLABEL ("L42")

L42:

# CONST (1)

	movq	$3,	%r10
# LINE (5)

	.stabn 68,0,5,.L8-Lfact

.L8:

# ST (Global ("result"))

	movq	%r10,	global_result(%rip)
# SLABEL ("L43")

L43:

# JMP ("L35")

	jmp	L35
# LABEL ("L39")

L39:

# SLABEL ("L45")

L45:

# LINE (6)

	.stabn 68,0,6,.L9-Lfact

.L9:

# LINE (7)

	.stabn 68,0,7,.L10-Lfact

.L10:

# LD (Arg (0))

	movq	%rdi,	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("-")

	subq	%r11,	%r10
	orq	$0x0001,	%r10
# CALL ("Lfact", 1, false)

	pushq	%rdi
	pushq	filler(%rip)
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lfact
	addq	$8,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LINE (8)

	.stabn 68,0,8,.L11-Lfact

.L11:

# LD (Global ("result"))

	movq	global_result(%rip),	%r10
# LD (Arg (0))

	movq	%rdi,	%r11
# BINOP ("*")

	decq	%r10
	movq	%r11,	%rax
	sarq	%rax
	imulq	%rax,	%r10
	orq	$0x0001,	%r10
# ST (Global ("result"))

	movq	%r10,	global_result(%rip)
# SLABEL ("L46")

L46:

# JMP ("L35")

	jmp	L35
# SLABEL ("L37")

L37:

# LABEL ("L35")

L35:

# SLABEL ("L34")

L34:

# END

	movq	%r10,	%rax
LLfact_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLfact_SIZE,	0

	.set	LSLfact_SIZE,	0

	.size Lfact, .-Lfact


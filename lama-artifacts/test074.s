	.file "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test074/test074.lama"

	.stabs "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test074/test074.lama",100,0,0,.Ltext

	.globl	main

	.data

string_0:	.string	"Function %s called with incorrect arguments count. Expected: %d. Actual: %d\n"

string_1:	.string	"ack"

init:	.quad 0

	.section custom_data,"aw",@progbits

filler:	.fill	0, 8, 1

	.stabs "m:S1",40,0,0,global_m

global_m:	.quad	1

	.stabs "n:S1",40,0,0,global_n

global_n:	.quad	1

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

# ST (Global ("x"))

	movq	%r10,	global_x(%rip)
# DROP

# SLABEL ("L8")

L8:

# CONST (0)

	movq	$1,	%r10
# LINE (12)

	.stabn 68,0,12,.L2

.L2:

# ST (Global ("m"))

	movq	%r10,	global_m(%rip)
# DROP

# JMP ("L15")

	jmp	L15
# FLABEL ("L14")

L14:

# SLABEL ("L19")

L19:

# SLABEL ("L21")

L21:

# CONST (0)

	movq	$1,	%r10
# LINE (13)

	.stabn 68,0,13,.L3

.L3:

# ST (Global ("n"))

	movq	%r10,	global_n(%rip)
# DROP

# JMP ("L28")

	jmp	L28
# FLABEL ("L27")

L27:

# SLABEL ("L32")

L32:

# LINE (14)

	.stabn 68,0,14,.L4

.L4:

# LD (Global ("m"))

	movq	global_m(%rip),	%r10
# LD (Global ("n"))

	movq	global_n(%rip),	%r11
# CALL ("Lack", 2, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$2,	%r11
	call	Lack
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

# SLABEL ("L33")

L33:

# LD (Global ("n"))

	movq	global_n(%rip),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# LINE (13)

	.stabn 68,0,13,.L5

.L5:

# ST (Global ("n"))

	movq	%r10,	global_n(%rip)
# DROP

# LABEL ("L28")

L28:

# LD (Global ("n"))

	movq	global_n(%rip),	%r10
# CONST (8)

	movq	$17,	%r11
# BINOP ("<=")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setle	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("nz", "L27")

	sarq	%r10
	cmpq	$0,	%r10
	jnz	L27
# SLABEL ("L22")

L22:

# SLABEL ("L20")

L20:

# LD (Global ("m"))

	movq	global_m(%rip),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# LINE (12)

	.stabn 68,0,12,.L6

.L6:

# ST (Global ("m"))

	movq	%r10,	global_m(%rip)
# DROP

# LABEL ("L15")

L15:

# LD (Global ("m"))

	movq	global_m(%rip),	%r10
# CONST (3)

	movq	$7,	%r11
# BINOP ("<=")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setle	%al
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

# LABEL ("Lack")

Lack:

# BEGIN ("Lack", 2, 0, [], ["m"; "n"], [{ blab="L46"; elab="L47"; names=[]; subs=[{ blab="L49"; elab="L50"; names=[]; subs=[{ blab="L75"; elab="L76"; names=[]; subs=[]; }; { blab="L69"; elab="L70"; names=[]; subs=[]; }; { blab="L55"; elab="L56"; names=[]; subs=[{ blab="L57"; elab="L58"; names=[]; subs=[]; }]; }]; }]; }])

	.type ack, @function

	.stabs "ack:F1",36,0,0,Lack

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLack_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLack_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$2,	%r11
	je	Lack_argc_correct
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
Lack_argc_correct:

# SLABEL ("L46")

L46:

# SLABEL ("L49")

L49:

# LINE (4)

	.stabn 68,0,4,0

	.stabn 68,0,4,.L7-Lack

.L7:

# LD (Arg (0))

	movq	%rdi,	%r10
# CONST (0)

	movq	$1,	%r11
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("z", "L52")

	sarq	%r10
	cmpq	$0,	%r10
	jz	L52
# SLABEL ("L55")

L55:

# SLABEL ("L57")

L57:

# LD (Arg (1))

	movq	%rsi,	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# SLABEL ("L58")

L58:

# SLABEL ("L56")

L56:

# JMP ("L48")

	jmp	L48
# LABEL ("L52")

L52:

# LINE (5)

	.stabn 68,0,5,.L8-Lack

.L8:

# LD (Arg (0))

	movq	%rdi,	%r10
# CONST (0)

	movq	$1,	%r11
# BINOP (">")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setg	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# LD (Arg (1))

	movq	%rsi,	%r11
# CONST (0)

	movq	$1,	%r12
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r12,	%r11
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r11
# BINOP ("&&")

	decq	%r11
	movq	%r11,	%rax
	andq	%r11,	%rax
	movq	$0,	%rax
	setne	%al
	decq	%r10
	movq	%r10,	%r12
	andq	%r10,	%r12
	movq	$0,	%r12
	setne	%r12b
	andq	%r12,	%rax
	setne	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("z", "L62")

	sarq	%r10
	cmpq	$0,	%r10
	jz	L62
# SLABEL ("L69")

L69:

# LD (Arg (0))

	movq	%rdi,	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("-")

	subq	%r11,	%r10
	orq	$0x0001,	%r10
# CONST (1)

	movq	$3,	%r11
# CALL ("Lack", 2, true)

	movq	%r10,	%rdi
	movq	%r11,	%rsi
	movq	%rbp,	%rsp
	popq	%rbp
	movq	$2,	%r11
	jmp	Lack
# SLABEL ("L70")

L70:

# JMP ("L48")

	jmp	L48
# LABEL ("L62")

L62:

# SLABEL ("L75")

L75:

# LINE (6)

	.stabn 68,0,6,.L9-Lack

.L9:

# LD (Arg (0))

	movq	%rdi,	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("-")

	subq	%r11,	%r10
	orq	$0x0001,	%r10
# LD (Arg (0))

	movq	%rdi,	%r11
# LD (Arg (1))

	movq	%rsi,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("-")

	subq	%r13,	%r12
	orq	$0x0001,	%r12
# CALL ("Lack", 2, false)

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$2,	%r11
	call	Lack
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# CALL ("Lack", 2, true)

	movq	%r10,	%rdi
	movq	%r11,	%rsi
	movq	%rbp,	%rsp
	popq	%rbp
	movq	$2,	%r11
	jmp	Lack
# SLABEL ("L76")

L76:

# JMP ("L48")

	jmp	L48
# SLABEL ("L50")

L50:

# LABEL ("L48")

L48:

# SLABEL ("L47")

L47:

# END

	movq	%r10,	%rax
LLack_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLack_SIZE,	0

	.set	LSLack_SIZE,	0

	.size Lack, .-Lack


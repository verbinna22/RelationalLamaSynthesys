	.file "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test015/test015.lama"

	.stabs "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test015/test015.lama",100,0,0,.Ltext

	.globl	main

	.data

init:	.quad 0

	.section custom_data,"aw",@progbits

filler:	.fill	2, 8, 1

	.stabs "n:S1",40,0,0,global_n

global_n:	.quad	1

	.stabs "p:S1",40,0,0,global_p

global_p:	.quad	1

	.stabs "s:S1",40,0,0,global_s

global_s:	.quad	1

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

# CONST (0)

	movq	$1,	%r10
# LINE (1)

	.stabn 68,0,1,.L0

.L0:

# ST (Global ("s"))

	movq	%r10,	global_s(%rip)
# DROP

# LINE (4)

	.stabn 68,0,4,.L1

.L1:

# CALL ("Lread", 0, false)

	pushq	%rdi
	pushq	%rsi
	movq	$0,	%r11
	call	Lread
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# LINE (3)

	.stabn 68,0,3,.L2

.L2:

# ST (Global ("n"))

	movq	%r10,	global_n(%rip)
# DROP

# CONST (2)

	movq	$5,	%r10
# ST (Global ("p"))

	movq	%r10,	global_p(%rip)
# DROP

# JMP ("L16")

	jmp	L16
# FLABEL ("L15")

L15:

# SLABEL ("L19")

L19:

# SLABEL ("L21")

L21:

# CONST (2)

	movq	$5,	%r10
# LINE (8)

	.stabn 68,0,8,.L3

.L3:

# ST (Local (1))

	movq	%r10,	-16(%rbp)
# DROP

# CONST (1)

	movq	$3,	%r10
# ST (Local (0))

	movq	%r10,	-8(%rbp)
# DROP

# JMP ("L32")

	jmp	L32
# FLABEL ("L31")

L31:

# SLABEL ("L39")

L39:

# SLABEL ("L46")

L46:

# LINE (11)

	.stabn 68,0,11,.L4

.L4:

# LD (Global ("p"))

	movq	global_p(%rip),	%r10
# LD (Local (1))

	movq	-16(%rbp),	%r11
# BINOP ("%")

	movq	%r10,	%rax
	sarq	%rax
	cqo
	sarq	%r11
	idivq	%r11
	salq	%rdx
	orq	$0x0001,	%rdx
	movq	%rdx,	%r10
# SLABEL ("L47")

L47:

# CONST (0)

	movq	$1,	%r11
# BINOP ("!=")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setne	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# ST (Local (0))

	movq	%r10,	-8(%rbp)
# DROP

# LINE (12)

	.stabn 68,0,12,.L5

.L5:

# LD (Local (1))

	movq	-16(%rbp),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# ST (Local (1))

	movq	%r10,	-16(%rbp)
# DROP

# SLABEL ("L40")

L40:

# LABEL ("L32")

L32:

# LINE (10)

	.stabn 68,0,10,.L6

.L6:

# LD (Local (1))

	movq	-16(%rbp),	%r10
# LD (Local (1))

	movq	-16(%rbp),	%r11
# BINOP ("*")

	decq	%r10
	movq	%r11,	%rax
	sarq	%rax
	imulq	%rax,	%r10
	orq	$0x0001,	%r10
# LD (Global ("p"))

	movq	global_p(%rip),	%r11
# BINOP ("<=")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setle	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# LD (Local (0))

	movq	-8(%rbp),	%r11
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
# CJMP ("nz", "L31")

	sarq	%r10
	cmpq	$0,	%r10
	jnz	L31
# LINE (15)

	.stabn 68,0,15,.L7

.L7:

# LD (Local (0))

	movq	-8(%rbp),	%r10
# CONST (0)

	movq	$1,	%r11
# BINOP ("!=")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setne	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("z", "L56")

	sarq	%r10
	cmpq	$0,	%r10
	jz	L56
# SLABEL ("L59")

L59:

# LINE (16)

	.stabn 68,0,16,.L8

.L8:

# LD (Global ("n"))

	movq	global_n(%rip),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("z", "L63")

	sarq	%r10
	cmpq	$0,	%r10
	jz	L63
# SLABEL ("L66")

L66:

# LD (Global ("p"))

	movq	global_p(%rip),	%r10
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

# SLABEL ("L67")

L67:

# JMP ("L61")

	jmp	L61
# LABEL ("L63")

L63:

# SLABEL ("L70")

L70:

# SLABEL ("L71")

L71:

# JMP ("L61")

	jmp	L61
# LABEL ("L61")

L61:

# LINE (17)

	.stabn 68,0,17,.L9

.L9:

# LD (Global ("n"))

	movq	global_n(%rip),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("-")

	subq	%r11,	%r10
	orq	$0x0001,	%r10
# ST (Global ("n"))

	movq	%r10,	global_n(%rip)
# DROP

# SLABEL ("L60")

L60:

# JMP ("L54")

	jmp	L54
# LABEL ("L56")

L56:

# SLABEL ("L76")

L76:

# SLABEL ("L77")

L77:

# JMP ("L54")

	jmp	L54
# LABEL ("L54")

L54:

# LINE (20)

	.stabn 68,0,20,.L10

.L10:

# LD (Global ("p"))

	movq	global_p(%rip),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# LINE (18)

	.stabn 68,0,18,.L11

.L11:

# ST (Global ("p"))

	movq	%r10,	global_p(%rip)
# DROP

# SLABEL ("L22")

L22:

# SLABEL ("L20")

L20:

# LABEL ("L16")

L16:

# LINE (7)

	.stabn 68,0,7,.L12

.L12:

# LD (Global ("n"))

	movq	global_n(%rip),	%r10
# CONST (0)

	movq	$1,	%r11
# BINOP (">")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setg	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("nz", "L15")

	sarq	%r10
	cmpq	$0,	%r10
	jnz	L15
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

	.set	Lmain_SIZE,	16

	.set	LSmain_SIZE,	2

	.size main, .-main


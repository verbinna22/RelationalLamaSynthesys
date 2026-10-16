	.file "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test019/test019.lama"

	.stabs "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test019/test019.lama",100,0,0,.Ltext

	.globl	main

	.data

init:	.quad 0

	.section custom_data,"aw",@progbits

filler:	.fill	1, 8, 1

	.stabs "i:S1",40,0,0,global_i

global_i:	.quad	1

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

# BEGIN ("main", 2, 1, [], [], [])

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

# ST (Global ("i"))

	movq	%r10,	global_i(%rip)
# DROP

# CONST (0)

	movq	$1,	%r10
# LINE (3)

	.stabn 68,0,3,.L1

.L1:

# ST (Global ("s"))

	movq	%r10,	global_s(%rip)
# DROP

# SLABEL ("L10")

L10:

# CONST (0)

	movq	$1,	%r10
# LINE (6)

	.stabn 68,0,6,.L2

.L2:

# ST (Global ("i"))

	movq	%r10,	global_i(%rip)
# DROP

# JMP ("L17")

	jmp	L17
# FLABEL ("L16")

L16:

# SLABEL ("L21")

L21:

# SLABEL ("L24")

L24:

# CONST (0)

	movq	$1,	%r10
# LINE (10)

	.stabn 68,0,10,.L3

.L3:

# ST (Local (0))

	movq	%r10,	-8(%rbp)
# DROP

# JMP ("L31")

	jmp	L31
# FLABEL ("L30")

L30:

# SLABEL ("L35")

L35:

# LINE (12)

	.stabn 68,0,12,.L4

.L4:

# LD (Global ("s"))

	movq	global_s(%rip),	%r10
# LD (Local (0))

	movq	-8(%rbp),	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# LINE (11)

	.stabn 68,0,11,.L5

.L5:

# ST (Global ("s"))

	movq	%r10,	global_s(%rip)
# DROP

# SLABEL ("L36")

L36:

# LD (Local (0))

	movq	-8(%rbp),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# LINE (10)

	.stabn 68,0,10,.L6

.L6:

# ST (Local (0))

	movq	%r10,	-8(%rbp)
# DROP

# LABEL ("L31")

L31:

# LD (Local (0))

	movq	-8(%rbp),	%r10
# CONST (100)

	movq	$201,	%r11
# BINOP ("<")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setl	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("nz", "L30")

	sarq	%r10
	cmpq	$0,	%r10
	jnz	L30
# SLABEL ("L25")

L25:

# LINE (14)

	.stabn 68,0,14,.L7

.L7:

# LD (Global ("s"))

	movq	global_s(%rip),	%r10
# LD (Global ("i"))

	movq	global_i(%rip),	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# LINE (13)

	.stabn 68,0,13,.L8

.L8:

# ST (Global ("s"))

	movq	%r10,	global_s(%rip)
# DROP

# SLABEL ("L22")

L22:

# LD (Global ("i"))

	movq	global_i(%rip),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# LINE (6)

	.stabn 68,0,6,.L9

.L9:

# ST (Global ("i"))

	movq	%r10,	global_i(%rip)
# DROP

# LABEL ("L17")

L17:

# LD (Global ("i"))

	movq	global_i(%rip),	%r10
# CONST (100)

	movq	$201,	%r11
# BINOP ("<")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setl	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("nz", "L16")

	sarq	%r10
	cmpq	$0,	%r10
	jnz	L16
# SLABEL ("L11")

L11:

# LINE (15)

	.stabn 68,0,15,.L10

.L10:

# LINE (17)

	.stabn 68,0,17,.L11

.L11:

# LD (Global ("s"))

	movq	global_s(%rip),	%r10
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

	.set	Lmain_SIZE,	16

	.set	LSmain_SIZE,	1

	.size main, .-main


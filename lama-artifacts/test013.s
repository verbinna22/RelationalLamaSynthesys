	.file "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test013/test013.lama"

	.stabs "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test013/test013.lama",100,0,0,.Ltext

	.globl	main

	.data

init:	.quad 0

	.section custom_data,"aw",@progbits

filler:	.fill	0, 8, 1

	.stabs "n:S1",40,0,0,global_n

global_n:	.quad	1

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
# LINE (1)

	.stabn 68,0,1,.L0

.L0:

# ST (Global ("n"))

	movq	%r10,	global_n(%rip)
# DROP

# SLABEL ("L8")

L8:

# LABEL ("L11")

L11:

# LINE (5)

	.stabn 68,0,5,.L1

.L1:

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
# CJMP ("z", "L17")

	sarq	%r10
	cmpq	$0,	%r10
	jz	L17
# SLABEL ("L20")

L20:

# CONST (0)

	movq	$1,	%r10
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

# SLABEL ("L21")

L21:

# JMP ("L15")

	jmp	L15
# LABEL ("L17")

L17:

# LINE (6)

	.stabn 68,0,6,.L2

.L2:

# LD (Global ("n"))

	movq	global_n(%rip),	%r10
# CONST (2)

	movq	$5,	%r11
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("z", "L25")

	sarq	%r10
	cmpq	$0,	%r10
	jz	L25
# SLABEL ("L28")

L28:

# CONST (1)

	movq	$3,	%r10
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

# SLABEL ("L29")

L29:

# JMP ("L15")

	jmp	L15
# LABEL ("L25")

L25:

# LINE (7)

	.stabn 68,0,7,.L3

.L3:

# LD (Global ("n"))

	movq	global_n(%rip),	%r10
# CONST (3)

	movq	$7,	%r11
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("z", "L33")

	sarq	%r10
	cmpq	$0,	%r10
	jz	L33
# SLABEL ("L36")

L36:

# CONST (2)

	movq	$5,	%r10
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

# SLABEL ("L37")

L37:

# JMP ("L15")

	jmp	L15
# LABEL ("L33")

L33:

# LINE (8)

	.stabn 68,0,8,.L4

.L4:

# LD (Global ("n"))

	movq	global_n(%rip),	%r10
# CONST (4)

	movq	$9,	%r11
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("z", "L41")

	sarq	%r10
	cmpq	$0,	%r10
	jz	L41
# SLABEL ("L44")

L44:

# CONST (3)

	movq	$7,	%r10
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

# SLABEL ("L45")

L45:

# JMP ("L15")

	jmp	L15
# LABEL ("L41")

L41:

# SLABEL ("L48")

L48:

# LINE (9)

	.stabn 68,0,9,.L5

.L5:

# CONST (10)

	movq	$21,	%r10
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

# SLABEL ("L49")

L49:

# JMP ("L15")

	jmp	L15
# LABEL ("L15")

L15:

# LINE (12)

	.stabn 68,0,12,.L6

.L6:

# LD (Global ("n"))

	movq	global_n(%rip),	%r10
# CONST (5)

	movq	$11,	%r11
# BINOP (">=")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setge	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("z", "L54")

	sarq	%r10
	cmpq	$0,	%r10
	jz	L54
# SLABEL ("L57")

L57:

# CONST (11)

	movq	$23,	%r10
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

# SLABEL ("L58")

L58:

# JMP ("L52")

	jmp	L52
# LABEL ("L54")

L54:

# JMP ("L52")

	jmp	L52
# LABEL ("L52")

L52:

# LINE (14)

	.stabn 68,0,14,.L7

.L7:

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

# LINE (16)

	.stabn 68,0,16,.L8

.L8:

# LD (Global ("n"))

	movq	global_n(%rip),	%r10
# CONST (0)

	movq	$1,	%r11
# BINOP ("!=")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setne	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("nz", "L11")

	sarq	%r10
	cmpq	$0,	%r10
	jnz	L11
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


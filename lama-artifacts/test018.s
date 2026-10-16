	.file "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test018/test018.lama"

	.stabs "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test018/test018.lama",100,0,0,.Ltext

	.globl	main

	.data

init:	.quad 0

	.section custom_data,"aw",@progbits

filler:	.fill	1, 8, 1

	.stabs "c:S1",40,0,0,global_c

global_c:	.quad	1

	.stabs "d:S1",40,0,0,global_d

global_d:	.quad	1

	.stabs "i:S1",40,0,0,global_i

global_i:	.quad	1

	.stabs "m:S1",40,0,0,global_m

global_m:	.quad	1

	.stabs "n:S1",40,0,0,global_n

global_n:	.quad	1

	.stabs "p:S1",40,0,0,global_p

global_p:	.quad	1

	.stabs "q:S1",40,0,0,global_q

global_q:	.quad	1

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

# LINE (3)

	.stabn 68,0,3,.L0

.L0:

# CALL ("Lread", 0, false)

	pushq	%rdi
	pushq	%rsi
	movq	$0,	%r11
	call	Lread
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# LINE (1)

	.stabn 68,0,1,.L1

.L1:

# ST (Global ("n"))

	movq	%r10,	global_n(%rip)
# DROP

# CONST (1)

	movq	$3,	%r10
# ST (Global ("c"))

	movq	%r10,	global_c(%rip)
# DROP

# CONST (2)

	movq	$5,	%r10
# LINE (5)

	.stabn 68,0,5,.L2

.L2:

# ST (Global ("p"))

	movq	%r10,	global_p(%rip)
# DROP

# JMP ("L16")

	jmp	L16
# FLABEL ("L15")

L15:

# SLABEL ("L17")

L17:

# CONST (1)

	movq	$3,	%r10
# LINE (10)

	.stabn 68,0,10,.L3

.L3:

# ST (Local (0))

	movq	%r10,	-8(%rbp)
# DROP

# JMP ("L25")

	jmp	L25
# FLABEL ("L24")

L24:

# SLABEL ("L26")

L26:

# CONST (2)

	movq	$5,	%r10
# ST (Global ("q"))

	movq	%r10,	global_q(%rip)
# DROP

# JMP ("L34")

	jmp	L34
# FLABEL ("L33")

L33:

# SLABEL ("L41")

L41:

# LINE (16)

	.stabn 68,0,16,.L4

.L4:

# LD (Global ("p"))

	movq	global_p(%rip),	%r10
# LD (Global ("q"))

	movq	global_q(%rip),	%r11
# BINOP ("%")

	movq	%r10,	%rax
	sarq	%rax
	cqo
	sarq	%r11
	idivq	%r11
	salq	%rdx
	orq	$0x0001,	%rdx
	movq	%rdx,	%r10
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

# LINE (17)

	.stabn 68,0,17,.L5

.L5:

# LD (Global ("q"))

	movq	global_q(%rip),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# ST (Global ("q"))

	movq	%r10,	global_q(%rip)
# DROP

# SLABEL ("L42")

L42:

# LABEL ("L34")

L34:

# LINE (15)

	.stabn 68,0,15,.L6

.L6:

# LD (Global ("q"))

	movq	global_q(%rip),	%r10
# LD (Global ("q"))

	movq	global_q(%rip),	%r11
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
# CJMP ("nz", "L33")

	sarq	%r10
	cmpq	$0,	%r10
	jnz	L33
# LINE (20)

	.stabn 68,0,20,.L7

.L7:

# LD (Local (0))

	movq	-8(%rbp),	%r10
# CJMP ("z", "L55")

	sarq	%r10
	cmpq	$0,	%r10
	jz	L55
# SLABEL ("L56")

L56:

# CONST (0)

	movq	$1,	%r10
# ST (Local (0))

	movq	%r10,	-8(%rbp)
# DROP

# SLABEL ("L57")

L57:

# JMP ("L25")

	jmp	L25
# LABEL ("L55")

L55:

# SLABEL ("L60")

L60:

# LD (Global ("p"))

	movq	global_p(%rip),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# ST (Global ("p"))

	movq	%r10,	global_p(%rip)
# DROP

# CONST (1)

	movq	$3,	%r10
# ST (Local (0))

	movq	%r10,	-8(%rbp)
# DROP

# SLABEL ("L61")

L61:

# JMP ("L25")

	jmp	L25
# SLABEL ("L27")

L27:

# LABEL ("L25")

L25:

# LINE (12)

	.stabn 68,0,12,.L8

.L8:

# LD (Local (0))

	movq	-8(%rbp),	%r10
# CJMP ("nz", "L24")

	sarq	%r10
	cmpq	$0,	%r10
	jnz	L24
# LINE (23)

	.stabn 68,0,23,.L9

.L9:

# LD (Global ("p"))

	movq	global_p(%rip),	%r10
# LINE (21)

	.stabn 68,0,21,.L10

.L10:

# ST (Global ("d"))

	movq	%r10,	global_d(%rip)
# DROP

# CONST (0)

	movq	$1,	%r10
# ST (Global ("i"))

	movq	%r10,	global_i(%rip)
# DROP

# LINE (26)

	.stabn 68,0,26,.L11

.L11:

# LD (Global ("n"))

	movq	global_n(%rip),	%r10
# LD (Global ("d"))

	movq	global_d(%rip),	%r11
# BINOP ("/")

	movq	%r10,	%rax
	sarq	%rax
	xorq	%rdx,	%rdx
	cqo
	sarq	%r11
	idivq	%r11
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# LINE (24)

	.stabn 68,0,24,.L12

.L12:

# ST (Global ("q"))

	movq	%r10,	global_q(%rip)
# DROP

# LINE (27)

	.stabn 68,0,27,.L13

.L13:

# LD (Global ("n"))

	movq	global_n(%rip),	%r10
# LD (Global ("d"))

	movq	global_d(%rip),	%r11
# BINOP ("%")

	movq	%r10,	%rax
	sarq	%rax
	cqo
	sarq	%r11
	idivq	%r11
	salq	%rdx
	orq	$0x0001,	%rdx
	movq	%rdx,	%r10
# ST (Global ("m"))

	movq	%r10,	global_m(%rip)
# DROP

# JMP ("L88")

	jmp	L88
# FLABEL ("L87")

L87:

# SLABEL ("L95")

L95:

# LINE (30)

	.stabn 68,0,30,.L14

.L14:

# LD (Global ("i"))

	movq	global_i(%rip),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# ST (Global ("i"))

	movq	%r10,	global_i(%rip)
# DROP

# LINE (31)

	.stabn 68,0,31,.L15

.L15:

# LD (Global ("d"))

	movq	global_d(%rip),	%r10
# LD (Global ("p"))

	movq	global_p(%rip),	%r11
# BINOP ("*")

	decq	%r10
	movq	%r11,	%rax
	sarq	%rax
	imulq	%rax,	%r10
	orq	$0x0001,	%r10
# ST (Global ("d"))

	movq	%r10,	global_d(%rip)
# DROP

# LINE (32)

	.stabn 68,0,32,.L16

.L16:

# LD (Global ("n"))

	movq	global_n(%rip),	%r10
# LD (Global ("d"))

	movq	global_d(%rip),	%r11
# BINOP ("%")

	movq	%r10,	%rax
	sarq	%rax
	cqo
	sarq	%r11
	idivq	%r11
	salq	%rdx
	orq	$0x0001,	%rdx
	movq	%rdx,	%r10
# ST (Global ("m"))

	movq	%r10,	global_m(%rip)
# DROP

# LINE (33)

	.stabn 68,0,33,.L17

.L17:

# LD (Global ("m"))

	movq	global_m(%rip),	%r10
# CONST (0)

	movq	$1,	%r11
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("z", "L113")

	sarq	%r10
	cmpq	$0,	%r10
	jz	L113
# SLABEL ("L116")

L116:

# LD (Global ("n"))

	movq	global_n(%rip),	%r10
# LD (Global ("d"))

	movq	global_d(%rip),	%r11
# BINOP ("/")

	movq	%r10,	%rax
	sarq	%rax
	xorq	%rdx,	%rdx
	cqo
	sarq	%r11
	idivq	%r11
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# ST (Global ("q"))

	movq	%r10,	global_q(%rip)
# DROP

# SLABEL ("L117")

L117:

# JMP ("L88")

	jmp	L88
# LABEL ("L113")

L113:

# SLABEL ("L122")

L122:

# SLABEL ("L123")

L123:

# JMP ("L88")

	jmp	L88
# SLABEL ("L96")

L96:

# LABEL ("L88")

L88:

# LINE (29)

	.stabn 68,0,29,.L18

.L18:

# LD (Global ("q"))

	movq	global_q(%rip),	%r10
# CONST (0)

	movq	$1,	%r11
# BINOP (">")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setg	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# LD (Global ("m"))

	movq	global_m(%rip),	%r11
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
# CJMP ("nz", "L87")

	sarq	%r10
	cmpq	$0,	%r10
	jnz	L87
# LINE (34)

	.stabn 68,0,34,.L19

.L19:

# LINE (36)

	.stabn 68,0,36,.L20

.L20:

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

# LINE (37)

	.stabn 68,0,37,.L21

.L21:

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

# LINE (39)

	.stabn 68,0,39,.L22

.L22:

# LD (Global ("n"))

	movq	global_n(%rip),	%r10
# SLABEL ("L135")

L135:

# LD (Global ("d"))

	movq	global_d(%rip),	%r11
# LD (Global ("p"))

	movq	global_p(%rip),	%r12
# BINOP ("/")

	movq	%r11,	%rax
	sarq	%rax
	xorq	%rdx,	%rdx
	cqo
	sarq	%r12
	idivq	%r12
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r11
# SLABEL ("L136")

L136:

# BINOP ("/")

	movq	%r10,	%rax
	sarq	%rax
	xorq	%rdx,	%rdx
	cqo
	sarq	%r11
	idivq	%r11
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# ST (Global ("n"))

	movq	%r10,	global_n(%rip)
# DROP

# LINE (40)

	.stabn 68,0,40,.L23

.L23:

# LD (Global ("p"))

	movq	global_p(%rip),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# ST (Global ("p"))

	movq	%r10,	global_p(%rip)
# DROP

# LINE (41)

	.stabn 68,0,41,.L24

.L24:

# LD (Global ("n"))

	movq	global_n(%rip),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("!=")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setne	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# ST (Global ("c"))

	movq	%r10,	global_c(%rip)
# DROP

# SLABEL ("L18")

L18:

# LABEL ("L16")

L16:

# LINE (8)

	.stabn 68,0,8,.L25

.L25:

# LD (Global ("c"))

	movq	global_c(%rip),	%r10
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

	.set	LSmain_SIZE,	1

	.size main, .-main


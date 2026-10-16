	.file "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test082/test082.lama"

	.stabs "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test082/test082.lama",100,0,0,.Ltext

	.globl	main

	.data

string_4:	.string	""

string_5:	.string	"Function %s called with incorrect arguments count. Expected: %d. Actual: %d\n"

string_3:	.string	"ab"

string_1:	.string	"abc"

string_7:	.string	"collect_ints"

string_8:	.string	"collect_ints_acc"

string_2:	.string	"def"

string_6:	.string	"print_list"

string_0:	.string	"test082.lama"

init:	.quad 0

	.section custom_data,"aw",@progbits

filler:	.fill	8, 8, 1

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

# BEGIN ("main", 2, 3, [], [], [])

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

# LINE (27)

	.stabn 68,0,27,.L0

.L0:

# CALL ("Lread", 0, false)

	pushq	%rdi
	pushq	%rsi
	movq	$0,	%r11
	call	Lread
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# LINE (25)

	.stabn 68,0,25,.L1

.L1:

# ST (Global ("n"))

	movq	%r10,	global_n(%rip)
# DROP

# CONST (1)

	movq	$3,	%r10
# DUP

	movq	%r10,	%r11
# SLABEL ("L11")

L11:

# CONST (5)

	movq	$11,	%r12
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r12,	%r11
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r11
# CJMP ("z", "L10")

	sarq	%r11
	cmpq	$0,	%r11
	jz	L10
# DROP

# SLABEL ("L13")

L13:

# LINE (30)

	.stabn 68,0,30,.L2

.L2:

# CONST (5)

	movq	$11,	%r10
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

# SLABEL ("L14")

L14:

# JMP ("L7")

	jmp	L7
# SLABEL ("L12")

L12:

# SLABEL ("L18")

L18:

# LABEL ("L10")

L10:

# DUP

	movq	%r10,	%r11
# CONST (4)

	movq	$9,	%r12
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r12,	%r11
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r11
# CJMP ("z", "L17")

	sarq	%r11
	cmpq	$0,	%r11
	jz	L17
# DROP

# SLABEL ("L20")

L20:

# LINE (31)

	.stabn 68,0,31,.L3

.L3:

# CONST (4)

	movq	$9,	%r10
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

# JMP ("L7")

	jmp	L7
# SLABEL ("L19")

L19:

# SLABEL ("L25")

L25:

# LABEL ("L17")

L17:

# DUP

	movq	%r10,	%r11
# CONST (3)

	movq	$7,	%r12
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r12,	%r11
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r11
# CJMP ("z", "L24")

	sarq	%r11
	cmpq	$0,	%r11
	jz	L24
# DROP

# SLABEL ("L27")

L27:

# LINE (32)

	.stabn 68,0,32,.L4

.L4:

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

# SLABEL ("L28")

L28:

# JMP ("L7")

	jmp	L7
# SLABEL ("L26")

L26:

# SLABEL ("L32")

L32:

# LABEL ("L24")

L24:

# DUP

	movq	%r10,	%r11
# CONST (2)

	movq	$5,	%r12
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r12,	%r11
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r11
# CJMP ("z", "L31")

	sarq	%r11
	cmpq	$0,	%r11
	jz	L31
# DROP

# SLABEL ("L34")

L34:

# LINE (33)

	.stabn 68,0,33,.L5

.L5:

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

# SLABEL ("L35")

L35:

# JMP ("L7")

	jmp	L7
# SLABEL ("L33")

L33:

# SLABEL ("L39")

L39:

# LABEL ("L31")

L31:

# DUP

	movq	%r10,	%r11
# CONST (1)

	movq	$3,	%r12
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r12,	%r11
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r11
# CJMP ("z", "L38")

	sarq	%r11
	cmpq	$0,	%r11
	jz	L38
# DROP

# SLABEL ("L41")

L41:

# LINE (34)

	.stabn 68,0,34,.L6

.L6:

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

# SLABEL ("L42")

L42:

# JMP ("L7")

	jmp	L7
# SLABEL ("L40")

L40:

# SLABEL ("L45")

L45:

# LABEL ("L38")

L38:

# DUP

	movq	%r10,	%r11
# CONST (0)

	movq	$1,	%r12
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r12,	%r11
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r11
# CJMP ("z", "L8")

	sarq	%r11
	cmpq	$0,	%r11
	jz	L8
# DROP

# SLABEL ("L47")

L47:

# LINE (35)

	.stabn 68,0,35,.L7

.L7:

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

# SLABEL ("L48")

L48:

# SLABEL ("L46")

L46:

# JMP ("L7")

	jmp	L7
# LABEL ("L8")

L8:

# FAIL ((29, 5), false)

	movq	$11,	%r13
	movq	$59,	%r12
	leaq	string_0(%rip),	%r11
	pushq	%rdi
	pushq	%rsi
	movq	%r13,	%rcx
	movq	%r12,	%rdx
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$4,	%r11
	call	Bmatch_failure
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# JMP ("L7")

	jmp	L7
# LABEL ("L7")

L7:

# CONST (1)

	movq	$3,	%r10
# DUP

	movq	%r10,	%r11
# SLABEL ("L55")

L55:

# CONST (5)

	movq	$11,	%r12
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r12,	%r11
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r11
# CJMP ("z", "L54")

	sarq	%r11
	cmpq	$0,	%r11
	jz	L54
# DUP

	movq	%r10,	%r11
# ST (Local (0))

	movq	%r11,	-8(%rbp)
# DROP

# DROP

# SLABEL ("L57")

L57:

# LINE (39)

	.stabn 68,0,39,.L8

.L8:

# LD (Local (0))

	movq	-8(%rbp),	%r10
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

# JMP ("L51")

	jmp	L51
# SLABEL ("L56")

L56:

# SLABEL ("L62")

L62:

# LABEL ("L54")

L54:

# DUP

	movq	%r10,	%r11
# CONST (4)

	movq	$9,	%r12
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r12,	%r11
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r11
# CJMP ("z", "L61")

	sarq	%r11
	cmpq	$0,	%r11
	jz	L61
# DUP

	movq	%r10,	%r11
# ST (Local (0))

	movq	%r11,	-8(%rbp)
# DROP

# DROP

# SLABEL ("L64")

L64:

# LINE (40)

	.stabn 68,0,40,.L9

.L9:

# LD (Local (0))

	movq	-8(%rbp),	%r10
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

# SLABEL ("L65")

L65:

# JMP ("L51")

	jmp	L51
# SLABEL ("L63")

L63:

# SLABEL ("L69")

L69:

# LABEL ("L61")

L61:

# DUP

	movq	%r10,	%r11
# CONST (3)

	movq	$7,	%r12
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r12,	%r11
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r11
# CJMP ("z", "L68")

	sarq	%r11
	cmpq	$0,	%r11
	jz	L68
# DUP

	movq	%r10,	%r11
# ST (Local (0))

	movq	%r11,	-8(%rbp)
# DROP

# DROP

# SLABEL ("L71")

L71:

# LINE (41)

	.stabn 68,0,41,.L10

.L10:

# LD (Local (0))

	movq	-8(%rbp),	%r10
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

# SLABEL ("L72")

L72:

# JMP ("L51")

	jmp	L51
# SLABEL ("L70")

L70:

# SLABEL ("L76")

L76:

# LABEL ("L68")

L68:

# DUP

	movq	%r10,	%r11
# CONST (2)

	movq	$5,	%r12
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r12,	%r11
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r11
# CJMP ("z", "L75")

	sarq	%r11
	cmpq	$0,	%r11
	jz	L75
# DUP

	movq	%r10,	%r11
# ST (Local (0))

	movq	%r11,	-8(%rbp)
# DROP

# DROP

# SLABEL ("L78")

L78:

# LINE (42)

	.stabn 68,0,42,.L11

.L11:

# LD (Local (0))

	movq	-8(%rbp),	%r10
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

# SLABEL ("L79")

L79:

# JMP ("L51")

	jmp	L51
# SLABEL ("L77")

L77:

# SLABEL ("L83")

L83:

# LABEL ("L75")

L75:

# DUP

	movq	%r10,	%r11
# CONST (1)

	movq	$3,	%r12
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r12,	%r11
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r11
# CJMP ("z", "L82")

	sarq	%r11
	cmpq	$0,	%r11
	jz	L82
# DUP

	movq	%r10,	%r11
# ST (Local (0))

	movq	%r11,	-8(%rbp)
# DROP

# DROP

# SLABEL ("L85")

L85:

# LINE (43)

	.stabn 68,0,43,.L12

.L12:

# LD (Local (0))

	movq	-8(%rbp),	%r10
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

# SLABEL ("L86")

L86:

# JMP ("L51")

	jmp	L51
# SLABEL ("L84")

L84:

# SLABEL ("L89")

L89:

# LABEL ("L82")

L82:

# DUP

	movq	%r10,	%r11
# CONST (0)

	movq	$1,	%r12
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r12,	%r11
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r11
# CJMP ("z", "L52")

	sarq	%r11
	cmpq	$0,	%r11
	jz	L52
# DUP

	movq	%r10,	%r11
# ST (Local (0))

	movq	%r11,	-8(%rbp)
# DROP

# DROP

# SLABEL ("L91")

L91:

# LINE (44)

	.stabn 68,0,44,.L13

.L13:

# LD (Local (0))

	movq	-8(%rbp),	%r10
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

# SLABEL ("L92")

L92:

# SLABEL ("L90")

L90:

# JMP ("L51")

	jmp	L51
# LABEL ("L52")

L52:

# FAIL ((38, 5), false)

	movq	$11,	%r13
	movq	$77,	%r12
	leaq	string_0(%rip),	%r11
	pushq	%rdi
	pushq	%rsi
	movq	%r13,	%rcx
	movq	%r12,	%rdx
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$4,	%r11
	call	Bmatch_failure
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# JMP ("L51")

	jmp	L51
# LABEL ("L51")

L51:

# CONST (1)

	movq	$3,	%r10
# CONST (2)

	movq	$5,	%r11
# CONST (3)

	movq	$7,	%r12
# SEXP ("A", 3)

	movq	$55,	%r13
	pushq	%rdi
	pushq	%rsi
	pushq	%r13
	pushq	%r12
	pushq	%r11
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$9,	%rsi
	call	Bsexp
	addq	$32,	%rsp
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DUP

	movq	%r10,	%r11
# SLABEL ("L104")

L104:

# DUP

	movq	%r11,	%r12
# TAG ("A", 3)

	movq	$55,	%r13
	movq	$7,	%r14
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r14,	%rdx
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$3,	%r11
	call	Btag
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CJMP ("nz", "L102")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L102
# LABEL ("L103")

L103:

# DROP

# JMP ("L101")

	jmp	L101
# LABEL ("L102")

L102:

# DUP

	movq	%r11,	%r12
# CONST (0)

	movq	$1,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r13,	%r12
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r12
# CJMP ("z", "L103")

	sarq	%r12
	cmpq	$0,	%r12
	jz	L103
# DUP

	movq	%r11,	%r12
# CONST (1)

	movq	$3,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CONST (3)

	movq	$7,	%r13
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r13,	%r12
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r12
# CJMP ("z", "L103")

	sarq	%r12
	cmpq	$0,	%r12
	jz	L103
# DUP

	movq	%r11,	%r12
# CONST (2)

	movq	$5,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CONST (5)

	movq	$11,	%r13
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r13,	%r12
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r12
# CJMP ("z", "L103")

	sarq	%r12
	cmpq	$0,	%r12
	jz	L103
# DROP

# DROP

# SLABEL ("L106")

L106:

# LINE (48)

	.stabn 68,0,48,.L14

.L14:

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

# SLABEL ("L107")

L107:

# JMP ("L95")

	jmp	L95
# SLABEL ("L105")

L105:

# SLABEL ("L113")

L113:

# LABEL ("L101")

L101:

# DUP

	movq	%r10,	%r11
# DUP

	movq	%r11,	%r12
# TAG ("A", 3)

	movq	$55,	%r13
	movq	$7,	%r14
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r14,	%rdx
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$3,	%r11
	call	Btag
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CJMP ("nz", "L111")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L111
# LABEL ("L112")

L112:

# DROP

# JMP ("L110")

	jmp	L110
# LABEL ("L111")

L111:

# DUP

	movq	%r11,	%r12
# CONST (0)

	movq	$1,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CONST (3)

	movq	$7,	%r13
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r13,	%r12
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r12
# CJMP ("z", "L112")

	sarq	%r12
	cmpq	$0,	%r12
	jz	L112
# DUP

	movq	%r11,	%r12
# CONST (1)

	movq	$3,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CONST (4)

	movq	$9,	%r13
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r13,	%r12
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r12
# CJMP ("z", "L112")

	sarq	%r12
	cmpq	$0,	%r12
	jz	L112
# DUP

	movq	%r11,	%r12
# CONST (2)

	movq	$5,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CONST (5)

	movq	$11,	%r13
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r13,	%r12
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r12
# CJMP ("z", "L112")

	sarq	%r12
	cmpq	$0,	%r12
	jz	L112
# DROP

# DROP

# SLABEL ("L115")

L115:

# LINE (49)

	.stabn 68,0,49,.L15

.L15:

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

# SLABEL ("L116")

L116:

# JMP ("L95")

	jmp	L95
# SLABEL ("L114")

L114:

# SLABEL ("L122")

L122:

# LABEL ("L110")

L110:

# DUP

	movq	%r10,	%r11
# DUP

	movq	%r11,	%r12
# TAG ("A", 3)

	movq	$55,	%r13
	movq	$7,	%r14
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r14,	%rdx
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$3,	%r11
	call	Btag
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CJMP ("nz", "L120")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L120
# LABEL ("L121")

L121:

# DROP

# JMP ("L119")

	jmp	L119
# LABEL ("L120")

L120:

# DUP

	movq	%r11,	%r12
# CONST (0)

	movq	$1,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r13,	%r12
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r12
# CJMP ("z", "L121")

	sarq	%r12
	cmpq	$0,	%r12
	jz	L121
# DUP

	movq	%r11,	%r12
# CONST (1)

	movq	$3,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CONST (2)

	movq	$5,	%r13
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r13,	%r12
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r12
# CJMP ("z", "L121")

	sarq	%r12
	cmpq	$0,	%r12
	jz	L121
# DUP

	movq	%r11,	%r12
# CONST (2)

	movq	$5,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CONST (3)

	movq	$7,	%r13
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r13,	%r12
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r12
# CJMP ("z", "L121")

	sarq	%r12
	cmpq	$0,	%r12
	jz	L121
# DROP

# DROP

# SLABEL ("L124")

L124:

# LINE (50)

	.stabn 68,0,50,.L16

.L16:

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

# SLABEL ("L125")

L125:

# JMP ("L95")

	jmp	L95
# SLABEL ("L123")

L123:

# SLABEL ("L130")

L130:

# LABEL ("L119")

L119:

# DUP

	movq	%r10,	%r11
# DUP

	movq	%r11,	%r12
# TAG ("A", 3)

	movq	$55,	%r13
	movq	$7,	%r14
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r14,	%rdx
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$3,	%r11
	call	Btag
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CJMP ("nz", "L128")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L128
# LABEL ("L129")

L129:

# DROP

# JMP ("L96")

	jmp	L96
# LABEL ("L128")

L128:

# DUP

	movq	%r11,	%r12
# CONST (0)

	movq	$1,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CONST (6)

	movq	$13,	%r13
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r13,	%r12
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r12
# CJMP ("z", "L129")

	sarq	%r12
	cmpq	$0,	%r12
	jz	L129
# DUP

	movq	%r11,	%r12
# CONST (1)

	movq	$3,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CONST (7)

	movq	$15,	%r13
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r13,	%r12
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r12
# CJMP ("z", "L129")

	sarq	%r12
	cmpq	$0,	%r12
	jz	L129
# DUP

	movq	%r11,	%r12
# CONST (2)

	movq	$5,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CONST (8)

	movq	$17,	%r13
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r13,	%r12
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r12
# CJMP ("z", "L129")

	sarq	%r12
	cmpq	$0,	%r12
	jz	L129
# DROP

# DROP

# SLABEL ("L132")

L132:

# LINE (51)

	.stabn 68,0,51,.L17

.L17:

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

# SLABEL ("L133")

L133:

# SLABEL ("L131")

L131:

# JMP ("L95")

	jmp	L95
# LABEL ("L96")

L96:

# FAIL ((47, 5), false)

	movq	$11,	%r13
	movq	$95,	%r12
	leaq	string_0(%rip),	%r11
	pushq	%rdi
	pushq	%rsi
	movq	%r13,	%rcx
	movq	%r12,	%rdx
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$4,	%r11
	call	Bmatch_failure
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# JMP ("L95")

	jmp	L95
# LABEL ("L95")

L95:

# STRING ("abc")

	leaq	string_1(%rip),	%r10
	pushq	%rdi
	pushq	%rsi
	pushq	filler(%rip)
	pushq	%r10
	movq	%rsp,	%rdi
	call	Bstring
	addq	$16,	%rsp
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DUP

	movq	%r10,	%r11
# SLABEL ("L140")

L140:

# STRING ("def")

	leaq	string_2(%rip),	%r12
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	pushq	filler(%rip)
	pushq	%r12
	movq	%rsp,	%rdi
	call	Bstring
	addq	$16,	%rsp
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# PATT (StrCmp)

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$2,	%r11
	call	Bstring_patt
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# CJMP ("z", "L139")

	sarq	%r11
	cmpq	$0,	%r11
	jz	L139
# DROP

# SLABEL ("L142")

L142:

# LINE (55)

	.stabn 68,0,55,.L18

.L18:

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

# SLABEL ("L143")

L143:

# JMP ("L136")

	jmp	L136
# SLABEL ("L141")

L141:

# SLABEL ("L147")

L147:

# LABEL ("L139")

L139:

# DUP

	movq	%r10,	%r11
# STRING ("ab")

	leaq	string_3(%rip),	%r12
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	pushq	filler(%rip)
	pushq	%r12
	movq	%rsp,	%rdi
	call	Bstring
	addq	$16,	%rsp
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# PATT (StrCmp)

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$2,	%r11
	call	Bstring_patt
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# CJMP ("z", "L146")

	sarq	%r11
	cmpq	$0,	%r11
	jz	L146
# DROP

# SLABEL ("L149")

L149:

# LINE (56)

	.stabn 68,0,56,.L19

.L19:

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

# SLABEL ("L150")

L150:

# JMP ("L136")

	jmp	L136
# SLABEL ("L148")

L148:

# SLABEL ("L154")

L154:

# LABEL ("L146")

L146:

# DUP

	movq	%r10,	%r11
# STRING ("abc")

	leaq	string_1(%rip),	%r12
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	pushq	filler(%rip)
	pushq	%r12
	movq	%rsp,	%rdi
	call	Bstring
	addq	$16,	%rsp
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# PATT (StrCmp)

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$2,	%r11
	call	Bstring_patt
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# CJMP ("z", "L153")

	sarq	%r11
	cmpq	$0,	%r11
	jz	L153
# DROP

# SLABEL ("L156")

L156:

# LINE (57)

	.stabn 68,0,57,.L20

.L20:

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

# SLABEL ("L157")

L157:

# JMP ("L136")

	jmp	L136
# SLABEL ("L155")

L155:

# SLABEL ("L160")

L160:

# LABEL ("L153")

L153:

# DUP

	movq	%r10,	%r11
# STRING ("")

	leaq	string_4(%rip),	%r12
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	pushq	filler(%rip)
	pushq	%r12
	movq	%rsp,	%rdi
	call	Bstring
	addq	$16,	%rsp
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# PATT (StrCmp)

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$2,	%r11
	call	Bstring_patt
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# CJMP ("z", "L137")

	sarq	%r11
	cmpq	$0,	%r11
	jz	L137
# DROP

# SLABEL ("L162")

L162:

# LINE (58)

	.stabn 68,0,58,.L21

.L21:

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

# SLABEL ("L163")

L163:

# SLABEL ("L161")

L161:

# JMP ("L136")

	jmp	L136
# LABEL ("L137")

L137:

# FAIL ((54, 5), false)

	movq	$11,	%r13
	movq	$109,	%r12
	leaq	string_0(%rip),	%r11
	pushq	%rdi
	pushq	%rsi
	movq	%r13,	%rcx
	movq	%r12,	%rdx
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$4,	%r11
	call	Bmatch_failure
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# JMP ("L136")

	jmp	L136
# LABEL ("L136")

L136:

# CONST (1)

	movq	$3,	%r10
# CONST (2)

	movq	$5,	%r11
# CONST (3)

	movq	$7,	%r12
# CALL (".array", 3, false)

	pushq	%rdi
	pushq	%rsi
	pushq	filler(%rip)
	pushq	%r12
	pushq	%r11
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$7,	%rsi
	call	Barray
	addq	$32,	%rsp
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DUP

	movq	%r10,	%r11
# SLABEL ("L175")

L175:

# DUP

	movq	%r11,	%r12
# ARRAY (0)

	movq	$1,	%r13
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Barray_patt
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CJMP ("nz", "L173")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L173
# LABEL ("L174")

L174:

# DROP

# JMP ("L172")

	jmp	L172
# LABEL ("L173")

L173:

# DROP

# DROP

# SLABEL ("L177")

L177:

# LINE (62)

	.stabn 68,0,62,.L22

.L22:

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

# SLABEL ("L178")

L178:

# JMP ("L166")

	jmp	L166
# SLABEL ("L176")

L176:

# SLABEL ("L184")

L184:

# LABEL ("L172")

L172:

# DUP

	movq	%r10,	%r11
# DUP

	movq	%r11,	%r12
# ARRAY (2)

	movq	$5,	%r13
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Barray_patt
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CJMP ("nz", "L182")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L182
# LABEL ("L183")

L183:

# DROP

# JMP ("L181")

	jmp	L181
# LABEL ("L182")

L182:

# DUP

	movq	%r11,	%r12
# CONST (0)

	movq	$1,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# DROP

# DUP

	movq	%r11,	%r12
# CONST (1)

	movq	$3,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# DROP

# DROP

# DUP

	movq	%r10,	%r11
# CONST (0)

	movq	$1,	%r12
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$2,	%r11
	call	Belem
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# ST (Local (1))

	movq	%r11,	-16(%rbp)
# DROP

# DUP

	movq	%r10,	%r11
# CONST (1)

	movq	$3,	%r12
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$2,	%r11
	call	Belem
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# ST (Local (0))

	movq	%r11,	-8(%rbp)
# DROP

# DROP

# SLABEL ("L186")

L186:

# LINE (63)

	.stabn 68,0,63,.L23

.L23:

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

# SLABEL ("L187")

L187:

# JMP ("L166")

	jmp	L166
# SLABEL ("L185")

L185:

# SLABEL ("L193")

L193:

# LABEL ("L181")

L181:

# DUP

	movq	%r10,	%r11
# DUP

	movq	%r11,	%r12
# ARRAY (3)

	movq	$7,	%r13
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Barray_patt
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CJMP ("nz", "L191")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L191
# LABEL ("L192")

L192:

# DROP

# JMP ("L190")

	jmp	L190
# LABEL ("L191")

L191:

# DUP

	movq	%r11,	%r12
# CONST (0)

	movq	$1,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# DROP

# DUP

	movq	%r11,	%r12
# CONST (1)

	movq	$3,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# DROP

# DUP

	movq	%r11,	%r12
# CONST (2)

	movq	$5,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# DROP

# DROP

# DUP

	movq	%r10,	%r11
# CONST (0)

	movq	$1,	%r12
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$2,	%r11
	call	Belem
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# ST (Local (2))

	movq	%r11,	-24(%rbp)
# DROP

# DUP

	movq	%r10,	%r11
# CONST (1)

	movq	$3,	%r12
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$2,	%r11
	call	Belem
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# ST (Local (1))

	movq	%r11,	-16(%rbp)
# DROP

# DUP

	movq	%r10,	%r11
# CONST (2)

	movq	$5,	%r12
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$2,	%r11
	call	Belem
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# ST (Local (0))

	movq	%r11,	-8(%rbp)
# DROP

# DROP

# SLABEL ("L195")

L195:

# LINE (64)

	.stabn 68,0,64,.L24

.L24:

# LD (Local (2))

	movq	-24(%rbp),	%r10
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

# LD (Local (1))

	movq	-16(%rbp),	%r10
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

# LD (Local (0))

	movq	-8(%rbp),	%r10
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

# SLABEL ("L196")

L196:

# JMP ("L166")

	jmp	L166
# SLABEL ("L194")

L194:

# SLABEL ("L207")

L207:

# LABEL ("L190")

L190:

# DUP

	movq	%r10,	%r11
# DUP

	movq	%r11,	%r12
# ARRAY (3)

	movq	$7,	%r13
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Barray_patt
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CJMP ("nz", "L205")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L205
# LABEL ("L206")

L206:

# DROP

# JMP ("L167")

	jmp	L167
# LABEL ("L205")

L205:

# DUP

	movq	%r11,	%r12
# CONST (0)

	movq	$1,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# DROP

# DUP

	movq	%r11,	%r12
# CONST (1)

	movq	$3,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# DROP

# DUP

	movq	%r11,	%r12
# CONST (2)

	movq	$5,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# DROP

# DROP

# DROP

# SLABEL ("L209")

L209:

# LINE (65)

	.stabn 68,0,65,.L25

.L25:

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

# SLABEL ("L210")

L210:

# SLABEL ("L208")

L208:

# JMP ("L166")

	jmp	L166
# LABEL ("L167")

L167:

# FAIL ((61, 5), false)

	movq	$11,	%r13
	movq	$123,	%r12
	leaq	string_0(%rip),	%r11
	pushq	%rdi
	pushq	%rsi
	movq	%r13,	%rcx
	movq	%r12,	%rdx
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$4,	%r11
	call	Bmatch_failure
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# JMP ("L166")

	jmp	L166
# LABEL ("L166")

L166:

# CONST (1)

	movq	$3,	%r10
# CONST (2)

	movq	$5,	%r11
# CONST (3)

	movq	$7,	%r12
# CALL (".array", 3, false)

	pushq	%rdi
	pushq	%rsi
	pushq	filler(%rip)
	pushq	%r12
	pushq	%r11
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$7,	%rsi
	call	Barray
	addq	$32,	%rsp
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DUP

	movq	%r10,	%r11
# SLABEL ("L222")

L222:

# DUP

	movq	%r11,	%r12
# ARRAY (0)

	movq	$1,	%r13
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Barray_patt
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CJMP ("nz", "L220")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L220
# LABEL ("L221")

L221:

# DROP

# JMP ("L219")

	jmp	L219
# LABEL ("L220")

L220:

# DROP

# DROP

# SLABEL ("L224")

L224:

# LINE (69)

	.stabn 68,0,69,.L26

.L26:

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

# SLABEL ("L225")

L225:

# JMP ("L213")

	jmp	L213
# SLABEL ("L223")

L223:

# SLABEL ("L231")

L231:

# LABEL ("L219")

L219:

# DUP

	movq	%r10,	%r11
# DUP

	movq	%r11,	%r12
# ARRAY (2)

	movq	$5,	%r13
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Barray_patt
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CJMP ("nz", "L229")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L229
# LABEL ("L230")

L230:

# DROP

# JMP ("L228")

	jmp	L228
# LABEL ("L229")

L229:

# DUP

	movq	%r11,	%r12
# CONST (0)

	movq	$1,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# DROP

# DUP

	movq	%r11,	%r12
# CONST (1)

	movq	$3,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# DROP

# DROP

# DUP

	movq	%r10,	%r11
# CONST (0)

	movq	$1,	%r12
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$2,	%r11
	call	Belem
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# ST (Local (1))

	movq	%r11,	-16(%rbp)
# DROP

# DUP

	movq	%r10,	%r11
# CONST (1)

	movq	$3,	%r12
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$2,	%r11
	call	Belem
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# ST (Local (0))

	movq	%r11,	-8(%rbp)
# DROP

# DROP

# SLABEL ("L233")

L233:

# LINE (70)

	.stabn 68,0,70,.L27

.L27:

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

# SLABEL ("L234")

L234:

# JMP ("L213")

	jmp	L213
# SLABEL ("L232")

L232:

# SLABEL ("L240")

L240:

# LABEL ("L228")

L228:

# DUP

	movq	%r10,	%r11
# DUP

	movq	%r11,	%r12
# ARRAY (3)

	movq	$7,	%r13
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Barray_patt
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CJMP ("nz", "L238")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L238
# LABEL ("L239")

L239:

# DROP

# JMP ("L237")

	jmp	L237
# LABEL ("L238")

L238:

# DUP

	movq	%r11,	%r12
# CONST (0)

	movq	$1,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# DROP

# DUP

	movq	%r11,	%r12
# CONST (1)

	movq	$3,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# DROP

# DUP

	movq	%r11,	%r12
# CONST (2)

	movq	$5,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# DROP

# DROP

# DROP

# SLABEL ("L242")

L242:

# LINE (71)

	.stabn 68,0,71,.L28

.L28:

# CONST (100)

	movq	$201,	%r10
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

# SLABEL ("L243")

L243:

# JMP ("L213")

	jmp	L213
# SLABEL ("L241")

L241:

# SLABEL ("L248")

L248:

# LABEL ("L237")

L237:

# DUP

	movq	%r10,	%r11
# DUP

	movq	%r11,	%r12
# ARRAY (3)

	movq	$7,	%r13
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Barray_patt
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# CJMP ("nz", "L246")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L246
# LABEL ("L247")

L247:

# DROP

# JMP ("L214")

	jmp	L214
# LABEL ("L246")

L246:

# DUP

	movq	%r11,	%r12
# CONST (0)

	movq	$1,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# DROP

# DUP

	movq	%r11,	%r12
# CONST (1)

	movq	$3,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# DROP

# DUP

	movq	%r11,	%r12
# CONST (2)

	movq	$5,	%r13
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# DROP

# DROP

# DUP

	movq	%r10,	%r11
# CONST (0)

	movq	$1,	%r12
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$2,	%r11
	call	Belem
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# ST (Local (2))

	movq	%r11,	-24(%rbp)
# DROP

# DUP

	movq	%r10,	%r11
# CONST (1)

	movq	$3,	%r12
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$2,	%r11
	call	Belem
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# ST (Local (1))

	movq	%r11,	-16(%rbp)
# DROP

# DUP

	movq	%r10,	%r11
# CONST (2)

	movq	$5,	%r12
# ELEM

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$2,	%r11
	call	Belem
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# ST (Local (0))

	movq	%r11,	-8(%rbp)
# DROP

# DROP

# SLABEL ("L250")

L250:

# LINE (72)

	.stabn 68,0,72,.L29

.L29:

# LD (Local (2))

	movq	-24(%rbp),	%r10
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

# LD (Local (1))

	movq	-16(%rbp),	%r10
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

# LD (Local (0))

	movq	-8(%rbp),	%r10
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

# SLABEL ("L251")

L251:

# SLABEL ("L249")

L249:

# JMP ("L213")

	jmp	L213
# LABEL ("L214")

L214:

# FAIL ((68, 5), false)

	movq	$11,	%r13
	movq	$137,	%r12
	leaq	string_0(%rip),	%r11
	pushq	%rdi
	pushq	%rsi
	movq	%r13,	%rcx
	movq	%r12,	%rdx
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$4,	%r11
	call	Bmatch_failure
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# JMP ("L213")

	jmp	L213
# LABEL ("L213")

L213:

# LINE (73)

	.stabn 68,0,73,.L30

.L30:

# LINE (75)

	.stabn 68,0,75,.L31

.L31:

# CONST (1)

	movq	$3,	%r10
# CONST (2)

	movq	$5,	%r11
# CONST (3)

	movq	$7,	%r12
# CONST (4)

	movq	$9,	%r13
# CONST (5)

	movq	$11,	%r14
# CONST (6)

	movq	$13,	-32(%rbp)
# CONST (1)

	movq	$3,	-40(%rbp)
# CONST (2)

	movq	$5,	-48(%rbp)
# CONST (3)

	movq	$7,	-56(%rbp)
# SEXP ("Cons", 3)

	movq	$15329063,	-64(%rbp)
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	filler(%rip)
	pushq	-64(%rbp)
	pushq	-56(%rbp)
	pushq	-48(%rbp)
	pushq	-40(%rbp)
	movq	%rsp,	%rdi
	movq	$9,	%rsi
	call	Bsexp
	addq	$40,	%rsp
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	-40(%rbp)
# CALL (".array", 4, false)

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	pushq	%r12
	pushq	filler(%rip)
	pushq	-40(%rbp)
	pushq	-32(%rbp)
	pushq	%r14
	pushq	%r13
	movq	%rsp,	%rdi
	movq	$9,	%rsi
	call	Barray
	addq	$40,	%rsp
	popq	%r12
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r13
# CALL (".array", 4, false)

	pushq	%rdi
	pushq	%rsi
	pushq	%r13
	pushq	%r12
	pushq	%r11
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$9,	%rsi
	call	Barray
	addq	$32,	%rsp
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# CALL ("Lcollect_ints", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lcollect_ints
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# CALL ("Lprint_list", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lprint_list
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

	.set	Lmain_SIZE,	64

	.set	LSmain_SIZE,	8

	.size main, .-main

# LABEL ("Lprint_list")

Lprint_list:

# BEGIN ("Lprint_list", 1, 2, [], ["l"], [{ blab="L273"; elab="L274"; names=[]; subs=[{ blab="L276"; elab="L277"; names=[]; subs=[{ blab="L290"; elab="L291"; names=[("n", 1); ("t", 0)]; subs=[{ blab="L292"; elab="L293"; names=[]; subs=[]; }]; }; { blab="L283"; elab="L284"; names=[]; subs=[{ blab="L285"; elab="L286"; names=[]; subs=[]; }]; }]; }]; }])

	.type print_list, @function

	.stabs "print_list:F1",36,0,0,Lprint_list

	.stabs "n:1",128,0,0,-16

	.stabs "t:1",128,0,0,-8

	.stabn 192,0,0,L290-Lprint_list

	.stabn 224,0,0,L291-Lprint_list

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLprint_list_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLprint_list_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$1,	%r11
	je	Lprint_list_argc_correct
	movq	%r11,	%r13
	movq	$1,	%r12
	leaq	string_6(%rip),	%r11
	leaq	string_5(%rip),	%r10
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
Lprint_list_argc_correct:

# SLABEL ("L273")

L273:

# SLABEL ("L276")

L276:

# LINE (21)

	.stabn 68,0,21,0

	.stabn 68,0,21,.L32-Lprint_list

.L32:

# LD (Arg (0))

	movq	%rdi,	%r10
# DUP

	movq	%r10,	%r11
# SLABEL ("L283")

L283:

# DUP

	movq	%r11,	%r12
# TAG ("Nil", 0)

	movq	$328857,	%r13
	movq	$1,	%r14
	pushq	%rdi
	pushq	%r10
	pushq	%r11
	pushq	filler(%rip)
	movq	%r14,	%rdx
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$3,	%r11
	call	Btag
	addq	$8,	%rsp
	popq	%r11
	popq	%r10
	popq	%rdi
	movq	%rax,	%r12
# CJMP ("nz", "L281")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L281
# LABEL ("L282")

L282:

# DROP

# JMP ("L280")

	jmp	L280
# LABEL ("L281")

L281:

# DROP

# DROP

# SLABEL ("L285")

L285:

# CONST (0)

	movq	$1,	%r10
# SLABEL ("L286")

L286:

# JMP ("L275")

	jmp	L275
# SLABEL ("L284")

L284:

# SLABEL ("L290")

L290:

# LABEL ("L280")

L280:

# DUP

	movq	%r10,	%r11
# DUP

	movq	%r11,	%r12
# TAG ("Cons", 2)

	movq	$15329063,	%r13
	movq	$5,	%r14
	pushq	%rdi
	pushq	%r10
	pushq	%r11
	pushq	filler(%rip)
	movq	%r14,	%rdx
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$3,	%r11
	call	Btag
	addq	$8,	%rsp
	popq	%r11
	popq	%r10
	popq	%rdi
	movq	%rax,	%r12
# CJMP ("nz", "L288")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L288
# LABEL ("L289")

L289:

# DROP

# JMP ("L278")

	jmp	L278
# LABEL ("L288")

L288:

# DUP

	movq	%r11,	%r12
# CONST (0)

	movq	$1,	%r13
# ELEM

	pushq	%rdi
	pushq	%r10
	pushq	%r11
	pushq	filler(%rip)
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	addq	$8,	%rsp
	popq	%r11
	popq	%r10
	popq	%rdi
	movq	%rax,	%r12
# DROP

# DUP

	movq	%r11,	%r12
# CONST (1)

	movq	$3,	%r13
# ELEM

	pushq	%rdi
	pushq	%r10
	pushq	%r11
	pushq	filler(%rip)
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Belem
	addq	$8,	%rsp
	popq	%r11
	popq	%r10
	popq	%rdi
	movq	%rax,	%r12
# DROP

# DROP

# DUP

	movq	%r10,	%r11
# CONST (0)

	movq	$1,	%r12
# ELEM

	pushq	%rdi
	pushq	%r10
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r10
	popq	%rdi
	movq	%rax,	%r11
# ST (Local (1))

	movq	%r11,	-16(%rbp)
# DROP

# DUP

	movq	%r10,	%r11
# CONST (1)

	movq	$3,	%r12
# ELEM

	pushq	%rdi
	pushq	%r10
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r10
	popq	%rdi
	movq	%rax,	%r11
# ST (Local (0))

	movq	%r11,	-8(%rbp)
# DROP

# DROP

# SLABEL ("L292")

L292:

# LINE (23)

	.stabn 68,0,23,.L33-Lprint_list

.L33:

# LD (Local (1))

	movq	-16(%rbp),	%r10
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

# LD (Local (0))

	movq	-8(%rbp),	%r10
# CALL ("Lprint_list", 1, true)

	movq	%r10,	%rdi
	movq	%rbp,	%rsp
	popq	%rbp
	movq	$1,	%r11
	jmp	Lprint_list
# SLABEL ("L293")

L293:

# SLABEL ("L291")

L291:

# JMP ("L275")

	jmp	L275
# LABEL ("L278")

L278:

# FAIL ((21, 7), true)

	movq	$15,	%r14
	movq	$43,	%r13
	leaq	string_0(%rip),	%r12
	movq	%r10,	%r11
	pushq	%rdi
	pushq	%r10
	movq	%r14,	%rcx
	movq	%r13,	%rdx
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$4,	%r11
	call	Bmatch_failure
	popq	%r10
	popq	%rdi
	movq	%rax,	%r11
# JMP ("L275")

	jmp	L275
# SLABEL ("L277")

L277:

# LABEL ("L275")

L275:

# SLABEL ("L274")

L274:

# END

	movq	%r10,	%rax
LLprint_list_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLprint_list_SIZE,	16

	.set	LSLprint_list_SIZE,	2

	.size Lprint_list, .-Lprint_list

# LABEL ("Lcollect_ints")

Lcollect_ints:

# BEGIN ("Lcollect_ints", 1, 0, [], ["v"], [{ blab="L298"; elab="L299"; names=[]; subs=[{ blab="L301"; elab="L302"; names=[]; subs=[]; }]; }])

	.type collect_ints, @function

	.stabs "collect_ints:F1",36,0,0,Lcollect_ints

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLcollect_ints_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLcollect_ints_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$1,	%r11
	je	Lcollect_ints_argc_correct
	movq	%r11,	%r13
	movq	$1,	%r12
	leaq	string_7(%rip),	%r11
	leaq	string_5(%rip),	%r10
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
Lcollect_ints_argc_correct:

# SLABEL ("L298")

L298:

# SLABEL ("L301")

L301:

# LINE (16)

	.stabn 68,0,16,0

	.stabn 68,0,16,.L34-Lcollect_ints

.L34:

# LINE (17)

	.stabn 68,0,17,.L35-Lcollect_ints

.L35:

# LD (Arg (0))

	movq	%rdi,	%r10
# SEXP ("Nil", 0)

	movq	$328857,	%r11
	pushq	%rdi
	pushq	%r10
	pushq	filler(%rip)
	pushq	%r11
	movq	%rsp,	%rdi
	movq	$3,	%rsi
	call	Bsexp
	addq	$16,	%rsp
	popq	%r10
	popq	%rdi
	movq	%rax,	%r11
# CALL ("Lcollect_ints_acc", 2, true)

	pushq	%rdi
	pushq	filler(%rip)
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$2,	%r11
	call	Lcollect_ints_acc
	addq	$8,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# SLABEL ("L302")

L302:

# LABEL ("L300")

L300:

# SLABEL ("L299")

L299:

# END

	movq	%r10,	%rax
LLcollect_ints_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLcollect_ints_SIZE,	0

	.set	LSLcollect_ints_SIZE,	0

	.size Lcollect_ints, .-Lcollect_ints

# LABEL ("Lcollect_ints_acc")

Lcollect_ints_acc:

# BEGIN ("Lcollect_ints_acc", 2, 2, [], ["v"; "tail"], [{ blab="L306"; elab="L307"; names=[]; subs=[{ blab="L309"; elab="L310"; names=[("i", 0)]; subs=[{ blab="L325"; elab="L326"; names=[]; subs=[{ blab="L327"; elab="L328"; names=[]; subs=[{ blab="L330"; elab="L331"; names=[]; subs=[{ blab="L342"; elab="L343"; names=[]; subs=[]; }]; }]; }]; }; { blab="L321"; elab="L322"; names=[]; subs=[{ blab="L323"; elab="L324"; names=[]; subs=[]; }]; }; { blab="L314"; elab="L315"; names=[("a", 1)]; subs=[{ blab="L316"; elab="L317"; names=[]; subs=[]; }]; }]; }]; }])

	.type collect_ints_acc, @function

	.stabs "collect_ints_acc:F1",36,0,0,Lcollect_ints_acc

	.stabs "i:1",128,0,0,-8

	.stabn 192,0,0,L309-Lcollect_ints_acc

	.stabs "a:1",128,0,0,-16

	.stabn 192,0,0,L314-Lcollect_ints_acc

	.stabn 224,0,0,L315-Lcollect_ints_acc

	.stabn 224,0,0,L310-Lcollect_ints_acc

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLcollect_ints_acc_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLcollect_ints_acc_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$2,	%r11
	je	Lcollect_ints_acc_argc_correct
	movq	%r11,	%r13
	movq	$2,	%r12
	leaq	string_8(%rip),	%r11
	leaq	string_5(%rip),	%r10
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
Lcollect_ints_acc_argc_correct:

# SLABEL ("L306")

L306:

# SLABEL ("L309")

L309:

# LINE (5)

	.stabn 68,0,5,0

	.stabn 68,0,5,.L36-Lcollect_ints_acc

.L36:

# LD (Arg (0))

	movq	%rdi,	%r10
# DUP

	movq	%r10,	%r11
# SLABEL ("L314")

L314:

# PATT (UnBoxed)

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r11,	%rdi
	movq	$1,	%r11
	call	Bunboxed_patt
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# CJMP ("z", "L313")

	sarq	%r11
	cmpq	$0,	%r11
	jz	L313
# DUP

	movq	%r10,	%r11
# ST (Local (1))

	movq	%r11,	-16(%rbp)
# DROP

# DROP

# SLABEL ("L316")

L316:

# LINE (6)

	.stabn 68,0,6,.L37-Lcollect_ints_acc

.L37:

# LD (Local (1))

	movq	-16(%rbp),	%r10
# LD (Arg (1))

	movq	%rsi,	%r11
# SEXP ("Cons", 2)

	movq	$15329063,	%r12
	pushq	%rdi
	pushq	%rsi
	pushq	filler(%rip)
	pushq	%r12
	pushq	%r11
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$7,	%rsi
	call	Bsexp
	addq	$32,	%rsp
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# SLABEL ("L317")

L317:

# JMP ("L308")

	jmp	L308
# SLABEL ("L315")

L315:

# SLABEL ("L321")

L321:

# LABEL ("L313")

L313:

# DUP

	movq	%r10,	%r11
# PATT (String)

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r11,	%rdi
	movq	$1,	%r11
	call	Bstring_tag_patt
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# CJMP ("z", "L320")

	sarq	%r11
	cmpq	$0,	%r11
	jz	L320
# DROP

# SLABEL ("L323")

L323:

# LINE (7)

	.stabn 68,0,7,.L38-Lcollect_ints_acc

.L38:

# LD (Arg (1))

	movq	%rsi,	%r10
# SLABEL ("L324")

L324:

# JMP ("L308")

	jmp	L308
# SLABEL ("L322")

L322:

# SLABEL ("L325")

L325:

# LABEL ("L320")

L320:

# DUP

	movq	%r10,	%r11
# DROP

# DROP

# SLABEL ("L327")

L327:

# SLABEL ("L330")

L330:

# CONST (0)

	movq	$1,	%r10
# LINE (9)

	.stabn 68,0,9,.L39-Lcollect_ints_acc

.L39:

# ST (Local (0))

	movq	%r10,	-8(%rbp)
# DROP

# JMP ("L337")

	jmp	L337
# FLABEL ("L336")

L336:

# SLABEL ("L342")

L342:

# LINE (10)

	.stabn 68,0,10,.L40-Lcollect_ints_acc

.L40:

# LD (Arg (0))

	movq	%rdi,	%r10
# LD (Local (0))

	movq	-8(%rbp),	%r11
# ELEM

	pushq	%rdi
	pushq	%rsi
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# LD (Arg (1))

	movq	%rsi,	%r11
# CALL ("Lcollect_ints_acc", 2, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$2,	%r11
	call	Lcollect_ints_acc
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# ST (Arg (1))

	movq	%r10,	%rsi
# DROP

# SLABEL ("L343")

L343:

# LD (Local (0))

	movq	-8(%rbp),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# LINE (9)

	.stabn 68,0,9,.L41-Lcollect_ints_acc

.L41:

# ST (Local (0))

	movq	%r10,	-8(%rbp)
# DROP

# LABEL ("L337")

L337:

# LD (Local (0))

	movq	-8(%rbp),	%r10
# LD (Arg (0))

	movq	%rdi,	%r11
# CALL ("Llength", 1, false)

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r11,	%rdi
	movq	$1,	%r11
	call	Llength
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# BINOP ("<")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setl	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("nz", "L336")

	sarq	%r10
	cmpq	$0,	%r10
	jnz	L336
# SLABEL ("L331")

L331:

# LINE (11)

	.stabn 68,0,11,.L42-Lcollect_ints_acc

.L42:

# LD (Arg (1))

	movq	%rsi,	%r10
# SLABEL ("L328")

L328:

# SLABEL ("L326")

L326:

# JMP ("L308")

	jmp	L308
# SLABEL ("L310")

L310:

# LABEL ("L308")

L308:

# SLABEL ("L307")

L307:

# END

	movq	%r10,	%rax
LLcollect_ints_acc_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLcollect_ints_acc_SIZE,	16

	.set	LSLcollect_ints_acc_SIZE,	2

	.size Lcollect_ints_acc, .-Lcollect_ints_acc


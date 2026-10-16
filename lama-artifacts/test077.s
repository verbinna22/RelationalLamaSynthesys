	.file "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test077/test077.lama"

	.stabs "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test077/test077.lama",100,0,0,.Ltext

	.globl	main

	.data

string_0:	.string	"Function %s called with incorrect arguments count. Expected: %d. Actual: %d\n"

string_1:	.string	"sort"

init:	.quad 0

	.section custom_data,"aw",@progbits

filler:	.fill	4, 8, 1

	.stabs "i:S1",40,0,0,global_i

global_i:	.quad	1

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

# LINE (22)

	.stabn 68,0,22,.L0

.L0:

# CALL ("Lread", 0, false)

	pushq	%rdi
	pushq	%rsi
	movq	$0,	%r11
	call	Lread
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# LINE (20)

	.stabn 68,0,20,.L1

.L1:

# ST (Global ("n"))

	movq	%r10,	global_n(%rip)
# DROP

# CONST (10)

	movq	$21,	%r10
# CONST (9)

	movq	$19,	%r11
# CONST (8)

	movq	$17,	%r12
# CONST (7)

	movq	$15,	%r13
# CONST (6)

	movq	$13,	%r14
# CONST (5)

	movq	$11,	-8(%rbp)
# CALL (".array", 6, false)

	pushq	%rdi
	pushq	%rsi
	pushq	-8(%rbp)
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r11
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$13,	%rsi
	call	Barray
	addq	$48,	%rsp
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# ST (Global ("x"))

	movq	%r10,	global_x(%rip)
# DROP

# LINE (25)

	.stabn 68,0,25,.L2

.L2:

# LD (Global ("x"))

	movq	global_x(%rip),	%r10
# CALL ("Lsort", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lsort
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# LINE (23)

	.stabn 68,0,23,.L3

.L3:

# ST (Global ("x"))

	movq	%r10,	global_x(%rip)
# DROP

# SLABEL ("L21")

L21:

# CONST (0)

	movq	$1,	%r10
# LINE (27)

	.stabn 68,0,27,.L4

.L4:

# ST (Global ("i"))

	movq	%r10,	global_i(%rip)
# DROP

# JMP ("L28")

	jmp	L28
# FLABEL ("L27")

L27:

# SLABEL ("L33")

L33:

# LINE (28)

	.stabn 68,0,28,.L5

.L5:

# LD (Global ("x"))

	movq	global_x(%rip),	%r10
# LD (Global ("i"))

	movq	global_i(%rip),	%r11
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

# SLABEL ("L34")

L34:

# LD (Global ("i"))

	movq	global_i(%rip),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# LINE (27)

	.stabn 68,0,27,.L6

.L6:

# ST (Global ("i"))

	movq	%r10,	global_i(%rip)
# DROP

# LABEL ("L28")

L28:

# LD (Global ("i"))

	movq	global_i(%rip),	%r10
# LD (Global ("x"))

	movq	global_x(%rip),	%r11
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
# CJMP ("nz", "L27")

	sarq	%r10
	cmpq	$0,	%r10
	jnz	L27
# SLABEL ("L22")

L22:

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

# LABEL ("Lsort")

Lsort:

# BEGIN ("Lsort", 1, 4, [], ["x"], [{ blab="L43"; elab="L44"; names=[]; subs=[{ blab="L46"; elab="L47"; names=[("i", 3); ("j", 2); ("y", 1); ("n", 0)]; subs=[{ blab="L61"; elab="L62"; names=[]; subs=[{ blab="L72"; elab="L73"; names=[]; subs=[{ blab="L74"; elab="L75"; names=[]; subs=[{ blab="L87"; elab="L88"; names=[]; subs=[{ blab="L97"; elab="L98"; names=[]; subs=[]; }]; }]; }]; }]; }; { blab="L57"; elab="L58"; names=[]; subs=[]; }]; }]; }])

	.type sort, @function

	.stabs "sort:F1",36,0,0,Lsort

	.stabs "i:1",128,0,0,-32

	.stabs "j:1",128,0,0,-24

	.stabs "y:1",128,0,0,-16

	.stabs "n:1",128,0,0,-8

	.stabn 192,0,0,L46-Lsort

	.stabn 224,0,0,L47-Lsort

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLsort_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLsort_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$1,	%r11
	je	Lsort_argc_correct
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
Lsort_argc_correct:

# SLABEL ("L43")

L43:

# SLABEL ("L46")

L46:

# LINE (5)

	.stabn 68,0,5,0

	.stabn 68,0,5,.L7-Lsort

.L7:

# LD (Arg (0))

	movq	%rdi,	%r10
# CALL ("Llength", 1, false)

	pushq	%rdi
	pushq	filler(%rip)
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Llength
	addq	$8,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# LINE (4)

	.stabn 68,0,4,.L8-Lsort

.L8:

# ST (Local (0))

	movq	%r10,	-8(%rbp)
# DROP

# LINE (7)

	.stabn 68,0,7,.L9-Lsort

.L9:

# LD (Local (0))

	movq	-8(%rbp),	%r10
# CONST (0)

	movq	$1,	%r11
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("z", "L54")

	sarq	%r10
	cmpq	$0,	%r10
	jz	L54
# SLABEL ("L57")

L57:

# LD (Arg (0))

	movq	%rdi,	%r10
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

# SLABEL ("L61")

L61:

# CONST (0)

	movq	$1,	%r10
# LINE (9)

	.stabn 68,0,9,.L10-Lsort

.L10:

# ST (Local (3))

	movq	%r10,	-32(%rbp)
# DROP

# JMP ("L68")

	jmp	L68
# FLABEL ("L67")

L67:

# SLABEL ("L72")

L72:

# SLABEL ("L74")

L74:

# LD (Local (3))

	movq	-32(%rbp),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# LINE (10)

	.stabn 68,0,10,.L11-Lsort

.L11:

# ST (Local (2))

	movq	%r10,	-24(%rbp)
# DROP

# JMP ("L83")

	jmp	L83
# FLABEL ("L82")

L82:

# SLABEL ("L87")

L87:

# LINE (11)

	.stabn 68,0,11,.L12-Lsort

.L12:

# LD (Arg (0))

	movq	%rdi,	%r10
# LD (Local (2))

	movq	-24(%rbp),	%r11
# ELEM

	pushq	%rdi
	pushq	filler(%rip)
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$2,	%r11
	call	Belem
	addq	$8,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# LD (Arg (0))

	movq	%rdi,	%r11
# LD (Local (3))

	movq	-32(%rbp),	%r12
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
# BINOP ("<")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setl	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("z", "L90")

	sarq	%r10
	cmpq	$0,	%r10
	jz	L90
# SLABEL ("L97")

L97:

# LINE (12)

	.stabn 68,0,12,.L13-Lsort

.L13:

# LD (Arg (0))

	movq	%rdi,	%r10
# LD (Local (3))

	movq	-32(%rbp),	%r11
# ELEM

	pushq	%rdi
	pushq	filler(%rip)
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$2,	%r11
	call	Belem
	addq	$8,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# ST (Local (1))

	movq	%r10,	-16(%rbp)
# DROP

# LD (Arg (0))

	movq	%rdi,	%r10
# LINE (13)

	.stabn 68,0,13,.L14-Lsort

.L14:

# LD (Local (3))

	movq	-32(%rbp),	%r11
# LD (Arg (0))

	movq	%rdi,	%r12
# LD (Local (2))

	movq	-24(%rbp),	%r13
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
# STA

	pushq	%rdi
	pushq	filler(%rip)
	movq	%r12,	%rdx
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$3,	%r11
	call	Bsta
	addq	$8,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LD (Arg (0))

	movq	%rdi,	%r10
# LINE (14)

	.stabn 68,0,14,.L15-Lsort

.L15:

# LD (Local (2))

	movq	-24(%rbp),	%r11
# LD (Local (1))

	movq	-16(%rbp),	%r12
# STA

	pushq	%rdi
	pushq	filler(%rip)
	movq	%r12,	%rdx
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$3,	%r11
	call	Bsta
	addq	$8,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# DROP

# SLABEL ("L98")

L98:

# JMP ("L86")

	jmp	L86
# LABEL ("L90")

L90:

# JMP ("L86")

	jmp	L86
# SLABEL ("L88")

L88:

# LABEL ("L86")

L86:

# LD (Local (2))

	movq	-24(%rbp),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# LINE (10)

	.stabn 68,0,10,.L16-Lsort

.L16:

# ST (Local (2))

	movq	%r10,	-24(%rbp)
# DROP

# LABEL ("L83")

L83:

# LD (Local (2))

	movq	-24(%rbp),	%r10
# LD (Local (0))

	movq	-8(%rbp),	%r11
# BINOP ("<")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setl	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("nz", "L82")

	sarq	%r10
	cmpq	$0,	%r10
	jnz	L82
# SLABEL ("L75")

L75:

# SLABEL ("L73")

L73:

# LD (Local (3))

	movq	-32(%rbp),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# LINE (9)

	.stabn 68,0,9,.L17-Lsort

.L17:

# ST (Local (3))

	movq	%r10,	-32(%rbp)
# DROP

# LABEL ("L68")

L68:

# LD (Local (3))

	movq	-32(%rbp),	%r10
# LD (Local (0))

	movq	-8(%rbp),	%r11
# BINOP ("<")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setl	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("nz", "L67")

	sarq	%r10
	cmpq	$0,	%r10
	jnz	L67
# SLABEL ("L62")

L62:

# LINE (17)

	.stabn 68,0,17,.L18-Lsort

.L18:

# LD (Arg (0))

	movq	%rdi,	%r10
# SLABEL ("L47")

L47:

# LABEL ("L45")

L45:

# SLABEL ("L44")

L44:

# END

	movq	%r10,	%rax
LLsort_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLsort_SIZE,	32

	.set	LSLsort_SIZE,	4

	.size Lsort, .-Lsort


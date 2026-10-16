	.file "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test036/test036.lama"

	.stabs "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test036/test036.lama",100,0,0,.Ltext

	.globl	main

	.data

string_2:	.string	"Function %s called with incorrect arguments count. Expected: %d. Actual: %d\n"

string_0:	.string	"abcd"

string_1:	.string	"efgh"

string_3:	.string	"printAS"

init:	.quad 0

	.section custom_data,"aw",@progbits

filler:	.fill	2, 8, 1

	.stabs "i:S1",40,0,0,global_i

global_i:	.quad	1

	.stabs "j:S1",40,0,0,global_j

global_j:	.quad	1

	.stabs "x:S1",40,0,0,global_x

global_x:	.quad	1

	.stabs "y:S1",40,0,0,global_y

global_y:	.quad	1

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

# ST (Global ("y"))

	movq	%r10,	global_y(%rip)
# DROP

# STRING ("abcd")

	leaq	string_0(%rip),	%r10
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
# STRING ("efgh")

	leaq	string_1(%rip),	%r11
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%rsp,	%rdi
	call	Bstring
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# CALL (".array", 2, false)

	pushq	%rdi
	pushq	%rsi
	pushq	%r11
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$5,	%rsi
	call	Barray
	addq	$16,	%rsp
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# ST (Global ("x"))

	movq	%r10,	global_x(%rip)
# DROP

# LINE (14)

	.stabn 68,0,14,.L2

.L2:

# LINE (16)

	.stabn 68,0,16,.L3

.L3:

# LD (Global ("x"))

	movq	global_x(%rip),	%r10
# CALL ("LprintAS", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	LprintAS
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# SLABEL ("L16")

L16:

# CONST (0)

	movq	$1,	%r10
# LINE (18)

	.stabn 68,0,18,.L4

.L4:

# ST (Global ("i"))

	movq	%r10,	global_i(%rip)
# DROP

# JMP ("L23")

	jmp	L23
# FLABEL ("L22")

L22:

# SLABEL ("L28")

L28:

# SLABEL ("L30")

L30:

# CONST (0)

	movq	$1,	%r10
# LINE (19)

	.stabn 68,0,19,.L5

.L5:

# ST (Global ("j"))

	movq	%r10,	global_j(%rip)
# DROP

# JMP ("L37")

	jmp	L37
# FLABEL ("L36")

L36:

# SLABEL ("L44")

L44:

# LD (Global ("x"))

	movq	global_x(%rip),	%r10
# LINE (20)

	.stabn 68,0,20,.L6

.L6:

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
# LD (Global ("j"))

	movq	global_j(%rip),	%r11
# CONST (97)

	movq	$195,	%r12
# STA

	pushq	%rdi
	pushq	%rsi
	movq	%r12,	%rdx
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$3,	%r11
	call	Bsta
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# SLABEL ("L45")

L45:

# LD (Global ("j"))

	movq	global_j(%rip),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# LINE (19)

	.stabn 68,0,19,.L7

.L7:

# ST (Global ("j"))

	movq	%r10,	global_j(%rip)
# DROP

# LABEL ("L37")

L37:

# LD (Global ("j"))

	movq	global_j(%rip),	%r10
# LD (Global ("x"))

	movq	global_x(%rip),	%r11
# LD (Global ("i"))

	movq	global_i(%rip),	%r12
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
# CJMP ("nz", "L36")

	sarq	%r10
	cmpq	$0,	%r10
	jnz	L36
# SLABEL ("L31")

L31:

# SLABEL ("L29")

L29:

# LD (Global ("i"))

	movq	global_i(%rip),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# LINE (18)

	.stabn 68,0,18,.L8

.L8:

# ST (Global ("i"))

	movq	%r10,	global_i(%rip)
# DROP

# LABEL ("L23")

L23:

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
# CJMP ("nz", "L22")

	sarq	%r10
	cmpq	$0,	%r10
	jnz	L22
# SLABEL ("L17")

L17:

# LINE (22)

	.stabn 68,0,22,.L9

.L9:

# LINE (24)

	.stabn 68,0,24,.L10

.L10:

# LD (Global ("x"))

	movq	global_x(%rip),	%r10
# CALL ("LprintAS", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	LprintAS
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

# LABEL ("LprintAS")

LprintAS:

# BEGIN ("LprintAS", 1, 2, [], ["x"], [{ blab="L61"; elab="L62"; names=[]; subs=[{ blab="L64"; elab="L65"; names=[("i", 1); ("j", 0)]; subs=[{ blab="L67"; elab="L68"; names=[]; subs=[{ blab="L79"; elab="L80"; names=[]; subs=[{ blab="L81"; elab="L82"; names=[]; subs=[{ blab="L95"; elab="L96"; names=[]; subs=[]; }]; }]; }]; }]; }]; }])

	.type printAS, @function

	.stabs "printAS:F1",36,0,0,LprintAS

	.stabs "i:1",128,0,0,-16

	.stabs "j:1",128,0,0,-8

	.stabn 192,0,0,L64-LprintAS

	.stabn 224,0,0,L65-LprintAS

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLprintAS_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLprintAS_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$1,	%r11
	je	LprintAS_argc_correct
	movq	%r11,	%r13
	movq	$1,	%r12
	leaq	string_3(%rip),	%r11
	leaq	string_2(%rip),	%r10
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
LprintAS_argc_correct:

# SLABEL ("L61")

L61:

# SLABEL ("L64")

L64:

# SLABEL ("L67")

L67:

# CONST (0)

	movq	$1,	%r10
# LINE (5)

	.stabn 68,0,5,0

	.stabn 68,0,5,.L11-LprintAS

.L11:

# ST (Local (1))

	movq	%r10,	-16(%rbp)
# DROP

# JMP ("L74")

	jmp	L74
# FLABEL ("L73")

L73:

# SLABEL ("L79")

L79:

# SLABEL ("L81")

L81:

# CONST (0)

	movq	$1,	%r10
# LINE (6)

	.stabn 68,0,6,.L12-LprintAS

.L12:

# ST (Local (0))

	movq	%r10,	-8(%rbp)
# DROP

# JMP ("L88")

	jmp	L88
# FLABEL ("L87")

L87:

# SLABEL ("L95")

L95:

# LINE (7)

	.stabn 68,0,7,.L13-LprintAS

.L13:

# LD (Arg (0))

	movq	%rdi,	%r10
# LD (Local (1))

	movq	-16(%rbp),	%r11
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
# LD (Local (0))

	movq	-8(%rbp),	%r11
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

# SLABEL ("L96")

L96:

# LD (Local (0))

	movq	-8(%rbp),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# LINE (6)

	.stabn 68,0,6,.L14-LprintAS

.L14:

# ST (Local (0))

	movq	%r10,	-8(%rbp)
# DROP

# LABEL ("L88")

L88:

# LD (Local (0))

	movq	-8(%rbp),	%r10
# LD (Arg (0))

	movq	%rdi,	%r11
# LD (Local (1))

	movq	-16(%rbp),	%r12
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
# CALL ("Llength", 1, false)

	pushq	%rdi
	pushq	%r10
	movq	%r11,	%rdi
	movq	$1,	%r11
	call	Llength
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
# CJMP ("nz", "L87")

	sarq	%r10
	cmpq	$0,	%r10
	jnz	L87
# SLABEL ("L82")

L82:

# SLABEL ("L80")

L80:

# LD (Local (1))

	movq	-16(%rbp),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# LINE (5)

	.stabn 68,0,5,.L15-LprintAS

.L15:

# ST (Local (1))

	movq	%r10,	-16(%rbp)
# DROP

# LABEL ("L74")

L74:

# LD (Local (1))

	movq	-16(%rbp),	%r10
# LD (Arg (0))

	movq	%rdi,	%r11
# CALL ("Llength", 1, false)

	pushq	%rdi
	pushq	%r10
	movq	%r11,	%rdi
	movq	$1,	%r11
	call	Llength
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
# CJMP ("nz", "L73")

	sarq	%r10
	cmpq	$0,	%r10
	jnz	L73
# SLABEL ("L68")

L68:

# CONST (0)

	movq	$1,	%r10
# SLABEL ("L65")

L65:

# LABEL ("L63")

L63:

# SLABEL ("L62")

L62:

# END

	movq	%r10,	%rax
LLprintAS_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLprintAS_SIZE,	16

	.set	LSLprintAS_SIZE,	2

	.size LprintAS, .-LprintAS


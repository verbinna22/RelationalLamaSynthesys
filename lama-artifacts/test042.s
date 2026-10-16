	.file "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test042/test042.lama"

	.stabs "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test042/test042.lama",100,0,0,.Ltext

	.globl	main

	.data

string_0:	.string	"Function %s called with incorrect arguments count. Expected: %d. Actual: %d\n"

string_1:	.string	"f"

init:	.quad 0

	.section custom_data,"aw",@progbits

filler:	.fill	3, 8, 1

	.stabs "i:S1",40,0,0,global_i

global_i:	.quad	1

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

# LINE (13)

	.stabn 68,0,13,.L0

.L0:

# CALL ("Lread", 0, false)

	pushq	%rdi
	pushq	%rsi
	movq	$0,	%r11
	call	Lread
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# LINE (11)

	.stabn 68,0,11,.L1

.L1:

# ST (Global ("x"))

	movq	%r10,	global_x(%rip)
# DROP

# SEXP ("Nil", 0)

	movq	$328857,	%r10
	pushq	%rdi
	pushq	%rsi
	pushq	filler(%rip)
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$3,	%rsi
	call	Bsexp
	addq	$16,	%rsp
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# ST (Global ("y"))

	movq	%r10,	global_y(%rip)
# DROP

# SLABEL ("L12")

L12:

# CONST (0)

	movq	$1,	%r10
# LINE (16)

	.stabn 68,0,16,.L2

.L2:

# ST (Global ("i"))

	movq	%r10,	global_i(%rip)
# DROP

# JMP ("L19")

	jmp	L19
# FLABEL ("L18")

L18:

# SLABEL ("L23")

L23:

# LINE (17)

	.stabn 68,0,17,.L3

.L3:

# LD (Global ("y"))

	movq	global_y(%rip),	%r10
# CALL ("Lf", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lf
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LINE (18)

	.stabn 68,0,18,.L4

.L4:

# LD (Global ("i"))

	movq	global_i(%rip),	%r10
# LD (Global ("y"))

	movq	global_y(%rip),	%r11
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
# ST (Global ("y"))

	movq	%r10,	global_y(%rip)
# DROP

# SLABEL ("L24")

L24:

# LD (Global ("i"))

	movq	global_i(%rip),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# LINE (16)

	.stabn 68,0,16,.L5

.L5:

# ST (Global ("i"))

	movq	%r10,	global_i(%rip)
# DROP

# LABEL ("L19")

L19:

# LD (Global ("i"))

	movq	global_i(%rip),	%r10
# CONST (10)

	movq	$21,	%r11
# BINOP ("<")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setl	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("nz", "L18")

	sarq	%r10
	cmpq	$0,	%r10
	jnz	L18
# SLABEL ("L13")

L13:

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

# LABEL ("Lf")

Lf:

# BEGIN ("Lf", 1, 0, [], ["x"], [{ blab="L36"; elab="L37"; names=[]; subs=[{ blab="L39"; elab="L40"; names=[]; subs=[{ blab="L87"; elab="L88"; names=[]; subs=[{ blab="L89"; elab="L90"; names=[]; subs=[]; }]; }; { blab="L82"; elab="L83"; names=[]; subs=[{ blab="L84"; elab="L85"; names=[]; subs=[]; }]; }; { blab="L68"; elab="L69"; names=[]; subs=[{ blab="L70"; elab="L71"; names=[]; subs=[]; }]; }; { blab="L56"; elab="L57"; names=[]; subs=[{ blab="L58"; elab="L59"; names=[]; subs=[]; }]; }; { blab="L46"; elab="L47"; names=[]; subs=[{ blab="L48"; elab="L49"; names=[]; subs=[]; }]; }]; }]; }])

	.type f, @function

	.stabs "f:F1",36,0,0,Lf

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLf_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLf_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$1,	%r11
	je	Lf_argc_correct
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
Lf_argc_correct:

# SLABEL ("L36")

L36:

# SLABEL ("L39")

L39:

# LINE (4)

	.stabn 68,0,4,0

	.stabn 68,0,4,.L6-Lf

.L6:

# LD (Arg (0))

	movq	%rdi,	%r10
# DUP

	movq	%r10,	%r11
# SLABEL ("L46")

L46:

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
# CJMP ("nz", "L44")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L44
# LABEL ("L45")

L45:

# DROP

# JMP ("L43")

	jmp	L43
# LABEL ("L44")

L44:

# DROP

# DROP

# SLABEL ("L48")

L48:

# LINE (5)

	.stabn 68,0,5,.L7-Lf

.L7:

# CONST (0)

	movq	$1,	%r10
# CALL ("Lwrite", 1, true)

	movq	%r10,	%rdi
	movq	%rbp,	%rsp
	popq	%rbp
	movq	$1,	%r11
	jmp	Lwrite
# SLABEL ("L49")

L49:

# JMP ("L38")

	jmp	L38
# SLABEL ("L47")

L47:

# SLABEL ("L56")

L56:

# LABEL ("L43")

L43:

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
# CJMP ("nz", "L52")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L52
# LABEL ("L53")

L53:

# DROP

# JMP ("L51")

	jmp	L51
# LABEL ("L52")

L52:

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
# DUP

	movq	%r12,	%r13
# TAG ("Nil", 0)

	movq	$328857,	%r14
	movq	$1,	-8(%rbp)
	pushq	%rdi
	pushq	%r10
	pushq	%r11
	pushq	%r12
	movq	-8(%rbp),	%rdx
	movq	%r14,	%rsi
	movq	%r13,	%rdi
	movq	$3,	%r11
	call	Btag
	popq	%r12
	popq	%r11
	popq	%r10
	popq	%rdi
	movq	%rax,	%r13
# CJMP ("nz", "L54")

	sarq	%r13
	cmpq	$0,	%r13
	jnz	L54
# LABEL ("L55")

L55:

# DROP

# JMP ("L53")

	jmp	L53
# LABEL ("L54")

L54:

# DROP

# DROP

# DROP

# SLABEL ("L58")

L58:

# LINE (6)

	.stabn 68,0,6,.L8-Lf

.L8:

# CONST (1)

	movq	$3,	%r10
# CALL ("Lwrite", 1, true)

	movq	%r10,	%rdi
	movq	%rbp,	%rsp
	popq	%rbp
	movq	$1,	%r11
	jmp	Lwrite
# SLABEL ("L59")

L59:

# JMP ("L38")

	jmp	L38
# SLABEL ("L57")

L57:

# SLABEL ("L68")

L68:

# LABEL ("L51")

L51:

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
# CJMP ("nz", "L62")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L62
# LABEL ("L63")

L63:

# DROP

# JMP ("L61")

	jmp	L61
# LABEL ("L62")

L62:

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
# DUP

	movq	%r12,	%r13
# TAG ("Cons", 2)

	movq	$15329063,	%r14
	movq	$5,	-8(%rbp)
	pushq	%rdi
	pushq	%r10
	pushq	%r11
	pushq	%r12
	movq	-8(%rbp),	%rdx
	movq	%r14,	%rsi
	movq	%r13,	%rdi
	movq	$3,	%r11
	call	Btag
	popq	%r12
	popq	%r11
	popq	%r10
	popq	%rdi
	movq	%rax,	%r13
# CJMP ("nz", "L64")

	sarq	%r13
	cmpq	$0,	%r13
	jnz	L64
# LABEL ("L65")

L65:

# DROP

# JMP ("L63")

	jmp	L63
# LABEL ("L64")

L64:

# DUP

	movq	%r12,	%r13
# CONST (0)

	movq	$1,	%r14
# ELEM

	pushq	%rdi
	pushq	%r10
	pushq	%r11
	pushq	%r12
	movq	%r14,	%rsi
	movq	%r13,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r12
	popq	%r11
	popq	%r10
	popq	%rdi
	movq	%rax,	%r13
# DROP

# DUP

	movq	%r12,	%r13
# CONST (1)

	movq	$3,	%r14
# ELEM

	pushq	%rdi
	pushq	%r10
	pushq	%r11
	pushq	%r12
	movq	%r14,	%rsi
	movq	%r13,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r12
	popq	%r11
	popq	%r10
	popq	%rdi
	movq	%rax,	%r13
# DUP

	movq	%r13,	%r14
# TAG ("Nil", 0)

	movq	$328857,	-8(%rbp)
	movq	$1,	-16(%rbp)
	pushq	%rdi
	pushq	%r10
	pushq	%r11
	pushq	%r12
	pushq	%r13
	pushq	filler(%rip)
	movq	-16(%rbp),	%rdx
	movq	-8(%rbp),	%rsi
	movq	%r14,	%rdi
	movq	$3,	%r11
	call	Btag
	addq	$8,	%rsp
	popq	%r13
	popq	%r12
	popq	%r11
	popq	%r10
	popq	%rdi
	movq	%rax,	%r14
# CJMP ("nz", "L66")

	sarq	%r14
	cmpq	$0,	%r14
	jnz	L66
# LABEL ("L67")

L67:

# DROP

# JMP ("L65")

	jmp	L65
# LABEL ("L66")

L66:

# DROP

# DROP

# DROP

# DROP

# SLABEL ("L70")

L70:

# LINE (7)

	.stabn 68,0,7,.L9-Lf

.L9:

# CONST (2)

	movq	$5,	%r10
# CALL ("Lwrite", 1, true)

	movq	%r10,	%rdi
	movq	%rbp,	%rsp
	popq	%rbp
	movq	$1,	%r11
	jmp	Lwrite
# SLABEL ("L71")

L71:

# JMP ("L38")

	jmp	L38
# SLABEL ("L69")

L69:

# SLABEL ("L82")

L82:

# LABEL ("L61")

L61:

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
# CJMP ("nz", "L74")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L74
# LABEL ("L75")

L75:

# DROP

# JMP ("L73")

	jmp	L73
# LABEL ("L74")

L74:

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
# DUP

	movq	%r12,	%r13
# TAG ("Cons", 2)

	movq	$15329063,	%r14
	movq	$5,	-8(%rbp)
	pushq	%rdi
	pushq	%r10
	pushq	%r11
	pushq	%r12
	movq	-8(%rbp),	%rdx
	movq	%r14,	%rsi
	movq	%r13,	%rdi
	movq	$3,	%r11
	call	Btag
	popq	%r12
	popq	%r11
	popq	%r10
	popq	%rdi
	movq	%rax,	%r13
# CJMP ("nz", "L76")

	sarq	%r13
	cmpq	$0,	%r13
	jnz	L76
# LABEL ("L77")

L77:

# DROP

# JMP ("L75")

	jmp	L75
# LABEL ("L76")

L76:

# DUP

	movq	%r12,	%r13
# CONST (0)

	movq	$1,	%r14
# ELEM

	pushq	%rdi
	pushq	%r10
	pushq	%r11
	pushq	%r12
	movq	%r14,	%rsi
	movq	%r13,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r12
	popq	%r11
	popq	%r10
	popq	%rdi
	movq	%rax,	%r13
# DROP

# DUP

	movq	%r12,	%r13
# CONST (1)

	movq	$3,	%r14
# ELEM

	pushq	%rdi
	pushq	%r10
	pushq	%r11
	pushq	%r12
	movq	%r14,	%rsi
	movq	%r13,	%rdi
	movq	$2,	%r11
	call	Belem
	popq	%r12
	popq	%r11
	popq	%r10
	popq	%rdi
	movq	%rax,	%r13
# DUP

	movq	%r13,	%r14
# TAG ("Cons", 2)

	movq	$15329063,	-8(%rbp)
	movq	$5,	-16(%rbp)
	pushq	%rdi
	pushq	%r10
	pushq	%r11
	pushq	%r12
	pushq	%r13
	pushq	filler(%rip)
	movq	-16(%rbp),	%rdx
	movq	-8(%rbp),	%rsi
	movq	%r14,	%rdi
	movq	$3,	%r11
	call	Btag
	addq	$8,	%rsp
	popq	%r13
	popq	%r12
	popq	%r11
	popq	%r10
	popq	%rdi
	movq	%rax,	%r14
# CJMP ("nz", "L78")

	sarq	%r14
	cmpq	$0,	%r14
	jnz	L78
# LABEL ("L79")

L79:

# DROP

# JMP ("L77")

	jmp	L77
# LABEL ("L78")

L78:

# DUP

	movq	%r13,	%r14
# CONST (0)

	movq	$1,	-8(%rbp)
# ELEM

	pushq	%rdi
	pushq	%r10
	pushq	%r11
	pushq	%r12
	pushq	%r13
	pushq	filler(%rip)
	movq	-8(%rbp),	%rsi
	movq	%r14,	%rdi
	movq	$2,	%r11
	call	Belem
	addq	$8,	%rsp
	popq	%r13
	popq	%r12
	popq	%r11
	popq	%r10
	popq	%rdi
	movq	%rax,	%r14
# DROP

# DUP

	movq	%r13,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# ELEM

	pushq	%rdi
	pushq	%r10
	pushq	%r11
	pushq	%r12
	pushq	%r13
	pushq	filler(%rip)
	movq	-8(%rbp),	%rsi
	movq	%r14,	%rdi
	movq	$2,	%r11
	call	Belem
	addq	$8,	%rsp
	popq	%r13
	popq	%r12
	popq	%r11
	popq	%r10
	popq	%rdi
	movq	%rax,	%r14
# DUP

	movq	%r14,	-8(%rbp)
# TAG ("Nil", 0)

	movq	$328857,	-16(%rbp)
	movq	$1,	-24(%rbp)
	pushq	%rdi
	pushq	%r10
	pushq	%r11
	pushq	%r12
	pushq	%r13
	pushq	%r14
	movq	-24(%rbp),	%rdx
	movq	-16(%rbp),	%rsi
	movq	-8(%rbp),	%rdi
	movq	$3,	%r11
	call	Btag
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%r11
	popq	%r10
	popq	%rdi
	movq	%rax,	-8(%rbp)
# CJMP ("nz", "L80")

	sarq	-8(%rbp)
	cmpq	$0,	-8(%rbp)
	jnz	L80
# LABEL ("L81")

L81:

# DROP

# JMP ("L79")

	jmp	L79
# LABEL ("L80")

L80:

# DROP

# DROP

# DROP

# DROP

# DROP

# SLABEL ("L84")

L84:

# LINE (8)

	.stabn 68,0,8,.L10-Lf

.L10:

# CONST (3)

	movq	$7,	%r10
# CALL ("Lwrite", 1, true)

	movq	%r10,	%rdi
	movq	%rbp,	%rsp
	popq	%rbp
	movq	$1,	%r11
	jmp	Lwrite
# SLABEL ("L85")

L85:

# JMP ("L38")

	jmp	L38
# SLABEL ("L83")

L83:

# SLABEL ("L87")

L87:

# LABEL ("L73")

L73:

# DUP

	movq	%r10,	%r11
# DROP

# DROP

# SLABEL ("L89")

L89:

# LINE (9)

	.stabn 68,0,9,.L11-Lf

.L11:

# CONST (4)

	movq	$9,	%r10
# CALL ("Lwrite", 1, true)

	movq	%r10,	%rdi
	movq	%rbp,	%rsp
	popq	%rbp
	movq	$1,	%r11
	jmp	Lwrite
# SLABEL ("L90")

L90:

# SLABEL ("L88")

L88:

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
LLf_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLf_SIZE,	32

	.set	LSLf_SIZE,	3

	.size Lf, .-Lf


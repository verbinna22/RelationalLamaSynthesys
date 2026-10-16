	.file "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test079/test079.lama"

	.stabs "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test079/test079.lama",100,0,0,.Ltext

	.globl	main

	.data

string_0:	.string	"Function %s called with incorrect arguments count. Expected: %d. Actual: %d\n"

string_1:	.string	"find"

string_3:	.string	"insert"

string_2:	.string	"test079.lama"

init:	.quad 0

	.section custom_data,"aw",@progbits

filler:	.fill	3, 8, 1

	.stabs "n:S1",40,0,0,global_n

global_n:	.quad	1

	.stabs "t:S1",40,0,0,global_t

global_t:	.quad	1

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

# LINE (23)

	.stabn 68,0,23,.L0

.L0:

# CALL ("Lread", 0, false)

	pushq	%rdi
	pushq	%rsi
	movq	$0,	%r11
	call	Lread
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# LINE (21)

	.stabn 68,0,21,.L1

.L1:

# ST (Global ("n"))

	movq	%r10,	global_n(%rip)
# DROP

# LINE (25)

	.stabn 68,0,25,.L2

.L2:

# SEXP ("Leaf", 0)

	movq	$19964045,	%r10
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
# CONST (5)

	movq	$11,	%r11
# CALL ("Linsert", 2, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$2,	%r11
	call	Linsert
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# CONST (4)

	movq	$9,	%r11
# CALL ("Linsert", 2, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$2,	%r11
	call	Linsert
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# CONST (6)

	movq	$13,	%r11
# CALL ("Linsert", 2, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$2,	%r11
	call	Linsert
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# CONST (3)

	movq	$7,	%r11
# CALL ("Linsert", 2, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$2,	%r11
	call	Linsert
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# ST (Global ("t"))

	movq	%r10,	global_t(%rip)
# DROP

# LINE (27)

	.stabn 68,0,27,.L3

.L3:

# LD (Global ("t"))

	movq	global_t(%rip),	%r10
# CONST (5)

	movq	$11,	%r11
# CALL ("Lfind", 2, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$2,	%r11
	call	Lfind
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

# LINE (28)

	.stabn 68,0,28,.L4

.L4:

# LD (Global ("t"))

	movq	global_t(%rip),	%r10
# CONST (4)

	movq	$9,	%r11
# CALL ("Lfind", 2, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$2,	%r11
	call	Lfind
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

# LINE (29)

	.stabn 68,0,29,.L5

.L5:

# LD (Global ("t"))

	movq	global_t(%rip),	%r10
# CONST (6)

	movq	$13,	%r11
# CALL ("Lfind", 2, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$2,	%r11
	call	Lfind
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

# LINE (30)

	.stabn 68,0,30,.L6

.L6:

# LD (Global ("t"))

	movq	global_t(%rip),	%r10
# CONST (3)

	movq	$7,	%r11
# CALL ("Lfind", 2, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$2,	%r11
	call	Lfind
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

# LINE (31)

	.stabn 68,0,31,.L7

.L7:

# LD (Global ("t"))

	movq	global_t(%rip),	%r10
# CONST (2)

	movq	$5,	%r11
# CALL ("Lfind", 2, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$2,	%r11
	call	Lfind
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

# LINE (32)

	.stabn 68,0,32,.L8

.L8:

# LD (Global ("t"))

	movq	global_t(%rip),	%r10
# CONST (1)

	movq	$3,	%r11
# CALL ("Lfind", 2, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$2,	%r11
	call	Lfind
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

# LABEL ("Lfind")

Lfind:

# BEGIN ("Lfind", 2, 3, [], ["t"; "x"], [{ blab="L47"; elab="L48"; names=[]; subs=[{ blab="L50"; elab="L51"; names=[]; subs=[{ blab="L63"; elab="L64"; names=[("y", 2); ("l", 1); ("r", 0)]; subs=[{ blab="L65"; elab="L66"; names=[]; subs=[{ blab="L81"; elab="L82"; names=[]; subs=[]; }; { blab="L77"; elab="L78"; names=[]; subs=[]; }; { blab="L71"; elab="L72"; names=[]; subs=[]; }]; }]; }; { blab="L57"; elab="L58"; names=[]; subs=[{ blab="L59"; elab="L60"; names=[]; subs=[]; }]; }]; }]; }])

	.type find, @function

	.stabs "find:F1",36,0,0,Lfind

	.stabs "y:1",128,0,0,-24

	.stabs "l:1",128,0,0,-16

	.stabs "r:1",128,0,0,-8

	.stabn 192,0,0,L63-Lfind

	.stabn 224,0,0,L64-Lfind

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLfind_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLfind_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$2,	%r11
	je	Lfind_argc_correct
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
Lfind_argc_correct:

# SLABEL ("L47")

L47:

# SLABEL ("L50")

L50:

# LINE (14)

	.stabn 68,0,14,0

	.stabn 68,0,14,.L9-Lfind

.L9:

# LD (Arg (0))

	movq	%rdi,	%r10
# DUP

	movq	%r10,	%r11
# SLABEL ("L57")

L57:

# DUP

	movq	%r11,	%r12
# TAG ("Leaf", 0)

	movq	$19964045,	%r13
	movq	$1,	%r14
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
# CJMP ("nz", "L55")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L55
# LABEL ("L56")

L56:

# DROP

# JMP ("L54")

	jmp	L54
# LABEL ("L55")

L55:

# DROP

# DROP

# SLABEL ("L59")

L59:

# CONST (0)

	movq	$1,	%r10
# SLABEL ("L60")

L60:

# JMP ("L49")

	jmp	L49
# SLABEL ("L58")

L58:

# SLABEL ("L63")

L63:

# LABEL ("L54")

L54:

# DUP

	movq	%r10,	%r11
# DUP

	movq	%r11,	%r12
# TAG ("Node", 3)

	movq	$21094923,	%r13
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
# CJMP ("nz", "L61")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L61
# LABEL ("L62")

L62:

# DROP

# JMP ("L52")

	jmp	L52
# LABEL ("L61")

L61:

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

# SLABEL ("L65")

L65:

# LINE (16)

	.stabn 68,0,16,.L10-Lfind

.L10:

# LD (Arg (1))

	movq	%rsi,	%r10
# LD (Local (2))

	movq	-24(%rbp),	%r11
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("z", "L68")

	sarq	%r10
	cmpq	$0,	%r10
	jz	L68
# SLABEL ("L71")

L71:

# CONST (1)

	movq	$3,	%r10
# SLABEL ("L72")

L72:

# JMP ("L49")

	jmp	L49
# LABEL ("L68")

L68:

# LINE (17)

	.stabn 68,0,17,.L11-Lfind

.L11:

# LD (Arg (1))

	movq	%rsi,	%r10
# LD (Local (2))

	movq	-24(%rbp),	%r11
# BINOP (">")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setg	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("z", "L74")

	sarq	%r10
	cmpq	$0,	%r10
	jz	L74
# SLABEL ("L77")

L77:

# LD (Local (1))

	movq	-16(%rbp),	%r10
# LD (Arg (1))

	movq	%rsi,	%r11
# CALL ("Lfind", 2, true)

	movq	%r10,	%rdi
	movq	%r11,	%rsi
	movq	%rbp,	%rsp
	popq	%rbp
	movq	$2,	%r11
	jmp	Lfind
# SLABEL ("L78")

L78:

# JMP ("L49")

	jmp	L49
# LABEL ("L74")

L74:

# SLABEL ("L81")

L81:

# LINE (18)

	.stabn 68,0,18,.L12-Lfind

.L12:

# LD (Local (0))

	movq	-8(%rbp),	%r10
# LD (Arg (1))

	movq	%rsi,	%r11
# CALL ("Lfind", 2, true)

	movq	%r10,	%rdi
	movq	%r11,	%rsi
	movq	%rbp,	%rsp
	popq	%rbp
	movq	$2,	%r11
	jmp	Lfind
# SLABEL ("L82")

L82:

# JMP ("L49")

	jmp	L49
# SLABEL ("L66")

L66:

# SLABEL ("L64")

L64:

# JMP ("L49")

# LABEL ("L52")

L52:

# FAIL ((14, 7), true)

	movq	$15,	%r14
	movq	$29,	%r13
	leaq	string_2(%rip),	%r12
	movq	%r10,	%r11
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r14,	%rcx
	movq	%r13,	%rdx
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$4,	%r11
	call	Bmatch_failure
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# JMP ("L49")

	jmp	L49
# SLABEL ("L51")

L51:

# LABEL ("L49")

L49:

# SLABEL ("L48")

L48:

# END

	movq	%r10,	%rax
LLfind_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLfind_SIZE,	32

	.set	LSLfind_SIZE,	3

	.size Lfind, .-Lfind

# LABEL ("Linsert")

Linsert:

# BEGIN ("Linsert", 2, 3, [], ["t"; "x"], [{ blab="L85"; elab="L86"; names=[]; subs=[{ blab="L88"; elab="L89"; names=[]; subs=[{ blab="L106"; elab="L107"; names=[("y", 2); ("l", 1); ("r", 0)]; subs=[{ blab="L108"; elab="L109"; names=[]; subs=[{ blab="L121"; elab="L122"; names=[]; subs=[]; }; { blab="L114"; elab="L115"; names=[]; subs=[]; }]; }]; }; { blab="L95"; elab="L96"; names=[]; subs=[{ blab="L97"; elab="L98"; names=[]; subs=[]; }]; }]; }]; }])

	.type insert, @function

	.stabs "insert:F1",36,0,0,Linsert

	.stabs "y:1",128,0,0,-24

	.stabs "l:1",128,0,0,-16

	.stabs "r:1",128,0,0,-8

	.stabn 192,0,0,L106-Linsert

	.stabn 224,0,0,L107-Linsert

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLinsert_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLinsert_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$2,	%r11
	je	Linsert_argc_correct
	movq	%r11,	%r13
	movq	$2,	%r12
	leaq	string_3(%rip),	%r11
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
Linsert_argc_correct:

# SLABEL ("L85")

L85:

# SLABEL ("L88")

L88:

# LINE (4)

	.stabn 68,0,4,0

	.stabn 68,0,4,.L13-Linsert

.L13:

# LD (Arg (0))

	movq	%rdi,	%r10
# DUP

	movq	%r10,	%r11
# SLABEL ("L95")

L95:

# DUP

	movq	%r11,	%r12
# TAG ("Leaf", 0)

	movq	$19964045,	%r13
	movq	$1,	%r14
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
# CJMP ("nz", "L93")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L93
# LABEL ("L94")

L94:

# DROP

# JMP ("L92")

	jmp	L92
# LABEL ("L93")

L93:

# DROP

# DROP

# SLABEL ("L97")

L97:

# LINE (5)

	.stabn 68,0,5,.L14-Linsert

.L14:

# LD (Arg (1))

	movq	%rsi,	%r10
# SEXP ("Leaf", 0)

	movq	$19964045,	%r11
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%rsp,	%rdi
	movq	$3,	%rsi
	call	Bsexp
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# SEXP ("Leaf", 0)

	movq	$19964045,	%r12
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	pushq	filler(%rip)
	pushq	%r12
	movq	%rsp,	%rdi
	movq	$3,	%rsi
	call	Bsexp
	addq	$16,	%rsp
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# SEXP ("Node", 3)

	movq	$21094923,	%r13
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
# SLABEL ("L98")

L98:

# JMP ("L87")

	jmp	L87
# SLABEL ("L96")

L96:

# SLABEL ("L106")

L106:

# LABEL ("L92")

L92:

# DUP

	movq	%r10,	%r11
# DUP

	movq	%r11,	%r12
# TAG ("Node", 3)

	movq	$21094923,	%r13
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
# CJMP ("nz", "L104")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L104
# LABEL ("L105")

L105:

# DROP

# JMP ("L90")

	jmp	L90
# LABEL ("L104")

L104:

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

# SLABEL ("L108")

L108:

# LINE (6)

	.stabn 68,0,6,.L15-Linsert

.L15:

# LD (Arg (1))

	movq	%rsi,	%r10
# LD (Local (2))

	movq	-24(%rbp),	%r11
# BINOP (">")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setg	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("z", "L111")

	sarq	%r10
	cmpq	$0,	%r10
	jz	L111
# SLABEL ("L114")

L114:

# LINE (7)

	.stabn 68,0,7,.L16-Linsert

.L16:

# LD (Local (2))

	movq	-24(%rbp),	%r10
# LD (Local (1))

	movq	-16(%rbp),	%r11
# LD (Arg (1))

	movq	%rsi,	%r12
# CALL ("Linsert", 2, false)

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$2,	%r11
	call	Linsert
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# LD (Local (0))

	movq	-8(%rbp),	%r12
# SEXP ("Node", 3)

	movq	$21094923,	%r13
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
# SLABEL ("L115")

L115:

# JMP ("L87")

	jmp	L87
# LABEL ("L111")

L111:

# SLABEL ("L121")

L121:

# LINE (8)

	.stabn 68,0,8,.L17-Linsert

.L17:

# LD (Local (2))

	movq	-24(%rbp),	%r10
# LD (Local (1))

	movq	-16(%rbp),	%r11
# LD (Local (0))

	movq	-8(%rbp),	%r12
# LD (Arg (1))

	movq	%rsi,	%r13
# CALL ("Linsert", 2, false)

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	movq	%r13,	%rsi
	movq	%r12,	%rdi
	movq	$2,	%r11
	call	Linsert
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r12
# SEXP ("Node", 3)

	movq	$21094923,	%r13
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
# SLABEL ("L122")

L122:

# JMP ("L87")

	jmp	L87
# SLABEL ("L109")

L109:

# SLABEL ("L107")

L107:

# JMP ("L87")

# LABEL ("L90")

L90:

# FAIL ((4, 7), true)

	movq	$15,	%r14
	movq	$9,	%r13
	leaq	string_2(%rip),	%r12
	movq	%r10,	%r11
	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	filler(%rip)
	movq	%r14,	%rcx
	movq	%r13,	%rdx
	movq	%r12,	%rsi
	movq	%r11,	%rdi
	movq	$4,	%r11
	call	Bmatch_failure
	addq	$8,	%rsp
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r11
# JMP ("L87")

	jmp	L87
# SLABEL ("L89")

L89:

# LABEL ("L87")

L87:

# SLABEL ("L86")

L86:

# END

	movq	%r10,	%rax
LLinsert_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLinsert_SIZE,	32

	.set	LSLinsert_SIZE,	3

	.size Linsert, .-Linsert


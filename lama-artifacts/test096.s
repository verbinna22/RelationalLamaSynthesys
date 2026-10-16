	.file "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test096/test096.lama"

	.stabs "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test096/test096.lama",100,0,0,.Ltext

	.globl	main

	.data

string_0:	.string	"Function %s called with incorrect arguments count. Expected: %d. Actual: %d\n"

string_3:	.string	"f"

string_4:	.string	"g_9"

string_1:	.string	"p"

string_2:	.string	"test096.lama"

init:	.quad 0

	.section custom_data,"aw",@progbits

filler:	.fill	2, 8, 1

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

# CALL ("Lread", 0, false)

	pushq	%rdi
	pushq	%rsi
	movq	$0,	%r11
	call	Lread
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# LINE (21)

	.stabn 68,0,21,.L0

.L0:

# ST (Global ("x"))

	movq	%r10,	global_x(%rip)
# DROP

# LINE (23)

	.stabn 68,0,23,.L1

.L1:

# CALL ("Lf", 0, false)

	pushq	%rdi
	pushq	%rsi
	movq	$0,	%r11
	call	Lf
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# CALL ("Lp", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lp
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

# LABEL ("Lp")

Lp:

# BEGIN ("Lp", 1, 2, [], ["l"], [{ blab="L9"; elab="L10"; names=[]; subs=[{ blab="L12"; elab="L13"; names=[]; subs=[{ blab="L24"; elab="L25"; names=[("h", 1); ("tl", 0)]; subs=[{ blab="L26"; elab="L27"; names=[]; subs=[]; }]; }; { blab="L17"; elab="L18"; names=[]; subs=[{ blab="L19"; elab="L20"; names=[]; subs=[]; }]; }]; }]; }])

	.type p, @function

	.stabs "p:F1",36,0,0,Lp

	.stabs "h:1",128,0,0,-16

	.stabs "tl:1",128,0,0,-8

	.stabn 192,0,0,L24-Lp

	.stabn 224,0,0,L25-Lp

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLp_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLp_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$1,	%r11
	je	Lp_argc_correct
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
Lp_argc_correct:

# SLABEL ("L9")

L9:

# SLABEL ("L12")

L12:

# LINE (15)

	.stabn 68,0,15,0

	.stabn 68,0,15,.L2-Lp

.L2:

# LD (Arg (0))

	movq	%rdi,	%r10
# DUP

	movq	%r10,	%r11
# SLABEL ("L17")

L17:

# CONST (0)

	movq	$1,	%r12
# BINOP ("==")

	xorq	%rax,	%rax
	cmpq	%r12,	%r11
	sete	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r11
# CJMP ("z", "L16")

	sarq	%r11
	cmpq	$0,	%r11
	jz	L16
# DROP

# SLABEL ("L19")

L19:

# CONST (0)

	movq	$1,	%r10
# SLABEL ("L20")

L20:

# JMP ("L11")

	jmp	L11
# SLABEL ("L18")

L18:

# SLABEL ("L24")

L24:

# LABEL ("L16")

L16:

# DUP

	movq	%r10,	%r11
# DUP

	movq	%r11,	%r12
# TAG ("cons", 2)

	movq	$1697575,	%r13
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
# CJMP ("nz", "L22")

	sarq	%r12
	cmpq	$0,	%r12
	jnz	L22
# LABEL ("L23")

L23:

# DROP

# JMP ("L14")

	jmp	L14
# LABEL ("L22")

L22:

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

# SLABEL ("L26")

L26:

# LINE (17)

	.stabn 68,0,17,.L3-Lp

.L3:

# LD (Local (1))

	movq	-16(%rbp),	%r10
# CALLC (0, false)

	pushq	%rdi
	pushq	%r10
	movq	%r10,	%r15
	movq	$0,	%r11
	call	*(%r15)
	popq	%r10
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

# LD (Local (0))

	movq	-8(%rbp),	%r10
# CALL ("Lp", 1, true)

	movq	%r10,	%rdi
	movq	%rbp,	%rsp
	popq	%rbp
	movq	$1,	%r11
	jmp	Lp
# SLABEL ("L27")

L27:

# SLABEL ("L25")

L25:

# JMP ("L11")

	jmp	L11
# LABEL ("L14")

L14:

# FAIL ((15, 7), true)

	movq	$15,	%r14
	movq	$31,	%r13
	leaq	string_2(%rip),	%r12
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
# JMP ("L11")

	jmp	L11
# SLABEL ("L13")

L13:

# LABEL ("L11")

L11:

# SLABEL ("L10")

L10:

# END

	movq	%r10,	%rax
LLp_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLp_SIZE,	16

	.set	LSLp_SIZE,	2

	.size Lp, .-Lp

# LABEL ("Lf")

Lf:

# BEGIN ("Lf", 0, 2, [], [], [{ blab="L33"; elab="L34"; names=[]; subs=[{ blab="L36"; elab="L37"; names=[("x", 1); ("l", 0)]; subs=[]; }]; }])

	.type f, @function

	.stabs "f:F1",36,0,0,Lf

	.stabs "x:1",128,0,0,-16

	.stabs "l:1",128,0,0,-8

	.stabn 192,0,0,L36-Lf

	.stabn 224,0,0,L37-Lf

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

	cmpq	$0,	%r11
	je	Lf_argc_correct
	movq	%r11,	%r13
	movq	$0,	%r12
	leaq	string_3(%rip),	%r11
	leaq	string_0(%rip),	%r10
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
Lf_argc_correct:

# SLABEL ("L33")

L33:

# SLABEL ("L36")

L36:

# CONST (0)

	movq	$1,	%r10
# LINE (2)

	.stabn 68,0,2,0

	.stabn 68,0,2,.L4-Lf

.L4:

# ST (Local (0))

	movq	%r10,	-8(%rbp)
# DROP

# CONST (1)

	movq	$3,	%r10
# LINE (3)

	.stabn 68,0,3,.L5-Lf

.L5:

# ST (Local (1))

	movq	%r10,	-16(%rbp)
# DROP

# LINE (6)

	.stabn 68,0,6,.L6-Lf

.L6:

# CLOSURE ("Lg_9", [Local (1)])

	movq	-16(%rbp),	%r11
	leaq	Lg_9(%rip),	%r10
	pushq	%r11
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$3,	%rsi
	call	Bclosure
	addq	$16,	%rsp
	movq	%rax,	%r10
# LD (Local (0))

	movq	-8(%rbp),	%r11
# SEXP ("cons", 2)

	movq	$1697575,	%r12
	pushq	filler(%rip)
	pushq	%r12
	pushq	%r11
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$7,	%rsi
	call	Bsexp
	addq	$32,	%rsp
	movq	%rax,	%r10
# LINE (5)

	.stabn 68,0,5,.L7-Lf

.L7:

# ST (Local (0))

	movq	%r10,	-8(%rbp)
# DROP

# CONST (2)

	movq	$5,	%r10
# ST (Local (1))

	movq	%r10,	-16(%rbp)
# DROP

# LINE (9)

	.stabn 68,0,9,.L8-Lf

.L8:

# CLOSURE ("Lg_9", [Local (1)])

	movq	-16(%rbp),	%r11
	leaq	Lg_9(%rip),	%r10
	pushq	%r11
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$3,	%rsi
	call	Bclosure
	addq	$16,	%rsp
	movq	%rax,	%r10
# LD (Local (0))

	movq	-8(%rbp),	%r11
# SEXP ("cons", 2)

	movq	$1697575,	%r12
	pushq	filler(%rip)
	pushq	%r12
	pushq	%r11
	pushq	%r10
	movq	%rsp,	%rdi
	movq	$7,	%rsi
	call	Bsexp
	addq	$32,	%rsp
	movq	%rax,	%r10
# LINE (8)

	.stabn 68,0,8,.L9-Lf

.L9:

# ST (Local (0))

	movq	%r10,	-8(%rbp)
# DROP

# LD (Local (0))

	movq	-8(%rbp),	%r10
# SLABEL ("L37")

L37:

# LABEL ("L35")

L35:

# SLABEL ("L34")

L34:

# END

	movq	%r10,	%rax
LLf_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLf_SIZE,	16

	.set	LSLf_SIZE,	2

	.size Lf, .-Lf

# LABEL ("Lg_9")

Lg_9:

# BEGIN ("Lg_9", 0, 0, [Local (1)], [], [{ blab="L57"; elab="L58"; names=[]; subs=[{ blab="L60"; elab="L61"; names=[]; subs=[]; }]; }])

	.type g_9, @function

	.stabs "g_9:F1",36,0,0,Lg_9

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLg_9_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLg_9_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$0,	%r11
	je	Lg_9_argc_correct
	movq	%r11,	%r13
	movq	$0,	%r12
	leaq	string_4(%rip),	%r11
	leaq	string_0(%rip),	%r10
	movq	%r13,	%rcx
	movq	%r12,	%rdx
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$4,	%r11
	call	failure
	movq	%rax,	%r10
Lg_9_argc_correct:

# SLABEL ("L57")

L57:

# SLABEL ("L60")

L60:

# LINE (3)

	.stabn 68,0,3,0

	.stabn 68,0,3,.L10-Lg_9

.L10:

# LD (Access (0))

	movq	8(%r15),	%r10
# SLABEL ("L61")

L61:

# LABEL ("L59")

L59:

# SLABEL ("L58")

L58:

# END

	movq	%r10,	%rax
LLg_9_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLg_9_SIZE,	0

	.set	LSLg_9_SIZE,	0

	.size Lg_9, .-Lg_9


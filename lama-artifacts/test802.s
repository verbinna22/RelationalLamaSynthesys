	.file "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test802/test802.lama"

	.stabs "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test802/test802.lama",100,0,0,.Ltext

	.globl	main

	.data

string_0:	.string	"Function %s called with incorrect arguments count. Expected: %d. Actual: %d\n"

string_1:	.string	"f"

init:	.quad 0

	.section custom_data,"aw",@progbits

filler:	.fill	3, 8, 1

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

	movq	$13,	-8(%rbp)
# CONST (7)

	movq	$15,	-16(%rbp)
# CONST (8)

	movq	$17,	-24(%rbp)
# CALL ("Lf", 8, false)

	pushq	%rdi
	pushq	%rsi
	pushq	-24(%rbp)
	pushq	-16(%rbp)
	movq	-8(%rbp),	%r9
	movq	%r14,	%r8
	movq	%r13,	%rcx
	movq	%r12,	%rdx
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$8,	%r11
	call	Lf
	addq	$16,	%rsp
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

	.set	Lmain_SIZE,	32

	.set	LSmain_SIZE,	3

	.size main, .-main

# LABEL ("Lf")

Lf:

# BEGIN ("Lf", 8, 2, [], ["a"; "b"; "c"; "d"; "e"; "f"; "g"; "h"], [{ blab="L11"; elab="L12"; names=[]; subs=[{ blab="L14"; elab="L15"; names=[("i", 1); ("j", 0)]; subs=[]; }]; }])

	.type f, @function

	.stabs "f:F1",36,0,0,Lf

	.stabs "i:1",128,0,0,-16

	.stabs "j:1",128,0,0,-8

	.stabn 192,0,0,L14-Lf

	.stabn 224,0,0,L15-Lf

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

	cmpq	$8,	%r11
	je	Lf_argc_correct
	movq	%r11,	%r13
	movq	$8,	%r12
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

# SLABEL ("L11")

L11:

# SLABEL ("L14")

L14:

# CONST (9)

	movq	$19,	%r10
# LINE (2)

	.stabn 68,0,2,0

	.stabn 68,0,2,.L1-Lf

.L1:

# ST (Local (1))

	movq	%r10,	-16(%rbp)
# DROP

# CONST (10)

	movq	$21,	%r10
# ST (Local (0))

	movq	%r10,	-8(%rbp)
# DROP

# LINE (3)

	.stabn 68,0,3,.L2-Lf

.L2:

# LD (Arg (0))

	movq	%rdi,	%r10
# CALL ("Lwrite", 1, false)

	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%r8
	pushq	%r9
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	popq	%r9
	popq	%r8
	popq	%rcx
	popq	%rdx
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LINE (4)

	.stabn 68,0,4,.L3-Lf

.L3:

# LD (Arg (1))

	movq	%rsi,	%r10
# CALL ("Lwrite", 1, false)

	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%r8
	pushq	%r9
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	popq	%r9
	popq	%r8
	popq	%rcx
	popq	%rdx
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LINE (5)

	.stabn 68,0,5,.L4-Lf

.L4:

# LD (Arg (2))

	movq	%rdx,	%r10
# CALL ("Lwrite", 1, false)

	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%r8
	pushq	%r9
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	popq	%r9
	popq	%r8
	popq	%rcx
	popq	%rdx
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LINE (6)

	.stabn 68,0,6,.L5-Lf

.L5:

# LD (Arg (3))

	movq	%rcx,	%r10
# CALL ("Lwrite", 1, false)

	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%r8
	pushq	%r9
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	popq	%r9
	popq	%r8
	popq	%rcx
	popq	%rdx
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LINE (7)

	.stabn 68,0,7,.L6-Lf

.L6:

# LD (Arg (4))

	movq	%r8,	%r10
# CALL ("Lwrite", 1, false)

	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%r8
	pushq	%r9
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	popq	%r9
	popq	%r8
	popq	%rcx
	popq	%rdx
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LINE (8)

	.stabn 68,0,8,.L7-Lf

.L7:

# LD (Arg (5))

	movq	%r9,	%r10
# CALL ("Lwrite", 1, false)

	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%r8
	pushq	%r9
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	popq	%r9
	popq	%r8
	popq	%rcx
	popq	%rdx
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LINE (9)

	.stabn 68,0,9,.L8-Lf

.L8:

# LD (Arg (6))

	movq	16(%rbp),	%r10
# CALL ("Lwrite", 1, false)

	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%r8
	pushq	%r9
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	popq	%r9
	popq	%r8
	popq	%rcx
	popq	%rdx
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LINE (10)

	.stabn 68,0,10,.L9-Lf

.L9:

# LD (Arg (7))

	movq	24(%rbp),	%r10
# CALL ("Lwrite", 1, false)

	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%r8
	pushq	%r9
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	popq	%r9
	popq	%r8
	popq	%rcx
	popq	%rdx
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LINE (11)

	.stabn 68,0,11,.L10-Lf

.L10:

# LD (Local (1))

	movq	-16(%rbp),	%r10
# CALL ("Lwrite", 1, false)

	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%r8
	pushq	%r9
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	popq	%r9
	popq	%r8
	popq	%rcx
	popq	%rdx
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LINE (12)

	.stabn 68,0,12,.L11-Lf

.L11:

# LD (Local (0))

	movq	-8(%rbp),	%r10
# CALL ("Lwrite", 1, true)

	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%r8
	pushq	%r9
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	popq	%r9
	popq	%r8
	popq	%rcx
	popq	%rdx
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# SLABEL ("L15")

L15:

# LABEL ("L13")

L13:

# SLABEL ("L12")

L12:

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


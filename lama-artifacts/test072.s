	.file "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test072/test072.lama"

	.stabs "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test072/test072.lama",100,0,0,.Ltext

	.globl	main

	.data

string_0:	.string	"Function %s called with incorrect arguments count. Expected: %d. Actual: %d\n"

string_1:	.string	"fib"

init:	.quad 0

	.section custom_data,"aw",@progbits

filler:	.fill	0, 8, 1

	.stabs "i:S1",40,0,0,global_i

global_i:	.quad	1

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

# LINE (11)

	.stabn 68,0,11,.L0

.L0:

# CALL ("Lread", 0, false)

	pushq	%rdi
	pushq	%rsi
	movq	$0,	%r11
	call	Lread
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# LINE (9)

	.stabn 68,0,9,.L1

.L1:

# ST (Global ("n"))

	movq	%r10,	global_n(%rip)
# DROP

# SLABEL ("L8")

L8:

# LD (Global ("n"))

	movq	global_n(%rip),	%r10
# LINE (13)

	.stabn 68,0,13,.L2

.L2:

# ST (Global ("i"))

	movq	%r10,	global_i(%rip)
# DROP

# JMP ("L15")

	jmp	L15
# FLABEL ("L14")

L14:

# SLABEL ("L19")

L19:

# LINE (14)

	.stabn 68,0,14,.L3

.L3:

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

# LINE (15)

	.stabn 68,0,15,.L4

.L4:

# LD (Global ("i"))

	movq	global_i(%rip),	%r10
# CALL ("Lfib", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lfib
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

# SLABEL ("L20")

L20:

# LD (Global ("i"))

	movq	global_i(%rip),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("-")

	subq	%r11,	%r10
	orq	$0x0001,	%r10
# LINE (13)

	.stabn 68,0,13,.L5

.L5:

# ST (Global ("i"))

	movq	%r10,	global_i(%rip)
# DROP

# LABEL ("L15")

L15:

# LD (Global ("i"))

	movq	global_i(%rip),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP (">=")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setge	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("nz", "L14")

	sarq	%r10
	cmpq	$0,	%r10
	jnz	L14
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

# LABEL ("Lfib")

Lfib:

# BEGIN ("Lfib", 1, 0, [], ["n"], [{ blab="L31"; elab="L32"; names=[]; subs=[{ blab="L34"; elab="L35"; names=[]; subs=[{ blab="L42"; elab="L43"; names=[]; subs=[{ blab="L44"; elab="L45"; names=[]; subs=[]; }]; }; { blab="L40"; elab="L41"; names=[]; subs=[]; }]; }]; }])

	.type fib, @function

	.stabs "fib:F1",36,0,0,Lfib

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLfib_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLfib_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$1,	%r11
	je	Lfib_argc_correct
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
Lfib_argc_correct:

# SLABEL ("L31")

L31:

# SLABEL ("L34")

L34:

# LINE (4)

	.stabn 68,0,4,0

	.stabn 68,0,4,.L6-Lfib

.L6:

# LD (Arg (0))

	movq	%rdi,	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("<=")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setle	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("z", "L37")

	sarq	%r10
	cmpq	$0,	%r10
	jz	L37
# SLABEL ("L40")

L40:

# CONST (1)

	movq	$3,	%r10
# SLABEL ("L41")

L41:

# JMP ("L33")

	jmp	L33
# LABEL ("L37")

L37:

# SLABEL ("L42")

L42:

# SLABEL ("L44")

L44:

# LINE (7)

	.stabn 68,0,7,.L7-Lfib

.L7:

# LD (Arg (0))

	movq	%rdi,	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("-")

	subq	%r11,	%r10
	orq	$0x0001,	%r10
# CALL ("Lfib", 1, false)

	pushq	%rdi
	pushq	filler(%rip)
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lfib
	addq	$8,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# LD (Arg (0))

	movq	%rdi,	%r11
# CONST (2)

	movq	$5,	%r12
# BINOP ("-")

	subq	%r12,	%r11
	orq	$0x0001,	%r11
# CALL ("Lfib", 1, false)

	pushq	%rdi
	pushq	%r10
	movq	%r11,	%rdi
	movq	$1,	%r11
	call	Lfib
	popq	%r10
	popq	%rdi
	movq	%rax,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# SLABEL ("L45")

L45:

# SLABEL ("L43")

L43:

# JMP ("L33")

	jmp	L33
# SLABEL ("L35")

L35:

# LABEL ("L33")

L33:

# SLABEL ("L32")

L32:

# END

	movq	%r10,	%rax
LLfib_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLfib_SIZE,	0

	.set	LSLfib_SIZE,	0

	.size Lfib, .-Lfib


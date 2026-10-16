	.file "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test034/test034.lama"

	.stabs "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test034/test034.lama",100,0,0,.Ltext

	.globl	main

	.data

string_1:	.string	"Function %s called with incorrect arguments count. Expected: %d. Actual: %d\n"

string_0:	.string	"abcdefgh"

string_2:	.string	"printString"

init:	.quad 0

	.section custom_data,"aw",@progbits

filler:	.fill	0, 8, 1

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

# LINE (9)

	.stabn 68,0,9,.L0

.L0:

# CALL ("Lread", 0, false)

	pushq	%rdi
	pushq	%rsi
	movq	$0,	%r11
	call	Lread
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# LINE (7)

	.stabn 68,0,7,.L1

.L1:

# ST (Global ("n"))

	movq	%r10,	global_n(%rip)
# DROP

# STRING ("abcdefgh")

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
# ST (Global ("x"))

	movq	%r10,	global_x(%rip)
# DROP

# LINE (11)

	.stabn 68,0,11,.L2

.L2:

# LINE (13)

	.stabn 68,0,13,.L3

.L3:

# LD (Global ("x"))

	movq	global_x(%rip),	%r10
# CALL ("LprintString", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	LprintString
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# SLABEL ("L14")

L14:

# CONST (0)

	movq	$1,	%r10
# LINE (15)

	.stabn 68,0,15,.L4

.L4:

# ST (Global ("i"))

	movq	%r10,	global_i(%rip)
# DROP

# JMP ("L21")

	jmp	L21
# FLABEL ("L20")

L20:

# SLABEL ("L26")

L26:

# LD (Global ("x"))

	movq	global_x(%rip),	%r10
# LINE (16)

	.stabn 68,0,16,.L5

.L5:

# LD (Global ("i"))

	movq	global_i(%rip),	%r11
# LD (Global ("x"))

	movq	global_x(%rip),	%r12
# LD (Global ("i"))

	movq	global_i(%rip),	%r13
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
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
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

# SLABEL ("L27")

L27:

# LD (Global ("i"))

	movq	global_i(%rip),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# LINE (15)

	.stabn 68,0,15,.L6

.L6:

# ST (Global ("i"))

	movq	%r10,	global_i(%rip)
# DROP

# LABEL ("L21")

L21:

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
# CJMP ("nz", "L20")

	sarq	%r10
	cmpq	$0,	%r10
	jnz	L20
# SLABEL ("L15")

L15:

# LINE (17)

	.stabn 68,0,17,.L7

.L7:

# LINE (19)

	.stabn 68,0,19,.L8

.L8:

# LD (Global ("x"))

	movq	global_x(%rip),	%r10
# CALL ("LprintString", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	LprintString
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

# LABEL ("LprintString")

LprintString:

# BEGIN ("LprintString", 1, 0, [], ["x"], [{ blab="L41"; elab="L42"; names=[]; subs=[{ blab="L44"; elab="L45"; names=[]; subs=[{ blab="L47"; elab="L48"; names=[]; subs=[{ blab="L59"; elab="L60"; names=[]; subs=[]; }]; }]; }]; }])

	.type printString, @function

	.stabs "printString:F1",36,0,0,LprintString

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLprintString_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLprintString_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$1,	%r11
	je	LprintString_argc_correct
	movq	%r11,	%r13
	movq	$1,	%r12
	leaq	string_2(%rip),	%r11
	leaq	string_1(%rip),	%r10
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
LprintString_argc_correct:

# SLABEL ("L41")

L41:

# SLABEL ("L44")

L44:

# SLABEL ("L47")

L47:

# CONST (0)

	movq	$1,	%r10
# LINE (4)

	.stabn 68,0,4,0

	.stabn 68,0,4,.L9-LprintString

.L9:

# ST (Global ("i"))

	movq	%r10,	global_i(%rip)
# DROP

# JMP ("L54")

	jmp	L54
# FLABEL ("L53")

L53:

# SLABEL ("L59")

L59:

# LINE (5)

	.stabn 68,0,5,.L10-LprintString

.L10:

# LD (Arg (0))

	movq	%rdi,	%r10
# LD (Global ("i"))

	movq	global_i(%rip),	%r11
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

# SLABEL ("L60")

L60:

# LD (Global ("i"))

	movq	global_i(%rip),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# LINE (4)

	.stabn 68,0,4,.L11-LprintString

.L11:

# ST (Global ("i"))

	movq	%r10,	global_i(%rip)
# DROP

# LABEL ("L54")

L54:

# LD (Global ("i"))

	movq	global_i(%rip),	%r10
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
# CJMP ("nz", "L53")

	sarq	%r10
	cmpq	$0,	%r10
	jnz	L53
# SLABEL ("L48")

L48:

# CONST (0)

	movq	$1,	%r10
# SLABEL ("L45")

L45:

# LABEL ("L43")

L43:

# SLABEL ("L42")

L42:

# END

	movq	%r10,	%rax
LLprintString_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLprintString_SIZE,	0

	.set	LSLprintString_SIZE,	0

	.size LprintString, .-LprintString


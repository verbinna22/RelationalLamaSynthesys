	.file "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test026/test026.lama"

	.stabs "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test026/test026.lama",100,0,0,.Ltext

	.globl	main

	.data

string_0:	.string	"Function %s called with incorrect arguments count. Expected: %d. Actual: %d\n"

string_1:	.string	"print"

string_4:	.string	"test1"

string_3:	.string	"test2"

string_2:	.string	"test3"

init:	.quad 0

	.section custom_data,"aw",@progbits

filler:	.fill	0, 8, 1

	.stabs "a:S1",40,0,0,global_a

global_a:	.quad	1

	.stabs "b:S1",40,0,0,global_b

global_b:	.quad	1

	.stabs "c:S1",40,0,0,global_c

global_c:	.quad	1

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

# LINE (24)

	.stabn 68,0,24,.L0

.L0:

# CALL ("Lread", 0, false)

	pushq	%rdi
	pushq	%rsi
	movq	$0,	%r11
	call	Lread
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# LINE (22)

	.stabn 68,0,22,.L1

.L1:

# ST (Global ("x"))

	movq	%r10,	global_x(%rip)
# DROP

# CONST (100)

	movq	$201,	%r10
# ST (Global ("a"))

	movq	%r10,	global_a(%rip)
# DROP

# CONST (200)

	movq	$401,	%r10
# LINE (26)

	.stabn 68,0,26,.L2

.L2:

# ST (Global ("b"))

	movq	%r10,	global_b(%rip)
# DROP

# CONST (300)

	movq	$601,	%r10
# LINE (27)

	.stabn 68,0,27,.L3

.L3:

# ST (Global ("c"))

	movq	%r10,	global_c(%rip)
# DROP

# LINE (28)

	.stabn 68,0,28,.L4

.L4:

# CONST (1)

	movq	$3,	%r10
# CALL ("Ltest1", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Ltest1
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LINE (30)

	.stabn 68,0,30,.L5

.L5:

# CALL ("Lprint", 0, false)

	pushq	%rdi
	pushq	%rsi
	movq	$0,	%r11
	call	Lprint
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LINE (31)

	.stabn 68,0,31,.L6

.L6:

# CONST (2)

	movq	$5,	%r10
# CALL ("Ltest2", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Ltest2
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LINE (32)

	.stabn 68,0,32,.L7

.L7:

# CALL ("Lprint", 0, false)

	pushq	%rdi
	pushq	%rsi
	movq	$0,	%r11
	call	Lprint
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LINE (33)

	.stabn 68,0,33,.L8

.L8:

# CONST (3)

	movq	$7,	%r10
# CALL ("Ltest3", 1, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Ltest3
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# DROP

# LINE (34)

	.stabn 68,0,34,.L9

.L9:

# CALL ("Lprint", 0, false)

	pushq	%rdi
	pushq	%rsi
	movq	$0,	%r11
	call	Lprint
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

# LABEL ("Lprint")

Lprint:

# BEGIN ("Lprint", 0, 0, [], [], [{ blab="L32"; elab="L33"; names=[]; subs=[{ blab="L35"; elab="L36"; names=[]; subs=[]; }]; }])

	.type print, @function

	.stabs "print:F1",36,0,0,Lprint

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLprint_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLprint_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$0,	%r11
	je	Lprint_argc_correct
	movq	%r11,	%r13
	movq	$0,	%r12
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
Lprint_argc_correct:

# SLABEL ("L32")

L32:

# SLABEL ("L35")

L35:

# LINE (18)

	.stabn 68,0,18,0

	.stabn 68,0,18,.L10-Lprint

.L10:

# LINE (19)

	.stabn 68,0,19,.L11-Lprint

.L11:

# LD (Global ("a"))

	movq	global_a(%rip),	%r10
# CALL ("Lwrite", 1, false)

	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	movq	%rax,	%r10
# DROP

# LINE (20)

	.stabn 68,0,20,.L12-Lprint

.L12:

# LD (Global ("b"))

	movq	global_b(%rip),	%r10
# CALL ("Lwrite", 1, false)

	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	movq	%rax,	%r10
# DROP

# LINE (21)

	.stabn 68,0,21,.L13-Lprint

.L13:

# LD (Global ("c"))

	movq	global_c(%rip),	%r10
# CALL ("Lwrite", 1, true)

	movq	%r10,	%rdi
	movq	$1,	%r11
	call	Lwrite
	movq	%rax,	%r10
# SLABEL ("L36")

L36:

# LABEL ("L34")

L34:

# SLABEL ("L33")

L33:

# END

	movq	%r10,	%rax
LLprint_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLprint_SIZE,	0

	.set	LSLprint_SIZE,	0

	.size Lprint, .-Lprint

# LABEL ("Ltest3")

Ltest3:

# BEGIN ("Ltest3", 1, 0, [], ["c"], [{ blab="L44"; elab="L45"; names=[]; subs=[{ blab="L47"; elab="L48"; names=[]; subs=[]; }]; }])

	.type test3, @function

	.stabs "test3:F1",36,0,0,Ltest3

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLtest3_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLtest3_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$1,	%r11
	je	Ltest3_argc_correct
	movq	%r11,	%r13
	movq	$1,	%r12
	leaq	string_2(%rip),	%r11
	leaq	string_0(%rip),	%r10
	movq	%r13,	%rcx
	movq	%r12,	%rdx
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$4,	%r11
	call	failure
	movq	%rax,	%r10
Ltest3_argc_correct:

# SLABEL ("L44")

L44:

# SLABEL ("L47")

L47:

# LINE (13)

	.stabn 68,0,13,0

	.stabn 68,0,13,.L14-Ltest3

.L14:

# LINE (14)

	.stabn 68,0,14,.L15-Ltest3

.L15:

# LD (Arg (0))

	movq	%rdi,	%r10
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

# CALL ("Lprint", 0, true)

	pushq	%rdi
	pushq	filler(%rip)
	movq	$0,	%r11
	call	Lprint
	addq	$8,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# SLABEL ("L48")

L48:

# LABEL ("L46")

L46:

# SLABEL ("L45")

L45:

# END

	movq	%r10,	%rax
LLtest3_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLtest3_SIZE,	0

	.set	LSLtest3_SIZE,	0

	.size Ltest3, .-Ltest3

# LABEL ("Ltest2")

Ltest2:

# BEGIN ("Ltest2", 1, 0, [], ["b"], [{ blab="L53"; elab="L54"; names=[]; subs=[{ blab="L56"; elab="L57"; names=[]; subs=[]; }]; }])

	.type test2, @function

	.stabs "test2:F1",36,0,0,Ltest2

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLtest2_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLtest2_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$1,	%r11
	je	Ltest2_argc_correct
	movq	%r11,	%r13
	movq	$1,	%r12
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
Ltest2_argc_correct:

# SLABEL ("L53")

L53:

# SLABEL ("L56")

L56:

# LINE (8)

	.stabn 68,0,8,0

	.stabn 68,0,8,.L16-Ltest2

.L16:

# LINE (9)

	.stabn 68,0,9,.L17-Ltest2

.L17:

# LD (Arg (0))

	movq	%rdi,	%r10
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

# CALL ("Lprint", 0, true)

	pushq	%rdi
	pushq	filler(%rip)
	movq	$0,	%r11
	call	Lprint
	addq	$8,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# SLABEL ("L57")

L57:

# LABEL ("L55")

L55:

# SLABEL ("L54")

L54:

# END

	movq	%r10,	%rax
LLtest2_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLtest2_SIZE,	0

	.set	LSLtest2_SIZE,	0

	.size Ltest2, .-Ltest2

# LABEL ("Ltest1")

Ltest1:

# BEGIN ("Ltest1", 1, 0, [], ["a"], [{ blab="L62"; elab="L63"; names=[]; subs=[{ blab="L65"; elab="L66"; names=[]; subs=[]; }]; }])

	.type test1, @function

	.stabs "test1:F1",36,0,0,Ltest1

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLtest1_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLtest1_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$1,	%r11
	je	Ltest1_argc_correct
	movq	%r11,	%r13
	movq	$1,	%r12
	leaq	string_4(%rip),	%r11
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
Ltest1_argc_correct:

# SLABEL ("L62")

L62:

# SLABEL ("L65")

L65:

# LINE (3)

	.stabn 68,0,3,0

	.stabn 68,0,3,.L18-Ltest1

.L18:

# LINE (4)

	.stabn 68,0,4,.L19-Ltest1

.L19:

# LD (Arg (0))

	movq	%rdi,	%r10
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

# CALL ("Lprint", 0, true)

	pushq	%rdi
	pushq	filler(%rip)
	movq	$0,	%r11
	call	Lprint
	addq	$8,	%rsp
	popq	%rdi
	movq	%rax,	%r10
# SLABEL ("L66")

L66:

# LABEL ("L64")

L64:

# SLABEL ("L63")

L63:

# END

	movq	%r10,	%rax
LLtest1_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLtest1_SIZE,	0

	.set	LSLtest1_SIZE,	0

	.size Ltest1, .-Ltest1


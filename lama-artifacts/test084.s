	.file "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test084/test084.lama"

	.stabs "/mnt/c/Users/NIKITA/Documents/project/repo/.lama-export.hQsMOx/work/test084/test084.lama",100,0,0,.Ltext

	.globl	main

	.data

string_0:	.string	"Function %s called with incorrect arguments count. Expected: %d. Actual: %d\n"

string_1:	.string	"test"

init:	.quad 0

	.section custom_data,"aw",@progbits

filler:	.fill	5, 8, 1

	.stabs "n:S1",40,0,0,global_n

global_n:	.quad	1

	.stabs "t:S1",40,0,0,global_t

global_t:	.quad	1

	.stabs "y:S1",40,0,0,global_y

global_y:	.quad	1

	.stabs "y2:S1",40,0,0,global_y2

global_y2:	.quad	1

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

# LINE (14)

	.stabn 68,0,14,.L0

.L0:

# CALL ("Lread", 0, false)

	pushq	%rdi
	pushq	%rsi
	movq	$0,	%r11
	call	Lread
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# LINE (12)

	.stabn 68,0,12,.L1

.L1:

# ST (Global ("n"))

	movq	%r10,	global_n(%rip)
# DROP

# SLABEL ("L10")

L10:

# SLABEL ("L14")

L14:

# SLABEL ("L18")

L18:

# SLABEL ("L22")

L22:

# SLABEL ("L26")

L26:

# SLABEL ("L30")

L30:

# SLABEL ("L34")

L34:

# SLABEL ("L38")

L38:

# CONST (1)

	movq	$3,	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# SLABEL ("L39")

L39:

# SLABEL ("L42")

L42:

# CONST (1)

	movq	$3,	%r11
# CONST (1)

	movq	$3,	%r12
# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L43")

L43:

# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# SLABEL ("L35")

L35:

# SLABEL ("L46")

L46:

# SLABEL ("L50")

L50:

# CONST (1)

	movq	$3,	%r11
# CONST (1)

	movq	$3,	%r12
# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L51")

L51:

# SLABEL ("L54")

L54:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L55")

L55:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L47")

L47:

# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# SLABEL ("L31")

L31:

# SLABEL ("L58")

L58:

# SLABEL ("L62")

L62:

# SLABEL ("L66")

L66:

# CONST (1)

	movq	$3,	%r11
# CONST (1)

	movq	$3,	%r12
# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L67")

L67:

# SLABEL ("L70")

L70:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L71")

L71:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L63")

L63:

# SLABEL ("L74")

L74:

# SLABEL ("L78")

L78:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L79")

L79:

# SLABEL ("L82")

L82:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L83")

L83:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L75")

L75:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L59")

L59:

# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# SLABEL ("L27")

L27:

# SLABEL ("L86")

L86:

# SLABEL ("L90")

L90:

# SLABEL ("L94")

L94:

# SLABEL ("L98")

L98:

# CONST (1)

	movq	$3,	%r11
# CONST (1)

	movq	$3,	%r12
# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L99")

L99:

# SLABEL ("L102")

L102:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L103")

L103:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L95")

L95:

# SLABEL ("L106")

L106:

# SLABEL ("L110")

L110:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L111")

L111:

# SLABEL ("L114")

L114:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L115")

L115:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L107")

L107:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L91")

L91:

# SLABEL ("L118")

L118:

# SLABEL ("L122")

L122:

# SLABEL ("L126")

L126:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L127")

L127:

# SLABEL ("L130")

L130:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L131")

L131:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L123")

L123:

# SLABEL ("L134")

L134:

# SLABEL ("L138")

L138:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L139")

L139:

# SLABEL ("L142")

L142:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L143")

L143:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L135")

L135:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L119")

L119:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L87")

L87:

# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# SLABEL ("L23")

L23:

# SLABEL ("L146")

L146:

# SLABEL ("L150")

L150:

# SLABEL ("L154")

L154:

# SLABEL ("L158")

L158:

# SLABEL ("L162")

L162:

# CONST (1)

	movq	$3,	%r11
# CONST (1)

	movq	$3,	%r12
# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L163")

L163:

# SLABEL ("L166")

L166:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L167")

L167:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L159")

L159:

# SLABEL ("L170")

L170:

# SLABEL ("L174")

L174:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L175")

L175:

# SLABEL ("L178")

L178:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L179")

L179:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L171")

L171:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L155")

L155:

# SLABEL ("L182")

L182:

# SLABEL ("L186")

L186:

# SLABEL ("L190")

L190:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L191")

L191:

# SLABEL ("L194")

L194:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L195")

L195:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L187")

L187:

# SLABEL ("L198")

L198:

# SLABEL ("L202")

L202:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L203")

L203:

# SLABEL ("L206")

L206:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L207")

L207:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L199")

L199:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L183")

L183:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L151")

L151:

# SLABEL ("L210")

L210:

# SLABEL ("L214")

L214:

# SLABEL ("L218")

L218:

# SLABEL ("L222")

L222:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L223")

L223:

# SLABEL ("L226")

L226:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L227")

L227:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L219")

L219:

# SLABEL ("L230")

L230:

# SLABEL ("L234")

L234:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L235")

L235:

# SLABEL ("L238")

L238:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L239")

L239:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L231")

L231:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L215")

L215:

# SLABEL ("L242")

L242:

# SLABEL ("L246")

L246:

# SLABEL ("L250")

L250:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L251")

L251:

# SLABEL ("L254")

L254:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L255")

L255:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L247")

L247:

# SLABEL ("L258")

L258:

# SLABEL ("L262")

L262:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L263")

L263:

# SLABEL ("L266")

L266:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L267")

L267:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L259")

L259:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L243")

L243:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L211")

L211:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L147")

L147:

# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# SLABEL ("L19")

L19:

# SLABEL ("L270")

L270:

# SLABEL ("L274")

L274:

# SLABEL ("L278")

L278:

# SLABEL ("L282")

L282:

# SLABEL ("L286")

L286:

# SLABEL ("L290")

L290:

# CONST (1)

	movq	$3,	%r11
# CONST (1)

	movq	$3,	%r12
# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L291")

L291:

# SLABEL ("L294")

L294:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L295")

L295:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L287")

L287:

# SLABEL ("L298")

L298:

# SLABEL ("L302")

L302:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L303")

L303:

# SLABEL ("L306")

L306:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L307")

L307:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L299")

L299:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L283")

L283:

# SLABEL ("L310")

L310:

# SLABEL ("L314")

L314:

# SLABEL ("L318")

L318:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L319")

L319:

# SLABEL ("L322")

L322:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L323")

L323:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L315")

L315:

# SLABEL ("L326")

L326:

# SLABEL ("L330")

L330:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L331")

L331:

# SLABEL ("L334")

L334:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L335")

L335:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L327")

L327:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L311")

L311:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L279")

L279:

# SLABEL ("L338")

L338:

# SLABEL ("L342")

L342:

# SLABEL ("L346")

L346:

# SLABEL ("L350")

L350:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L351")

L351:

# SLABEL ("L354")

L354:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L355")

L355:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L347")

L347:

# SLABEL ("L358")

L358:

# SLABEL ("L362")

L362:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L363")

L363:

# SLABEL ("L366")

L366:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L367")

L367:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L359")

L359:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L343")

L343:

# SLABEL ("L370")

L370:

# SLABEL ("L374")

L374:

# SLABEL ("L378")

L378:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L379")

L379:

# SLABEL ("L382")

L382:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L383")

L383:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L375")

L375:

# SLABEL ("L386")

L386:

# SLABEL ("L390")

L390:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L391")

L391:

# SLABEL ("L394")

L394:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L395")

L395:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L387")

L387:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L371")

L371:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L339")

L339:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L275")

L275:

# SLABEL ("L398")

L398:

# SLABEL ("L402")

L402:

# SLABEL ("L406")

L406:

# SLABEL ("L410")

L410:

# SLABEL ("L414")

L414:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L415")

L415:

# SLABEL ("L418")

L418:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L419")

L419:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L411")

L411:

# SLABEL ("L422")

L422:

# SLABEL ("L426")

L426:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L427")

L427:

# SLABEL ("L430")

L430:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L431")

L431:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L423")

L423:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L407")

L407:

# SLABEL ("L434")

L434:

# SLABEL ("L438")

L438:

# SLABEL ("L442")

L442:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L443")

L443:

# SLABEL ("L446")

L446:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L447")

L447:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L439")

L439:

# SLABEL ("L450")

L450:

# SLABEL ("L454")

L454:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L455")

L455:

# SLABEL ("L458")

L458:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L459")

L459:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L451")

L451:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L435")

L435:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L403")

L403:

# SLABEL ("L462")

L462:

# SLABEL ("L466")

L466:

# SLABEL ("L470")

L470:

# SLABEL ("L474")

L474:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L475")

L475:

# SLABEL ("L478")

L478:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L479")

L479:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L471")

L471:

# SLABEL ("L482")

L482:

# SLABEL ("L486")

L486:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L487")

L487:

# SLABEL ("L490")

L490:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L491")

L491:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L483")

L483:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L467")

L467:

# SLABEL ("L494")

L494:

# SLABEL ("L498")

L498:

# SLABEL ("L502")

L502:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L503")

L503:

# SLABEL ("L506")

L506:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L507")

L507:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L499")

L499:

# SLABEL ("L510")

L510:

# SLABEL ("L514")

L514:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L515")

L515:

# SLABEL ("L518")

L518:

# CONST (1)

	movq	$3,	-16(%rbp)
# CONST (1)

	movq	$3,	-24(%rbp)
# BINOP ("+")

	movq	-24(%rbp),	%rax
	decq	%rax
	addq	%rax,	-16(%rbp)
# SLABEL ("L519")

L519:

# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L511")

L511:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L495")

L495:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L463")

L463:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L399")

L399:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L271")

L271:

# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# SLABEL ("L15")

L15:

# SLABEL ("L522")

L522:

# SLABEL ("L526")

L526:

# SLABEL ("L530")

L530:

# SLABEL ("L534")

L534:

# SLABEL ("L538")

L538:

# SLABEL ("L542")

L542:

# SLABEL ("L546")

L546:

# CONST (1)

	movq	$3,	%r11
# CONST (1)

	movq	$3,	%r12
# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L547")

L547:

# SLABEL ("L550")

L550:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L551")

L551:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L543")

L543:

# SLABEL ("L554")

L554:

# SLABEL ("L558")

L558:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L559")

L559:

# SLABEL ("L562")

L562:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L563")

L563:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L555")

L555:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L539")

L539:

# SLABEL ("L566")

L566:

# SLABEL ("L570")

L570:

# SLABEL ("L574")

L574:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L575")

L575:

# SLABEL ("L578")

L578:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L579")

L579:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L571")

L571:

# SLABEL ("L582")

L582:

# SLABEL ("L586")

L586:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L587")

L587:

# SLABEL ("L590")

L590:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L591")

L591:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L583")

L583:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L567")

L567:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L535")

L535:

# SLABEL ("L594")

L594:

# SLABEL ("L598")

L598:

# SLABEL ("L602")

L602:

# SLABEL ("L606")

L606:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L607")

L607:

# SLABEL ("L610")

L610:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L611")

L611:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L603")

L603:

# SLABEL ("L614")

L614:

# SLABEL ("L618")

L618:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L619")

L619:

# SLABEL ("L622")

L622:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L623")

L623:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L615")

L615:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L599")

L599:

# SLABEL ("L626")

L626:

# SLABEL ("L630")

L630:

# SLABEL ("L634")

L634:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L635")

L635:

# SLABEL ("L638")

L638:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L639")

L639:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L631")

L631:

# SLABEL ("L642")

L642:

# SLABEL ("L646")

L646:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L647")

L647:

# SLABEL ("L650")

L650:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L651")

L651:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L643")

L643:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L627")

L627:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L595")

L595:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L531")

L531:

# SLABEL ("L654")

L654:

# SLABEL ("L658")

L658:

# SLABEL ("L662")

L662:

# SLABEL ("L666")

L666:

# SLABEL ("L670")

L670:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L671")

L671:

# SLABEL ("L674")

L674:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L675")

L675:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L667")

L667:

# SLABEL ("L678")

L678:

# SLABEL ("L682")

L682:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L683")

L683:

# SLABEL ("L686")

L686:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L687")

L687:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L679")

L679:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L663")

L663:

# SLABEL ("L690")

L690:

# SLABEL ("L694")

L694:

# SLABEL ("L698")

L698:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L699")

L699:

# SLABEL ("L702")

L702:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L703")

L703:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L695")

L695:

# SLABEL ("L706")

L706:

# SLABEL ("L710")

L710:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L711")

L711:

# SLABEL ("L714")

L714:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L715")

L715:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L707")

L707:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L691")

L691:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L659")

L659:

# SLABEL ("L718")

L718:

# SLABEL ("L722")

L722:

# SLABEL ("L726")

L726:

# SLABEL ("L730")

L730:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L731")

L731:

# SLABEL ("L734")

L734:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L735")

L735:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L727")

L727:

# SLABEL ("L738")

L738:

# SLABEL ("L742")

L742:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L743")

L743:

# SLABEL ("L746")

L746:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L747")

L747:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L739")

L739:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L723")

L723:

# SLABEL ("L750")

L750:

# SLABEL ("L754")

L754:

# SLABEL ("L758")

L758:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L759")

L759:

# SLABEL ("L762")

L762:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L763")

L763:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L755")

L755:

# SLABEL ("L766")

L766:

# SLABEL ("L770")

L770:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L771")

L771:

# SLABEL ("L774")

L774:

# CONST (1)

	movq	$3,	-16(%rbp)
# CONST (1)

	movq	$3,	-24(%rbp)
# BINOP ("+")

	movq	-24(%rbp),	%rax
	decq	%rax
	addq	%rax,	-16(%rbp)
# SLABEL ("L775")

L775:

# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L767")

L767:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L751")

L751:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L719")

L719:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L655")

L655:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L527")

L527:

# SLABEL ("L778")

L778:

# SLABEL ("L782")

L782:

# SLABEL ("L786")

L786:

# SLABEL ("L790")

L790:

# SLABEL ("L794")

L794:

# SLABEL ("L798")

L798:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L799")

L799:

# SLABEL ("L802")

L802:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L803")

L803:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L795")

L795:

# SLABEL ("L806")

L806:

# SLABEL ("L810")

L810:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L811")

L811:

# SLABEL ("L814")

L814:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L815")

L815:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L807")

L807:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L791")

L791:

# SLABEL ("L818")

L818:

# SLABEL ("L822")

L822:

# SLABEL ("L826")

L826:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L827")

L827:

# SLABEL ("L830")

L830:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L831")

L831:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L823")

L823:

# SLABEL ("L834")

L834:

# SLABEL ("L838")

L838:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L839")

L839:

# SLABEL ("L842")

L842:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L843")

L843:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L835")

L835:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L819")

L819:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L787")

L787:

# SLABEL ("L846")

L846:

# SLABEL ("L850")

L850:

# SLABEL ("L854")

L854:

# SLABEL ("L858")

L858:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L859")

L859:

# SLABEL ("L862")

L862:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L863")

L863:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L855")

L855:

# SLABEL ("L866")

L866:

# SLABEL ("L870")

L870:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L871")

L871:

# SLABEL ("L874")

L874:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L875")

L875:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L867")

L867:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L851")

L851:

# SLABEL ("L878")

L878:

# SLABEL ("L882")

L882:

# SLABEL ("L886")

L886:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L887")

L887:

# SLABEL ("L890")

L890:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L891")

L891:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L883")

L883:

# SLABEL ("L894")

L894:

# SLABEL ("L898")

L898:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L899")

L899:

# SLABEL ("L902")

L902:

# CONST (1)

	movq	$3,	-16(%rbp)
# CONST (1)

	movq	$3,	-24(%rbp)
# BINOP ("+")

	movq	-24(%rbp),	%rax
	decq	%rax
	addq	%rax,	-16(%rbp)
# SLABEL ("L903")

L903:

# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L895")

L895:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L879")

L879:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L847")

L847:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L783")

L783:

# SLABEL ("L906")

L906:

# SLABEL ("L910")

L910:

# SLABEL ("L914")

L914:

# SLABEL ("L918")

L918:

# SLABEL ("L922")

L922:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L923")

L923:

# SLABEL ("L926")

L926:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L927")

L927:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L919")

L919:

# SLABEL ("L930")

L930:

# SLABEL ("L934")

L934:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L935")

L935:

# SLABEL ("L938")

L938:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L939")

L939:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L931")

L931:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L915")

L915:

# SLABEL ("L942")

L942:

# SLABEL ("L946")

L946:

# SLABEL ("L950")

L950:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L951")

L951:

# SLABEL ("L954")

L954:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L955")

L955:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L947")

L947:

# SLABEL ("L958")

L958:

# SLABEL ("L962")

L962:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L963")

L963:

# SLABEL ("L966")

L966:

# CONST (1)

	movq	$3,	-16(%rbp)
# CONST (1)

	movq	$3,	-24(%rbp)
# BINOP ("+")

	movq	-24(%rbp),	%rax
	decq	%rax
	addq	%rax,	-16(%rbp)
# SLABEL ("L967")

L967:

# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L959")

L959:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L943")

L943:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L911")

L911:

# SLABEL ("L970")

L970:

# SLABEL ("L974")

L974:

# SLABEL ("L978")

L978:

# SLABEL ("L982")

L982:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L983")

L983:

# SLABEL ("L986")

L986:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L987")

L987:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L979")

L979:

# SLABEL ("L990")

L990:

# SLABEL ("L994")

L994:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L995")

L995:

# SLABEL ("L998")

L998:

# CONST (1)

	movq	$3,	-16(%rbp)
# CONST (1)

	movq	$3,	-24(%rbp)
# BINOP ("+")

	movq	-24(%rbp),	%rax
	decq	%rax
	addq	%rax,	-16(%rbp)
# SLABEL ("L999")

L999:

# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L991")

L991:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L975")

L975:

# SLABEL ("L1002")

L1002:

# SLABEL ("L1006")

L1006:

# SLABEL ("L1010")

L1010:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1011")

L1011:

# SLABEL ("L1014")

L1014:

# CONST (1)

	movq	$3,	-16(%rbp)
# CONST (1)

	movq	$3,	-24(%rbp)
# BINOP ("+")

	movq	-24(%rbp),	%rax
	decq	%rax
	addq	%rax,	-16(%rbp)
# SLABEL ("L1015")

L1015:

# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1007")

L1007:

# SLABEL ("L1018")

L1018:

# SLABEL ("L1022")

L1022:

# CONST (1)

	movq	$3,	-16(%rbp)
# CONST (1)

	movq	$3,	-24(%rbp)
# BINOP ("+")

	movq	-24(%rbp),	%rax
	decq	%rax
	addq	%rax,	-16(%rbp)
# SLABEL ("L1023")

L1023:

# SLABEL ("L1026")

L1026:

# CONST (1)

	movq	$3,	-24(%rbp)
# LINE (15)

	.stabn 68,0,15,.L2

.L2:

# CONST (10)

	movq	$21,	-32(%rbp)
# CONST (100)

	movq	$201,	-40(%rbp)
# CALL ("Ltest", 2, false)

	pushq	%rdi
	pushq	%rsi
	pushq	%r10
	pushq	%r11
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	filler(%rip)
	movq	-40(%rbp),	%rsi
	movq	-32(%rbp),	%rdi
	movq	$2,	%r11
	call	Ltest
	addq	$8,	%rsp
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%r11
	popq	%r10
	popq	%rsi
	popq	%rdi
	movq	%rax,	-32(%rbp)
# BINOP ("+")

	movq	-32(%rbp),	%rax
	decq	%rax
	addq	%rax,	-24(%rbp)
# SLABEL ("L1027")

L1027:

# BINOP ("+")

	movq	-24(%rbp),	%rax
	decq	%rax
	addq	%rax,	-16(%rbp)
# SLABEL ("L1019")

L1019:

# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1003")

L1003:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L971")

L971:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L907")

L907:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L779")

L779:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L523")

L523:

# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# SLABEL ("L11")

L11:

# ST (Global ("y"))

	movq	%r10,	global_y(%rip)
# DROP

# LINE (17)

	.stabn 68,0,17,.L3

.L3:

# CONST (10)

	movq	$21,	%r10
# CONST (100)

	movq	$201,	%r11
# CALL ("Ltest", 2, false)

	pushq	%rdi
	pushq	%rsi
	movq	%r11,	%rsi
	movq	%r10,	%rdi
	movq	$2,	%r11
	call	Ltest
	popq	%rsi
	popq	%rdi
	movq	%rax,	%r10
# ST (Global ("t"))

	movq	%r10,	global_t(%rip)
# DROP

# SLABEL ("L1040")

L1040:

# SLABEL ("L1044")

L1044:

# SLABEL ("L1048")

L1048:

# SLABEL ("L1052")

L1052:

# SLABEL ("L1056")

L1056:

# SLABEL ("L1060")

L1060:

# SLABEL ("L1064")

L1064:

# SLABEL ("L1068")

L1068:

# CONST (1)

	movq	$3,	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# SLABEL ("L1069")

L1069:

# SLABEL ("L1072")

L1072:

# CONST (1)

	movq	$3,	%r11
# CONST (1)

	movq	$3,	%r12
# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1073")

L1073:

# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# SLABEL ("L1065")

L1065:

# SLABEL ("L1076")

L1076:

# SLABEL ("L1080")

L1080:

# CONST (1)

	movq	$3,	%r11
# CONST (1)

	movq	$3,	%r12
# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1081")

L1081:

# SLABEL ("L1084")

L1084:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1085")

L1085:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1077")

L1077:

# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# SLABEL ("L1061")

L1061:

# SLABEL ("L1088")

L1088:

# SLABEL ("L1092")

L1092:

# SLABEL ("L1096")

L1096:

# CONST (1)

	movq	$3,	%r11
# CONST (1)

	movq	$3,	%r12
# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1097")

L1097:

# SLABEL ("L1100")

L1100:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1101")

L1101:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1093")

L1093:

# SLABEL ("L1104")

L1104:

# SLABEL ("L1108")

L1108:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1109")

L1109:

# SLABEL ("L1112")

L1112:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1113")

L1113:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1105")

L1105:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1089")

L1089:

# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# SLABEL ("L1057")

L1057:

# SLABEL ("L1116")

L1116:

# SLABEL ("L1120")

L1120:

# SLABEL ("L1124")

L1124:

# SLABEL ("L1128")

L1128:

# CONST (1)

	movq	$3,	%r11
# CONST (1)

	movq	$3,	%r12
# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1129")

L1129:

# SLABEL ("L1132")

L1132:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1133")

L1133:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1125")

L1125:

# SLABEL ("L1136")

L1136:

# SLABEL ("L1140")

L1140:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1141")

L1141:

# SLABEL ("L1144")

L1144:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1145")

L1145:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1137")

L1137:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1121")

L1121:

# SLABEL ("L1148")

L1148:

# SLABEL ("L1152")

L1152:

# SLABEL ("L1156")

L1156:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1157")

L1157:

# SLABEL ("L1160")

L1160:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1161")

L1161:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1153")

L1153:

# SLABEL ("L1164")

L1164:

# SLABEL ("L1168")

L1168:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1169")

L1169:

# SLABEL ("L1172")

L1172:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1173")

L1173:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1165")

L1165:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1149")

L1149:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1117")

L1117:

# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# SLABEL ("L1053")

L1053:

# SLABEL ("L1176")

L1176:

# SLABEL ("L1180")

L1180:

# SLABEL ("L1184")

L1184:

# SLABEL ("L1188")

L1188:

# SLABEL ("L1192")

L1192:

# CONST (1)

	movq	$3,	%r11
# CONST (1)

	movq	$3,	%r12
# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1193")

L1193:

# SLABEL ("L1196")

L1196:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1197")

L1197:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1189")

L1189:

# SLABEL ("L1200")

L1200:

# SLABEL ("L1204")

L1204:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1205")

L1205:

# SLABEL ("L1208")

L1208:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1209")

L1209:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1201")

L1201:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1185")

L1185:

# SLABEL ("L1212")

L1212:

# SLABEL ("L1216")

L1216:

# SLABEL ("L1220")

L1220:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1221")

L1221:

# SLABEL ("L1224")

L1224:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1225")

L1225:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1217")

L1217:

# SLABEL ("L1228")

L1228:

# SLABEL ("L1232")

L1232:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1233")

L1233:

# SLABEL ("L1236")

L1236:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1237")

L1237:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1229")

L1229:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1213")

L1213:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1181")

L1181:

# SLABEL ("L1240")

L1240:

# SLABEL ("L1244")

L1244:

# SLABEL ("L1248")

L1248:

# SLABEL ("L1252")

L1252:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1253")

L1253:

# SLABEL ("L1256")

L1256:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1257")

L1257:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1249")

L1249:

# SLABEL ("L1260")

L1260:

# SLABEL ("L1264")

L1264:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1265")

L1265:

# SLABEL ("L1268")

L1268:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1269")

L1269:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1261")

L1261:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1245")

L1245:

# SLABEL ("L1272")

L1272:

# SLABEL ("L1276")

L1276:

# SLABEL ("L1280")

L1280:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1281")

L1281:

# SLABEL ("L1284")

L1284:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1285")

L1285:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1277")

L1277:

# SLABEL ("L1288")

L1288:

# SLABEL ("L1292")

L1292:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1293")

L1293:

# SLABEL ("L1296")

L1296:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1297")

L1297:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1289")

L1289:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1273")

L1273:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1241")

L1241:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1177")

L1177:

# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# SLABEL ("L1049")

L1049:

# SLABEL ("L1300")

L1300:

# SLABEL ("L1304")

L1304:

# SLABEL ("L1308")

L1308:

# SLABEL ("L1312")

L1312:

# SLABEL ("L1316")

L1316:

# SLABEL ("L1320")

L1320:

# CONST (1)

	movq	$3,	%r11
# CONST (1)

	movq	$3,	%r12
# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1321")

L1321:

# SLABEL ("L1324")

L1324:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1325")

L1325:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1317")

L1317:

# SLABEL ("L1328")

L1328:

# SLABEL ("L1332")

L1332:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1333")

L1333:

# SLABEL ("L1336")

L1336:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1337")

L1337:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1329")

L1329:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1313")

L1313:

# SLABEL ("L1340")

L1340:

# SLABEL ("L1344")

L1344:

# SLABEL ("L1348")

L1348:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1349")

L1349:

# SLABEL ("L1352")

L1352:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1353")

L1353:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1345")

L1345:

# SLABEL ("L1356")

L1356:

# SLABEL ("L1360")

L1360:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1361")

L1361:

# SLABEL ("L1364")

L1364:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1365")

L1365:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1357")

L1357:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1341")

L1341:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1309")

L1309:

# SLABEL ("L1368")

L1368:

# SLABEL ("L1372")

L1372:

# SLABEL ("L1376")

L1376:

# SLABEL ("L1380")

L1380:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1381")

L1381:

# SLABEL ("L1384")

L1384:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1385")

L1385:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1377")

L1377:

# SLABEL ("L1388")

L1388:

# SLABEL ("L1392")

L1392:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1393")

L1393:

# SLABEL ("L1396")

L1396:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1397")

L1397:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1389")

L1389:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1373")

L1373:

# SLABEL ("L1400")

L1400:

# SLABEL ("L1404")

L1404:

# SLABEL ("L1408")

L1408:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1409")

L1409:

# SLABEL ("L1412")

L1412:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1413")

L1413:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1405")

L1405:

# SLABEL ("L1416")

L1416:

# SLABEL ("L1420")

L1420:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1421")

L1421:

# SLABEL ("L1424")

L1424:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1425")

L1425:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1417")

L1417:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1401")

L1401:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1369")

L1369:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1305")

L1305:

# SLABEL ("L1428")

L1428:

# SLABEL ("L1432")

L1432:

# SLABEL ("L1436")

L1436:

# SLABEL ("L1440")

L1440:

# SLABEL ("L1444")

L1444:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1445")

L1445:

# SLABEL ("L1448")

L1448:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1449")

L1449:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1441")

L1441:

# SLABEL ("L1452")

L1452:

# SLABEL ("L1456")

L1456:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1457")

L1457:

# SLABEL ("L1460")

L1460:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1461")

L1461:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1453")

L1453:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1437")

L1437:

# SLABEL ("L1464")

L1464:

# SLABEL ("L1468")

L1468:

# SLABEL ("L1472")

L1472:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1473")

L1473:

# SLABEL ("L1476")

L1476:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1477")

L1477:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1469")

L1469:

# SLABEL ("L1480")

L1480:

# SLABEL ("L1484")

L1484:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1485")

L1485:

# SLABEL ("L1488")

L1488:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1489")

L1489:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1481")

L1481:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1465")

L1465:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1433")

L1433:

# SLABEL ("L1492")

L1492:

# SLABEL ("L1496")

L1496:

# SLABEL ("L1500")

L1500:

# SLABEL ("L1504")

L1504:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1505")

L1505:

# SLABEL ("L1508")

L1508:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1509")

L1509:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1501")

L1501:

# SLABEL ("L1512")

L1512:

# SLABEL ("L1516")

L1516:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1517")

L1517:

# SLABEL ("L1520")

L1520:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1521")

L1521:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1513")

L1513:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1497")

L1497:

# SLABEL ("L1524")

L1524:

# SLABEL ("L1528")

L1528:

# SLABEL ("L1532")

L1532:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1533")

L1533:

# SLABEL ("L1536")

L1536:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1537")

L1537:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1529")

L1529:

# SLABEL ("L1540")

L1540:

# SLABEL ("L1544")

L1544:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1545")

L1545:

# SLABEL ("L1548")

L1548:

# CONST (1)

	movq	$3,	-16(%rbp)
# CONST (1)

	movq	$3,	-24(%rbp)
# BINOP ("+")

	movq	-24(%rbp),	%rax
	decq	%rax
	addq	%rax,	-16(%rbp)
# SLABEL ("L1549")

L1549:

# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1541")

L1541:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1525")

L1525:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1493")

L1493:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1429")

L1429:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1301")

L1301:

# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# SLABEL ("L1045")

L1045:

# SLABEL ("L1552")

L1552:

# SLABEL ("L1556")

L1556:

# SLABEL ("L1560")

L1560:

# SLABEL ("L1564")

L1564:

# SLABEL ("L1568")

L1568:

# SLABEL ("L1572")

L1572:

# SLABEL ("L1576")

L1576:

# CONST (1)

	movq	$3,	%r11
# CONST (1)

	movq	$3,	%r12
# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1577")

L1577:

# SLABEL ("L1580")

L1580:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1581")

L1581:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1573")

L1573:

# SLABEL ("L1584")

L1584:

# SLABEL ("L1588")

L1588:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1589")

L1589:

# SLABEL ("L1592")

L1592:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1593")

L1593:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1585")

L1585:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1569")

L1569:

# SLABEL ("L1596")

L1596:

# SLABEL ("L1600")

L1600:

# SLABEL ("L1604")

L1604:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1605")

L1605:

# SLABEL ("L1608")

L1608:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1609")

L1609:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1601")

L1601:

# SLABEL ("L1612")

L1612:

# SLABEL ("L1616")

L1616:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1617")

L1617:

# SLABEL ("L1620")

L1620:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1621")

L1621:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1613")

L1613:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1597")

L1597:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1565")

L1565:

# SLABEL ("L1624")

L1624:

# SLABEL ("L1628")

L1628:

# SLABEL ("L1632")

L1632:

# SLABEL ("L1636")

L1636:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1637")

L1637:

# SLABEL ("L1640")

L1640:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1641")

L1641:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1633")

L1633:

# SLABEL ("L1644")

L1644:

# SLABEL ("L1648")

L1648:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1649")

L1649:

# SLABEL ("L1652")

L1652:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1653")

L1653:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1645")

L1645:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1629")

L1629:

# SLABEL ("L1656")

L1656:

# SLABEL ("L1660")

L1660:

# SLABEL ("L1664")

L1664:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1665")

L1665:

# SLABEL ("L1668")

L1668:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1669")

L1669:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1661")

L1661:

# SLABEL ("L1672")

L1672:

# SLABEL ("L1676")

L1676:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1677")

L1677:

# SLABEL ("L1680")

L1680:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1681")

L1681:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1673")

L1673:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1657")

L1657:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1625")

L1625:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1561")

L1561:

# SLABEL ("L1684")

L1684:

# SLABEL ("L1688")

L1688:

# SLABEL ("L1692")

L1692:

# SLABEL ("L1696")

L1696:

# SLABEL ("L1700")

L1700:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1701")

L1701:

# SLABEL ("L1704")

L1704:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1705")

L1705:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1697")

L1697:

# SLABEL ("L1708")

L1708:

# SLABEL ("L1712")

L1712:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1713")

L1713:

# SLABEL ("L1716")

L1716:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1717")

L1717:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1709")

L1709:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1693")

L1693:

# SLABEL ("L1720")

L1720:

# SLABEL ("L1724")

L1724:

# SLABEL ("L1728")

L1728:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1729")

L1729:

# SLABEL ("L1732")

L1732:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1733")

L1733:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1725")

L1725:

# SLABEL ("L1736")

L1736:

# SLABEL ("L1740")

L1740:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1741")

L1741:

# SLABEL ("L1744")

L1744:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1745")

L1745:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1737")

L1737:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1721")

L1721:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1689")

L1689:

# SLABEL ("L1748")

L1748:

# SLABEL ("L1752")

L1752:

# SLABEL ("L1756")

L1756:

# SLABEL ("L1760")

L1760:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1761")

L1761:

# SLABEL ("L1764")

L1764:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1765")

L1765:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1757")

L1757:

# SLABEL ("L1768")

L1768:

# SLABEL ("L1772")

L1772:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1773")

L1773:

# SLABEL ("L1776")

L1776:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1777")

L1777:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1769")

L1769:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1753")

L1753:

# SLABEL ("L1780")

L1780:

# SLABEL ("L1784")

L1784:

# SLABEL ("L1788")

L1788:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1789")

L1789:

# SLABEL ("L1792")

L1792:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1793")

L1793:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1785")

L1785:

# SLABEL ("L1796")

L1796:

# SLABEL ("L1800")

L1800:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1801")

L1801:

# SLABEL ("L1804")

L1804:

# CONST (1)

	movq	$3,	-16(%rbp)
# CONST (1)

	movq	$3,	-24(%rbp)
# BINOP ("+")

	movq	-24(%rbp),	%rax
	decq	%rax
	addq	%rax,	-16(%rbp)
# SLABEL ("L1805")

L1805:

# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1797")

L1797:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1781")

L1781:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1749")

L1749:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1685")

L1685:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1557")

L1557:

# SLABEL ("L1808")

L1808:

# SLABEL ("L1812")

L1812:

# SLABEL ("L1816")

L1816:

# SLABEL ("L1820")

L1820:

# SLABEL ("L1824")

L1824:

# SLABEL ("L1828")

L1828:

# CONST (1)

	movq	$3,	%r12
# CONST (1)

	movq	$3,	%r13
# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1829")

L1829:

# SLABEL ("L1832")

L1832:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1833")

L1833:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1825")

L1825:

# SLABEL ("L1836")

L1836:

# SLABEL ("L1840")

L1840:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1841")

L1841:

# SLABEL ("L1844")

L1844:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1845")

L1845:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1837")

L1837:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1821")

L1821:

# SLABEL ("L1848")

L1848:

# SLABEL ("L1852")

L1852:

# SLABEL ("L1856")

L1856:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1857")

L1857:

# SLABEL ("L1860")

L1860:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1861")

L1861:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1853")

L1853:

# SLABEL ("L1864")

L1864:

# SLABEL ("L1868")

L1868:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1869")

L1869:

# SLABEL ("L1872")

L1872:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1873")

L1873:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1865")

L1865:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1849")

L1849:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1817")

L1817:

# SLABEL ("L1876")

L1876:

# SLABEL ("L1880")

L1880:

# SLABEL ("L1884")

L1884:

# SLABEL ("L1888")

L1888:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1889")

L1889:

# SLABEL ("L1892")

L1892:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1893")

L1893:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1885")

L1885:

# SLABEL ("L1896")

L1896:

# SLABEL ("L1900")

L1900:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1901")

L1901:

# SLABEL ("L1904")

L1904:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1905")

L1905:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1897")

L1897:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1881")

L1881:

# SLABEL ("L1908")

L1908:

# SLABEL ("L1912")

L1912:

# SLABEL ("L1916")

L1916:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1917")

L1917:

# SLABEL ("L1920")

L1920:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1921")

L1921:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1913")

L1913:

# SLABEL ("L1924")

L1924:

# SLABEL ("L1928")

L1928:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1929")

L1929:

# SLABEL ("L1932")

L1932:

# CONST (1)

	movq	$3,	-16(%rbp)
# CONST (1)

	movq	$3,	-24(%rbp)
# BINOP ("+")

	movq	-24(%rbp),	%rax
	decq	%rax
	addq	%rax,	-16(%rbp)
# SLABEL ("L1933")

L1933:

# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1925")

L1925:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1909")

L1909:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1877")

L1877:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1813")

L1813:

# SLABEL ("L1936")

L1936:

# SLABEL ("L1940")

L1940:

# SLABEL ("L1944")

L1944:

# SLABEL ("L1948")

L1948:

# SLABEL ("L1952")

L1952:

# CONST (1)

	movq	$3,	%r13
# CONST (1)

	movq	$3,	%r14
# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1953")

L1953:

# SLABEL ("L1956")

L1956:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1957")

L1957:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1949")

L1949:

# SLABEL ("L1960")

L1960:

# SLABEL ("L1964")

L1964:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1965")

L1965:

# SLABEL ("L1968")

L1968:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1969")

L1969:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1961")

L1961:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1945")

L1945:

# SLABEL ("L1972")

L1972:

# SLABEL ("L1976")

L1976:

# SLABEL ("L1980")

L1980:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1981")

L1981:

# SLABEL ("L1984")

L1984:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1985")

L1985:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1977")

L1977:

# SLABEL ("L1988")

L1988:

# SLABEL ("L1992")

L1992:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1993")

L1993:

# SLABEL ("L1996")

L1996:

# CONST (1)

	movq	$3,	-16(%rbp)
# CONST (1)

	movq	$3,	-24(%rbp)
# BINOP ("+")

	movq	-24(%rbp),	%rax
	decq	%rax
	addq	%rax,	-16(%rbp)
# SLABEL ("L1997")

L1997:

# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L1989")

L1989:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L1973")

L1973:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1941")

L1941:

# SLABEL ("L2000")

L2000:

# SLABEL ("L2004")

L2004:

# SLABEL ("L2008")

L2008:

# SLABEL ("L2012")

L2012:

# CONST (1)

	movq	$3,	%r14
# CONST (1)

	movq	$3,	-8(%rbp)
# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L2013")

L2013:

# SLABEL ("L2016")

L2016:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L2017")

L2017:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L2009")

L2009:

# SLABEL ("L2020")

L2020:

# SLABEL ("L2024")

L2024:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L2025")

L2025:

# SLABEL ("L2028")

L2028:

# CONST (1)

	movq	$3,	-16(%rbp)
# CONST (1)

	movq	$3,	-24(%rbp)
# BINOP ("+")

	movq	-24(%rbp),	%rax
	decq	%rax
	addq	%rax,	-16(%rbp)
# SLABEL ("L2029")

L2029:

# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L2021")

L2021:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L2005")

L2005:

# SLABEL ("L2032")

L2032:

# SLABEL ("L2036")

L2036:

# SLABEL ("L2040")

L2040:

# CONST (1)

	movq	$3,	-8(%rbp)
# CONST (1)

	movq	$3,	-16(%rbp)
# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L2041")

L2041:

# SLABEL ("L2044")

L2044:

# CONST (1)

	movq	$3,	-16(%rbp)
# CONST (1)

	movq	$3,	-24(%rbp)
# BINOP ("+")

	movq	-24(%rbp),	%rax
	decq	%rax
	addq	%rax,	-16(%rbp)
# SLABEL ("L2045")

L2045:

# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L2037")

L2037:

# SLABEL ("L2048")

L2048:

# SLABEL ("L2052")

L2052:

# CONST (1)

	movq	$3,	-16(%rbp)
# CONST (1)

	movq	$3,	-24(%rbp)
# BINOP ("+")

	movq	-24(%rbp),	%rax
	decq	%rax
	addq	%rax,	-16(%rbp)
# SLABEL ("L2053")

L2053:

# SLABEL ("L2056")

L2056:

# CONST (1)

	movq	$3,	-24(%rbp)
# LINE (18)

	.stabn 68,0,18,.L4

.L4:

# LD (Global ("t"))

	movq	global_t(%rip),	%rax
	movq	%rax,	-32(%rbp)
# BINOP ("+")

	movq	-32(%rbp),	%rax
	decq	%rax
	addq	%rax,	-24(%rbp)
# SLABEL ("L2057")

L2057:

# BINOP ("+")

	movq	-24(%rbp),	%rax
	decq	%rax
	addq	%rax,	-16(%rbp)
# SLABEL ("L2049")

L2049:

# BINOP ("+")

	movq	-16(%rbp),	%rax
	decq	%rax
	addq	%rax,	-8(%rbp)
# SLABEL ("L2033")

L2033:

# BINOP ("+")

	addq	-8(%rbp),	%r14
	decq	%r14
# SLABEL ("L2001")

L2001:

# BINOP ("+")

	addq	%r14,	%r13
	decq	%r13
# SLABEL ("L1937")

L1937:

# BINOP ("+")

	addq	%r13,	%r12
	decq	%r12
# SLABEL ("L1809")

L1809:

# BINOP ("+")

	addq	%r12,	%r11
	decq	%r11
# SLABEL ("L1553")

L1553:

# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# SLABEL ("L1041")

L1041:

# ST (Global ("y2"))

	movq	%r10,	global_y2(%rip)
# DROP

# LINE (20)

	.stabn 68,0,20,.L5

.L5:

# LD (Global ("t"))

	movq	global_t(%rip),	%r10
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

# LINE (21)

	.stabn 68,0,21,.L6

.L6:

# LD (Global ("y2"))

	movq	global_y2(%rip),	%r10
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

# LINE (22)

	.stabn 68,0,22,.L7

.L7:

# LD (Global ("y"))

	movq	global_y(%rip),	%r10
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

	.set	Lmain_SIZE,	48

	.set	LSmain_SIZE,	5

	.size main, .-main

# LABEL ("Ltest")

Ltest:

# BEGIN ("Ltest", 2, 2, [], ["n"; "m"], [{ blab="L2067"; elab="L2068"; names=[]; subs=[{ blab="L2070"; elab="L2071"; names=[("i", 1); ("s", 0)]; subs=[{ blab="L2076"; elab="L2077"; names=[]; subs=[{ blab="L2087"; elab="L2088"; names=[]; subs=[{ blab="L2098"; elab="L2099"; names=[]; subs=[]; }]; }]; }]; }]; }])

	.type test, @function

	.stabs "test:F1",36,0,0,Ltest

	.stabs "i:1",128,0,0,-16

	.stabs "s:1",128,0,0,-8

	.stabn 192,0,0,L2070-Ltest

	.stabn 224,0,0,L2071-Ltest

	.cfi_startproc

	pushq	%rbp
	.cfi_def_cfa_offset	8

	.cfi_offset 5, -8

	movq	%rsp,	%rbp
	.cfi_def_cfa_register	5

	subq	$LLtest_SIZE,	%rsp
	movq	%rdi,	%r12
	movq	%rsi,	%r13
	movq	%rcx,	%r14
	movq	%rsp,	%rdi
	leaq	filler(%rip),	%rsi
	movq	$LSLtest_SIZE,	%rcx
	rep movsq	
	movq	%r12,	%rdi
	movq	%r13,	%rsi
	movq	%r14,	%rcx
# Check arguments count

	cmpq	$2,	%r11
	je	Ltest_argc_correct
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
Ltest_argc_correct:

# SLABEL ("L2067")

L2067:

# SLABEL ("L2070")

L2070:

# CONST (0)

	movq	$1,	%r10
# LINE (4)

	.stabn 68,0,4,0

	.stabn 68,0,4,.L8-Ltest

.L8:

# ST (Local (0))

	movq	%r10,	-8(%rbp)
# DROP

# SLABEL ("L2076")

L2076:

# CONST (0)

	movq	$1,	%r10
# LINE (6)

	.stabn 68,0,6,.L9-Ltest

.L9:

# ST (Local (1))

	movq	%r10,	-16(%rbp)
# DROP

# JMP ("L2083")

	jmp	L2083
# FLABEL ("L2082")

L2082:

# SLABEL ("L2087")

L2087:

# LINE (7)

	.stabn 68,0,7,.L10-Ltest

.L10:

# LD (Local (0))

	movq	-8(%rbp),	%r10
# LD (Local (1))

	movq	-16(%rbp),	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# ST (Local (0))

	movq	%r10,	-8(%rbp)
# DROP

# LINE (8)

	.stabn 68,0,8,.L11-Ltest

.L11:

# LD (Local (0))

	movq	-8(%rbp),	%r10
# LD (Arg (1))

	movq	%rsi,	%r11
# BINOP (">")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setg	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("z", "L2095")

	sarq	%r10
	cmpq	$0,	%r10
	jz	L2095
# SLABEL ("L2098")

L2098:

# LD (Local (0))

	movq	-8(%rbp),	%r10
# DROP

# SLABEL ("L2099")

L2099:

# JMP ("L2086")

	jmp	L2086
# LABEL ("L2095")

L2095:

# JMP ("L2086")

	jmp	L2086
# SLABEL ("L2088")

L2088:

# LABEL ("L2086")

L2086:

# LD (Local (1))

	movq	-16(%rbp),	%r10
# CONST (1)

	movq	$3,	%r11
# BINOP ("+")

	addq	%r11,	%r10
	decq	%r10
# LINE (6)

	.stabn 68,0,6,.L12-Ltest

.L12:

# ST (Local (1))

	movq	%r10,	-16(%rbp)
# DROP

# LABEL ("L2083")

L2083:

# LD (Local (1))

	movq	-16(%rbp),	%r10
# LD (Arg (0))

	movq	%rdi,	%r11
# BINOP ("<=")

	xorq	%rax,	%rax
	cmpq	%r11,	%r10
	setle	%al
	salq	%rax
	orq	$0x0001,	%rax
	movq	%rax,	%r10
# CJMP ("nz", "L2082")

	sarq	%r10
	cmpq	$0,	%r10
	jnz	L2082
# SLABEL ("L2077")

L2077:

# LINE (9)

	.stabn 68,0,9,.L13-Ltest

.L13:

# LD (Local (0))

	movq	-8(%rbp),	%r10
# SLABEL ("L2071")

L2071:

# LABEL ("L2069")

L2069:

# SLABEL ("L2068")

L2068:

# END

	movq	%r10,	%rax
LLtest_epilogue:

	movq	%rbp,	%rsp
	popq	%rbp
	.cfi_restore	rbp

	.cfi_def_cfa	4, 4

	ret
	.cfi_endproc

	.set	LLtest_SIZE,	16

	.set	LSLtest_SIZE,	2

	.size Ltest, .-Ltest


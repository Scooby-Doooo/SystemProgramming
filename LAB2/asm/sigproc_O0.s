	.file	"sigproc.c"
	.intel_syntax noprefix
	.text
	.type	now_sec, @function
now_sec:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	lea	rax, -32[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rax, QWORD PTR -32[rbp]
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, rax
	mov	rax, QWORD PTR -24[rbp]
	pxor	xmm2, xmm2
	cvtsi2sd	xmm2, rax
	movsd	xmm0, QWORD PTR .LC0[rip]
	mulsd	xmm0, xmm2
	addsd	xmm0, xmm1
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, QWORD PTR fs:40
	je	.L3
	call	__stack_chk_fail@PLT
.L3:
	leave
	ret
	.size	now_sec, .-now_sec
	.section	.rodata
.LC1:
	.string	"aligned_alloc"
	.text
	.type	xalloc, @function
xalloc:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	rax, QWORD PTR -24[rbp]
	add	rax, 63
	and	rax, -64
	mov	rsi, rax
	mov	edi, 64
	call	aligned_alloc@PLT
	mov	QWORD PTR -8[rbp], rax
	cmp	QWORD PTR -8[rbp], 0
	jne	.L5
	lea	rax, .LC1[rip]
	mov	rdi, rax
	call	perror@PLT
	mov	edi, 1
	call	exit@PLT
.L5:
	mov	rax, QWORD PTR -8[rbp]
	leave
	ret
	.size	xalloc, .-xalloc
	.globl	synth_signal
	.type	synth_signal, @function
synth_signal:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR -24[rbp], rdi
	mov	DWORD PTR -28[rbp], esi
	mov	QWORD PTR -40[rbp], rdx
	mov	rax, QWORD PTR -40[rbp]
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR -16[rbp], eax
	mov	DWORD PTR -12[rbp], 0
	jmp	.L8
.L11:
	mov	eax, DWORD PTR -16[rbp]
	sal	eax, 13
	xor	DWORD PTR -16[rbp], eax
	mov	eax, DWORD PTR -16[rbp]
	shr	eax, 17
	xor	DWORD PTR -16[rbp], eax
	mov	eax, DWORD PTR -16[rbp]
	sal	eax, 5
	xor	DWORD PTR -16[rbp], eax
	mov	eax, DWORD PTR -16[rbp]
	movzx	eax, ax
	mov	eax, eax
	test	rax, rax
	js	.L9
	pxor	xmm0, xmm0
	cvtsi2ss	xmm0, rax
	jmp	.L10
.L9:
	mov	rdx, rax
	shr	rdx
	and	eax, 1
	or	rdx, rax
	pxor	xmm0, xmm0
	cvtsi2ss	xmm0, rdx
	addss	xmm0, xmm0
.L10:
	movss	xmm1, DWORD PTR .LC2[rip]
	divss	xmm0, xmm1
	movss	xmm1, DWORD PTR .LC3[rip]
	subss	xmm0, xmm1
	movss	DWORD PTR -8[rbp], xmm0
	mov	eax, DWORD PTR -12[rbp]
	and	eax, 1023
	pxor	xmm0, xmm0
	cvtsi2ss	xmm0, eax
	movss	xmm1, DWORD PTR .LC4[rip]
	divss	xmm0, xmm1
	movss	DWORD PTR -4[rbp], xmm0
	movss	xmm1, DWORD PTR -8[rbp]
	movss	xmm0, DWORD PTR .LC5[rip]
	mulss	xmm0, xmm1
	mov	eax, DWORD PTR -12[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	addss	xmm0, DWORD PTR -4[rbp]
	movss	DWORD PTR [rax], xmm0
	add	DWORD PTR -12[rbp], 1
.L8:
	mov	eax, DWORD PTR -12[rbp]
	cmp	eax, DWORD PTR -28[rbp]
	jl	.L11
	mov	rax, QWORD PTR -40[rbp]
	mov	edx, DWORD PTR -16[rbp]
	mov	DWORD PTR [rax], edx
	nop
	pop	rbp
	ret
	.size	synth_signal, .-synth_signal
	.globl	fir_filter
	.type	fir_filter, @function
fir_filter:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR -40[rbp], rdi
	mov	QWORD PTR -48[rbp], rsi
	mov	QWORD PTR -56[rbp], rdx
	mov	DWORD PTR -60[rbp], ecx
	mov	eax, DWORD PTR -60[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -40[rbp]
	mov	esi, 0
	mov	rdi, rax
	call	memset@PLT
	mov	DWORD PTR -20[rbp], 0
	jmp	.L13
.L16:
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -56[rbp]
	add	rax, rdx
	movss	xmm0, DWORD PTR [rax]
	movss	DWORD PTR -12[rbp], xmm0
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -48[rbp]
	add	rax, rdx
	mov	QWORD PTR -8[rbp], rax
	mov	DWORD PTR -16[rbp], 0
	jmp	.L14
.L15:
	mov	eax, DWORD PTR -16[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	movss	xmm1, DWORD PTR [rax]
	mov	eax, DWORD PTR -16[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, DWORD PTR -12[rbp]
	mov	eax, DWORD PTR -16[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	addss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	add	DWORD PTR -16[rbp], 1
.L14:
	mov	eax, DWORD PTR -16[rbp]
	cmp	eax, DWORD PTR -60[rbp]
	jl	.L15
	add	DWORD PTR -20[rbp], 1
.L13:
	cmp	DWORD PTR -20[rbp], 47
	jle	.L16
	nop
	nop
	leave
	ret
	.size	fir_filter, .-fir_filter
	.globl	heat_step
	.type	heat_step, @function
heat_step:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR -56[rbp], rdi
	mov	QWORD PTR -64[rbp], rsi
	mov	DWORD PTR -68[rbp], edx
	movss	DWORD PTR -72[rbp], xmm0
	mov	DWORD PTR -40[rbp], 1
	jmp	.L18
.L21:
	mov	eax, DWORD PTR -40[rbp]
	sub	eax, 1
	movsx	rdx, eax
	mov	eax, DWORD PTR -68[rbp]
	cdqe
	imul	rax, rdx
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -64[rbp]
	add	rax, rdx
	mov	QWORD PTR -32[rbp], rax
	mov	eax, DWORD PTR -40[rbp]
	movsx	rdx, eax
	mov	eax, DWORD PTR -68[rbp]
	cdqe
	imul	rax, rdx
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -64[rbp]
	add	rax, rdx
	mov	QWORD PTR -24[rbp], rax
	mov	eax, DWORD PTR -40[rbp]
	add	eax, 1
	movsx	rdx, eax
	mov	eax, DWORD PTR -68[rbp]
	cdqe
	imul	rax, rdx
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -64[rbp]
	add	rax, rdx
	mov	QWORD PTR -16[rbp], rax
	mov	eax, DWORD PTR -40[rbp]
	movsx	rdx, eax
	mov	eax, DWORD PTR -68[rbp]
	cdqe
	imul	rax, rdx
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -56[rbp]
	add	rax, rdx
	mov	QWORD PTR -8[rbp], rax
	mov	DWORD PTR -36[rbp], 1
	jmp	.L19
.L20:
	mov	eax, DWORD PTR -36[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movss	xmm1, DWORD PTR [rax]
	mov	eax, DWORD PTR -36[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -32[rbp]
	add	rax, rdx
	movss	xmm2, DWORD PTR [rax]
	mov	eax, DWORD PTR -36[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -16[rbp]
	add	rax, rdx
	movss	xmm0, DWORD PTR [rax]
	addss	xmm2, xmm0
	mov	eax, DWORD PTR -36[rbp]
	cdqe
	sal	rax, 2
	lea	rdx, -4[rax]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movss	xmm0, DWORD PTR [rax]
	addss	xmm2, xmm0
	mov	eax, DWORD PTR -36[rbp]
	cdqe
	add	rax, 1
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movss	xmm0, DWORD PTR [rax]
	addss	xmm0, xmm2
	mov	eax, DWORD PTR -36[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movss	xmm3, DWORD PTR [rax]
	movss	xmm2, DWORD PTR .LC6[rip]
	mulss	xmm2, xmm3
	subss	xmm0, xmm2
	mulss	xmm0, DWORD PTR -72[rbp]
	mov	eax, DWORD PTR -36[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	addss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	add	DWORD PTR -36[rbp], 1
.L19:
	mov	eax, DWORD PTR -68[rbp]
	sub	eax, 1
	cmp	DWORD PTR -36[rbp], eax
	jl	.L20
	add	DWORD PTR -40[rbp], 1
.L18:
	mov	eax, DWORD PTR -68[rbp]
	sub	eax, 1
	cmp	DWORD PTR -40[rbp], eax
	jl	.L21
	nop
	nop
	pop	rbp
	ret
	.size	heat_step, .-heat_step
	.globl	quantize_hist
	.type	quantize_hist, @function
quantize_hist:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR -24[rbp], rdi
	mov	DWORD PTR -28[rbp], esi
	mov	QWORD PTR -40[rbp], rdx
	movss	DWORD PTR -32[rbp], xmm0
	movss	DWORD PTR -44[rbp], xmm1
	movss	xmm0, DWORD PTR -44[rbp]
	movaps	xmm1, xmm0
	subss	xmm1, DWORD PTR -32[rbp]
	movss	xmm0, DWORD PTR .LC7[rip]
	divss	xmm0, xmm1
	movss	DWORD PTR -4[rbp], xmm0
	mov	DWORD PTR -12[rbp], 0
	jmp	.L23
.L26:
	mov	eax, DWORD PTR -12[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movss	xmm0, DWORD PTR [rax]
	subss	xmm0, DWORD PTR -32[rbp]
	mulss	xmm0, DWORD PTR -4[rbp]
	cvttss2si	eax, xmm0
	mov	DWORD PTR -8[rbp], eax
	cmp	DWORD PTR -8[rbp], 0
	jns	.L24
	mov	DWORD PTR -8[rbp], 0
.L24:
	cmp	DWORD PTR -8[rbp], 4095
	jle	.L25
	mov	DWORD PTR -8[rbp], 4095
.L25:
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	add	edx, 1
	mov	DWORD PTR [rax], edx
	add	DWORD PTR -12[rbp], 1
.L23:
	mov	eax, DWORD PTR -12[rbp]
	cmp	eax, DWORD PTR -28[rbp]
	jl	.L26
	nop
	nop
	pop	rbp
	ret
	.size	quantize_hist, .-quantize_hist
	.globl	checksum
	.type	checksum, @function
checksum:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR -24[rbp], rdi
	mov	DWORD PTR -28[rbp], esi
	pxor	xmm0, xmm0
	movsd	QWORD PTR -8[rbp], xmm0
	mov	DWORD PTR -12[rbp], 0
	jmp	.L28
.L29:
	mov	eax, DWORD PTR -12[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movss	xmm0, DWORD PTR [rax]
	cvtss2sd	xmm0, xmm0
	movsd	xmm1, QWORD PTR -8[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -8[rbp], xmm0
	add	DWORD PTR -12[rbp], 1
.L28:
	mov	eax, DWORD PTR -12[rbp]
	cmp	eax, DWORD PTR -28[rbp]
	jl	.L29
	movsd	xmm0, QWORD PTR -8[rbp]
	pop	rbp
	ret
	.size	checksum, .-checksum
	.section	.rodata
	.align 8
.LC9:
	.string	"usage: %s [rounds>=1] [log2n 10..28] [grid>=16]\n"
	.align 8
.LC16:
	.string	"rounds=%d  n=2^%d  grid=%dx%d  taps=%d\n"
.LC17:
	.string	"share"
.LC18:
	.string	"time, s"
.LC19:
	.string	"stage"
.LC20:
	.string	"%-14s %9s %7s\n"
.LC22:
	.string	"synth_signal"
.LC23:
	.string	"%-14s %9.3f %6.1f%%\n"
.LC24:
	.string	"fir_filter"
.LC25:
	.string	"heat_step"
.LC26:
	.string	"quantize_hist"
.LC27:
	.string	"checksum"
.LC28:
	.string	"TOTAL"
.LC29:
	.string	"%-14s %9.3f\n"
	.align 8
.LC30:
	.string	"result: acc=%.6e  hist=%016llx\n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 272
	mov	DWORD PTR -244[rbp], edi
	mov	QWORD PTR -256[rbp], rsi
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	cmp	DWORD PTR -244[rbp], 1
	jle	.L32
	mov	rax, QWORD PTR -256[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	jmp	.L33
.L32:
	mov	eax, 30
.L33:
	mov	DWORD PTR -196[rbp], eax
	cmp	DWORD PTR -244[rbp], 2
	jle	.L34
	mov	rax, QWORD PTR -256[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	jmp	.L35
.L34:
	mov	eax, 22
.L35:
	mov	DWORD PTR -192[rbp], eax
	cmp	DWORD PTR -244[rbp], 3
	jle	.L36
	mov	rax, QWORD PTR -256[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	jmp	.L37
.L36:
	mov	eax, 1536
.L37:
	mov	DWORD PTR -188[rbp], eax
	cmp	DWORD PTR -196[rbp], 0
	jle	.L38
	cmp	DWORD PTR -192[rbp], 9
	jle	.L38
	cmp	DWORD PTR -192[rbp], 28
	jg	.L38
	cmp	DWORD PTR -188[rbp], 15
	jg	.L39
.L38:
	mov	rax, QWORD PTR -256[rbp]
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR stderr[rip]
	lea	rcx, .LC9[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	mov	eax, 2
	jmp	.L57
.L39:
	mov	eax, DWORD PTR -192[rbp]
	mov	edx, 1
	mov	ecx, eax
	sal	edx, cl
	mov	eax, edx
	mov	DWORD PTR -184[rbp], eax
	mov	eax, DWORD PTR -184[rbp]
	cdqe
	add	rax, 48
	sal	rax, 2
	mov	rdi, rax
	call	xalloc
	mov	QWORD PTR -104[rbp], rax
	mov	eax, DWORD PTR -184[rbp]
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	xalloc
	mov	QWORD PTR -96[rbp], rax
	mov	edi, 192
	call	xalloc
	mov	QWORD PTR -88[rbp], rax
	mov	eax, DWORD PTR -188[rbp]
	movsx	rdx, eax
	mov	eax, DWORD PTR -188[rbp]
	cdqe
	imul	rax, rdx
	sal	rax, 2
	mov	rdi, rax
	call	xalloc
	mov	QWORD PTR -176[rbp], rax
	mov	eax, DWORD PTR -188[rbp]
	movsx	rdx, eax
	mov	eax, DWORD PTR -188[rbp]
	cdqe
	imul	rax, rdx
	sal	rax, 2
	mov	rdi, rax
	call	xalloc
	mov	QWORD PTR -168[rbp], rax
	mov	edi, 16384
	call	xalloc
	mov	QWORD PTR -80[rbp], rax
	pxor	xmm0, xmm0
	movss	DWORD PTR -228[rbp], xmm0
	mov	DWORD PTR -224[rbp], 0
	jmp	.L41
.L44:
	cmp	DWORD PTR -224[rbp], 23
	jg	.L42
	mov	eax, DWORD PTR -224[rbp]
	add	eax, 1
	pxor	xmm0, xmm0
	cvtsi2ss	xmm0, eax
	jmp	.L43
.L42:
	mov	eax, 48
	sub	eax, DWORD PTR -224[rbp]
	pxor	xmm0, xmm0
	cvtsi2ss	xmm0, eax
.L43:
	mov	eax, DWORD PTR -224[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -88[rbp]
	add	rax, rdx
	movss	DWORD PTR [rax], xmm0
	mov	eax, DWORD PTR -224[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -88[rbp]
	add	rax, rdx
	movss	xmm0, DWORD PTR [rax]
	movss	xmm1, DWORD PTR -228[rbp]
	addss	xmm0, xmm1
	movss	DWORD PTR -228[rbp], xmm0
	add	DWORD PTR -224[rbp], 1
.L41:
	cmp	DWORD PTR -224[rbp], 47
	jle	.L44
	mov	DWORD PTR -220[rbp], 0
	jmp	.L45
.L46:
	mov	eax, DWORD PTR -220[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -88[rbp]
	add	rax, rdx
	movss	xmm0, DWORD PTR [rax]
	mov	eax, DWORD PTR -220[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -88[rbp]
	add	rax, rdx
	divss	xmm0, DWORD PTR -228[rbp]
	movss	DWORD PTR [rax], xmm0
	add	DWORD PTR -220[rbp], 1
.L45:
	cmp	DWORD PTR -220[rbp], 47
	jle	.L46
	mov	eax, DWORD PTR -188[rbp]
	movsx	rdx, eax
	mov	eax, DWORD PTR -188[rbp]
	cdqe
	imul	rax, rdx
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -176[rbp]
	mov	esi, 0
	mov	rdi, rax
	call	memset@PLT
	mov	eax, DWORD PTR -188[rbp]
	movsx	rdx, eax
	imul	rdx, rdx, 1431655766
	mov	rcx, rdx
	shr	rcx, 32
	cdq
	mov	eax, ecx
	sub	eax, edx
	mov	DWORD PTR -216[rbp], eax
	jmp	.L47
.L50:
	mov	eax, DWORD PTR -188[rbp]
	movsx	rdx, eax
	imul	rdx, rdx, 1431655766
	mov	rcx, rdx
	shr	rcx, 32
	cdq
	mov	eax, ecx
	sub	eax, edx
	mov	DWORD PTR -212[rbp], eax
	jmp	.L48
.L49:
	mov	eax, DWORD PTR -216[rbp]
	movsx	rdx, eax
	mov	eax, DWORD PTR -188[rbp]
	cdqe
	imul	rdx, rax
	mov	eax, DWORD PTR -212[rbp]
	cdqe
	add	rax, rdx
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -176[rbp]
	add	rax, rdx
	movss	xmm0, DWORD PTR .LC11[rip]
	movss	DWORD PTR [rax], xmm0
	add	DWORD PTR -212[rbp], 1
.L48:
	mov	eax, DWORD PTR -188[rbp]
	add	eax, eax
	movsx	rdx, eax
	imul	rdx, rdx, 1431655766
	mov	rcx, rdx
	shr	rcx, 32
	cdq
	mov	eax, ecx
	sub	eax, edx
	cmp	DWORD PTR -212[rbp], eax
	jl	.L49
	add	DWORD PTR -216[rbp], 1
.L47:
	mov	eax, DWORD PTR -188[rbp]
	add	eax, eax
	movsx	rdx, eax
	imul	rdx, rdx, 1431655766
	mov	rcx, rdx
	shr	rcx, 32
	cdq
	mov	eax, ecx
	sub	eax, edx
	cmp	DWORD PTR -216[rbp], eax
	jl	.L50
	mov	eax, DWORD PTR -188[rbp]
	movsx	rdx, eax
	mov	eax, DWORD PTR -188[rbp]
	cdqe
	imul	rax, rdx
	lea	rdx, 0[0+rax*4]
	mov	rcx, QWORD PTR -176[rbp]
	mov	rax, QWORD PTR -168[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	memcpy@PLT
	pxor	xmm0, xmm0
	movsd	QWORD PTR -160[rbp], xmm0
	pxor	xmm0, xmm0
	movsd	QWORD PTR -152[rbp], xmm0
	pxor	xmm0, xmm0
	movsd	QWORD PTR -144[rbp], xmm0
	pxor	xmm0, xmm0
	movsd	QWORD PTR -136[rbp], xmm0
	pxor	xmm0, xmm0
	movsd	QWORD PTR -128[rbp], xmm0
	pxor	xmm0, xmm0
	movsd	QWORD PTR -120[rbp], xmm0
	mov	DWORD PTR -232[rbp], -1640531527
	mov	DWORD PTR -180[rbp], 8
	mov	DWORD PTR -208[rbp], 0
	jmp	.L51
.L54:
	call	now_sec
	movq	rax, xmm0
	mov	QWORD PTR -64[rbp], rax
	mov	eax, DWORD PTR -184[rbp]
	lea	ecx, 48[rax]
	lea	rdx, -232[rbp]
	mov	rax, QWORD PTR -104[rbp]
	mov	esi, ecx
	mov	rdi, rax
	call	synth_signal
	call	now_sec
	movq	rax, xmm0
	mov	QWORD PTR -56[rbp], rax
	mov	ecx, DWORD PTR -184[rbp]
	mov	rdx, QWORD PTR -88[rbp]
	mov	rsi, QWORD PTR -104[rbp]
	mov	rax, QWORD PTR -96[rbp]
	mov	rdi, rax
	call	fir_filter
	call	now_sec
	movq	rax, xmm0
	mov	QWORD PTR -48[rbp], rax
	mov	DWORD PTR -204[rbp], 0
	jmp	.L52
.L53:
	mov	edx, DWORD PTR -188[rbp]
	mov	rcx, QWORD PTR -176[rbp]
	mov	rax, QWORD PTR -168[rbp]
	mov	esi, DWORD PTR .LC12[rip]
	movd	xmm0, esi
	mov	rsi, rcx
	mov	rdi, rax
	call	heat_step
	mov	rax, QWORD PTR -176[rbp]
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -168[rbp]
	mov	QWORD PTR -176[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	mov	QWORD PTR -168[rbp], rax
	add	DWORD PTR -204[rbp], 1
.L52:
	mov	eax, DWORD PTR -204[rbp]
	cmp	eax, DWORD PTR -180[rbp]
	jl	.L53
	call	now_sec
	movq	rax, xmm0
	mov	QWORD PTR -40[rbp], rax
	mov	rax, QWORD PTR -80[rbp]
	mov	edx, 16384
	mov	esi, 0
	mov	rdi, rax
	call	memset@PLT
	mov	rdx, QWORD PTR -80[rbp]
	mov	ecx, DWORD PTR -184[rbp]
	mov	rax, QWORD PTR -96[rbp]
	movss	xmm1, DWORD PTR .LC13[rip]
	mov	esi, DWORD PTR .LC14[rip]
	movd	xmm0, esi
	mov	esi, ecx
	mov	rdi, rax
	call	quantize_hist
	call	now_sec
	movq	rax, xmm0
	mov	QWORD PTR -32[rbp], rax
	mov	edx, DWORD PTR -184[rbp]
	mov	rax, QWORD PTR -96[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	checksum
	movsd	QWORD PTR -264[rbp], xmm0
	mov	eax, DWORD PTR -188[rbp]
	imul	eax, eax
	mov	edx, eax
	mov	rax, QWORD PTR -176[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	checksum
	movsd	xmm1, QWORD PTR .LC15[rip]
	mulsd	xmm0, xmm1
	addsd	xmm0, QWORD PTR -264[rbp]
	movsd	xmm1, QWORD PTR -120[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -120[rbp], xmm0
	call	now_sec
	movq	rax, xmm0
	mov	QWORD PTR -24[rbp], rax
	movsd	xmm0, QWORD PTR -56[rbp]
	subsd	xmm0, QWORD PTR -64[rbp]
	movsd	xmm1, QWORD PTR -160[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -160[rbp], xmm0
	movsd	xmm0, QWORD PTR -48[rbp]
	subsd	xmm0, QWORD PTR -56[rbp]
	movsd	xmm1, QWORD PTR -152[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -152[rbp], xmm0
	movsd	xmm0, QWORD PTR -40[rbp]
	subsd	xmm0, QWORD PTR -48[rbp]
	movsd	xmm1, QWORD PTR -144[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -144[rbp], xmm0
	movsd	xmm0, QWORD PTR -32[rbp]
	subsd	xmm0, QWORD PTR -40[rbp]
	movsd	xmm1, QWORD PTR -136[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -136[rbp], xmm0
	movsd	xmm0, QWORD PTR -24[rbp]
	subsd	xmm0, QWORD PTR -32[rbp]
	movsd	xmm1, QWORD PTR -128[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -128[rbp], xmm0
	add	DWORD PTR -208[rbp], 1
.L51:
	mov	eax, DWORD PTR -208[rbp]
	cmp	eax, DWORD PTR -196[rbp]
	jl	.L54
	mov	QWORD PTR -112[rbp], 0
	mov	DWORD PTR -200[rbp], 0
	jmp	.L55
.L56:
	mov	rdx, QWORD PTR -112[rbp]
	mov	rax, rdx
	sal	rax, 5
	sub	rax, rdx
	mov	rcx, rax
	mov	eax, DWORD PTR -200[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -80[rbp]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	eax, eax
	add	rax, rcx
	mov	QWORD PTR -112[rbp], rax
	add	DWORD PTR -200[rbp], 1
.L55:
	cmp	DWORD PTR -200[rbp], 4095
	jle	.L56
	movsd	xmm0, QWORD PTR -160[rbp]
	addsd	xmm0, QWORD PTR -152[rbp]
	addsd	xmm0, QWORD PTR -144[rbp]
	addsd	xmm0, QWORD PTR -136[rbp]
	movsd	xmm1, QWORD PTR -128[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -72[rbp], xmm0
	mov	esi, DWORD PTR -188[rbp]
	mov	ecx, DWORD PTR -188[rbp]
	mov	edx, DWORD PTR -192[rbp]
	mov	eax, DWORD PTR -196[rbp]
	mov	r9d, 48
	mov	r8d, esi
	mov	esi, eax
	lea	rax, .LC16[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	lea	rax, .LC17[rip]
	mov	rcx, rax
	lea	rax, .LC18[rip]
	mov	rdx, rax
	lea	rax, .LC19[rip]
	mov	rsi, rax
	lea	rax, .LC20[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	movsd	xmm1, QWORD PTR -160[rbp]
	movsd	xmm0, QWORD PTR .LC21[rip]
	mulsd	xmm0, xmm1
	divsd	xmm0, QWORD PTR -72[rbp]
	mov	rax, QWORD PTR -160[rbp]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	lea	rax, .LC22[rip]
	mov	rsi, rax
	lea	rax, .LC23[rip]
	mov	rdi, rax
	mov	eax, 2
	call	printf@PLT
	movsd	xmm1, QWORD PTR -152[rbp]
	movsd	xmm0, QWORD PTR .LC21[rip]
	mulsd	xmm0, xmm1
	divsd	xmm0, QWORD PTR -72[rbp]
	mov	rax, QWORD PTR -152[rbp]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	lea	rax, .LC24[rip]
	mov	rsi, rax
	lea	rax, .LC23[rip]
	mov	rdi, rax
	mov	eax, 2
	call	printf@PLT
	movsd	xmm1, QWORD PTR -144[rbp]
	movsd	xmm0, QWORD PTR .LC21[rip]
	mulsd	xmm0, xmm1
	divsd	xmm0, QWORD PTR -72[rbp]
	mov	rax, QWORD PTR -144[rbp]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	lea	rax, .LC25[rip]
	mov	rsi, rax
	lea	rax, .LC23[rip]
	mov	rdi, rax
	mov	eax, 2
	call	printf@PLT
	movsd	xmm1, QWORD PTR -136[rbp]
	movsd	xmm0, QWORD PTR .LC21[rip]
	mulsd	xmm0, xmm1
	divsd	xmm0, QWORD PTR -72[rbp]
	mov	rax, QWORD PTR -136[rbp]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	lea	rax, .LC26[rip]
	mov	rsi, rax
	lea	rax, .LC23[rip]
	mov	rdi, rax
	mov	eax, 2
	call	printf@PLT
	movsd	xmm1, QWORD PTR -128[rbp]
	movsd	xmm0, QWORD PTR .LC21[rip]
	mulsd	xmm0, xmm1
	divsd	xmm0, QWORD PTR -72[rbp]
	mov	rax, QWORD PTR -128[rbp]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	lea	rax, .LC27[rip]
	mov	rsi, rax
	lea	rax, .LC23[rip]
	mov	rdi, rax
	mov	eax, 2
	call	printf@PLT
	mov	rax, QWORD PTR -72[rbp]
	movq	xmm0, rax
	lea	rax, .LC28[rip]
	mov	rsi, rax
	lea	rax, .LC29[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	rdx, QWORD PTR -112[rbp]
	mov	rax, QWORD PTR -120[rbp]
	mov	rsi, rdx
	movq	xmm0, rax
	lea	rax, .LC30[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	rax, QWORD PTR -104[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -96[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -88[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -176[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -168[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -80[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	eax, 0
.L57:
	mov	rdx, QWORD PTR -8[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L58
	call	__stack_chk_fail@PLT
.L58:
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	-400107883
	.long	1041313291
	.align 4
.LC2:
	.long	1199570944
	.align 4
.LC3:
	.long	1056964608
	.align 4
.LC4:
	.long	1149239296
	.align 4
.LC5:
	.long	1048576000
	.align 4
.LC6:
	.long	1082130432
	.align 4
.LC7:
	.long	1166016512
	.align 4
.LC11:
	.long	1120403456
	.align 4
.LC12:
	.long	1045220557
	.align 4
.LC13:
	.long	1067030938
	.align 4
.LC14:
	.long	-1102263091
	.align 8
.LC15:
	.long	-1598689907
	.long	1051772663
	.align 8
.LC21:
	.long	0
	.long	1079574528
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:

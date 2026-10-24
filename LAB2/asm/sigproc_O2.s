	.file	"sigproc.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"aligned_alloc"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB1:
	.text
.LHOTB1:
	.p2align 4
	.type	xalloc, @function
xalloc:
	push	rbp
	lea	rsi, 63[rdi]
	mov	edi, 64
	and	rsi, -64
	mov	rbp, rsp
	call	aligned_alloc@PLT
	test	rax, rax
	je	.L3
	pop	rbp
	ret
	.section	.text.unlikely
	.type	xalloc.cold, @function
xalloc.cold:
.L3:
	lea	rdi, .LC0[rip]
	call	perror@PLT
	mov	edi, 1
	call	exit@PLT
	.text
	.size	xalloc, .-xalloc
	.section	.text.unlikely
	.size	xalloc.cold, .-xalloc.cold
.LCOLDE1:
	.text
.LHOTE1:
	.p2align 4
	.globl	synth_signal
	.type	synth_signal, @function
synth_signal:
	endbr64
	mov	eax, DWORD PTR [rdx]
	mov	r8, rdx
	test	esi, esi
	jle	.L7
	movss	xmm5, DWORD PTR .LC2[rip]
	movsx	rsi, esi
	xor	edx, edx
	movss	xmm4, DWORD PTR .LC3[rip]
	movss	xmm3, DWORD PTR .LC4[rip]
	movss	xmm2, DWORD PTR .LC5[rip]
	.p2align 4,,10
	.p2align 3
.L8:
	mov	ecx, eax
	pxor	xmm0, xmm0
	pxor	xmm1, xmm1
	sal	ecx, 13
	xor	eax, ecx
	mov	ecx, eax
	shr	ecx, 17
	xor	ecx, eax
	mov	eax, ecx
	sal	eax, 5
	xor	eax, ecx
	movzx	ecx, ax
	cvtsi2ss	xmm0, ecx
	mov	ecx, edx
	and	ecx, 1023
	cvtsi2ss	xmm1, ecx
	mulss	xmm0, xmm5
	mulss	xmm1, xmm2
	subss	xmm0, xmm4
	mulss	xmm0, xmm3
	addss	xmm0, xmm1
	movss	DWORD PTR [rdi+rdx*4], xmm0
	add	rdx, 1
	cmp	rsi, rdx
	jne	.L8
.L7:
	mov	DWORD PTR [r8], eax
	ret
	.size	synth_signal, .-synth_signal
	.p2align 4
	.globl	fir_filter
	.type	fir_filter, @function
fir_filter:
	endbr64
	push	rbp
	mov	rbp, rsp
	push	r14
	push	r13
	mov	r13, rdx
	push	r12
	movsx	r12, ecx
	push	rbx
	mov	r14, r12
	sal	r12, 2
	mov	rbx, rsi
	mov	rdx, r12
	xor	esi, esi
	call	memset@PLT
	mov	rdx, rbx
	xor	esi, esi
	mov	rdi, rax
	.p2align 4,,10
	.p2align 3
.L15:
	test	r14d, r14d
	jle	.L11
	.p2align 4,,10
	.p2align 3
.L22:
	movss	xmm1, DWORD PTR 0[r13+rsi*4]
	xor	eax, eax
	.p2align 4,,10
	.p2align 3
.L12:
	movss	xmm0, DWORD PTR [rdx+rax]
	mulss	xmm0, xmm1
	addss	xmm0, DWORD PTR [rdi+rax]
	movss	DWORD PTR [rdi+rax], xmm0
	add	rax, 4
	cmp	r12, rax
	jne	.L12
	add	rsi, 1
	add	rdx, 4
	cmp	rsi, 48
	jne	.L22
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	rbp
	ret
.L11:
	add	rsi, 1
	add	rdx, 4
	cmp	rsi, 48
	jne	.L15
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	rbp
	ret
	.size	fir_filter, .-fir_filter
	.p2align 4
	.globl	heat_step
	.type	heat_step, @function
heat_step:
	endbr64
	push	rbp
	mov	rbp, rsp
	push	r13
	lea	r13d, -1[rdx]
	push	r12
	push	rbx
	cmp	r13d, 1
	jle	.L23
	movsx	rdx, edx
	mov	rbx, rdi
	mov	r10, rsi
	mov	r12d, 1
	lea	r11, 0[0+rdx*4]
	movss	xmm5, DWORD PTR .LC6[rip]
	lea	rcx, [rsi+rdx*8]
	mov	r8d, r13d
	mov	r9, r11
	mov	rdx, rsi
	.p2align 4,,10
	.p2align 3
.L26:
	movss	xmm2, DWORD PTR [r10+r9]
	lea	rdi, [r10+r9]
	add	r12d, 1
	lea	rsi, [rbx+r9]
	movss	xmm3, DWORD PTR 4[r10+r9]
	mov	eax, 1
	.p2align 4,,10
	.p2align 3
.L25:
	movss	xmm1, DWORD PTR [rdx+rax*4]
	addss	xmm1, DWORD PTR [rcx+rax*4]
	addss	xmm1, xmm2
	movaps	xmm2, xmm3
	movss	xmm3, DWORD PTR 4[rdi+rax*4]
	movaps	xmm4, xmm2
	mulss	xmm4, xmm5
	addss	xmm1, xmm3
	subss	xmm1, xmm4
	mulss	xmm1, xmm0
	addss	xmm1, xmm2
	movss	DWORD PTR [rsi+rax*4], xmm1
	add	rax, 1
	cmp	r8, rax
	jne	.L25
	add	rdx, r11
	add	rcx, r11
	add	r9, r11
	cmp	r12d, r13d
	jne	.L26
.L23:
	pop	rbx
	pop	r12
	pop	r13
	pop	rbp
	ret
	.size	heat_step, .-heat_step
	.p2align 4
	.globl	quantize_hist
	.type	quantize_hist, @function
quantize_hist:
	endbr64
	subss	xmm1, xmm0
	movss	xmm2, DWORD PTR .LC7[rip]
	divss	xmm2, xmm1
	test	esi, esi
	jle	.L31
	movsx	rsi, esi
	lea	rsi, [rdi+rsi*4]
	.p2align 4,,10
	.p2align 3
.L33:
	movss	xmm1, DWORD PTR [rdi]
	mov	ecx, 4095
	subss	xmm1, xmm0
	mulss	xmm1, xmm2
	cvttss2si	eax, xmm1
	cmp	eax, ecx
	cmovg	eax, ecx
	xor	ecx, ecx
	test	eax, eax
	cmovs	eax, ecx
	add	rdi, 4
	cdqe
	add	DWORD PTR [rdx+rax*4], 1
	cmp	rdi, rsi
	jne	.L33
.L31:
	ret
	.size	quantize_hist, .-quantize_hist
	.p2align 4
	.globl	checksum
	.type	checksum, @function
checksum:
	endbr64
	test	esi, esi
	jle	.L38
	movsx	rsi, esi
	pxor	xmm0, xmm0
	lea	rax, [rdi+rsi*4]
	.p2align 4,,10
	.p2align 3
.L37:
	pxor	xmm1, xmm1
	add	rdi, 4
	cvtss2sd	xmm1, DWORD PTR -4[rdi]
	addsd	xmm0, xmm1
	cmp	rdi, rax
	jne	.L37
	ret
	.p2align 4,,10
	.p2align 3
.L38:
	pxor	xmm0, xmm0
	ret
	.size	checksum, .-checksum
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC10:
	.string	"usage: %s [rounds>=1] [log2n 10..28] [grid>=16]\n"
	.align 8
.LC17:
	.string	"rounds=%d  n=2^%d  grid=%dx%d  taps=%d\n"
	.section	.rodata.str1.1
.LC18:
	.string	"share"
.LC19:
	.string	"time, s"
.LC20:
	.string	"stage"
.LC21:
	.string	"%-14s %9s %7s\n"
.LC23:
	.string	"synth_signal"
.LC24:
	.string	"%-14s %9.3f %6.1f%%\n"
.LC25:
	.string	"fir_filter"
.LC26:
	.string	"heat_step"
.LC27:
	.string	"quantize_hist"
.LC28:
	.string	"checksum"
.LC29:
	.string	"TOTAL"
.LC30:
	.string	"%-14s %9.3f\n"
	.section	.rodata.str1.8
	.align 8
.LC31:
	.string	"result: acc=%.6e  hist=%016llx\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 216
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -56[rbp], rax
	xor	eax, eax
	cmp	edi, 1
	jg	.L77
	mov	DWORD PTR -220[rbp], 30
.L76:
	mov	DWORD PTR -256[rbp], 22
	mov	r13d, 1536
.L41:
	movzx	ecx, BYTE PTR -256[rbp]
	mov	eax, 1
	movsx	r14, r13d
	sal	eax, cl
	mov	DWORD PTR -104[rbp], eax
	add	eax, 48
	movsx	rbx, eax
	mov	DWORD PTR -252[rbp], eax
	sal	rbx, 2
	mov	rdi, rbx
	call	xalloc
	lea	rdi, -192[rbx]
	mov	QWORD PTR -232[rbp], rax
	call	xalloc
	mov	edi, 192
	mov	QWORD PTR -160[rbp], rax
	call	xalloc
	mov	QWORD PTR -112[rbp], rax
	mov	rax, r14
	imul	rax, r14
	lea	r12, 0[0+rax*4]
	mov	rdi, r12
	call	xalloc
	mov	rdi, r12
	mov	rbx, rax
	call	xalloc
	mov	edi, 16384
	mov	r15, rax
	call	xalloc
	mov	r11, QWORD PTR -112[rbp]
	pxor	xmm0, xmm0
	mov	ecx, 48
	mov	QWORD PTR -216[rbp], rax
	xor	eax, eax
	.p2align 4,,10
	.p2align 3
.L51:
	cmp	rax, 23
	ja	.L48
.L78:
	lea	edx, 1[rax]
	pxor	xmm1, xmm1
	cvtsi2ss	xmm1, edx
	movss	DWORD PTR [r11+rax*4], xmm1
	add	rax, 1
	addss	xmm0, xmm1
	cmp	rax, 23
	jbe	.L78
.L48:
	mov	edx, ecx
	pxor	xmm1, xmm1
	sub	edx, eax
	cvtsi2ss	xmm1, edx
	movss	DWORD PTR [r11+rax*4], xmm1
	add	rax, 1
	addss	xmm0, xmm1
	cmp	rax, 48
	jne	.L51
	mov	rax, r11
	lea	rdx, 192[r11]
	shufps	xmm0, xmm0, 0
	.p2align 4,,10
	.p2align 3
.L52:
	movups	xmm1, XMMWORD PTR [rax]
	add	rax, 16
	divps	xmm1, xmm0
	movups	XMMWORD PTR -16[rax], xmm1
	cmp	rax, rdx
	jne	.L52
	xor	esi, esi
	mov	rdx, r12
	mov	rdi, rbx
	mov	QWORD PTR -112[rbp], r11
	call	memset@PLT
	mov	eax, r13d
	mov	ecx, 3
	mov	r11, QWORD PTR -112[rbp]
	cdq
	idiv	ecx
	mov	esi, eax
	lea	eax, [r13+r13]
	cdq
	idiv	ecx
	cmp	esi, eax
	jge	.L53
	movsx	rdx, esi
	lea	r8, 0[0+r14*4]
	add	r14, 1
	mov	edi, eax
	imul	r14, rdx
	sub	edi, esi
	movss	xmm0, DWORD PTR .LC11[rip]
	lea	rdx, [r14+rdi]
	imul	rdi, rdi, -4
	lea	rcx, [rbx+rdx*4]
	.p2align 4,,10
	.p2align 3
.L54:
	mov	r9, rdi
	lea	rdx, [rcx+rdi]
	neg	r9
	and	r9d, 4
	je	.L55
	movss	DWORD PTR [rdx], xmm0
	add	rdx, 4
	cmp	rcx, rdx
	je	.L71
	.p2align 4,,10
	.p2align 3
.L55:
	movss	DWORD PTR [rdx], xmm0
	add	rdx, 8
	movss	DWORD PTR -4[rdx], xmm0
	cmp	rcx, rdx
	jne	.L55
.L71:
	add	esi, 1
	add	rcx, r8
	cmp	esi, eax
	jne	.L54
.L53:
	mov	rsi, rbx
	mov	rdx, r12
	mov	rdi, r15
	mov	QWORD PTR -176[rbp], r11
	call	memcpy@PLT
	mov	eax, r13d
	xor	esi, esi
	lea	r14, -80[rbp]
	imul	eax, r13d
	mov	r11, QWORD PTR -176[rbp]
	mov	DWORD PTR -112[rbp], esi
	mov	DWORD PTR -84[rbp], -1640531527
	mov	QWORD PTR -168[rbp], 0x000000000
	mov	DWORD PTR -224[rbp], eax
	lea	rax, -84[rbp]
	mov	QWORD PTR -152[rbp], 0x000000000
	mov	QWORD PTR -144[rbp], 0x000000000
	mov	QWORD PTR -136[rbp], 0x000000000
	mov	QWORD PTR -128[rbp], 0x000000000
	mov	QWORD PTR -120[rbp], 0x000000000
	mov	QWORD PTR -248[rbp], rax
	mov	QWORD PTR -240[rbp], r11
	.p2align 4,,10
	.p2align 3
.L57:
	mov	rsi, r14
	mov	edi, 1
	call	clock_gettime@PLT
	pxor	xmm0, xmm0
	pxor	xmm1, xmm1
	mov	r12, QWORD PTR -232[rbp]
	cvtsi2sd	xmm0, QWORD PTR -72[rbp]
	mulsd	xmm0, QWORD PTR .LC12[rip]
	mov	rdx, QWORD PTR -248[rbp]
	cvtsi2sd	xmm1, QWORD PTR -80[rbp]
	mov	esi, DWORD PTR -252[rbp]
	mov	rdi, r12
	addsd	xmm0, xmm1
	movsd	QWORD PTR -184[rbp], xmm0
	call	synth_signal
	mov	rsi, r14
	mov	edi, 1
	call	clock_gettime@PLT
	pxor	xmm0, xmm0
	pxor	xmm1, xmm1
	mov	ecx, DWORD PTR -104[rbp]
	cvtsi2sd	xmm0, QWORD PTR -72[rbp]
	mulsd	xmm0, QWORD PTR .LC12[rip]
	mov	rsi, r12
	mov	rdx, QWORD PTR -240[rbp]
	cvtsi2sd	xmm1, QWORD PTR -80[rbp]
	mov	rdi, QWORD PTR -160[rbp]
	mov	r12d, 8
	addsd	xmm0, xmm1
	movsd	QWORD PTR -176[rbp], xmm0
	call	fir_filter
	mov	rsi, r14
	mov	edi, 1
	call	clock_gettime@PLT
	pxor	xmm6, xmm6
	pxor	xmm0, xmm0
	mov	rax, r15
	cvtsi2sd	xmm6, QWORD PTR -72[rbp]
	mulsd	xmm6, QWORD PTR .LC12[rip]
	mov	r15, rbx
	mov	rbx, rax
	cvtsi2sd	xmm0, QWORD PTR -80[rbp]
	addsd	xmm6, xmm0
	jmp	.L56
	.p2align 4,,10
	.p2align 3
.L61:
	mov	rax, r15
	mov	r15, rbx
	mov	rbx, rax
.L56:
	movss	xmm0, DWORD PTR .LC13[rip]
	mov	edx, r13d
	mov	rsi, r15
	mov	rdi, rbx
	call	heat_step
	sub	r12d, 1
	jne	.L61
	mov	rsi, r14
	mov	edi, 1
	movsd	QWORD PTR -208[rbp], xmm6
	call	clock_gettime@PLT
	pxor	xmm3, xmm3
	pxor	xmm0, xmm0
	xor	esi, esi
	cvtsi2sd	xmm3, QWORD PTR -72[rbp]
	mulsd	xmm3, QWORD PTR .LC12[rip]
	mov	edx, 16384
	mov	r12, QWORD PTR -216[rbp]
	cvtsi2sd	xmm0, QWORD PTR -80[rbp]
	mov	rdi, r12
	addsd	xmm3, xmm0
	movsd	QWORD PTR -200[rbp], xmm3
	call	memset@PLT
	mov	rdx, r12
	mov	r12, QWORD PTR -160[rbp]
	mov	esi, DWORD PTR -104[rbp]
	movss	xmm1, DWORD PTR .LC14[rip]
	movss	xmm0, DWORD PTR .LC15[rip]
	mov	rdi, r12
	call	quantize_hist
	mov	rsi, r14
	mov	edi, 1
	call	clock_gettime@PLT
	pxor	xmm1, xmm1
	pxor	xmm0, xmm0
	mov	esi, DWORD PTR -104[rbp]
	cvtsi2sd	xmm1, QWORD PTR -72[rbp]
	mulsd	xmm1, QWORD PTR .LC12[rip]
	mov	rdi, r12
	cvtsi2sd	xmm0, QWORD PTR -80[rbp]
	addsd	xmm1, xmm0
	movsd	QWORD PTR -192[rbp], xmm1
	call	checksum
	mov	esi, DWORD PTR -224[rbp]
	mov	rdi, rbx
	movapd	xmm2, xmm0
	call	checksum
	mulsd	xmm0, QWORD PTR .LC16[rip]
	mov	rsi, r14
	mov	edi, 1
	addsd	xmm0, xmm2
	addsd	xmm0, QWORD PTR -168[rbp]
	movsd	QWORD PTR -168[rbp], xmm0
	call	clock_gettime@PLT
	pxor	xmm0, xmm0
	pxor	xmm2, xmm2
	movsd	xmm4, QWORD PTR -176[rbp]
	cvtsi2sd	xmm0, QWORD PTR -72[rbp]
	mulsd	xmm0, QWORD PTR .LC12[rip]
	movsd	xmm6, QWORD PTR -208[rbp]
	cvtsi2sd	xmm2, QWORD PTR -80[rbp]
	movsd	xmm3, QWORD PTR -200[rbp]
	add	DWORD PTR -112[rbp], 1
	movsd	xmm1, QWORD PTR -192[rbp]
	mov	eax, DWORD PTR -112[rbp]
	mov	ecx, DWORD PTR -220[rbp]
	addsd	xmm0, xmm2
	movapd	xmm2, xmm4
	subsd	xmm2, QWORD PTR -184[rbp]
	addsd	xmm2, QWORD PTR -120[rbp]
	subsd	xmm0, xmm1
	addsd	xmm0, QWORD PTR -152[rbp]
	movsd	QWORD PTR -120[rbp], xmm2
	movapd	xmm2, xmm6
	subsd	xmm2, xmm4
	addsd	xmm2, QWORD PTR -128[rbp]
	movsd	QWORD PTR -152[rbp], xmm0
	movsd	QWORD PTR -128[rbp], xmm2
	movapd	xmm2, xmm3
	subsd	xmm2, xmm6
	addsd	xmm2, QWORD PTR -136[rbp]
	movsd	QWORD PTR -136[rbp], xmm2
	movapd	xmm2, xmm1
	subsd	xmm2, xmm3
	addsd	xmm2, QWORD PTR -144[rbp]
	movsd	QWORD PTR -144[rbp], xmm2
	cmp	eax, ecx
	jne	.L57
	mov	rsi, QWORD PTR -216[rbp]
	mov	r11, QWORD PTR -240[rbp]
	xor	r14d, r14d
	mov	rax, rsi
	lea	rcx, 16384[rsi]
	.p2align 4,,10
	.p2align 3
.L58:
	mov	rdx, r14
	add	rax, 4
	sal	rdx, 5
	sub	rdx, r14
	mov	r14d, DWORD PTR -4[rax]
	add	r14, rdx
	cmp	rcx, rax
	jne	.L58
	movsd	xmm1, QWORD PTR -120[rbp]
	addsd	xmm1, QWORD PTR -128[rbp]
	mov	r9d, r13d
	mov	r8d, r13d
	mov	QWORD PTR -112[rbp], r11
	addsd	xmm1, QWORD PTR -136[rbp]
	lea	rsi, .LC17[rip]
	mov	edi, 2
	addsd	xmm1, QWORD PTR -144[rbp]
	addsd	xmm1, QWORD PTR -152[rbp]
	lea	r12, .LC24[rip]
	movsd	QWORD PTR -104[rbp], xmm1
	push	rax
	mov	ecx, DWORD PTR -256[rbp]
	xor	eax, eax
	push	48
	mov	edx, DWORD PTR -220[rbp]
	call	__printf_chk@PLT
	lea	rcx, .LC19[rip]
	xor	eax, eax
	lea	r8, .LC18[rip]
	lea	rdx, .LC20[rip]
	lea	rsi, .LC21[rip]
	mov	edi, 2
	call	__printf_chk@PLT
	movsd	xmm0, QWORD PTR -120[rbp]
	mov	rsi, r12
	mov	edi, 2
	movsd	xmm6, QWORD PTR .LC22[rip]
	lea	rdx, .LC23[rip]
	mov	eax, 2
	mulsd	xmm6, xmm0
	movapd	xmm1, xmm6
	divsd	xmm1, QWORD PTR -104[rbp]
	call	__printf_chk@PLT
	movsd	xmm0, QWORD PTR -128[rbp]
	mov	rsi, r12
	mov	edi, 2
	movsd	xmm1, QWORD PTR .LC22[rip]
	lea	rdx, .LC25[rip]
	mov	eax, 2
	mulsd	xmm1, xmm0
	divsd	xmm1, QWORD PTR -104[rbp]
	call	__printf_chk@PLT
	mov	rsi, r12
	movsd	xmm0, QWORD PTR -136[rbp]
	movsd	xmm1, QWORD PTR .LC22[rip]
	mov	edi, 2
	mov	eax, 2
	lea	rdx, .LC26[rip]
	mulsd	xmm1, xmm0
	divsd	xmm1, QWORD PTR -104[rbp]
	call	__printf_chk@PLT
	mov	rsi, r12
	movsd	xmm0, QWORD PTR -144[rbp]
	movsd	xmm1, QWORD PTR .LC22[rip]
	mov	edi, 2
	mov	eax, 2
	lea	rdx, .LC27[rip]
	mulsd	xmm1, xmm0
	divsd	xmm1, QWORD PTR -104[rbp]
	call	__printf_chk@PLT
	mov	rsi, r12
	movsd	xmm7, QWORD PTR -152[rbp]
	movsd	xmm1, QWORD PTR .LC22[rip]
	mov	edi, 2
	mov	eax, 2
	lea	rdx, .LC28[rip]
	movapd	xmm0, xmm7
	mulsd	xmm1, xmm7
	divsd	xmm1, QWORD PTR -104[rbp]
	call	__printf_chk@PLT
	movsd	xmm0, QWORD PTR -104[rbp]
	lea	rdx, .LC29[rip]
	lea	rsi, .LC30[rip]
	mov	edi, 2
	mov	eax, 1
	call	__printf_chk@PLT
	movsd	xmm0, QWORD PTR -168[rbp]
	mov	rdx, r14
	lea	rsi, .LC31[rip]
	mov	edi, 2
	mov	eax, 1
	call	__printf_chk@PLT
	mov	rdi, QWORD PTR -232[rbp]
	call	free@PLT
	mov	rdi, QWORD PTR -160[rbp]
	call	free@PLT
	mov	rdi, QWORD PTR -112[rbp]
	call	free@PLT
	mov	rdi, rbx
	call	free@PLT
	mov	rdi, r15
	call	free@PLT
	mov	rdi, QWORD PTR -216[rbp]
	call	free@PLT
	pop	rdx
	xor	eax, eax
	pop	rcx
.L40:
	mov	rdx, QWORD PTR -56[rbp]
	sub	rdx, QWORD PTR fs:40
	jne	.L79
	lea	rsp, -40[rbp]
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
.L77:
	mov	ebx, edi
	mov	rdi, QWORD PTR 8[rsi]
	mov	r12, rsi
	mov	edx, 10
	xor	esi, esi
	call	strtol@PLT
	mov	DWORD PTR -220[rbp], eax
	mov	r14, rax
	cmp	ebx, 2
	je	.L42
	mov	rdi, QWORD PTR 16[r12]
	mov	edx, 10
	xor	esi, esi
	call	strtol@PLT
	mov	DWORD PTR -256[rbp], eax
	mov	r15, rax
	cmp	ebx, 3
	je	.L43
	mov	rdi, QWORD PTR 24[r12]
	mov	edx, 10
	xor	esi, esi
	sub	r15d, 10
	call	strtol@PLT
	mov	r13d, eax
	cmp	r15d, 18
	ja	.L47
	test	r14d, r14d
	jle	.L47
	cmp	eax, 15
	jg	.L41
.L47:
	mov	rcx, QWORD PTR [r12]
	mov	rdi, QWORD PTR stderr[rip]
	lea	rdx, .LC10[rip]
	xor	eax, eax
	mov	esi, 2
	call	__fprintf_chk@PLT
	mov	eax, 2
	jmp	.L40
.L42:
	test	eax, eax
	jle	.L47
	jmp	.L76
.L43:
	sub	r15d, 10
	cmp	r15d, 18
	ja	.L47
	test	r14d, r14d
	jle	.L47
	mov	r13d, 1536
	jmp	.L41
.L79:
	call	__stack_chk_fail@PLT
	.size	main, .-main
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC2:
	.long	931135488
	.align 4
.LC3:
	.long	1056964608
	.align 4
.LC4:
	.long	1048576000
	.align 4
.LC5:
	.long	981467136
	.align 4
.LC6:
	.long	1082130432
	.align 4
.LC7:
	.long	1166016512
	.align 4
.LC11:
	.long	1120403456
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC12:
	.long	-400107883
	.long	1041313291
	.section	.rodata.cst4
	.align 4
.LC13:
	.long	1045220557
	.align 4
.LC14:
	.long	1067030938
	.align 4
.LC15:
	.long	-1102263091
	.section	.rodata.cst8
	.align 8
.LC16:
	.long	-1598689907
	.long	1051772663
	.align 8
.LC22:
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

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
	.type	heat_step.constprop.0, @function
heat_step.constprop.0:
	push	rbp
	mov	rbp, rsp
	push	r15
	mov	r15, rdi
	lea	edi, -1[rdx]
	push	r14
	push	r13
	push	r12
	push	rbx
	and	rsp, -32
	mov	DWORD PTR -52[rsp], edx
	mov	DWORD PTR -36[rsp], edi
	cmp	edi, 1
	jle	.L28
	lea	ebx, -2[rdx]
	mov	rax, rsi
	movsx	rsi, edx
	sub	edx, 3
	lea	rdi, 0[0+rsi*4]
	mov	r10d, ebx
	mov	DWORD PTR -16[rsp], ebx
	and	ebx, -8
	shr	r10d, 3
	mov	QWORD PTR -24[rsp], rdi
	add	rdi, 4
	vmovss	xmm10, DWORD PTR .LC3[rip]
	mov	DWORD PTR -60[rsp], ebx
	lea	r12, [rax+rdi]
	sal	r10, 5
	add	rdi, r15
	add	ebx, 1
	vmovss	xmm9, DWORD PTR .LC5[rip]
	mov	DWORD PTR -40[rsp], edx
	vbroadcastss	ymm1, xmm10
	mov	QWORD PTR -48[rsp], rsi
	vmovq	xmm14, QWORD PTR .LC8[rip]
	vshufps	xmm7, xmm10, xmm10, 0
	mov	DWORD PTR -56[rsp], ebx
	vbroadcastss	ymm0, xmm9
	vshufps	xmm6, xmm9, xmm9, 0
	vmovq	xmm15, QWORD PTR .LC9[rip]
	mov	DWORD PTR -12[rsp], 1
	mov	QWORD PTR -32[rsp], r10
	mov	QWORD PTR -8[rsp], rdi
	.p2align 4,,10
	.p2align 3
.L14:
	mov	rcx, QWORD PTR -48[rsp]
	mov	r11, rsi
	add	DWORD PTR -12[rsp], 1
	mov	rbx, rsi
	lea	rdx, -4[r12]
	sub	r11, rcx
	add	rsi, rcx
	cmp	DWORD PTR -40[rsp], 6
	jbe	.L16
	mov	rcx, QWORD PTR -24[rsp]
	mov	r13, r12
	mov	r10, QWORD PTR -32[rsp]
	lea	r8, 4[r12]
	mov	rdi, QWORD PTR -8[rsp]
	sub	r13, rcx
	lea	r9, [rcx+r12]
	xor	ecx, ecx
	.p2align 4,,10
	.p2align 3
.L9:
	vmovups	ymm5, YMMWORD PTR [r9+rcx]
	vmovups	ymm4, YMMWORD PTR [r8+rcx]
	vaddps	ymm2, ymm5, YMMWORD PTR 0[r13+rcx]
	vaddps	ymm3, ymm4, YMMWORD PTR [rdx+rcx]
	vaddps	ymm2, ymm2, ymm3
	vfnmadd231ps	ymm2, ymm1, YMMWORD PTR [r12+rcx]
	vfmadd213ps	ymm2, ymm0, YMMWORD PTR [r12+rcx]
	vmovups	YMMWORD PTR [rdi+rcx], ymm2
	add	rcx, 32
	cmp	r10, rcx
	jne	.L9
	mov	QWORD PTR -32[rsp], r10
	mov	QWORD PTR -8[rsp], rdi
	test	BYTE PTR -16[rsp], 7
	je	.L10
	mov	ecx, DWORD PTR -60[rsp]
	mov	r8d, DWORD PTR -56[rsp]
.L8:
	mov	r12d, DWORD PTR -52[rsp]
	sub	r12d, ecx
	lea	r14d, -2[r12]
	sub	r12d, 3
	cmp	r12d, 2
	jbe	.L11
	lea	r13, 1[rcx+rbx]
	lea	r12, 0[0+r13*4]
	vmovups	xmm4, XMMWORD PTR [rax+r13*4]
	lea	r13, 1[r11+rcx]
	lea	rcx, 1[rsi+rcx]
	vmovups	xmm5, XMMWORD PTR -4[rax+r12]
	vaddps	xmm3, xmm5, XMMWORD PTR 4[rax+r12]
	vmovups	xmm2, XMMWORD PTR [rax+rcx*4]
	vaddps	xmm2, xmm2, XMMWORD PTR [rax+r13*4]
	mov	ecx, r14d
	and	ecx, -4
	add	r8d, ecx
	and	r14d, 3
	vaddps	xmm2, xmm2, xmm3
	vfnmadd231ps	xmm2, xmm4, xmm7
	vfmadd132ps	xmm2, xmm4, xmm6
	vmovups	XMMWORD PTR [r15+r12], xmm2
	je	.L10
.L11:
	movsx	rcx, r8d
	mov	edi, DWORD PTR -16[rsp]
	lea	r13d, 1[r8]
	lea	r12, [rcx+rbx]
	lea	r14, [rax+r12*4]
	cmp	r13d, edi
	jge	.L17
	lea	r10, [r11+rcx]
	vmovq	xmm4, QWORD PTR -4[r14]
	vmovq	xmm3, QWORD PTR [r14]
	lea	r13, 0[0+rcx*4]
	vmovq	xmm2, QWORD PTR [rax+r10*4]
	add	rcx, rsi
	vmovq	xmm5, QWORD PTR 4[rdx+r13]
	vaddps	xmm2, xmm2, xmm4
	vmovq	xmm4, QWORD PTR [rax+rcx*4]
	lea	ecx, 2[r8]
	vaddps	xmm4, xmm4, xmm5
	vaddps	xmm2, xmm2, xmm4
	vfnmadd231ps	xmm2, xmm3, xmm14
	vfmadd132ps	xmm2, xmm3, xmm15
	vmovlps	QWORD PTR [r15+r12*4], xmm2
	lea	r12d, 3[r8]
	cmp	edi, r12d
	jg	.L27
	vmovaps	xmm4, xmm10
	vmovaps	xmm8, xmm9
.L13:
	movsx	r8, ecx
	mov	r10d, DWORD PTR -36[rsp]
	lea	r14, [r11+r8]
	lea	r13, [rsi+r8]
	vmovss	xmm3, DWORD PTR [rdx+r8*4]
	lea	r12, 0[0+r8*4]
	vmovss	xmm2, DWORD PTR [rax+r14*4]
	add	r8, rbx
	vaddss	xmm2, xmm2, DWORD PTR [rax+r13*4]
	vmovss	xmm5, DWORD PTR 4[rdx+r12]
	vaddss	xmm11, xmm5, DWORD PTR -4[rdx+r12]
	vaddss	xmm2, xmm2, xmm11
	vfnmadd231ss	xmm2, xmm3, xmm4
	vfmadd132ss	xmm2, xmm3, xmm8
	vmovss	DWORD PTR [r15+r8*4], xmm2
	lea	r8d, 1[rcx]
	cmp	r10d, r8d
	jle	.L10
	movsx	r8, r8d
	vmovss	xmm11, DWORD PTR 8[rdx+r12]
	add	ecx, 2
	lea	r14, [r11+r8]
	lea	r13, [rsi+r8]
	add	r8, rbx
	vaddss	xmm3, xmm3, xmm11
	vmovss	xmm2, DWORD PTR [rax+r14*4]
	vaddss	xmm2, xmm2, DWORD PTR [rax+r13*4]
	vaddss	xmm2, xmm2, xmm3
	vfnmadd231ss	xmm2, xmm5, xmm4
	vfmadd132ss	xmm2, xmm5, xmm8
	vmovss	DWORD PTR [r15+r8*4], xmm2
	cmp	r10d, ecx
	jle	.L10
	movsx	rcx, ecx
	vmovss	xmm3, DWORD PTR 12[rdx+r12]
	add	r11, rcx
	lea	r8, [rsi+rcx]
	add	rcx, rbx
	vaddss	xmm3, xmm3, xmm5
	vmovss	xmm2, DWORD PTR [rax+r11*4]
	vaddss	xmm2, xmm2, DWORD PTR [rax+r8*4]
	vaddss	xmm2, xmm2, xmm3
	vfnmadd132ss	xmm4, xmm2, xmm11
	vfmadd132ss	xmm4, xmm11, xmm8
	vmovss	DWORD PTR [r15+rcx*4], xmm4
.L10:
	mov	rbx, QWORD PTR -24[rsp]
	mov	edx, DWORD PTR -36[rsp]
	mov	r12, r9
	add	QWORD PTR -8[rsp], rbx
	cmp	DWORD PTR -12[rsp], edx
	jne	.L14
	vzeroupper
.L28:
	lea	rsp, -40[rbp]
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
	.p2align 4,,10
	.p2align 3
.L27:
	vmovshdup	xmm3, xmm3
	lea	r14, 12[rdx+r13]
	movsx	rcx, ecx
	movsx	r12, r12d
	vmovss	xmm11, DWORD PTR [r14]
	mov	r10, QWORD PTR [r14]
	lea	rdi, [rsi+rcx]
	lea	r14, [r11+rcx]
	vmovshdup	xmm5, xmm5
	vmovaps	xmm4, xmm10
	vmovaps	xmm8, xmm9
	add	rcx, rbx
	vmovss	xmm2, DWORD PTR [rax+r14*4]
	vaddss	xmm2, xmm2, DWORD PTR [rax+rdi*4]
	lea	r14, [r11+r12]
	add	r12, rsi
	vaddss	xmm3, xmm3, xmm11
	vmovss	xmm12, DWORD PTR [rax+r14*4]
	vaddss	xmm12, xmm12, DWORD PTR [rax+r12*4]
	vmovss	xmm13, DWORD PTR 16[rdx+r13]
	lea	r12d, 5[r8]
	vaddss	xmm2, xmm2, xmm3
	vmovq	xmm3, r10
	vmovshdup	xmm3, xmm3
	vfnmadd231ss	xmm2, xmm5, xmm10
	vfnmadd231ss	xmm3, xmm11, xmm10
	vfmadd132ss	xmm2, xmm5, xmm9
	vaddss	xmm3, xmm3, xmm12
	vaddss	xmm3, xmm3, xmm5
	vfmadd132ss	xmm3, xmm11, xmm9
	vunpcklps	xmm2, xmm2, xmm3
	vmovlps	QWORD PTR [r15+rcx*4], xmm2
	lea	ecx, 4[r8]
	cmp	DWORD PTR -16[rsp], r12d
	jle	.L13
	movsx	rcx, ecx
	vmovq	xmm5, r10
	vinsertps	xmm13, xmm13, DWORD PTR 20[rdx+r13], 0x10
	lea	r12, [r11+rcx]
	vmovq	xmm2, QWORD PTR [rax+r12*4]
	lea	r12, [rsi+rcx]
	add	rcx, rbx
	vmovq	xmm3, QWORD PTR [rax+r12*4]
	vaddps	xmm2, xmm2, xmm3
	vmovq	xmm3, QWORD PTR 20[rdx+r13]
	vaddps	xmm3, xmm3, xmm5
	vaddps	xmm2, xmm2, xmm3
	vfnmadd231ps	xmm2, xmm13, xmm14
	vfmadd132ps	xmm2, xmm13, xmm15
	vmovlps	QWORD PTR [r15+rcx*4], xmm2
	lea	ecx, 6[r8]
	jmp	.L13
	.p2align 4,,10
	.p2align 3
.L16:
	mov	r9, QWORD PTR -24[rsp]
	xor	ecx, ecx
	mov	r8d, 1
	add	r9, r12
	jmp	.L8
.L17:
	vmovss	xmm4, DWORD PTR .LC3[rip]
	vmovss	xmm8, DWORD PTR .LC5[rip]
	mov	ecx, r8d
	jmp	.L13
	.size	heat_step.constprop.0, .-heat_step.constprop.0
	.p2align 4
	.globl	synth_signal
	.type	synth_signal, @function
synth_signal:
	endbr64
	mov	eax, DWORD PTR [rdx]
	mov	r8, rdx
	test	esi, esi
	jle	.L31
	vmovss	xmm6, DWORD PTR .LC10[rip]
	vxorps	xmm2, xmm2, xmm2
	movsx	rsi, esi
	xor	edx, edx
	vmovss	xmm5, DWORD PTR .LC11[rip]
	vmovss	xmm4, DWORD PTR .LC12[rip]
	vmovss	xmm3, DWORD PTR .LC13[rip]
	.p2align 4,,10
	.p2align 3
.L32:
	mov	ecx, eax
	sal	ecx, 13
	xor	eax, ecx
	mov	ecx, eax
	shr	ecx, 17
	xor	ecx, eax
	mov	eax, ecx
	sal	eax, 5
	xor	eax, ecx
	movzx	ecx, ax
	vcvtsi2ss	xmm0, xmm2, ecx
	mov	ecx, edx
	and	ecx, 1023
	vcvtsi2ss	xmm1, xmm2, ecx
	vfmadd132ss	xmm0, xmm5, xmm6
	vmulss	xmm0, xmm0, xmm4
	vfmadd132ss	xmm1, xmm0, xmm3
	vmovss	DWORD PTR [rdi+rdx*4], xmm1
	add	rdx, 1
	cmp	rdx, rsi
	jne	.L32
.L31:
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
	push	r15
	push	r14
	push	r13
	push	r12
	mov	r12, rdx
	movsx	rdx, ecx
	push	rbx
	mov	r13, rdx
	mov	rbx, rsi
	sal	rdx, 2
	xor	esi, esi
	and	rsp, -32
	call	memset@PLT
	test	r13d, r13d
	jle	.L48
	mov	r8d, r13d
	mov	r9d, r13d
	mov	rdi, rax
	mov	rcx, rbx
	shr	r8d, 3
	lea	r10d, -1[r13]
	and	r9d, -8
	mov	edx, 1
	sal	r8, 5
	.p2align 4,,10
	.p2align 3
.L41:
	vmovss	xmm3, DWORD PTR -4[r12+rdx*4]
	lea	r11, -1[rdx]
	cmp	r10d, 6
	jbe	.L42
	vbroadcastss	ymm1, DWORD PTR [r12+rdx*4]
	vbroadcastss	ymm2, xmm3
	lea	rsi, 4[rcx]
	xor	eax, eax
	.p2align 4,,10
	.p2align 3
.L37:
	vmovups	ymm0, YMMWORD PTR [rcx+rax]
	vfmadd213ps	ymm0, ymm2, YMMWORD PTR [rdi+rax]
	vfmadd231ps	ymm0, ymm1, YMMWORD PTR [rsi+rax]
	vmovups	YMMWORD PTR [rdi+rax], ymm0
	add	rax, 32
	cmp	r8, rax
	jne	.L37
	cmp	r13d, r9d
	je	.L38
	mov	esi, r9d
	mov	eax, r9d
.L36:
	mov	r14d, r13d
	sub	r14d, esi
	lea	r15d, -1[r14]
	cmp	r15d, 2
	jbe	.L39
	lea	r15, [rdi+rsi*4]
	add	rsi, r11
	vshufps	xmm1, xmm3, xmm3, 0
	vbroadcastss	xmm0, DWORD PTR [r12+rdx*4]
	vmovups	xmm4, XMMWORD PTR [r15]
	vfmadd132ps	xmm1, xmm4, XMMWORD PTR [rbx+rsi*4]
	vfmadd132ps	xmm0, xmm1, XMMWORD PTR 4[rbx+rsi*4]
	mov	esi, r14d
	and	esi, -4
	add	eax, esi
	and	r14d, 3
	vmovups	XMMWORD PTR [r15], xmm0
	je	.L38
.L39:
	movsx	rsi, eax
	vmovss	xmm1, DWORD PTR [r12+rdx*4]
	lea	r14, 0[0+rsi*4]
	add	r11, rsi
	add	rsi, rdx
	lea	r15, [rdi+r14]
	vmovss	xmm2, DWORD PTR [rbx+r11*4]
	vmovss	xmm0, DWORD PTR [rbx+rsi*4]
	lea	r11d, 1[rax]
	vfmadd213ss	xmm2, xmm3, DWORD PTR [r15]
	vfmadd231ss	xmm2, xmm0, xmm1
	vmovss	DWORD PTR [r15], xmm2
	cmp	r13d, r11d
	jle	.L38
	lea	rsi, 4[rdi+r14]
	movsx	r11, r11d
	add	eax, 2
	vfmadd213ss	xmm0, xmm3, DWORD PTR [rsi]
	add	r11, rdx
	vmovss	xmm2, DWORD PTR [rbx+r11*4]
	vfmadd231ss	xmm0, xmm2, xmm1
	vmovss	DWORD PTR [rsi], xmm0
	cmp	r13d, eax
	jle	.L38
	lea	rsi, 8[rdi+r14]
	cdqe
	vfmadd213ss	xmm2, xmm3, DWORD PTR [rsi]
	add	rax, rdx
	vfmadd132ss	xmm1, xmm2, DWORD PTR [rbx+rax*4]
	vmovss	DWORD PTR [rsi], xmm1
.L38:
	add	rdx, 2
	add	rcx, 8
	cmp	rdx, 49
	jne	.L41
	vzeroupper
.L48:
	lea	rsp, -40[rbp]
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
.L42:
	xor	esi, esi
	xor	eax, eax
	jmp	.L36
	.size	fir_filter, .-fir_filter
	.p2align 4
	.globl	heat_step
	.type	heat_step, @function
heat_step:
	endbr64
	push	rbp
	mov	rbp, rsp
	push	r15
	mov	r15, rdi
	lea	edi, -1[rdx]
	push	r14
	push	r13
	push	r12
	push	rbx
	and	rsp, -32
	mov	DWORD PTR -48[rsp], edx
	mov	DWORD PTR -28[rsp], edi
	cmp	edi, 1
	jle	.L71
	lea	ebx, -2[rdx]
	mov	rax, rsi
	movsx	rsi, edx
	sub	edx, 3
	mov	r10d, ebx
	mov	DWORD PTR -32[rsp], edx
	mov	edx, ebx
	vmovaps	xmm1, xmm0
	and	edx, -8
	shr	r10d, 3
	mov	DWORD PTR -8[rsp], ebx
	vmovsldup	xmm7, xmm0
	mov	DWORD PTR -56[rsp], edx
	sal	r10, 5
	add	edx, 1
	and	ebx, 7
	mov	QWORD PTR -40[rsp], rsi
	vbroadcastss	ymm3, xmm0
	vshufps	xmm5, xmm0, xmm0, 0
	vmovss	xmm6, DWORD PTR .LC3[rip]
	lea	rdi, 0[0+rsi*4]
	mov	DWORD PTR -52[rsp], edx
	vmovq	xmm8, QWORD PTR .LC8[rip]
	mov	DWORD PTR -44[rsp], ebx
	vbroadcastss	ymm2, xmm6
	vshufps	xmm4, xmm6, xmm6, 0
	mov	DWORD PTR -4[rsp], 1
	mov	QWORD PTR -24[rsp], r10
	mov	QWORD PTR -16[rsp], rdi
	add	rdi, 4
	lea	r12, [rax+rdi]
	add	rdi, r15
	.p2align 4,,10
	.p2align 3
.L58:
	mov	rcx, QWORD PTR -40[rsp]
	mov	r11, rsi
	add	DWORD PTR -4[rsp], 1
	mov	rbx, rsi
	lea	rdx, -4[r12]
	sub	r11, rcx
	add	rsi, rcx
	cmp	DWORD PTR -32[rsp], 6
	jbe	.L60
	mov	rcx, QWORD PTR -16[rsp]
	mov	r13, r12
	mov	r10, QWORD PTR -24[rsp]
	lea	r8, 4[r12]
	sub	r13, rcx
	lea	r9, [r12+rcx]
	xor	ecx, ecx
	.p2align 4,,10
	.p2align 3
.L53:
	vmovups	ymm0, YMMWORD PTR [r9+rcx]
	vmovups	ymm14, YMMWORD PTR [r8+rcx]
	vaddps	ymm0, ymm0, YMMWORD PTR 0[r13+rcx]
	vaddps	ymm13, ymm14, YMMWORD PTR [rdx+rcx]
	vaddps	ymm0, ymm0, ymm13
	vfnmadd231ps	ymm0, ymm2, YMMWORD PTR [r12+rcx]
	vfmadd213ps	ymm0, ymm3, YMMWORD PTR [r12+rcx]
	vmovups	YMMWORD PTR [rdi+rcx], ymm0
	add	rcx, 32
	cmp	r10, rcx
	jne	.L53
	mov	ecx, DWORD PTR -44[rsp]
	mov	QWORD PTR -24[rsp], r10
	test	ecx, ecx
	je	.L54
	mov	ecx, DWORD PTR -56[rsp]
	mov	r8d, DWORD PTR -52[rsp]
.L52:
	mov	r12d, DWORD PTR -48[rsp]
	sub	r12d, ecx
	lea	r14d, -2[r12]
	sub	r12d, 3
	cmp	r12d, 2
	jbe	.L55
	lea	r13, 1[rcx+rbx]
	lea	r12, 0[0+r13*4]
	vmovups	xmm10, XMMWORD PTR [rax+r13*4]
	lea	r13, 1[r11+rcx]
	lea	rcx, 1[rsi+rcx]
	vmovups	xmm15, XMMWORD PTR -4[rax+r12]
	vaddps	xmm9, xmm15, XMMWORD PTR 4[rax+r12]
	vmovups	xmm0, XMMWORD PTR [rax+rcx*4]
	vaddps	xmm0, xmm0, XMMWORD PTR [rax+r13*4]
	mov	ecx, r14d
	and	ecx, -4
	add	r8d, ecx
	and	r14d, 3
	vaddps	xmm0, xmm0, xmm9
	vfnmadd231ps	xmm0, xmm10, xmm4
	vfmadd132ps	xmm0, xmm10, xmm5
	vmovups	XMMWORD PTR [r15+r12], xmm0
	je	.L54
.L55:
	movsx	rcx, r8d
	mov	r10d, DWORD PTR -8[rsp]
	lea	r13d, 1[r8]
	lea	r12, [rcx+rbx]
	lea	r14, [rax+r12*4]
	cmp	r13d, r10d
	jge	.L61
	lea	r10, [r11+rcx]
	vmovq	xmm10, QWORD PTR -4[r14]
	vmovq	xmm9, QWORD PTR [r14]
	lea	r13, 0[0+rcx*4]
	vmovq	xmm0, QWORD PTR [rax+r10*4]
	add	rcx, rsi
	vmovq	xmm13, QWORD PTR 4[rdx+r13]
	vaddps	xmm0, xmm0, xmm10
	vmovq	xmm10, QWORD PTR [rax+rcx*4]
	lea	ecx, 2[r8]
	vaddps	xmm10, xmm10, xmm13
	vaddps	xmm0, xmm0, xmm10
	vmovaps	xmm10, xmm6
	vfnmadd231ps	xmm0, xmm9, xmm8
	vfmadd132ps	xmm0, xmm9, xmm7
	vmovlps	QWORD PTR [r15+r12*4], xmm0
	lea	r12d, 3[r8]
	cmp	DWORD PTR -8[rsp], r12d
	jle	.L57
	vmovshdup	xmm9, xmm9
	movsx	rcx, ecx
	lea	r14, 12[rdx+r13]
	movsx	r12, r12d
	vmovss	xmm11, DWORD PTR [r14]
	vmovq	xmm12, QWORD PTR [r14]
	lea	r14, [r11+rcx]
	vmovshdup	xmm13, xmm13
	mov	r10, r14
	lea	r14, [rsi+rcx]
	add	rcx, rbx
	vmovss	xmm14, DWORD PTR 16[rdx+r13]
	vmovss	xmm0, DWORD PTR [rax+r10*4]
	vaddss	xmm0, xmm0, DWORD PTR [rax+r14*4]
	lea	r14, [r11+r12]
	add	r12, rsi
	vaddss	xmm9, xmm9, xmm11
	vmovss	xmm15, DWORD PTR [rax+r14*4]
	vaddss	xmm15, xmm15, DWORD PTR [rax+r12*4]
	lea	r12d, 5[r8]
	vaddss	xmm0, xmm0, xmm9
	vmovshdup	xmm9, xmm12
	vfnmadd231ss	xmm0, xmm13, xmm6
	vfnmadd231ss	xmm9, xmm11, xmm6
	vfmadd132ss	xmm0, xmm13, xmm1
	vaddss	xmm9, xmm9, xmm15
	vaddss	xmm9, xmm9, xmm13
	vfmadd132ss	xmm9, xmm11, xmm1
	vunpcklps	xmm0, xmm0, xmm9
	vmovlps	QWORD PTR [r15+rcx*4], xmm0
	lea	ecx, 4[r8]
	cmp	DWORD PTR -8[rsp], r12d
	jle	.L57
	movsx	rcx, ecx
	vinsertps	xmm14, xmm14, DWORD PTR 20[rdx+r13], 0x10
	lea	r12, [rsi+rcx]
	vmovq	xmm0, QWORD PTR [rax+r12*4]
	lea	r12, [r11+rcx]
	add	rcx, rbx
	vmovq	xmm9, QWORD PTR [rax+r12*4]
	vaddps	xmm0, xmm0, xmm9
	vmovq	xmm9, QWORD PTR 20[rdx+r13]
	vaddps	xmm9, xmm9, xmm12
	vaddps	xmm0, xmm0, xmm9
	vfnmadd231ps	xmm0, xmm14, xmm8
	vfmadd132ps	xmm0, xmm14, xmm7
	vmovlps	QWORD PTR [r15+rcx*4], xmm0
	lea	ecx, 6[r8]
.L57:
	movsx	r8, ecx
	mov	r10d, DWORD PTR -28[rsp]
	lea	r14, [r11+r8]
	lea	r13, [rsi+r8]
	vmovss	xmm11, DWORD PTR [rdx+r8*4]
	lea	r12, 0[0+r8*4]
	vmovss	xmm0, DWORD PTR [rax+r14*4]
	add	r8, rbx
	vaddss	xmm0, xmm0, DWORD PTR [rax+r13*4]
	vmovss	xmm9, DWORD PTR 4[rdx+r12]
	vaddss	xmm12, xmm9, DWORD PTR -4[rdx+r12]
	vaddss	xmm0, xmm0, xmm12
	vfnmadd231ss	xmm0, xmm11, xmm10
	vfmadd132ss	xmm0, xmm11, xmm1
	vmovss	DWORD PTR [r15+r8*4], xmm0
	lea	r8d, 1[rcx]
	cmp	r10d, r8d
	jle	.L54
	movsx	r8, r8d
	vmovss	xmm12, DWORD PTR 8[rdx+r12]
	add	ecx, 2
	lea	r14, [r11+r8]
	lea	r13, [rsi+r8]
	add	r8, rbx
	vaddss	xmm11, xmm11, xmm12
	vmovss	xmm0, DWORD PTR [rax+r14*4]
	vaddss	xmm0, xmm0, DWORD PTR [rax+r13*4]
	vaddss	xmm0, xmm0, xmm11
	vfnmadd231ss	xmm0, xmm9, xmm10
	vfmadd132ss	xmm0, xmm9, xmm1
	vmovss	DWORD PTR [r15+r8*4], xmm0
	cmp	r10d, ecx
	jle	.L54
	movsx	rcx, ecx
	vmovss	xmm9, DWORD PTR 12[rdx+r12]
	vaddss	xmm9, xmm9, DWORD PTR 4[rdx+r12]
	add	r11, rcx
	lea	r8, [rsi+rcx]
	add	rcx, rbx
	vmovss	xmm0, DWORD PTR [rax+r11*4]
	vaddss	xmm0, xmm0, DWORD PTR [rax+r8*4]
	vaddss	xmm0, xmm0, xmm9
	vfnmadd132ss	xmm10, xmm0, xmm12
	vfmadd132ss	xmm10, xmm12, xmm1
	vmovss	DWORD PTR [r15+rcx*4], xmm10
.L54:
	mov	rbx, QWORD PTR -16[rsp]
	mov	edx, DWORD PTR -28[rsp]
	mov	r12, r9
	add	rdi, rbx
	cmp	DWORD PTR -4[rsp], edx
	jne	.L58
	vzeroupper
.L71:
	lea	rsp, -40[rbp]
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
	.p2align 4,,10
	.p2align 3
.L60:
	mov	r14, QWORD PTR -16[rsp]
	xor	ecx, ecx
	mov	r8d, 1
	lea	r9, [r12+r14]
	jmp	.L52
.L61:
	vmovss	xmm10, DWORD PTR .LC3[rip]
	mov	ecx, r8d
	jmp	.L57
	.size	heat_step, .-heat_step
	.p2align 4
	.globl	quantize_hist
	.type	quantize_hist, @function
quantize_hist:
	endbr64
	vsubss	xmm1, xmm1, xmm0
	vmovss	xmm3, DWORD PTR .LC14[rip]
	vdivss	xmm3, xmm3, xmm1
	test	esi, esi
	jle	.L77
	movsx	rsi, esi
	lea	rcx, [rdi+rsi*4]
	.p2align 4,,10
	.p2align 3
.L75:
	vmovss	xmm1, DWORD PTR [rdi]
	vmovdqa	xmm2, XMMWORD PTR .LC15[rip]
	add	rdi, 4
	vsubss	xmm1, xmm1, xmm0
	vmulss	xmm1, xmm1, xmm3
	vcvttss2si	eax, xmm1
	vmovd	xmm1, eax
	vpminsd	xmm1, xmm1, xmm2
	vpxor	xmm2, xmm2, xmm2
	vpmaxsd	xmm1, xmm1, xmm2
	vmovd	eax, xmm1
	cdqe
	add	DWORD PTR [rdx+rax*4], 1
	cmp	rdi, rcx
	jne	.L75
.L77:
	ret
	.size	quantize_hist, .-quantize_hist
	.p2align 4
	.globl	checksum
	.type	checksum, @function
checksum:
	endbr64
	mov	ecx, esi
	test	esi, esi
	jle	.L86
	lea	eax, -1[rsi]
	cmp	eax, 6
	jbe	.L87
	mov	edx, esi
	mov	rax, rdi
	vxorpd	xmm2, xmm2, xmm2
	shr	edx, 3
	sal	rdx, 5
	add	rdx, rdi
	.p2align 4,,10
	.p2align 3
.L81:
	vmovups	ymm4, YMMWORD PTR [rax]
	vcvtps2pd	ymm1, XMMWORD PTR [rax]
	add	rax, 32
	vextractf128	xmm0, ymm4, 0x1
	vcvtps2pd	ymm0, xmm0
	vaddpd	ymm0, ymm1, ymm0
	vaddpd	ymm2, ymm2, ymm0
	cmp	rdx, rax
	jne	.L81
	vextractf128	xmm3, ymm2, 0x1
	mov	eax, ecx
	vaddpd	xmm1, xmm3, xmm2
	and	eax, -8
	vaddpd	xmm2, xmm2, xmm3
	mov	edx, eax
	vunpckhpd	xmm0, xmm1, xmm1
	vaddpd	xmm0, xmm0, xmm1
	cmp	ecx, eax
	je	.L93
	vzeroupper
.L80:
	mov	esi, ecx
	sub	esi, edx
	lea	r8d, -1[rsi]
	cmp	r8d, 2
	jbe	.L84
	vmovups	xmm3, XMMWORD PTR [rdi+rdx*4]
	vxorps	xmm0, xmm0, xmm0
	mov	edx, esi
	and	edx, -4
	vmovhlps	xmm0, xmm0, xmm3
	vcvtps2pd	xmm1, xmm3
	add	eax, edx
	and	esi, 3
	vcvtps2pd	xmm0, xmm0
	vaddpd	xmm1, xmm1, xmm0
	vaddpd	xmm1, xmm1, xmm2
	vunpckhpd	xmm0, xmm1, xmm1
	vaddpd	xmm0, xmm0, xmm1
	je	.L78
.L84:
	movsx	rdx, eax
	vxorps	xmm1, xmm1, xmm1
	vcvtss2sd	xmm2, xmm1, DWORD PTR [rdi+rdx*4]
	lea	rsi, 0[0+rdx*4]
	lea	edx, 1[rax]
	vaddsd	xmm0, xmm0, xmm2
	cmp	ecx, edx
	jle	.L78
	add	eax, 2
	vcvtss2sd	xmm2, xmm1, DWORD PTR 4[rdi+rsi]
	vaddsd	xmm0, xmm0, xmm2
	cmp	ecx, eax
	jle	.L78
	vcvtss2sd	xmm1, xmm1, DWORD PTR 8[rdi+rsi]
	vaddsd	xmm0, xmm0, xmm1
	ret
	.p2align 4,,10
	.p2align 3
.L86:
	vxorpd	xmm0, xmm0, xmm0
.L78:
	ret
	.p2align 4,,10
	.p2align 3
.L93:
	vzeroupper
	ret
.L87:
	vxorpd	xmm2, xmm2, xmm2
	xor	edx, edx
	vxorpd	xmm0, xmm0, xmm0
	xor	eax, eax
	jmp	.L80
	.size	checksum, .-checksum
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC17:
	.string	"usage: %s [rounds>=1] [log2n 10..28] [grid>=16]\n"
	.align 8
.LC31:
	.string	"rounds=%d  n=2^%d  grid=%dx%d  taps=%d\n"
	.section	.rodata.str1.1
.LC32:
	.string	"share"
.LC33:
	.string	"time, s"
.LC34:
	.string	"stage"
.LC35:
	.string	"%-14s %9s %7s\n"
.LC37:
	.string	"synth_signal"
.LC38:
	.string	"%-14s %9.3f %6.1f%%\n"
.LC39:
	.string	"fir_filter"
.LC40:
	.string	"heat_step"
.LC41:
	.string	"quantize_hist"
.LC42:
	.string	"checksum"
.LC43:
	.string	"TOTAL"
.LC44:
	.string	"%-14s %9.3f\n"
	.section	.rodata.str1.8
	.align 8
.LC45:
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
	push	r10
	push	rbx
	sub	rsp, 224
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -56[rbp], rax
	xor	eax, eax
	cmp	edi, 1
	jg	.L137
	mov	DWORD PTR -112[rbp], 30
.L136:
	mov	DWORD PTR -268[rbp], 22
	mov	r13d, 1536
.L95:
	movzx	edi, BYTE PTR -268[rbp]
	mov	eax, 1
	movsx	r14, r13d
	shlx	eax, eax, edi
	mov	DWORD PTR -104[rbp], eax
	add	eax, 48
	movsx	rbx, eax
	mov	DWORD PTR -256[rbp], eax
	sal	rbx, 2
	mov	rdi, rbx
	call	xalloc
	lea	rdi, -192[rbx]
	mov	QWORD PTR -240[rbp], rax
	call	xalloc
	mov	edi, 192
	mov	QWORD PTR -160[rbp], rax
	call	xalloc
	mov	r15, rax
	mov	QWORD PTR -248[rbp], rax
	mov	rax, r14
	imul	rax, r14
	lea	r12, 0[0+rax*4]
	mov	rdi, r12
	call	xalloc
	mov	rdi, r12
	mov	QWORD PTR -144[rbp], r12
	mov	rbx, rax
	call	xalloc
	mov	edi, 16384
	mov	r12, rax
	call	xalloc
	vmovaps	ymm0, YMMWORD PTR .LC18[rip]
	xor	esi, esi
	mov	rdi, rbx
	mov	QWORD PTR -232[rbp], rax
	mov	rdx, QWORD PTR -144[rbp]
	vmovups	YMMWORD PTR [r15], ymm0
	vmovaps	ymm0, YMMWORD PTR .LC19[rip]
	vmovups	YMMWORD PTR 32[r15], ymm0
	vmovaps	ymm0, YMMWORD PTR .LC20[rip]
	vmovups	YMMWORD PTR 64[r15], ymm0
	vmovaps	ymm0, YMMWORD PTR .LC21[rip]
	vmovups	YMMWORD PTR 96[r15], ymm0
	vmovaps	ymm0, YMMWORD PTR .LC22[rip]
	vmovups	YMMWORD PTR 128[r15], ymm0
	vmovaps	ymm0, YMMWORD PTR .LC23[rip]
	vmovups	YMMWORD PTR 160[r15], ymm0
	vzeroupper
	call	memset@PLT
	mov	eax, r13d
	mov	ecx, 3
	cdq
	idiv	ecx
	mov	DWORD PTR -152[rbp], eax
	lea	eax, [r13+r13]
	mov	esi, DWORD PTR -152[rbp]
	cdq
	idiv	ecx
	cmp	esi, eax
	jge	.L102
	mov	r15d, eax
	movsx	rdi, esi
	lea	r8, 1[r14]
	mov	r9d, esi
	sub	r15d, esi
	imul	r8, rdi
	vmovss	xmm1, DWORD PTR .LC25[rip]
	lea	rdx, 0[0+r14*4]
	lea	ecx, -1[r15]
	mov	r10d, r15d
	vbroadcastss	ymm0, DWORD PTR .LC25[rip]
	mov	QWORD PTR -136[rbp], rdi
	mov	DWORD PTR -108[rbp], ecx
	mov	ecx, r15d
	shr	r10d, 3
	vshufps	xmm2, xmm1, xmm1, 0
	and	ecx, -8
	mov	DWORD PTR -168[rbp], r13d
	lea	rdi, [rbx+r8*4]
	sal	r10, 5
	mov	DWORD PTR -128[rbp], ecx
	add	ecx, esi
	mov	esi, r15d
	mov	DWORD PTR -120[rbp], ecx
	and	esi, 7
	mov	QWORD PTR -176[rbp], r12
	mov	r13d, esi
	mov	r12, rdx
	.p2align 4,,10
	.p2align 3
.L103:
	cmp	DWORD PTR -108[rbp], 6
	jbe	.L115
	lea	rcx, [r10+rdi]
	mov	rdx, rdi
	test	r10b, 32
	je	.L107
	lea	rdx, 32[rdi]
	vmovups	YMMWORD PTR [rdi], ymm0
	cmp	rdx, rcx
	je	.L130
	.p2align 4,,10
	.p2align 3
.L107:
	vmovups	YMMWORD PTR [rdx], ymm0
	add	rdx, 64
	vmovups	YMMWORD PTR -32[rdx], ymm0
	cmp	rdx, rcx
	jne	.L107
.L130:
	test	r13d, r13d
	je	.L104
	mov	ecx, DWORD PTR -128[rbp]
	mov	edx, DWORD PTR -120[rbp]
.L109:
	mov	esi, r15d
	sub	esi, ecx
	lea	r11d, -1[rsi]
	cmp	r11d, 2
	jbe	.L105
	add	rcx, r8
	vmovups	XMMWORD PTR [rbx+rcx*4], xmm2
	mov	ecx, esi
	and	ecx, -4
	add	edx, ecx
	and	esi, 3
	je	.L104
.L105:
	mov	rcx, QWORD PTR -136[rbp]
	mov	rsi, r8
	sub	rsi, rcx
	movsx	rcx, edx
	add	rcx, rsi
	vmovss	DWORD PTR [rbx+rcx*4], xmm1
	lea	ecx, 1[rdx]
	cmp	ecx, eax
	jge	.L104
	movsx	rcx, ecx
	add	edx, 2
	add	rcx, rsi
	vmovss	DWORD PTR [rbx+rcx*4], xmm1
	cmp	edx, eax
	jge	.L104
	movsx	rdx, edx
	add	rdx, rsi
	vmovss	DWORD PTR [rbx+rdx*4], xmm1
.L104:
	add	r9d, 1
	add	rdi, r12
	add	r8, r14
	cmp	r9d, eax
	jne	.L103
	mov	r13d, DWORD PTR -168[rbp]
	mov	r12, QWORD PTR -176[rbp]
	vzeroupper
.L102:
	mov	rdx, QWORD PTR -144[rbp]
	mov	rsi, rbx
	mov	rdi, r12
	lea	r15, -80[rbp]
	call	memcpy@PLT
	mov	eax, r13d
	xor	esi, esi
	mov	DWORD PTR -84[rbp], -1640531527
	imul	eax, r13d
	mov	DWORD PTR -108[rbp], esi
	mov	QWORD PTR -168[rbp], 0x000000000
	mov	QWORD PTR -152[rbp], 0x000000000
	mov	DWORD PTR -252[rbp], eax
	lea	rax, -84[rbp]
	mov	QWORD PTR -144[rbp], 0x000000000
	mov	QWORD PTR -136[rbp], 0x000000000
	mov	QWORD PTR -128[rbp], 0x000000000
	mov	QWORD PTR -120[rbp], 0x000000000
	mov	QWORD PTR -264[rbp], rax
	.p2align 4,,10
	.p2align 3
.L111:
	mov	rsi, r15
	mov	edi, 1
	call	clock_gettime@PLT
	vxorpd	xmm4, xmm4, xmm4
	mov	r14, QWORD PTR -240[rbp]
	mov	rdx, QWORD PTR -264[rbp]
	vcvtsi2sd	xmm0, xmm4, QWORD PTR -80[rbp]
	mov	esi, DWORD PTR -256[rbp]
	mov	rdi, r14
	vmovsd	QWORD PTR -200[rbp], xmm0
	vcvtsi2sd	xmm0, xmm4, QWORD PTR -72[rbp]
	vmovsd	QWORD PTR -176[rbp], xmm0
	call	synth_signal
	mov	rsi, r15
	mov	edi, 1
	vzeroupper
	call	clock_gettime@PLT
	vxorpd	xmm4, xmm4, xmm4
	mov	ecx, DWORD PTR -104[rbp]
	vcvtsi2sd	xmm2, xmm4, QWORD PTR -72[rbp]
	vmovsd	xmm7, QWORD PTR .LC27[rip]
	vmovsd	xmm0, QWORD PTR -176[rbp]
	mov	rsi, r14
	vcvtsi2sd	xmm1, xmm4, QWORD PTR -80[rbp]
	mov	rdx, QWORD PTR -248[rbp]
	mov	rdi, QWORD PTR -160[rbp]
	mov	r14d, 8
	vmovsd	xmm6, xmm2, xmm2
	vfmadd132sd	xmm6, xmm1, QWORD PTR .LC27[rip]
	vfnmadd132sd	xmm0, xmm6, xmm7
	vmovsd	QWORD PTR -192[rbp], xmm6
	vmovsd	QWORD PTR -208[rbp], xmm0
	call	fir_filter
	mov	rsi, r15
	mov	edi, 1
	call	clock_gettime@PLT
	vxorpd	xmm4, xmm4, xmm4
	mov	rax, r12
	mov	r12, rbx
	vcvtsi2sd	xmm1, xmm4, QWORD PTR -72[rbp]
	mov	rbx, rax
	vcvtsi2sd	xmm0, xmm4, QWORD PTR -80[rbp]
	vfmadd132sd	xmm1, xmm0, QWORD PTR .LC27[rip]
	vmovsd	QWORD PTR -184[rbp], xmm1
	jmp	.L110
	.p2align 4,,10
	.p2align 3
.L116:
	mov	rax, r12
	mov	r12, rbx
	mov	rbx, rax
.L110:
	mov	edx, r13d
	mov	rsi, r12
	mov	rdi, rbx
	call	heat_step.constprop.0
	sub	r14d, 1
	jne	.L116
	mov	rsi, r15
	mov	edi, 1
	call	clock_gettime@PLT
	vxorpd	xmm5, xmm5, xmm5
	xor	esi, esi
	mov	edx, 16384
	vcvtsi2sd	xmm0, xmm5, QWORD PTR -80[rbp]
	mov	r14, QWORD PTR -232[rbp]
	vcvtsi2sd	xmm2, xmm5, QWORD PTR -72[rbp]
	vfmadd132sd	xmm2, xmm0, QWORD PTR .LC27[rip]
	mov	rdi, r14
	vmovsd	QWORD PTR -224[rbp], xmm2
	call	memset@PLT
	mov	rdx, r14
	mov	r14, QWORD PTR -160[rbp]
	mov	esi, DWORD PTR -104[rbp]
	vmovss	xmm1, DWORD PTR .LC28[rip]
	vmovss	xmm0, DWORD PTR .LC29[rip]
	mov	rdi, r14
	call	quantize_hist
	mov	rsi, r15
	mov	edi, 1
	vzeroupper
	call	clock_gettime@PLT
	vxorpd	xmm5, xmm5, xmm5
	mov	esi, DWORD PTR -104[rbp]
	vcvtsi2sd	xmm1, xmm5, QWORD PTR -72[rbp]
	mov	rdi, r14
	vcvtsi2sd	xmm0, xmm5, QWORD PTR -80[rbp]
	vfmadd132sd	xmm1, xmm0, QWORD PTR .LC27[rip]
	vmovsd	QWORD PTR -216[rbp], xmm1
	call	checksum
	mov	esi, DWORD PTR -252[rbp]
	mov	rdi, rbx
	vmovsd	QWORD PTR -176[rbp], xmm0
	call	checksum
	vmovsd	xmm6, QWORD PTR -176[rbp]
	mov	edi, 1
	mov	rsi, r15
	vmovsd	xmm3, xmm0, xmm0
	vaddsd	xmm0, xmm6, QWORD PTR -168[rbp]
	vfmadd132sd	xmm3, xmm0, QWORD PTR .LC30[rip]
	vmovsd	QWORD PTR -168[rbp], xmm3
	call	clock_gettime@PLT
	vxorpd	xmm5, xmm5, xmm5
	add	DWORD PTR -108[rbp], 1
	mov	edi, DWORD PTR -112[rbp]
	vmovsd	xmm6, QWORD PTR -120[rbp]
	vcvtsi2sd	xmm3, xmm5, QWORD PTR -80[rbp]
	vmovsd	xmm7, QWORD PTR -184[rbp]
	vcvtsi2sd	xmm0, xmm5, QWORD PTR -72[rbp]
	vmovsd	xmm2, QWORD PTR -224[rbp]
	vmovsd	xmm1, QWORD PTR -216[rbp]
	vfmadd132sd	xmm0, xmm3, QWORD PTR .LC27[rip]
	mov	eax, DWORD PTR -108[rbp]
	vsubsd	xmm3, xmm6, QWORD PTR -200[rbp]
	vaddsd	xmm6, xmm3, QWORD PTR -208[rbp]
	vsubsd	xmm3, xmm7, QWORD PTR -192[rbp]
	vaddsd	xmm3, xmm3, QWORD PTR -128[rbp]
	vmovsd	QWORD PTR -120[rbp], xmm6
	vmovsd	xmm6, QWORD PTR -152[rbp]
	vmovsd	QWORD PTR -128[rbp], xmm3
	vsubsd	xmm3, xmm2, xmm7
	vsubsd	xmm2, xmm1, xmm2
	vsubsd	xmm1, xmm6, xmm1
	vaddsd	xmm2, xmm2, QWORD PTR -144[rbp]
	vaddsd	xmm7, xmm3, QWORD PTR -136[rbp]
	vmovsd	QWORD PTR -144[rbp], xmm2
	vaddsd	xmm2, xmm0, xmm1
	vmovsd	QWORD PTR -136[rbp], xmm7
	vmovsd	QWORD PTR -152[rbp], xmm2
	cmp	eax, edi
	jne	.L111
	vmovsd	xmm7, QWORD PTR -120[rbp]
	vaddsd	xmm1, xmm7, QWORD PTR -128[rbp]
	xor	r14d, r14d
	vmovsd	xmm7, QWORD PTR -136[rbp]
	vaddsd	xmm2, xmm7, QWORD PTR -144[rbp]
	mov	rdi, QWORD PTR -232[rbp]
	vaddsd	xmm1, xmm1, xmm2
	mov	rax, rdi
	lea	rcx, 16384[rdi]
	.p2align 4,,10
	.p2align 3
.L112:
	mov	rdx, r14
	add	rax, 4
	sal	rdx, 5
	sub	rdx, r14
	mov	r14d, DWORD PTR -4[rax]
	add	r14, rdx
	cmp	rcx, rax
	jne	.L112
	vaddsd	xmm3, xmm1, QWORD PTR -152[rbp]
	mov	r9d, r13d
	mov	r8d, r13d
	mov	edi, 2
	lea	rsi, .LC31[rip]
	lea	r13, .LC38[rip]
	vmovsd	QWORD PTR -104[rbp], xmm3
	push	rax
	mov	ecx, DWORD PTR -268[rbp]
	xor	eax, eax
	push	48
	mov	edx, DWORD PTR -112[rbp]
	call	__printf_chk@PLT
	lea	rcx, .LC33[rip]
	xor	eax, eax
	lea	r8, .LC32[rip]
	lea	rdx, .LC34[rip]
	lea	rsi, .LC35[rip]
	mov	edi, 2
	call	__printf_chk@PLT
	vmovsd	xmm6, QWORD PTR .LC36[rip]
	vmovsd	xmm0, QWORD PTR -120[rbp]
	mov	rsi, r13
	lea	rdx, .LC37[rip]
	mov	edi, 2
	mov	eax, 2
	vmulsd	xmm1, xmm6, xmm0
	vdivsd	xmm1, xmm1, QWORD PTR -104[rbp]
	call	__printf_chk@PLT
	vmovsd	xmm0, QWORD PTR -128[rbp]
	vmovsd	xmm6, QWORD PTR .LC36[rip]
	lea	rdx, .LC39[rip]
	mov	rsi, r13
	mov	edi, 2
	mov	eax, 2
	vmulsd	xmm1, xmm6, xmm0
	vdivsd	xmm1, xmm1, QWORD PTR -104[rbp]
	call	__printf_chk@PLT
	mov	rsi, r13
	vmovsd	xmm2, QWORD PTR .LC36[rip]
	vmovsd	xmm0, QWORD PTR -136[rbp]
	mov	edi, 2
	mov	eax, 2
	lea	rdx, .LC40[rip]
	vmulsd	xmm1, xmm2, xmm0
	vdivsd	xmm1, xmm1, QWORD PTR -104[rbp]
	call	__printf_chk@PLT
	mov	rsi, r13
	vmovsd	xmm6, QWORD PTR .LC36[rip]
	vmovsd	xmm0, QWORD PTR -144[rbp]
	mov	edi, 2
	mov	eax, 2
	lea	rdx, .LC41[rip]
	vmulsd	xmm1, xmm6, xmm0
	vdivsd	xmm1, xmm1, QWORD PTR -104[rbp]
	call	__printf_chk@PLT
	mov	rsi, r13
	vmovsd	xmm7, QWORD PTR -152[rbp]
	vmovsd	xmm2, QWORD PTR .LC36[rip]
	mov	edi, 2
	mov	eax, 2
	lea	rdx, .LC42[rip]
	vmovsd	xmm0, xmm7, xmm7
	vmulsd	xmm1, xmm2, xmm7
	vdivsd	xmm1, xmm1, QWORD PTR -104[rbp]
	call	__printf_chk@PLT
	vmovsd	xmm0, QWORD PTR -104[rbp]
	lea	rdx, .LC43[rip]
	lea	rsi, .LC44[rip]
	mov	edi, 2
	mov	eax, 1
	call	__printf_chk@PLT
	vmovsd	xmm0, QWORD PTR -168[rbp]
	mov	rdx, r14
	lea	rsi, .LC45[rip]
	mov	edi, 2
	mov	eax, 1
	call	__printf_chk@PLT
	mov	rdi, QWORD PTR -240[rbp]
	call	free@PLT
	mov	rdi, QWORD PTR -160[rbp]
	call	free@PLT
	mov	rdi, QWORD PTR -248[rbp]
	call	free@PLT
	mov	rdi, rbx
	call	free@PLT
	mov	rdi, r12
	call	free@PLT
	mov	rdi, QWORD PTR -232[rbp]
	call	free@PLT
	pop	rdx
	xor	eax, eax
	pop	rcx
.L94:
	mov	rdx, QWORD PTR -56[rbp]
	sub	rdx, QWORD PTR fs:40
	jne	.L138
	lea	rsp, -48[rbp]
	pop	rbx
	pop	r10
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
.L115:
	mov	edx, DWORD PTR -152[rbp]
	xor	ecx, ecx
	jmp	.L109
.L137:
	mov	ebx, edi
	mov	rdi, QWORD PTR 8[rsi]
	mov	r12, rsi
	mov	edx, 10
	xor	esi, esi
	call	strtol@PLT
	mov	DWORD PTR -112[rbp], eax
	mov	r14, rax
	cmp	ebx, 2
	je	.L96
	mov	rdi, QWORD PTR 16[r12]
	mov	edx, 10
	xor	esi, esi
	call	strtol@PLT
	mov	DWORD PTR -268[rbp], eax
	mov	r15, rax
	cmp	ebx, 3
	je	.L97
	mov	rdi, QWORD PTR 24[r12]
	mov	edx, 10
	xor	esi, esi
	sub	r15d, 10
	call	strtol@PLT
	mov	r13d, eax
	cmp	r15d, 18
	ja	.L101
	test	r14d, r14d
	jle	.L101
	cmp	eax, 15
	jg	.L95
.L101:
	mov	rcx, QWORD PTR [r12]
	mov	rdi, QWORD PTR stderr[rip]
	lea	rdx, .LC17[rip]
	xor	eax, eax
	mov	esi, 2
	call	__fprintf_chk@PLT
	mov	eax, 2
	jmp	.L94
.L96:
	test	eax, eax
	jle	.L101
	jmp	.L136
.L97:
	sub	r15d, 10
	cmp	r15d, 18
	ja	.L101
	test	r14d, r14d
	jle	.L101
	mov	r13d, 1536
	jmp	.L95
.L138:
	call	__stack_chk_fail@PLT
	.size	main, .-main
	.set	.LC3,.LC8
	.set	.LC5,.LC9
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC8:
	.long	1082130432
	.long	1082130432
	.align 8
.LC9:
	.long	1045220557
	.long	1045220557
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC10:
	.long	931135488
	.align 4
.LC11:
	.long	-1090519040
	.align 4
.LC12:
	.long	1048576000
	.align 4
.LC13:
	.long	981467136
	.align 4
.LC14:
	.long	1166016512
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC15:
	.long	4095
	.long	0
	.long	0
	.long	0
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC18:
	.long	987395086
	.long	995783694
	.long	1000593162
	.long	1004172302
	.long	1007192201
	.long	1008981770
	.long	1010771340
	.long	1012560910
	.align 32
.LC19:
	.long	1014350480
	.long	1015580809
	.long	1016475594
	.long	1017370378
	.long	1018265163
	.long	1019159948
	.long	1020054733
	.long	1020949518
	.align 32
.LC20:
	.long	1021844303
	.long	1022739088
	.long	1023522024
	.long	1023969417
	.long	1024416809
	.long	1024864202
	.long	1025311594
	.long	1025758986
	.align 32
.LC21:
	.long	1025758986
	.long	1025311594
	.long	1024864202
	.long	1024416809
	.long	1023969417
	.long	1023522024
	.long	1022739088
	.long	1021844303
	.align 32
.LC22:
	.long	1020949518
	.long	1020054733
	.long	1019159948
	.long	1018265163
	.long	1017370378
	.long	1016475594
	.long	1015580809
	.long	1014350480
	.align 32
.LC23:
	.long	1012560910
	.long	1010771340
	.long	1008981770
	.long	1007192201
	.long	1004172302
	.long	1000593162
	.long	995783694
	.long	987395086
	.section	.rodata.cst4
	.align 4
.LC25:
	.long	1120403456
	.section	.rodata.cst8
	.align 8
.LC27:
	.long	-400107883
	.long	1041313291
	.section	.rodata.cst4
	.align 4
.LC28:
	.long	1067030938
	.align 4
.LC29:
	.long	-1102263091
	.section	.rodata.cst8
	.align 8
.LC30:
	.long	-1598689907
	.long	1051772663
	.align 8
.LC36:
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

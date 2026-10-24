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
	mov	DWORD PTR -44[rsp], edx
	mov	DWORD PTR -28[rsp], edi
	cmp	edi, 1
	jle	.L28
	lea	ebx, -2[rdx]
	mov	rax, rsi
	movsx	rsi, edx
	sub	edx, 3
	mov	r10d, ebx
	mov	DWORD PTR -4[rsp], ebx
	and	ebx, -8
	vmovss	xmm6, DWORD PTR .LC3[rip]
	shr	r10d, 3
	mov	DWORD PTR -52[rsp], ebx
	add	ebx, 1
	vmovss	xmm5, DWORD PTR .LC5[rip]
	sal	r10, 5
	lea	rdi, 0[0+rsi*4]
	mov	QWORD PTR -40[rsp], rsi
	vmovq	xmm8, QWORD PTR .LC8[rip]
	mov	DWORD PTR -32[rsp], edx
	vbroadcastss	ymm2, xmm6
	vbroadcastss	ymm1, xmm5
	vmovq	xmm7, QWORD PTR .LC9[rip]
	mov	DWORD PTR -48[rsp], ebx
	vshufps	xmm4, xmm6, xmm6, 0
	vshufps	xmm3, xmm5, xmm5, 0
	mov	DWORD PTR -8[rsp], 1
	mov	QWORD PTR -24[rsp], r10
	mov	QWORD PTR -16[rsp], rdi
	add	rdi, 4
	lea	r12, [rax+rdi]
	add	rdi, r15
	.p2align 4,,10
	.p2align 3
.L14:
	mov	rcx, QWORD PTR -40[rsp]
	mov	r11, rsi
	add	DWORD PTR -8[rsp], 1
	mov	rbx, rsi
	lea	rdx, -4[r12]
	sub	r11, rcx
	add	rsi, rcx
	cmp	DWORD PTR -32[rsp], 6
	jbe	.L16
	mov	rcx, QWORD PTR -16[rsp]
	mov	r13, r12
	mov	r10, QWORD PTR -24[rsp]
	lea	r8, 4[r12]
	sub	r13, rcx
	lea	r9, [rcx+r12]
	xor	ecx, ecx
	.p2align 4,,10
	.p2align 3
.L9:
	vmovups	ymm0, YMMWORD PTR [r9+rcx]
	vaddps	ymm0, ymm0, YMMWORD PTR 0[r13+rcx]
	vaddps	ymm0, ymm0, YMMWORD PTR [rdx+rcx]
	vaddps	ymm0, ymm0, YMMWORD PTR [r8+rcx]
	vfnmadd231ps	ymm0, ymm2, YMMWORD PTR [r12+rcx]
	vfmadd213ps	ymm0, ymm1, YMMWORD PTR [r12+rcx]
	vmovups	YMMWORD PTR [rdi+rcx], ymm0
	add	rcx, 32
	cmp	r10, rcx
	jne	.L9
	mov	QWORD PTR -24[rsp], r10
	test	BYTE PTR -4[rsp], 7
	je	.L10
	mov	ecx, DWORD PTR -52[rsp]
	mov	r8d, DWORD PTR -48[rsp]
.L8:
	mov	r12d, DWORD PTR -44[rsp]
	sub	r12d, ecx
	lea	r13d, -2[r12]
	sub	r12d, 3
	cmp	r12d, 2
	jbe	.L11
	lea	r12, 1[rcx+rbx]
	lea	r14, 1[r11+rcx]
	lea	rcx, 1[rsi+rcx]
	vmovups	xmm0, XMMWORD PTR [rax+rcx*4]
	vaddps	xmm0, xmm0, XMMWORD PTR [rax+r14*4]
	mov	ecx, r13d
	vaddps	xmm0, xmm0, XMMWORD PTR -4[rax+r12*4]
	vaddps	xmm0, xmm0, XMMWORD PTR 4[rax+r12*4]
	and	ecx, -4
	vfnmadd231ps	xmm0, xmm4, XMMWORD PTR [rax+r12*4]
	add	r8d, ecx
	and	r13d, 3
	vfmadd213ps	xmm0, xmm3, XMMWORD PTR [rax+r12*4]
	vmovups	XMMWORD PTR [r15+r12*4], xmm0
	je	.L10
.L11:
	movsx	rcx, r8d
	mov	r10d, DWORD PTR -4[rsp]
	lea	r13d, 1[r8]
	lea	r12, [rcx+rbx]
	lea	r14, [rax+r12*4]
	cmp	r13d, r10d
	jge	.L17
	lea	r13, 0[0+rcx*4]
	lea	r10, [r11+rcx]
	add	rcx, rsi
	vmovq	xmm9, QWORD PTR [r14]
	vmovq	xmm10, QWORD PTR [rax+rcx*4]
	vmovq	xmm0, QWORD PTR [rax+r10*4]
	lea	ecx, 2[r8]
	vmovq	xmm15, QWORD PTR 4[rdx+r13]
	vaddps	xmm0, xmm0, xmm10
	vmovq	xmm10, QWORD PTR -4[r14]
	vaddps	xmm0, xmm0, xmm10
	vaddps	xmm0, xmm0, xmm15
	vfnmadd231ps	xmm0, xmm9, xmm8
	vfmadd132ps	xmm0, xmm9, xmm7
	vmovlps	QWORD PTR [r15+r12*4], xmm0
	lea	r12d, 3[r8]
	cmp	DWORD PTR -4[rsp], r12d
	jg	.L27
	vmovaps	xmm9, xmm6
	vmovaps	xmm10, xmm5
.L13:
	movsx	r8, ecx
	mov	r10d, DWORD PTR -28[rsp]
	lea	r14, [r11+r8]
	lea	r13, [rsi+r8]
	vmovss	xmm11, DWORD PTR [rdx+r8*4]
	lea	r12, 0[0+r8*4]
	vmovss	xmm0, DWORD PTR [rax+r14*4]
	add	r8, rbx
	vaddss	xmm0, xmm0, DWORD PTR [rax+r13*4]
	vaddss	xmm0, xmm0, DWORD PTR -4[rdx+r12]
	vmovss	xmm12, DWORD PTR 4[rdx+r12]
	vaddss	xmm0, xmm0, xmm12
	vfnmadd231ss	xmm0, xmm11, xmm9
	vfmadd132ss	xmm0, xmm11, xmm10
	vmovss	DWORD PTR [r15+r8*4], xmm0
	lea	r8d, 1[rcx]
	cmp	r10d, r8d
	jle	.L10
	movsx	r8, r8d
	vmovss	xmm13, DWORD PTR 8[rdx+r12]
	add	ecx, 2
	lea	r14, [r11+r8]
	lea	r13, [rsi+r8]
	add	r8, rbx
	vmovss	xmm0, DWORD PTR [rax+r14*4]
	vaddss	xmm0, xmm0, DWORD PTR [rax+r13*4]
	vaddss	xmm0, xmm0, xmm11
	vaddss	xmm0, xmm0, xmm13
	vfnmadd231ss	xmm0, xmm12, xmm9
	vfmadd132ss	xmm0, xmm12, xmm10
	vmovss	DWORD PTR [r15+r8*4], xmm0
	cmp	r10d, ecx
	jle	.L10
	movsx	rcx, ecx
	add	r11, rcx
	lea	r8, [rsi+rcx]
	add	rcx, rbx
	vmovss	xmm0, DWORD PTR [rax+r11*4]
	vaddss	xmm0, xmm0, DWORD PTR [rax+r8*4]
	vaddss	xmm0, xmm0, xmm12
	vaddss	xmm0, xmm0, DWORD PTR 12[rdx+r12]
	vfnmadd132ss	xmm9, xmm0, xmm13
	vfmadd132ss	xmm9, xmm13, xmm10
	vmovss	DWORD PTR [r15+rcx*4], xmm9
.L10:
	mov	rbx, QWORD PTR -16[rsp]
	mov	edx, DWORD PTR -28[rsp]
	mov	r12, r9
	add	rdi, rbx
	cmp	DWORD PTR -8[rsp], edx
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
	movsx	rcx, ecx
	lea	r14, 12[rdx+r13]
	vmovaps	xmm10, xmm5
	movsx	r12, r12d
	vmovss	xmm12, DWORD PTR [r14]
	vmovq	xmm13, QWORD PTR [r14]
	lea	r14, [r11+rcx]
	vmovshdup	xmm9, xmm9
	mov	r10, r14
	lea	r14, [rsi+rcx]
	add	rcx, rbx
	vmovss	xmm14, DWORD PTR 16[rdx+r13]
	vmovss	xmm0, DWORD PTR [rax+r10*4]
	vaddss	xmm0, xmm0, DWORD PTR [rax+r14*4]
	vmovshdup	xmm15, xmm15
	lea	r14, [r11+r12]
	add	r12, rsi
	vmovss	xmm11, DWORD PTR [rax+r14*4]
	vaddss	xmm11, xmm11, DWORD PTR [rax+r12*4]
	lea	r12d, 5[r8]
	vaddss	xmm0, xmm0, xmm9
	vmovaps	xmm9, xmm6
	vaddss	xmm11, xmm11, xmm15
	vaddss	xmm0, xmm0, xmm12
	vfnmadd231ss	xmm0, xmm15, xmm6
	vfmadd132ss	xmm0, xmm15, xmm5
	vmovshdup	xmm15, xmm13
	vaddss	xmm11, xmm11, xmm15
	vfnmadd231ss	xmm11, xmm12, xmm6
	vfmadd132ss	xmm11, xmm12, xmm5
	vunpcklps	xmm0, xmm0, xmm11
	vmovlps	QWORD PTR [r15+rcx*4], xmm0
	lea	ecx, 4[r8]
	cmp	DWORD PTR -4[rsp], r12d
	jle	.L13
	movsx	rcx, ecx
	vinsertps	xmm14, xmm14, DWORD PTR 20[rdx+r13], 0x10
	lea	r12, [r11+rcx]
	vmovq	xmm0, QWORD PTR [rax+r12*4]
	lea	r12, [rsi+rcx]
	add	rcx, rbx
	vmovq	xmm12, QWORD PTR [rax+r12*4]
	vaddps	xmm0, xmm0, xmm12
	vmovq	xmm12, QWORD PTR 20[rdx+r13]
	vaddps	xmm0, xmm0, xmm13
	vaddps	xmm0, xmm0, xmm12
	vfnmadd231ps	xmm0, xmm14, xmm8
	vfmadd132ps	xmm0, xmm14, xmm7
	vmovlps	QWORD PTR [r15+rcx*4], xmm0
	lea	ecx, 6[r8]
	jmp	.L13
	.p2align 4,,10
	.p2align 3
.L16:
	mov	r14, QWORD PTR -16[rsp]
	xor	ecx, ecx
	mov	r8d, 1
	lea	r9, [r14+r12]
	jmp	.L8
.L17:
	vmovss	xmm9, DWORD PTR .LC3[rip]
	vmovss	xmm10, DWORD PTR .LC5[rip]
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
	vmovaps	xmm3, xmm0
	and	edx, -8
	shr	r10d, 3
	mov	DWORD PTR -8[rsp], ebx
	vmovsldup	xmm7, xmm0
	mov	DWORD PTR -56[rsp], edx
	sal	r10, 5
	add	edx, 1
	and	ebx, 7
	mov	QWORD PTR -40[rsp], rsi
	vbroadcastss	ymm2, xmm0
	vshufps	xmm5, xmm0, xmm0, 0
	vmovss	xmm6, DWORD PTR .LC3[rip]
	lea	rdi, 0[0+rsi*4]
	mov	DWORD PTR -52[rsp], edx
	vmovq	xmm8, QWORD PTR .LC8[rip]
	mov	DWORD PTR -44[rsp], ebx
	vbroadcastss	ymm1, xmm6
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
	vaddps	ymm0, ymm0, YMMWORD PTR 0[r13+rcx]
	vaddps	ymm0, ymm0, YMMWORD PTR [rdx+rcx]
	vaddps	ymm0, ymm0, YMMWORD PTR [r8+rcx]
	vfnmadd231ps	ymm0, ymm1, YMMWORD PTR [r12+rcx]
	vfmadd213ps	ymm0, ymm2, YMMWORD PTR [r12+rcx]
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
	lea	r13d, -2[r12]
	sub	r12d, 3
	cmp	r12d, 2
	jbe	.L55
	lea	r12, 1[rcx+rbx]
	lea	r14, 1[r11+rcx]
	lea	rcx, 1[rsi+rcx]
	vmovups	xmm0, XMMWORD PTR [rax+rcx*4]
	vaddps	xmm0, xmm0, XMMWORD PTR [rax+r14*4]
	mov	ecx, r13d
	vaddps	xmm0, xmm0, XMMWORD PTR -4[rax+r12*4]
	vaddps	xmm0, xmm0, XMMWORD PTR 4[rax+r12*4]
	and	ecx, -4
	vfnmadd231ps	xmm0, xmm4, XMMWORD PTR [rax+r12*4]
	add	r8d, ecx
	and	r13d, 3
	vfmadd213ps	xmm0, xmm5, XMMWORD PTR [rax+r12*4]
	vmovups	XMMWORD PTR [r15+r12*4], xmm0
	je	.L54
.L55:
	movsx	rcx, r8d
	mov	r10d, DWORD PTR -8[rsp]
	lea	r13d, 1[r8]
	lea	r12, [rcx+rbx]
	lea	r14, [rax+r12*4]
	cmp	r13d, r10d
	jge	.L61
	lea	r13, 0[0+rcx*4]
	lea	r10, [r11+rcx]
	add	rcx, rsi
	vmovq	xmm10, QWORD PTR [r14]
	vmovq	xmm9, QWORD PTR [rax+rcx*4]
	vmovq	xmm0, QWORD PTR [rax+r10*4]
	lea	ecx, 2[r8]
	vmovaps	xmm11, xmm6
	vmovq	xmm14, QWORD PTR 4[rdx+r13]
	vaddps	xmm0, xmm0, xmm9
	vmovq	xmm9, QWORD PTR -4[r14]
	vaddps	xmm0, xmm0, xmm9
	vaddps	xmm0, xmm0, xmm14
	vfnmadd231ps	xmm0, xmm10, xmm8
	vfmadd132ps	xmm0, xmm10, xmm7
	vmovlps	QWORD PTR [r15+r12*4], xmm0
	lea	r12d, 3[r8]
	cmp	DWORD PTR -8[rsp], r12d
	jle	.L57
	movsx	rcx, ecx
	vmovshdup	xmm10, xmm10
	lea	r14, 12[rdx+r13]
	movsx	r12, r12d
	vmovss	xmm12, DWORD PTR [r14]
	vmovq	xmm13, QWORD PTR [r14]
	lea	r14, [r11+rcx]
	vmovshdup	xmm14, xmm14
	mov	r10, r14
	lea	r14, [rsi+rcx]
	add	rcx, rbx
	vmovss	xmm0, DWORD PTR [rax+r10*4]
	vaddss	xmm0, xmm0, DWORD PTR [rax+r14*4]
	lea	r14, [r11+r12]
	add	r12, rsi
	vmovss	xmm9, DWORD PTR [rax+r14*4]
	vaddss	xmm9, xmm9, DWORD PTR [rax+r12*4]
	lea	r12d, 5[r8]
	vaddss	xmm0, xmm0, xmm10
	vmovss	xmm10, DWORD PTR 16[rdx+r13]
	vaddss	xmm9, xmm9, xmm14
	vaddss	xmm0, xmm0, xmm12
	vfnmadd231ss	xmm0, xmm14, xmm6
	vfmadd132ss	xmm0, xmm14, xmm3
	vmovshdup	xmm14, xmm13
	vaddss	xmm9, xmm9, xmm14
	vfnmadd231ss	xmm9, xmm12, xmm6
	vfmadd132ss	xmm9, xmm12, xmm3
	vunpcklps	xmm0, xmm0, xmm9
	vmovlps	QWORD PTR [r15+rcx*4], xmm0
	lea	ecx, 4[r8]
	cmp	DWORD PTR -8[rsp], r12d
	jle	.L57
	movsx	rcx, ecx
	vinsertps	xmm10, xmm10, DWORD PTR 20[rdx+r13], 0x10
	lea	r12, [rsi+rcx]
	vmovq	xmm0, QWORD PTR [rax+r12*4]
	lea	r12, [r11+rcx]
	add	rcx, rbx
	vmovq	xmm9, QWORD PTR [rax+r12*4]
	vaddps	xmm0, xmm0, xmm9
	vmovq	xmm9, QWORD PTR 20[rdx+r13]
	vaddps	xmm0, xmm0, xmm13
	vaddps	xmm0, xmm0, xmm9
	vfnmadd231ps	xmm0, xmm10, xmm8
	vfmadd132ps	xmm0, xmm10, xmm7
	vmovlps	QWORD PTR [r15+rcx*4], xmm0
	lea	ecx, 6[r8]
.L57:
	movsx	r8, ecx
	mov	r10d, DWORD PTR -28[rsp]
	lea	r14, [r11+r8]
	lea	r13, [rsi+r8]
	vmovss	xmm9, DWORD PTR [rdx+r8*4]
	lea	r12, 0[0+r8*4]
	vmovss	xmm0, DWORD PTR [rax+r14*4]
	add	r8, rbx
	vaddss	xmm0, xmm0, DWORD PTR [rax+r13*4]
	vaddss	xmm0, xmm0, DWORD PTR -4[rdx+r12]
	vmovss	xmm10, DWORD PTR 4[rdx+r12]
	vaddss	xmm0, xmm0, xmm10
	vfnmadd231ss	xmm0, xmm9, xmm11
	vfmadd132ss	xmm0, xmm9, xmm3
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
	vmovss	xmm0, DWORD PTR [rax+r14*4]
	vaddss	xmm0, xmm0, DWORD PTR [rax+r13*4]
	vaddss	xmm0, xmm0, xmm9
	vaddss	xmm0, xmm0, xmm12
	vfnmadd231ss	xmm0, xmm10, xmm11
	vfmadd132ss	xmm0, xmm10, xmm3
	vmovss	DWORD PTR [r15+r8*4], xmm0
	cmp	r10d, ecx
	jle	.L54
	movsx	rcx, ecx
	add	r11, rcx
	lea	r8, [rsi+rcx]
	add	rcx, rbx
	vmovss	xmm0, DWORD PTR [rax+r11*4]
	vaddss	xmm0, xmm0, DWORD PTR [rax+r8*4]
	vaddss	xmm0, xmm0, xmm10
	vaddss	xmm0, xmm0, DWORD PTR 12[rdx+r12]
	vfnmadd132ss	xmm11, xmm0, xmm12
	vfmadd132ss	xmm11, xmm12, xmm3
	vmovss	DWORD PTR [r15+rcx*4], xmm11
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
	vmovss	xmm11, DWORD PTR .LC3[rip]
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
	test	esi, esi
	jle	.L81
	movsx	rsi, esi
	vxorps	xmm2, xmm2, xmm2
	vxorpd	xmm1, xmm1, xmm1
	lea	rax, [rdi+rsi*4]
	.p2align 4,,10
	.p2align 3
.L80:
	vcvtss2sd	xmm0, xmm2, DWORD PTR [rdi]
	add	rdi, 4
	vaddsd	xmm1, xmm1, xmm0
	cmp	rax, rdi
	jne	.L80
	vmovsd	xmm0, xmm1, xmm1
	ret
	.p2align 4,,10
	.p2align 3
.L81:
	vxorpd	xmm1, xmm1, xmm1
	vmovsd	xmm0, xmm1, xmm1
	ret
	.size	checksum, .-checksum
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC18:
	.string	"usage: %s [rounds>=1] [log2n 10..28] [grid>=16]\n"
	.align 8
.LC26:
	.string	"rounds=%d  n=2^%d  grid=%dx%d  taps=%d\n"
	.section	.rodata.str1.1
.LC27:
	.string	"share"
.LC28:
	.string	"time, s"
.LC29:
	.string	"stage"
.LC30:
	.string	"%-14s %9s %7s\n"
.LC32:
	.string	"synth_signal"
.LC33:
	.string	"%-14s %9.3f %6.1f%%\n"
.LC34:
	.string	"fir_filter"
.LC35:
	.string	"heat_step"
.LC36:
	.string	"quantize_hist"
.LC37:
	.string	"checksum"
.LC38:
	.string	"TOTAL"
.LC39:
	.string	"%-14s %9.3f\n"
	.section	.rodata.str1.8
	.align 8
.LC40:
	.string	"result: acc=%.6e  hist=%016llx\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
	endbr64
	lea	r10, 8[rsp]
	and	rsp, -32
	push	QWORD PTR -8[r10]
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
	jg	.L130
	mov	DWORD PTR -220[rbp], 30
.L129:
	mov	DWORD PTR -256[rbp], 22
	mov	r14d, 1536
.L84:
	movzx	edi, BYTE PTR -256[rbp]
	mov	eax, 1
	movsx	r12, r14d
	shlx	eax, eax, edi
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
	mov	rax, r12
	imul	rax, r12
	lea	r15, 0[0+rax*4]
	mov	rdi, r15
	call	xalloc
	mov	rdi, r15
	mov	rbx, rax
	call	xalloc
	mov	edi, 16384
	mov	r13, rax
	call	xalloc
	mov	r10, QWORD PTR -112[rbp]
	vxorps	xmm1, xmm1, xmm1
	mov	ecx, 48
	mov	QWORD PTR -216[rbp], rax
	xor	eax, eax
	.p2align 4,,10
	.p2align 3
.L94:
	cmp	rax, 23
	ja	.L91
.L131:
	lea	edx, 1[rax]
	vxorps	xmm6, xmm6, xmm6
	vcvtsi2ss	xmm0, xmm6, edx
	vmovss	DWORD PTR [r10+rax*4], xmm0
	add	rax, 1
	vaddss	xmm1, xmm1, xmm0
	cmp	rax, 23
	jbe	.L131
.L91:
	mov	edx, ecx
	vxorps	xmm7, xmm7, xmm7
	sub	edx, eax
	vcvtsi2ss	xmm0, xmm7, edx
	vmovss	DWORD PTR [r10+rax*4], xmm0
	add	rax, 1
	vaddss	xmm1, xmm1, xmm0
	cmp	rax, 48
	jne	.L94
	vmovups	ymm7, YMMWORD PTR [r10]
	vbroadcastss	ymm1, xmm1
	mov	QWORD PTR -112[rbp], r10
	xor	esi, esi
	vmovups	ymm6, YMMWORD PTR 96[r10]
	mov	rdx, r15
	mov	rdi, rbx
	vdivps	ymm0, ymm7, ymm1
	vmovups	ymm7, YMMWORD PTR 32[r10]
	vmovups	YMMWORD PTR [r10], ymm0
	vdivps	ymm0, ymm7, ymm1
	vmovups	ymm7, YMMWORD PTR 64[r10]
	vmovups	YMMWORD PTR 32[r10], ymm0
	vdivps	ymm0, ymm7, ymm1
	vmovups	ymm7, YMMWORD PTR 128[r10]
	vmovups	YMMWORD PTR 64[r10], ymm0
	vdivps	ymm0, ymm6, ymm1
	vmovups	ymm6, YMMWORD PTR 160[r10]
	vmovups	YMMWORD PTR 96[r10], ymm0
	vdivps	ymm0, ymm7, ymm1
	vmovups	YMMWORD PTR 128[r10], ymm0
	vdivps	ymm0, ymm6, ymm1
	vmovups	YMMWORD PTR 160[r10], ymm0
	vzeroupper
	call	memset@PLT
	mov	eax, r14d
	mov	r10, QWORD PTR -112[rbp]
	mov	ecx, 3
	cdq
	idiv	ecx
	mov	DWORD PTR -144[rbp], eax
	lea	eax, [r14+r14]
	cdq
	idiv	ecx
	mov	edx, DWORD PTR -144[rbp]
	cmp	edx, eax
	jge	.L95
	mov	esi, eax
	lea	rdi, 0[0+r12*4]
	lea	r8, 1[r12]
	mov	QWORD PTR -192[rbp], r10
	sub	esi, edx
	mov	QWORD PTR -168[rbp], rdi
	movsx	rdi, edx
	vmovss	xmm1, DWORD PTR .LC20[rip]
	imul	r8, rdi
	lea	ecx, -1[rsi]
	mov	r11d, esi
	mov	DWORD PTR -112[rbp], esi
	mov	DWORD PTR -152[rbp], ecx
	mov	ecx, esi
	shr	r11d, 3
	and	esi, 7
	and	ecx, -8
	mov	DWORD PTR -184[rbp], r14d
	vbroadcastss	ymm0, DWORD PTR .LC20[rip]
	sal	r11, 5
	mov	DWORD PTR -128[rbp], ecx
	lea	r9d, [rcx+rdx]
	mov	r14, QWORD PTR -168[rbp]
	vshufps	xmm2, xmm1, xmm1, 0
	mov	QWORD PTR -200[rbp], r13
	mov	r13d, DWORD PTR -152[rbp]
	mov	QWORD PTR -136[rbp], rdi
	lea	rdi, [rbx+r8*4]
	mov	DWORD PTR -120[rbp], r9d
	mov	r9d, edx
	mov	QWORD PTR -176[rbp], r15
	mov	r15d, esi
	.p2align 4,,10
	.p2align 3
.L96:
	cmp	r13d, 6
	jbe	.L108
	lea	rcx, [r11+rdi]
	mov	rdx, rdi
	test	r11b, 32
	je	.L100
	lea	rdx, 32[rdi]
	vmovups	YMMWORD PTR [rdi], ymm0
	cmp	rcx, rdx
	je	.L123
	.p2align 4,,10
	.p2align 3
.L100:
	vmovups	YMMWORD PTR [rdx], ymm0
	add	rdx, 64
	vmovups	YMMWORD PTR -32[rdx], ymm0
	cmp	rcx, rdx
	jne	.L100
.L123:
	test	r15d, r15d
	je	.L97
	mov	ecx, DWORD PTR -128[rbp]
	mov	edx, DWORD PTR -120[rbp]
.L102:
	mov	esi, DWORD PTR -112[rbp]
	sub	esi, ecx
	lea	r10d, -1[rsi]
	cmp	r10d, 2
	jbe	.L98
	add	rcx, r8
	vmovups	XMMWORD PTR [rbx+rcx*4], xmm2
	mov	ecx, esi
	and	ecx, -4
	add	edx, ecx
	and	esi, 3
	je	.L97
.L98:
	mov	rcx, QWORD PTR -136[rbp]
	mov	rsi, r8
	sub	rsi, rcx
	movsx	rcx, edx
	add	rcx, rsi
	vmovss	DWORD PTR [rbx+rcx*4], xmm1
	lea	ecx, 1[rdx]
	cmp	ecx, eax
	jge	.L97
	movsx	rcx, ecx
	add	edx, 2
	add	rcx, rsi
	vmovss	DWORD PTR [rbx+rcx*4], xmm1
	cmp	eax, edx
	jle	.L97
	movsx	rdx, edx
	add	rdx, rsi
	vmovss	DWORD PTR [rbx+rdx*4], xmm1
.L97:
	add	r9d, 1
	add	rdi, r14
	add	r8, r12
	cmp	r9d, eax
	jne	.L96
	mov	r15, QWORD PTR -176[rbp]
	mov	r14d, DWORD PTR -184[rbp]
	mov	r10, QWORD PTR -192[rbp]
	mov	r13, QWORD PTR -200[rbp]
	vzeroupper
.L95:
	mov	rdx, r15
	mov	rsi, rbx
	mov	rdi, r13
	mov	QWORD PTR -176[rbp], r10
	call	memcpy@PLT
	mov	eax, r14d
	xor	esi, esi
	lea	r15, -80[rbp]
	imul	eax, r14d
	mov	r10, QWORD PTR -176[rbp]
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
	mov	QWORD PTR -240[rbp], r10
	.p2align 4,,10
	.p2align 3
.L104:
	mov	rsi, r15
	mov	edi, 1
	call	clock_gettime@PLT
	vxorpd	xmm4, xmm4, xmm4
	mov	r12, QWORD PTR -232[rbp]
	mov	rdx, QWORD PTR -248[rbp]
	vcvtsi2sd	xmm0, xmm4, QWORD PTR -80[rbp]
	mov	esi, DWORD PTR -252[rbp]
	vcvtsi2sd	xmm1, xmm4, QWORD PTR -72[rbp]
	mov	rdi, r12
	vfmadd132sd	xmm1, xmm0, QWORD PTR .LC22[rip]
	vmovsd	QWORD PTR -192[rbp], xmm1
	call	synth_signal
	mov	rsi, r15
	mov	edi, 1
	vzeroupper
	call	clock_gettime@PLT
	vxorpd	xmm4, xmm4, xmm4
	mov	ecx, DWORD PTR -104[rbp]
	vcvtsi2sd	xmm0, xmm4, QWORD PTR -80[rbp]
	mov	rdx, QWORD PTR -240[rbp]
	mov	rsi, r12
	mov	rdi, QWORD PTR -160[rbp]
	vcvtsi2sd	xmm1, xmm4, QWORD PTR -72[rbp]
	mov	r12d, 8
	vfmadd132sd	xmm1, xmm0, QWORD PTR .LC22[rip]
	vmovsd	QWORD PTR -184[rbp], xmm1
	call	fir_filter
	mov	rsi, r15
	mov	edi, 1
	call	clock_gettime@PLT
	vxorpd	xmm4, xmm4, xmm4
	mov	rax, r13
	mov	r13, rbx
	vcvtsi2sd	xmm1, xmm4, QWORD PTR -72[rbp]
	mov	rbx, rax
	vcvtsi2sd	xmm0, xmm4, QWORD PTR -80[rbp]
	vfmadd132sd	xmm1, xmm0, QWORD PTR .LC22[rip]
	vmovsd	QWORD PTR -176[rbp], xmm1
	jmp	.L103
	.p2align 4,,10
	.p2align 3
.L109:
	mov	rax, r13
	mov	r13, rbx
	mov	rbx, rax
.L103:
	mov	edx, r14d
	mov	rsi, r13
	mov	rdi, rbx
	call	heat_step.constprop.0
	sub	r12d, 1
	jne	.L109
	mov	rsi, r15
	mov	edi, 1
	call	clock_gettime@PLT
	vxorpd	xmm5, xmm5, xmm5
	xor	esi, esi
	mov	edx, 16384
	vcvtsi2sd	xmm0, xmm5, QWORD PTR -80[rbp]
	mov	r12, QWORD PTR -216[rbp]
	vcvtsi2sd	xmm2, xmm5, QWORD PTR -72[rbp]
	vfmadd132sd	xmm2, xmm0, QWORD PTR .LC22[rip]
	mov	rdi, r12
	vmovsd	QWORD PTR -208[rbp], xmm2
	call	memset@PLT
	mov	rdx, r12
	mov	r12, QWORD PTR -160[rbp]
	mov	esi, DWORD PTR -104[rbp]
	vmovss	xmm1, DWORD PTR .LC23[rip]
	vmovss	xmm0, DWORD PTR .LC24[rip]
	mov	rdi, r12
	call	quantize_hist
	mov	rsi, r15
	mov	edi, 1
	vzeroupper
	call	clock_gettime@PLT
	vxorpd	xmm5, xmm5, xmm5
	mov	esi, DWORD PTR -104[rbp]
	vcvtsi2sd	xmm0, xmm5, QWORD PTR -80[rbp]
	mov	rdi, r12
	vcvtsi2sd	xmm1, xmm5, QWORD PTR -72[rbp]
	vfmadd132sd	xmm1, xmm0, QWORD PTR .LC22[rip]
	vmovsd	QWORD PTR -200[rbp], xmm1
	call	checksum
	mov	esi, DWORD PTR -224[rbp]
	mov	rdi, rbx
	vmovsd	xmm3, xmm0, xmm0
	call	checksum
	mov	edi, 1
	mov	rsi, r15
	vfmadd132sd	xmm0, xmm3, QWORD PTR .LC25[rip]
	vaddsd	xmm3, xmm0, QWORD PTR -168[rbp]
	vmovsd	QWORD PTR -168[rbp], xmm3
	vzeroupper
	call	clock_gettime@PLT
	vxorpd	xmm5, xmm5, xmm5
	vmovsd	xmm6, QWORD PTR -184[rbp]
	vcvtsi2sd	xmm3, xmm5, QWORD PTR -80[rbp]
	vmovsd	xmm7, QWORD PTR -176[rbp]
	add	DWORD PTR -112[rbp], 1
	vcvtsi2sd	xmm0, xmm5, QWORD PTR -72[rbp]
	mov	eax, DWORD PTR -112[rbp]
	vfmadd132sd	xmm0, xmm3, QWORD PTR .LC22[rip]
	vsubsd	xmm3, xmm6, QWORD PTR -192[rbp]
	vaddsd	xmm3, xmm3, QWORD PTR -120[rbp]
	vmovsd	xmm2, QWORD PTR -208[rbp]
	vmovsd	xmm1, QWORD PTR -200[rbp]
	mov	edi, DWORD PTR -220[rbp]
	vmovsd	QWORD PTR -120[rbp], xmm3
	vsubsd	xmm3, xmm7, xmm6
	vaddsd	xmm6, xmm3, QWORD PTR -128[rbp]
	vsubsd	xmm0, xmm0, xmm1
	vsubsd	xmm3, xmm2, xmm7
	vsubsd	xmm2, xmm1, xmm2
	vaddsd	xmm7, xmm3, QWORD PTR -136[rbp]
	vaddsd	xmm3, xmm2, QWORD PTR -144[rbp]
	vaddsd	xmm2, xmm0, QWORD PTR -152[rbp]
	vmovsd	QWORD PTR -128[rbp], xmm6
	vmovsd	QWORD PTR -136[rbp], xmm7
	vmovsd	QWORD PTR -144[rbp], xmm3
	vmovsd	QWORD PTR -152[rbp], xmm2
	cmp	eax, edi
	jne	.L104
	mov	rdi, QWORD PTR -216[rbp]
	mov	r10, QWORD PTR -240[rbp]
	xor	r15d, r15d
	mov	rax, rdi
	lea	rcx, 16384[rdi]
	.p2align 4,,10
	.p2align 3
.L105:
	mov	rdx, r15
	add	rax, 4
	sal	rdx, 5
	sub	rdx, r15
	mov	r15d, DWORD PTR -4[rax]
	add	r15, rdx
	cmp	rax, rcx
	jne	.L105
	vmovsd	xmm0, QWORD PTR -120[rbp]
	vaddsd	xmm1, xmm0, QWORD PTR -128[rbp]
	mov	r9d, r14d
	mov	r8d, r14d
	mov	QWORD PTR -112[rbp], r10
	vaddsd	xmm1, xmm1, QWORD PTR -136[rbp]
	lea	rsi, .LC26[rip]
	mov	edi, 2
	vaddsd	xmm1, xmm1, QWORD PTR -144[rbp]
	vaddsd	xmm2, xmm1, QWORD PTR -152[rbp]
	lea	r12, .LC33[rip]
	vmovsd	QWORD PTR -104[rbp], xmm2
	push	rax
	mov	ecx, DWORD PTR -256[rbp]
	xor	eax, eax
	push	48
	mov	edx, DWORD PTR -220[rbp]
	call	__printf_chk@PLT
	lea	rcx, .LC28[rip]
	xor	eax, eax
	lea	r8, .LC27[rip]
	lea	rdx, .LC29[rip]
	lea	rsi, .LC30[rip]
	mov	edi, 2
	call	__printf_chk@PLT
	vmovsd	xmm4, QWORD PTR .LC31[rip]
	vmovsd	xmm0, QWORD PTR -120[rbp]
	mov	rsi, r12
	lea	rdx, .LC32[rip]
	mov	edi, 2
	mov	eax, 2
	vmulsd	xmm1, xmm4, xmm0
	vdivsd	xmm1, xmm1, QWORD PTR -104[rbp]
	call	__printf_chk@PLT
	vmovsd	xmm0, QWORD PTR -128[rbp]
	vmovsd	xmm5, QWORD PTR .LC31[rip]
	lea	rdx, .LC34[rip]
	mov	rsi, r12
	mov	edi, 2
	mov	eax, 2
	vmulsd	xmm1, xmm5, xmm0
	vdivsd	xmm1, xmm1, QWORD PTR -104[rbp]
	call	__printf_chk@PLT
	mov	rsi, r12
	vmovsd	xmm4, QWORD PTR .LC31[rip]
	vmovsd	xmm0, QWORD PTR -136[rbp]
	mov	edi, 2
	mov	eax, 2
	lea	rdx, .LC35[rip]
	vmulsd	xmm1, xmm4, xmm0
	vdivsd	xmm1, xmm1, QWORD PTR -104[rbp]
	call	__printf_chk@PLT
	mov	rsi, r12
	vmovsd	xmm7, QWORD PTR .LC31[rip]
	vmovsd	xmm0, QWORD PTR -144[rbp]
	mov	edi, 2
	mov	eax, 2
	lea	rdx, .LC36[rip]
	vmulsd	xmm1, xmm7, xmm0
	vdivsd	xmm1, xmm1, QWORD PTR -104[rbp]
	call	__printf_chk@PLT
	mov	rsi, r12
	vmovsd	xmm6, QWORD PTR -152[rbp]
	vmovsd	xmm3, QWORD PTR .LC31[rip]
	mov	edi, 2
	mov	eax, 2
	lea	rdx, .LC37[rip]
	vmovsd	xmm0, xmm6, xmm6
	vmulsd	xmm1, xmm3, xmm6
	vdivsd	xmm1, xmm1, QWORD PTR -104[rbp]
	call	__printf_chk@PLT
	vmovsd	xmm0, QWORD PTR -104[rbp]
	lea	rdx, .LC38[rip]
	lea	rsi, .LC39[rip]
	mov	edi, 2
	mov	eax, 1
	call	__printf_chk@PLT
	vmovsd	xmm0, QWORD PTR -168[rbp]
	mov	rdx, r15
	lea	rsi, .LC40[rip]
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
	mov	rdi, r13
	call	free@PLT
	mov	rdi, QWORD PTR -216[rbp]
	call	free@PLT
	pop	rdx
	xor	eax, eax
	pop	rcx
.L83:
	mov	rdx, QWORD PTR -56[rbp]
	sub	rdx, QWORD PTR fs:40
	jne	.L132
	lea	rsp, -48[rbp]
	pop	rbx
	pop	r10
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	lea	rsp, -8[r10]
	ret
.L108:
	mov	edx, DWORD PTR -144[rbp]
	xor	ecx, ecx
	jmp	.L102
.L130:
	mov	ebx, edi
	mov	rdi, QWORD PTR 8[rsi]
	mov	r12, rsi
	mov	edx, 10
	xor	esi, esi
	call	strtol@PLT
	mov	DWORD PTR -220[rbp], eax
	mov	r13, rax
	cmp	ebx, 2
	je	.L85
	mov	rdi, QWORD PTR 16[r12]
	mov	edx, 10
	xor	esi, esi
	call	strtol@PLT
	mov	DWORD PTR -256[rbp], eax
	mov	r15, rax
	cmp	ebx, 3
	je	.L86
	mov	rdi, QWORD PTR 24[r12]
	mov	edx, 10
	xor	esi, esi
	sub	r15d, 10
	call	strtol@PLT
	mov	r14d, eax
	cmp	r15d, 18
	ja	.L90
	test	r13d, r13d
	jle	.L90
	cmp	eax, 15
	jg	.L84
.L90:
	mov	rcx, QWORD PTR [r12]
	mov	rdi, QWORD PTR stderr[rip]
	lea	rdx, .LC18[rip]
	xor	eax, eax
	mov	esi, 2
	call	__fprintf_chk@PLT
	mov	eax, 2
	jmp	.L83
.L85:
	test	eax, eax
	jle	.L90
	jmp	.L129
.L86:
	sub	r15d, 10
	cmp	r15d, 18
	ja	.L90
	test	r13d, r13d
	jle	.L90
	mov	r14d, 1536
	jmp	.L84
.L132:
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
	.section	.rodata.cst4
	.align 4
.LC20:
	.long	1120403456
	.section	.rodata.cst8
	.align 8
.LC22:
	.long	-400107883
	.long	1041313291
	.section	.rodata.cst4
	.align 4
.LC23:
	.long	1067030938
	.align 4
.LC24:
	.long	-1102263091
	.section	.rodata.cst8
	.align 8
.LC25:
	.long	-1598689907
	.long	1051772663
	.align 8
.LC31:
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

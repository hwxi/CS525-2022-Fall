	.file	"fact_dats.c"
	.text
	.type	atspre_g0int_sub_int, @function
atspre_g0int_sub_int:
.LFB29:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %eax
	subl	-8(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE29:
	.size	atspre_g0int_sub_int, .-atspre_g0int_sub_int
	.type	atspre_g0int_mul_int, @function
atspre_g0int_mul_int:
.LFB30:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %eax
	imull	-8(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE30:
	.size	atspre_g0int_mul_int, .-atspre_g0int_mul_int
	.type	atspre_g0int_gt_int, @function
atspre_g0int_gt_int:
.LFB38:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	setg	%al
	movzbl	%al, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE38:
	.size	atspre_g0int_gt_int, .-atspre_g0int_gt_int
	.type	fact_0, @function
fact_0:
.LFB849:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
.L8:
	endbr64
	movl	-20(%rbp), %eax
	movl	$0, %esi
	movl	%eax, %edi
	call	ATSLIB_056_prelude__gt_g0int_int__1__1
	movl	%eax, -12(%rbp)
	cmpl	$0, -12(%rbp)
	je	.L9
	movl	-20(%rbp), %eax
	movl	$1, %esi
	movl	%eax, %edi
	call	atspre_g0int_sub_int
	movl	%eax, -8(%rbp)
	movl	-8(%rbp), %eax
	movl	%eax, %edi
	call	fact_0
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %edx
	movl	-20(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	atspre_g0int_mul_int
	movl	%eax, -16(%rbp)
	jmp	.L10
.L9:
	movl	$1, -16(%rbp)
.L10:
	movl	-16(%rbp), %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE849:
	.size	fact_0, .-fact_0
	.type	ATSLIB_056_prelude__gt_g0int_int__1__1, @function
ATSLIB_056_prelude__gt_g0int_int__1__1:
.LFB850:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$24, %rsp
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
.L13:
	endbr64
	movl	-24(%rbp), %eax
	movl	%eax, -8(%rbp)
	movl	-8(%rbp), %edx
	movl	-20(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	atspre_g0int_gt_int
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE850:
	.size	ATSLIB_056_prelude__gt_g0int_int__1__1, .-ATSLIB_056_prelude__gt_g0int_int__1__1
	.globl	_057_home_057_hwxi_057_Teaching_057_CS525_055_2022_055_Fall_057_lectures_057_lecture_055_10_055_31_057_fact_056_dats__dynload
	.type	_057_home_057_hwxi_057_Teaching_057_CS525_055_2022_055_Fall_057_lectures_057_lecture_055_10_055_31_057_fact_056_dats__dynload, @function
_057_home_057_hwxi_057_Teaching_057_CS525_055_2022_055_Fall_057_lectures_057_lecture_055_10_055_31_057_fact_056_dats__dynload:
.LFB851:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	_057_home_057_hwxi_057_Teaching_057_CS525_055_2022_055_Fall_057_lectures_057_lecture_055_10_055_31_057_fact_056_dats__dynloadflag(%rip), %eax
	testl	%eax, %eax
	jne	.L18
	movl	$1, _057_home_057_hwxi_057_Teaching_057_CS525_055_2022_055_Fall_057_lectures_057_lecture_055_10_055_31_057_fact_056_dats__dynloadflag(%rip)
	nop
.L18:
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE851:
	.size	_057_home_057_hwxi_057_Teaching_057_CS525_055_2022_055_Fall_057_lectures_057_lecture_055_10_055_31_057_fact_056_dats__dynload, .-_057_home_057_hwxi_057_Teaching_057_CS525_055_2022_055_Fall_057_lectures_057_lecture_055_10_055_31_057_fact_056_dats__dynload
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:

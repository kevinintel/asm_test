	.globl	add_sum
	.type	add_sum, @function
        .text

add_sum:
.LFB0:
	.cfi_startproc #program start
	#endbr64 #TERMINATE BRANCH 64bit
	pushq	%rbp #stack pointer

#+----------------+
#|stack pointer rbp|
#+----------------+

	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16


#8:64bits
#:                :
#|    whatever    | <--- CFA
#+----------------+
#| return address | <--- %rsp == CFA - 8
#+----------------+


#:                :
#|    whatever    | <--- CFA
#+----------------+
#| return address |<- when c call asm, push address
#+----------------+
#| reserved space | <--- %rsp == CFA - 16 ,call site
#+----------------+

	movq	%rsp, %rbp 
#rbp is the base pointer, which points to the base of the current stack frame, and rsp is the stack pointer, which points to the top of the current stack frame.
	.cfi_def_cfa_register 6 #cfa register is rbp
	movq	%rdi, -24(%rbp) #arg0 *(rbp-24) = rdi;
	movq	%rsi, -32(%rbp) #arg1 *(rbp-32) = rsi;
	movq	%rdx, -40(%rbp) #arg2
	movq	-24(%rbp), %rdx #rdx =arg0
	movq	-32(%rbp), %rax #rax = arg1
	addq	%rdx, %rax #add arg0,arg1 to rax

        movq    %rax,%rcx






movq    %rdx,%xmm0
vpbroadcastd %xmm0, %zmm0
#vcvtps2dq %ymm1, %ymm6
#movq    %rax,%zmm0
vpmovdb    %zmm0,%xmm0#xmm0:128bits,lower 64 bits
#movhlps %xmm0,%xmm0 #move hight to lower

#vpmovdb %zmm0,%xmm0


	#movq	%rax, -8(%rbp) #*(rbp-8) = rax
	movq	-40(%rbp), %rax #rax = arg2
	#movq	-8(%rbp), %rdx  #rdx = *(rbp-8)
	movq	%xmm0, (%rax) #*rax=rdx
##        movq  %rax, -40(%rbp)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc # program end
#.LFE0:
#.data_tag:
#	.size	add_sum, .-add_sum
#	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
#	.section	.note.GNU-stack,"",@progbits
#	.section	.note.gnu.property,"a"
#	.align 8
#	.long	 1f - 0f
#	.long	 4f - 1f
#	.long	 5
#0:
#	.string	 "GNU"
#1:
#	.align 8
#	.long	 0xc0000002
#	.long	 3f - 2f
#2:
#	.long	 0x3
#3:
#	.align 8
#4:





section .text
global _start
_start:
	mov rax, 0xFFFFFFFFFFFFFFFF
	shr rax, 4
	
	mov rax, 0xFB00000000000000
	sar rax, 4
	
	mov rax,60
	xor rdi,rdi
	syscall

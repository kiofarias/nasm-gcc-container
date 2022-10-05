section .data;
	codes: db '0123456789abcdef'
	demo1: dq 0x123456789ABCDEF;
	demo2: db 0x01,0x23,0x45,0x67,0x89,0xAB,0xCD,0xEF;
	newline_char: db 10;

section .text;
global _start;

print_newline:
	mov rax, 1;
	mov rdi, 1;
	mov rsi, newline_char;
	mov rdx, 1;
	syscall;
	ret;

print_hex:
	mov rax, rdi; 
	mov rdi, 1;
	mov rdx, 1;
	mov rcx, 64;

iterate:
	push rax;
	sub rcx, 4;
	sar rax, cl;
	and rax, 0xf;
	lea rsi,[codes+rax];
	
	mov rax,1;
	push rcx;
	syscall;

	pop rcx;
	pop rax;
	test rcx,rcx;
	jnz iterate;
	ret;

_start:
	mov rdi, [demo1];
	call print_hex;
	call print_newline;
	
	mov rdi,[demo2];
	call print_hex;
	call print_newline

	mov rax, 60;
	xor rdi,rdi;
	syscall;

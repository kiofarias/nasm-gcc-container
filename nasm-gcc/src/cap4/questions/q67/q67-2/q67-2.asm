%define O_RDONLY 0
%define PROT_READ 0x1
%define MAP_PRIVATE 0x2

section .data
	filename:db 'input.txt', 0
	newline:db 10
		
section .text

global _start

print_newline:
	mov rax, 1
	mov rdi, 1
	mov rsi, newline
	mov rdx, 1
	syscall
	ret

string_length:
	xor rax, rax
.loop:
	cmp byte[rdi + rax], 0
	je .end
	inc rax
	jmp .loop 
.end:
	ret

print_string:
	push rdi
	call string_length
	pop rsi
	mov rdx, rax
	mov rax, 1
	mov rdi, 1
	syscall
	ret	

print_uint: 
	mov rax, rdi
	mov rdi, rsp
	push 0
	sub rsp, 16
	
	dec rdi
	mov r8, 10	
.loop:
	xor rdx, rdx
	div r8
	or dl, 0x30
	dec rdi
	mov [rdi], dl
	test rax, rax
	jnz .loop

	call print_string
	
	add rsp, 24
	ret

parse_uint: 
	mov r8, 10
	xor rax, rax
	xor rcx, rcx
.loop:
	movzx r9, byte[rdi + rcx]
	cmp r9b, '0'
	jb .end
	cmp r9b, '9'
	ja .end
	xor rdx, rdx
	mul r8
	and r9b, 0x0f
	add rax, r9
	inc rcx
	jmp .loop
.end:
	mov rdx, rcx
	ret

exit:
	mov rax, 60
	mov rdi, 0
	syscall
	ret

open_file:
	mov rax, 2
	mov rdi, filename
	mov rsi, O_RDONLY
	mov rdx, 0
	syscall
	ret
	
mmap_file:
	mov r8, rax
	mov rax, 9
	mov rdi, 0
	mov rsi, 4096
	mov rdx, PROT_READ
	mov r10, MAP_PRIVATE
	mov r9, 0
	syscall
	ret

fibonacci:

	push rbp
	mov rbp, rsp
	mov rax, [rbp + 16]
	cmp rax, 0
	je .fibonacci_base
	cmp rax, 1
	je .fibonacci_base
	sub rsp, 16
	mov [rbp-16], rax
	mov qword[rbp-8], 0
	mov rbx, rax

	mov rcx, rbx
	sub rcx, 1
	push rcx
	call fibonacci
	add rsp, 8
	add [rbp-8], rax

	mov rbx, [rsp]
	mov rcx, rbx
	sub rcx, 2
	push rcx
	call fibonacci
	add rsp, 8
	add [rbp-8], rax
	
	mov rax, [rbp-8]	

.fibonacci_base:
	mov rsp, rbp
	pop rbp
	ret


_start:

	call open_file
	call mmap_file
	mov rdi, rax
	call parse_uint
	push rax
	call fibonacci
	mov rdi, rax
	call print_uint
	call print_newline
	call exit
	

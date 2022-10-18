%define O_RDONLY 0
%define PROT_READ 0x1
%define MAP_PRIVATE 0x2

section .data
	filename: dq 'test.txt',0
	message: db 'file size:', 0
	message2:db ' byte(s)', 0
	message3: db 'Content:', 0
	newline: db 10
	stat_buffer: dq 0

section .text

global _start

string_length:
	xor rax,rax
.loop:
	cmp byte [rdi+rax], 0
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

print_newline:
	mov rax, 1
	mov rdi, 1
	mov rsi, newline
	mov rdx, 1
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

exit: 
	mov rax, 60;
	xor rdi,rdi;
	syscall; 
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


file_size:
	mov rax, 4;
	mov rdi, filename;
	mov rsi, stat_buffer;
	syscall;
	
	mov rdi, message
	call print_string

	mov rdi, [stat_buffer+48]
	call print_uint
	
	mov rdi, message2
	call print_string

	call print_newline 	
	ret

_start:
	call file_size	
	
	mov rdi, message3
	call print_string
	call print_newline	

	call open_file

	call mmap_file	

	mov rdi, rax
		
	call print_string

	call exit
	 


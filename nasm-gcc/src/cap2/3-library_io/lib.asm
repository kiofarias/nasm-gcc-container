global _start;
section .data;
	string: db 'ola';

section .text;

exit:
	xor rdi,rdi;
	mov rax,60;
	syscall;
	ret;

string_length:
	xor rax,rax;
.loop:
	cmp byte [rdi+rax],0;
	je .end;
	inc rax;
	jmp .loop;
.end:
	ret;

print_string:
	push rdi;
	call string_length;
	pop rsi;
	mov rdx, rax;
	mov rax, 1;
	mov rdi, 1;
	syscall;
	ret;	

print_char:
	push rdi;
	mov rdi, rsp;
	call print_string;
	pop rdi;
	ret;

print_newline:
    	mov rdi,0xA;
	call print_char;
	ret;

print_uint:
	mov rax, rdi;
	mov rdi, rsp;	
	mov r8, 10;
	push 0;
	sub rsp, 16;
	dec rdi;

.loop:
	xor rdx, rdx;
	div r8;
	or dl, 0x30;
	dec rdi;
	mov [rdi], dl;
	test rax,rax;
	jnz .loop;
	
	call print_string;
	
	add rsp, 24;
	ret;

print_int:
	test rdi, rdi;
	jns .positive;
	jmp .negative;
.positive:
	call print_uint;
	ret;
.negative:
	push rdi;
	mov rdi, '-';
	call print_char;
	pop rdi;
	neg rdi;
	call print_uint;
	ret;

read_char:

	push 0;
	xor rax, rax;
	xor rdi, rdi;
	mov rsi, rsp;
	mov rdx, 1;
	syscall;
	pop rax;
	ret;

_start:
	mov rdi, string;
	mov rsi, 4;
	call read_word;
	call exit;

read_word:
    	push r14;
	push r15;
	xor r14, r14;
	mov r15, rsi;
	dec r15;

.A:
	push rdi;
	call read_char;
	pop rdi;

	cmp al, ' ';
	je .A;
	cmp al, 10;
	je .A;
	cmp al, 13;
	je .A;
	cmp al, 9;
	je .A;
	test al, al;
	
.B:
	mov byte [rdi+r14], al;
	inc r14;

	push rdi;
	call read_char;
	pop rdi;
	cmp al, ' ';
	je .C;
	cmp al, 10;
	je .C;
	cmp al, 13;
	je .C;
	cmp al, 9;
	je .C;
	test al, al;
	jz .C;
	cmp r14, r15;
	je .D;
	
	jmp .B;

.C:
	mov byte [rdi+r14], al;
	mov rax, rdi;

	mov rdx, r14;
	pop r15;
	pop r14;
	ret;

.D:
	xor rax, rax;
	pop r15;
	pop r14;
	ret;

 
string_equals:
    xor rax, rax
    ret


; rdi points to a string
; returns rax: number, rdx : length
parse_uint:
    xor rax, rax
    ret

; rdi points to a string
; returns rax: number, rdx : length
parse_int:
    xor rax, rax
    ret 


string_copy:
    ret

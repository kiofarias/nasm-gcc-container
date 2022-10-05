global _start;

section .text

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

_start:
	call read_char;
	call exit;

read_char:
	push 0;
	xor rax, rax;
	xor rdi, rdi;
	mov rsi, rsp;
	mov rdx, 1;
	syscall;
	pop rax;
	ret;

read_word:
    ret
 
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

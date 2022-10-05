section .data;

	test: dq -1;

section .text;

global _start;

_start:
	mov byte[test],1;1
	mov word[test],1;2
	mov dword[test],1;4
	mov qword[test],1;8


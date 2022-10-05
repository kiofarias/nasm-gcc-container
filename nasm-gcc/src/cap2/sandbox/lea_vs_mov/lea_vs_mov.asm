section .data
codes:
	db	'0123456789ABCDEF'

section .text
global _start
_start:
	;rsi <- endereco do rotulo 'codes', um numero
	mov rsi, codes;
	
	;rsi <- conteudo da memoria, comecando no endereco 'codes'
	;8 bytes consecutivos sao obtidos porque o tamanho de rsi e de 8 bytes
	mov rsi,[codes];

	;rsi <- endereco de 'codes'
	;neste caso, e equivalente a mov rsi, codes
	lea rsi,[codes];

	;rsi <- conteudo da memoria comecando em (codes+rax)
	mov rax,2;
	mov rsi,[codes+rax];

	;rsi <- codes+rax
	;equivalente a combinacao:
	;-- mov rsi, codes
	;-- add rsi,rax
	;nao e possivel fazer isso em um unico mov!
	lea rsi, [codes+rax];

	mov rax, 60;
	xor rdi,rdi;
	syscall;

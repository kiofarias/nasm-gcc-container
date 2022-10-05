section .data;
	newline_char: db 10;
	codes: db '0123456789abcdef';

section .text;
global _start;

print_newline:
	mov rax, 1;identificador da syscall 'write'
	mov rdi, 1;descritor do arquivo stdout
	mov rsi, newline_char; newline armazena o endereco onde esta o dados para impressao
	mov rdx, 1;quantidade de bytes que serao impressos
	syscall;
	ret;

print_hex:
	mov rax, rdi;carrega as informacoes do que devera ser impresso 
	mov rdi, 1;escritor do arquivo stdout
	mov rdx, 1;quantidade de bytes que serao impressos
	mov rcx, 64;valor representa ate que ponto deslocaremos rax
;iteracao que passara por todos os caracteres que foram armazenados em rax
iterate:
	push rax;salva o valor inicial de rax
	sub rcx, 4;
	sar rax, cl;desloca para 60,56,52,...,4,0
	and rax, 0xf;pega somente o ultimos 4 bits menos significativos
	lea rsi,[codes+rax];obtem o codigo do caractere que representa o digito que queremos em codes
	
	mov rax,1;identificador da funcao 'write'
	push rcx;rcx dev ser armazenado porque syscall altera valores de rcx e r11
	syscall;

	pop rcx;recupera rcx
	pop rax;recupera o valor original de rax
	test rcx,rcx;teste para rcx igual a zero
	jnz iterate;
	ret;

_start:
	mov rdi, 0x1122334455667788
	call print_hex;
	call print_newline;

	mov rax, 60;
	xor rdi,rdi;
	syscall;

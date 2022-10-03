section .data
codes:
	db	'0123456789ABCDEF',10

section .text

global _start
_start:
	;n√mero 1122... em formato hexadecimal
	mov rax, 0x1122334455667788;

	mov rdi,1;
	mov rdx,1;
	mov rcx,64;
	;Cada 4 bits devem ser exibidos como um d√gito hexadecimal
	;Use o deslocamento (shift) e a opera√√o bit a bit AND para isol√-los
	;o resultado √©o offset no array 'codes'
.loop:
	push rax;
	sub rcx,4;
	;cl √ um registrador, a parte menor de rcx
	;rax -- ecx -- ax -- ah + al
	;rcx -- ecx -- cx -- ch + cl
	sar rax,cl;
	and rax,0xf;

	lea rsi,[codes + rax];
	mov rax,1;

	;syscall deixa rcx e r11 alterados
	push rcx;
	syscall;
	pop rcx;

	pop rax;
	;test pode ser executado para uma verifica√√o mais r√pida do tipo '√ um zero?'
	;consulte a documenta√√o do comando 'test'
	test rcx,rcx;
	jnz .loop;

final:
	mov rax,1;
	lea rsi,[codes+0x10];
	syscall;
	mov rax,60;
	xor rdi,rdi;
	syscall;


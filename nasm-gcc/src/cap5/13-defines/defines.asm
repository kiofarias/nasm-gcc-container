%define i 1

%define d i*3
%xdefine xd i*3
%assign a i*3

mov rax, d
mov rax, xd
mov rax, a

; vamos redefinir i
%define i 100

mov rax, d
mov rax, xd
mov rax, a



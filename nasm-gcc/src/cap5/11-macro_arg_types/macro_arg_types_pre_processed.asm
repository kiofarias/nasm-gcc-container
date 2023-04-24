%line 15+1 macro_arg_types.asm
myhello: db 'hello',10, 0
_start:
%line 3+1 macro_arg_types.asm
 mov rdi, myhello
 call print_string
%line 7+1 macro_arg_types.asm
 mov rdi, 42
 call print_uint
%line 19+1 macro_arg_types.asm
 mov rax, 60
 syscall

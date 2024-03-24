extern is_prime
section .text
global _start
_start:
    mov rax, 97
    call is_prime

    mov rax, 60
    xor rdi, rdi
    syscall
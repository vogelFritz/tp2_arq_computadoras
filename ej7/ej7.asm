extern is_prime
section .text
global _start
_start:
    mov rax, 39
    call is_prime

    mov rax, 60
    xor rdi, rdi
    syscall
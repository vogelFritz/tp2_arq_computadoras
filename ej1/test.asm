section .text
global _start
_start:

    mov rax, 60
    xor rdx, rdx
    syscall
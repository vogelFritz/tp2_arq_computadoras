extern turned_bits_amount
extern print_unsigned_int
section .text
global _start
_start:
    mov rax, 15
    call turned_bits_amount

    mov rax, rdx
    call print_unsigned_int

    mov rax, 60
    xor rdi, rdi
    syscall
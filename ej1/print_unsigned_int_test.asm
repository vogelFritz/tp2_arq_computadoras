extern print_unsigned_int
section .text
global _start
_start:
    
    call print_loop

    mov rax, 60
    xor rdi, rdi
    syscall

print_loop:
    ; setup
    mov rax, 1
    xor rcx, rcx
main_loop:
    cmp rcx, 10
    jge end_loop
    push rcx
    call print_unsigned_int
    inc rax
    pop rcx
    inc rcx
    jmp main_loop

end_loop:
    ret
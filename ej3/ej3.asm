section .text
global _start
_start:
    ; Epilogue
    push rbp
    mov rbp, rsp

    sub rsp, 2

    mov eax, 60

    xor rbx, rbx
    mov rbx, 1
    shl rbx, 31
    xor rcx, rcx

    call main_loop

    mov byte [rbp - 2], 10
    mov byte [rbp - 1], 0

    mov rax, 1 ; syswrite
    mov rdi, 1 ; stdout
    lea rsi, [rbp - 2]
    mov rdx, 2
    syscall

    ; Prologue
    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall

main_loop:
    cmp rcx, 32
    jge end_loop
    push rcx

    xor rsi, rsi
    xor rdx, rdx

    xor rdi, rdi
    mov esi, eax
    push rax
    and esi, ebx
    shr rbx, 1
    call store_bit
    ; rdx contains the bit
    add rdx, 48 ; convert to ascii
    mov byte [rbp - 2], dl
    mov byte [rbp - 1], 0

    push rax
    push rsi
    push rdx
    mov rax, 1 ; syswrite
    mov rdi, 1 ; stdout
    lea rsi, [rbp - 2]
    mov rdx, 2
    syscall
    pop rdx
    pop rsi
    pop rax


    pop rax
    pop rcx
    call print_space
    inc rcx
    jmp main_loop

end_loop:
    ret

store_bit:
    test esi, esi
    jz store_zero
    mov rdx, 1
    ret

store_zero:
    xor rdx, rdx
    ret

print_space:
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi

    xor rdx, rdx
    mov rax, rcx
    add rax, 1
    mov rbx, 4
    div ebx
    cmp rdx, 0
    jne cancel_print_space
    

    mov byte [rbp - 2], ' '
    mov byte [rbp - 1], 0
    mov rax, 1 ; syswrite
    mov rdi, 1 ; stdout
    lea rsi, [rbp - 2]
    mov rdx, 2
    syscall
cancel_print_space:
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret
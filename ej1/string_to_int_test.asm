extern string_to_int
extern print_unsigned_int
section .data
    successStr: db "Success", 10, 0
    successLen: equ $-successStr
section .text
global _start
_start:
    push rbp
    mov rbp, rsp

    sub rsp, 8
    
    mov byte [rbp - 8], '-'
    mov byte [rbp - 7], '4'
    mov byte [rbp - 6], '3'
    mov byte [rbp - 5], 10
    mov byte [rbp - 4], 0
    
    lea rsi, [rbp - 8]
    call string_to_int

    call print_info

    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall

print_info:
    xor rsi, rsi
    mov esi, eax
    xor rax, rax
    mov eax, esi
    call print_unsigned_int
    cmp eax, -43
    je print_success
    mov byte [rbp - 8], 'N'
    mov byte [rbp - 7], 10
    mov byte [rbp - 6], 0
    mov rax, 1 ; syswrite
    mov rdi, 1 ; stdout
    lea rsi, [rbp - 8]
    mov rdx, 3
    syscall
    ret
print_success:
    mov byte [rbp - 8], 'S'
    mov byte [rbp - 7], 10
    mov byte [rbp - 6], 0
    mov rax, 1 ; syswrite
    mov rdi, 1 ; stdout
    mov rsi, successStr
    mov rdx, successLen
    syscall
    ret
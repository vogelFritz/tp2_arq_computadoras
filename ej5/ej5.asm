extern print_unsigned_int
extern multiply
section .data
    INVALID_PARAM: db "condition rax >= 0 must be met", 10, 0
    MSG_LEN: equ $-INVALID_PARAM
section .text
global _start
_start:
    mov rax, 8
    call factorial

    mov rax, rbx
    call print_unsigned_int

    mov rax, 60
    xor rdi, rdi
    syscall

; Parameters
; rax: number
; Output
; rbx: factorial of number in rax
factorial:
    ; Setup
    cmp rax, 0
    jl invalid_parameter
    je zero_case
    mov rbx, rax
    mov rcx, rax
    dec rcx
    
main_loop:
    cmp rcx, 2
    jl end_loop

    xor rax, rax
    call multiply
    mov rbx, rax

    dec rcx
    jmp main_loop
end_loop:
    ret

zero_case:
    mov rax, 1
    ret

invalid_parameter:
    mov rax, 1
    mov rdi, 1
    mov rsi, INVALID_PARAM
    mov rdx, MSG_LEN
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall
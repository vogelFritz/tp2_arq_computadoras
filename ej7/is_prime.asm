section .text
global is_prime

; Parameters
; rax: natural number
is_prime:
    ; calculate half
    push rax
    xor rdx, rdx
    mov rbx, 2
    div ebx
    mov rbx, rax
    pop rax
    ; rbx contains the half

    ; counter
    mov rcx, rbx ; Start from the half

main_loop:
    ; each iteration tests a number
    cmp rcx, 2
    jl asserted_prime

    push rax
    xor rdx, rdx
    mov rbx, rcx
    div ebx
    test edx, edx
    pop rax
    jz not_prime 

    dec rcx
    jmp main_loop
    
asserted_prime:
    push rbp
    mov rbp, rsp

    sub rsp, 3

    mov byte [rbp - 3], '1'
    mov byte [rbp - 2], 10
    mov byte [rbp - 1], 0
    mov rax, 1
    mov rdi, 1
    lea rsi, [rbp - 3]
    mov rdx, 3
    syscall

    mov rsp, rbp
    pop rbp

    ret

not_prime:
    push rbp
    mov rbp, rsp

    sub rsp, 3

    mov byte [rbp - 3], '0'
    mov byte [rbp - 2], 10
    mov byte [rbp - 1], 0
    mov rax, 1
    mov rdi, 1
    lea rsi, [rbp - 3]
    mov rdx, 3
    syscall

    mov rsp, rbp
    pop rbp

    ret
extern get_array_from_user
extern print_unsigned_int
section .text
global _start

_start:
    push rbp
    mov rbp, rsp

    sub rsp, 40

    lea rsi, [rbp - 40]
    mov rdx, 10
    call get_array_from_user

    call array_average

    call print_unsigned_int

    mov rsp, rbp
    pop rbp

    call end_program

; Parameters
; rsi: memory address of array
; Output
; rax: average
array_average:
    ; Setup
    xor rcx, rcx
    lea rsi, [rbp - 40]
    xor rax, rax

    call sum_loop

    ; Setup registers for division
    xor rdx, rdx
    mov rbx, 5
    ; rax already contains the number
    div ebx ; dword division

    ; Now rax contains the average
    ret

sum_loop:
    cmp rcx, 5
    jge end_loop

    add rax, [rsi + rcx * 4]

    inc rcx
    jmp sum_loop

end_loop:
    ret


end_program:
    mov rax, 60
    mov rdi, 0
    syscall
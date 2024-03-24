extern print_unsigned_int
extern get_array_from_user
section .text
global _start
_start:
    push rbp
    mov rbp, rsp

    sub rsp, 40

    lea rsi, [rbp - 40]
    mov rdx, 10
    call get_array_from_user

    lea rsi, [rbp - 40]
    call parse_binary_list

    ; rax contains the number
    call print_unsigned_int

    lea rsi, [rbp - 40] ; This line solved the problem
    call parse_binary_list_inverse

    call print_unsigned_int

    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall

; Parameters
; rsi: memory address of list
; Output
; rax: resulting int
parse_binary_list:
    ; Setup
    xor rax, rax
    xor rcx, rcx
array_loop:
    cmp rcx, 5
    jge end_loop

    add eax, dword [rsi + rcx * 4]
    shl rax, 1

    inc rcx
    jmp array_loop

end_loop:
    shr rax, 1
    ret


parse_binary_list_inverse:
    ; Setup
    xor rax, rax
    mov rcx, 4
inverse_binary_loop:
    cmp rcx, 0
    jl end_inverse_loop

    add eax, dword [rsi + rcx * 4]
    shl rax, 1

    dec rcx
    jmp inverse_binary_loop

end_inverse_loop:
    shr rax, 1
    ret
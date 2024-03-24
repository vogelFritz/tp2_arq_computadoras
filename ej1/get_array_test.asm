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
    push rsi
    call get_array_from_user
    pop rsi

    call print_array

    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall

; Parameters
; rsi: int[]
; rdx: size
print_array:
    ; setup
    xor rcx, rcx ; counter
main_loop:
    cmp rcx, 4
    jg end_loop
    xor rax, rax
    mov eax, dword [rsi + rcx * 4]
    push rcx
    push rsi
    call print_unsigned_int
    pop rsi
    pop rcx
    inc rcx
    jmp main_loop
end_loop:
    ret
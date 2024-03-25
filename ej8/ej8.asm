extern get_array_from_user
extern turned_bits_amount
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

    call for_each

    mov rsp, rbp
    pop rbp

    mov rax, 60
    xor rdi, rdi
    syscall

for_each:
    ; Setup
    xor rcx, rcx ; counter
main_loop:
    cmp rcx, 5
    jge end_loop

    push rcx
    xor rax, rax
    mov eax, [rsi + rcx * 4]
    call turned_bits_amount

    mov rax, rdx
    push rsi
    call print_unsigned_int
    pop rsi


    pop rcx
    inc rcx
    jmp main_loop
end_loop:
    ret


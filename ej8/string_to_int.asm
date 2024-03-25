section .text
global string_to_int

; Parameters
; rsi: Memory address of char[]
; Output
; eax: Resulting int
string_to_int:
    ; Setup
    push rsi ; Avoid changing input parameters
    push rdx

    push rbx
    push rcx
    push rdi

    xor rax, rax
    xor rcx, rcx

    call negative_number

    push rbx ; rbx contains the sign
    call main_loop ; deals with string as it was a positive number
    pop rbx

    call deal_with_sign

    pop rdi
    pop rcx
    pop rbx
    pop rdx
    pop rsi

    ret

main_loop:
    xor rdi, rdi
    mov dil, byte [rsi + rcx]
    cmp rdi, 0
    je end_loop
    cmp rdi, 10
    je end_loop

    xor rbx, rbx
    mov bl, byte [rsi + rcx]
    sub rbx, 48
    imul rax, rax, 10
    add rax, rbx
    inc rcx
    jmp main_loop

end_loop:
    ret

negative_number:
    xor rbx, rbx
    cmp byte [rsi], '-'
    je store_sign
    ret

store_sign:
    inc rbx
    inc rsi
    ret

deal_with_sign:
    cmp rbx, 1
    je complement_2
    ret

complement_2:
    not rax
    inc rax
    ret

section .text
global turned_bits_amount

; Parameters
; rax: number
; Output
; rdx: amount of turned bits
turned_bits_amount:
    ; Setup
    push rbx
    push rcx ; avoid changing outside value
    mov rcx, 32 ; loop counter
    xor rdx, rdx ; turned bits counter
    mov rbx, 1 ; mask

turned_bits_loop:
    cmp rcx, 0
    jle end_turned_bits_loop

    push rax
    and rax, rbx
    cmp rax, 0
    call update_counter
    pop rax

    shl rbx, 1
    dec rcx
    jmp turned_bits_loop

update_counter:
    cmp rax, 0
    jne inc_counter
    ret

inc_counter:
    inc rdx
    ret



end_turned_bits_loop:
    pop rcx
    pop rbx
    ret

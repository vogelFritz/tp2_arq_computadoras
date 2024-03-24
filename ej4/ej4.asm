extern print_unsigned_int
section .text
global multiply
global _start
_start:
    mov bx, 3
    mov cx, 18
    call multiply

    call print_unsigned_int

    mov rax, 60
    xor rdi, rdi
    syscall

; Parameters
; bx: first operand
; cx: second operand
; Output
; ax: product
multiply:
    ; Setup
    xor rax, rax
    xor rdx, rdx
    mov dx, cx
main_loop:
    cmp rdx, 0
    jle end_loop

    add ax, bx

    dec rdx
    jmp main_loop

end_loop:
    ret
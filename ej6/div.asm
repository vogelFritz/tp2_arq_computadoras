section .text
global divide

; Parameters
; bx: dividend
; cx: divisor
; Output
; ax: result
; dx: remainder
divide:
    ; Setup
    push rbx
    xor rax, rax
    xor rdx, rdx
    mov dx, bx
main_loop:
    cmp dx, cx
    jl end_loop

    sub dx, cx
    inc rax

    dec rdi
    jmp main_loop
end_loop:
    pop rbx
    ret
section .data
    msg: db "hola", 10
    msgLen: equ $-msg 
section .bss
    buffer: resb 10
    bufferLen: equ $-buffer
section .text
    global _start

    _start:
        mov rax, 10
        mov bx, 5
        div bx

        mov ah, 10
        add al, '0'
        mov [buffer], word ax

        shl rax, 48
        ;mov [0x0], qword rax
        mov rsi, buffer
        mov rax, 1 ; sys_write
        mov rdi, 1 ; stdout
        ; mov rdx, 2 ; message length
        mov rdx, 2
        syscall

        ; end
        mov rax, 60
        xor rdi, rdi
        syscall
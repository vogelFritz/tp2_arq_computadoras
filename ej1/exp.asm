section .bss ; Variables that might change during the life cycle of the app
section .data ; constants
    hello: db "Hi Mom!", 10
    helloLen: equ $-hello ; Length of string
section .text
    global _start ; entry point for linker

    _start: 

        mov rax, 1 ; sys_write
        mov rdi, 1 ; stdout

        mov rsi, hello ; message to write
        mov rdx, helloLen ;message length
        syscall

        ; end program
        mov rax, 60 ; sys_exit
        mov rdi, 0 ; error code 0 (sucess)
        syscall


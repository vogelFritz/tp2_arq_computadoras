section     .text       ; Create the text section
global      _start      ; Has to be declared for the linker
_start:                 ; The start section begins
    mov edx, len
    mov ecx, msg
    mov ebx, 1
    mov eax, 4
    int 0x80
    mov eax, 1
    int 0x80
section     .data       ; Create the data section
    msg db "Hello world!", 0xa  ; 0xa --> new line
    len equ $ -msg
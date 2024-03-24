extern divide
section .data
    FAILED_MSG: db "Failed test", 10, 0
    MSG_LEN equ $-FAILED_MSG
    SUCCESS: db "Test passed", 10, 0
    SUCCESS_LEN: equ $-SUCCESS
    DID_NOT_THROW: db "Failed test: Exception expected", 10, 0
    DID_NOT_THROW_LEN: equ $-DID_NOT_THROW
section .text
global _start
_start:
    ; Test bx<-5 cx<-2
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx
    mov bx, 5
    mov cx, 2
    call divide
    mov bx, 2
    call assert_equal
    mov ax, dx
    mov bx, 1
    call assert_equal

    ; Test bx<-43, cx<-7
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx
    mov bx, 43
    mov cx, 7
    call divide
    mov bx, 6
    call assert_equal
    mov ax, dx
    mov bx, 1
    call assert_equal

    mov rax, 60
    xor rdi, rdi
    syscall

; Parameters
; ax: actual
; bx: expected
assert_equal:
    cmp ax, bx
    jne failed_test

    push rdx
    mov rax, 1
    mov rdi, 1
    mov rsi, SUCCESS
    mov rdx, SUCCESS_LEN
    syscall
    pop rdx
    ret

failed_test:
    push rdx
    mov rax, 1
    mov rdi, 1
    mov rsi, FAILED_MSG
    mov rdx, MSG_LEN
    syscall
    pop rdx
    ret

did_not_throw:
    mov rax, 1
    mov rdi, 1
    mov rsi, DID_NOT_THROW
    mov rdx, DID_NOT_THROW_LEN
    syscall
    ret
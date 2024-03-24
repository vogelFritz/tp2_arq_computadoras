extern string_to_int
section .text
global get_array_from_user

; Parameters
; rsi: memory address of array (int array[])
; rdx: length of array (int n)
get_array_from_user:
    ; Setup

    ; Prologue: Allocate space for local variables on the stack
    push rbp        ; Save the base pointer
    mov rbp, rsp    ; Set the base pointer to the current stack pointer

    ; Allocate space for local variables
    sub rsp, 100      ; 100 bytes so max 99 chars and endl

    push rsi ; Avoid changing parameters
    push rdx

    push rax ; Avoid changing other registers
    push rbx
    push rcx
    push rdi
    xor rcx, rcx ; Clear counter

    call main_loop

    pop rdi
    pop rcx
    pop rbx
    pop rax
    pop rdx
    pop rsi

    ; Epilogue: Restore the stack pointer and base pointer
    mov rsp, rbp    ; Restore the stack pointer
    pop rbp         ; Restore the base pointer

    ret

; In each iteration one number is stored
main_loop:
    cmp rcx, rdx
    jge end_loop ; End if there is no more space
    push rcx
    
    ; Get ascii input
    push rsi
    push rdi
    xor rax, rax ; sysread
    xor rdi, rdi ; stdin
    lea rsi, [rbp - 100]
    mov rdx, 90 ; bytes to store
    syscall
    pop rdi
    
    ; Parse to get int in eax
    call string_to_int
    pop rsi

    test eax, eax ; eax is the parsed int
    js end_loop ; If negative end loop

    mov dword [rsi], eax ; Store natural number

    add rsi, 4 ; Position for next 4 bytes
    pop rcx
    inc rcx    ; Increment counter
    jmp main_loop

end_loop:
    pop rcx
    ret
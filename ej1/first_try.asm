section .data
section .bss
    buffer: resb 20
    bufferLen: equ $-buffer
    numbers: resd 10
    numbersCount: resd 1
section .text
    global _start

    _start:
        mov dword [numbersCount], 0 ; Initialize numbersCount to 0
        call getArrayFromInput

        call int_to_str
        
        call print_result

        call end_program

    getArrayFromInput:
        xor ecx, ecx ; Clear ecx to use it as a loop counter
    read_loop:
        push rcx
        call readInput
        pop rcx
        mov byte [rsi + rax], 0
        xor rax, rax
        call str_to_int
        ; after str_to_int finishes, eax has the number

        ; test if the number is negative
        test eax, eax
        js end_read_loop

        call store_number

        ; Increment loop counter and repeat
        inc ecx
        jmp read_loop

    
    store_number:
        mov ebx, dword [numbersCount] ; load current count of numbers
        mov dword [numbers + ebx*4], eax ; Store the number in the array
        inc dword [numbersCount] ; Increment the count of numbers
        cmp dword [numbersCount], 10 ; Check if we've reached the limit
        jge end_read_loop ; If yes, exit the loop
        ret

    end_read_loop:
        ret

    str_to_int:
        xor eax, eax ; Clear eax to store the result
        xor ebx, ebx ; ebx to store the sign (0 positive, 1 negative)
        mov rsi, buffer
        movzx edi, byte [rsi] ; load character
        cmp edi, '-' ; check for negative sign
        je str_to_int_negative

    str_to_int_loop:
        mov dil, byte [rsi] ; Load the next character
        test edi, edi ; Check for null terminator
        jz str_to_int_done
        cmp edi, '0'
        jl str_to_int_done
        cmp edi, '9'
        jg str_to_int_done
        imul eax, eax, 10
        sub edi, '0'
        add eax, edi
        inc rsi
        jmp str_to_int_loop

    str_to_int_done:
        test ebx, ebx ; check if the number is negative
        jz str_to_int_not_negative
        
        neg eax
        ret
        
    str_to_int_negative:
        inc rsi
        mov ebx, 1 ; indicate negative sign
        jmp str_to_int_loop

    str_to_int_not_negative:
        ret

    readInput:
        xor eax, eax ; sys_read
        xor edi, edi ; stdin
        mov rsi, buffer
        mov edx, bufferLen
        syscall
        ret

    print_result:
        mov rax, 1 ; sys_write
        mov rdi, 1 ; stdout
        mov rsi, buffer ; message to write
        mov rdx, numbersCount ; message length
        syscall
        ret

    int_to_str:
        ; The resulting string will be stored in 'buffer'
        mov rsi, buffer ; Ensure rsi points to the buffer
        xor rcx, rcx ; set counter to 0
        
    ; stores one number from the numbers array in each iteration
    int_to_str_loop:
        mov ebx, dword [numbers + rcx*4] ; store the current number in ebx
        push rcx ; push to stack to get it back later
        call store_positive_number
        pop rcx ; get back the stored value
        cmp rcx, numbersCount
        jge int_to_str_loop_end
        inc rcx
        jmp int_to_str_loop

    int_to_str_loop_end:
        mov [rsi], byte 10
        inc rsi
        mov [rsi], byte 0
        ret

    store_positive_number:
        ; get the digit
        mov eax, ebx ; using eax as aux register to not modify the value in ebx
        mov ecx, 0 ; initialize the counter that will contain the digit
        mov edx, 9 ; initialize aux register to get most significant digit
        call get_most_significant_digit_loop
        xor edx, edx ; initialize counter
        push rbx
        call get_digit
        pop rbx
        add eax, 48 ; eax contains the digit in complement 2, adding 48 to convert to ascii
        mov [rsi], byte al
        inc rsi
        ret

    get_most_significant_digit_loop:
        cmp ebx, edx
        jg increase_edx
        ret

    increase_edx:
        imul edx, edx, 10
        add edx, 9
        inc ecx
        jmp get_most_significant_digit_loop

    get_digit:
        mov rbx, 10
        push rdx
        xor rdx, rdx
        div rbx
        pop rdx
        cmp edx, ecx
        jl increase_digit_ctr
        ret

    increase_digit_ctr:
        inc edx
        jmp get_digit

    end_program:
        mov rax, 60
        mov rdi, 0
        syscall

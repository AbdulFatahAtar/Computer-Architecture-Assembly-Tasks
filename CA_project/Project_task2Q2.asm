section .data
    ; This section store prime numbers we use for factorial
    primes dd 2, 3, 5, 7, 11  

    msg1 db "2! = ", 0
    msg2 db "3! = ", 0
    msg3 db "5! = ", 0
    msg4 db "7! = ", 0
    msg5 db "11! = ", 0
    newline db 10
    buffer db 20             

section .bss
    ; Reserve space to store the result of factorial
    int_result resd 1

section .text
    global _start

; This subroutine calculates factorial of a number in eax
factorial:
    mov ecx, eax            
    dec ecx                 
    cmp ecx, 0
    jle .done
.loop:
    mul ecx                 
    dec ecx
    cmp ecx, 0
    jg .loop
.done:
    ret

; This subroutine calculates prime factorials and prints them
Primer:
    mov esi, primes         

    ; Calculate 2!
    mov eax, [esi]
    call factorial
    mov [int_result], eax
    mov ecx, msg1
    call print_msg_and_number

    ; Calculate 3!
    add esi, 4
    mov eax, [esi]
    call factorial
    mov [int_result], eax
    mov ecx, msg2
    call print_msg_and_number

    ; Calculate 5!
    add esi, 4
    mov eax, [esi]
    call factorial
    mov [int_result], eax
    mov ecx, msg3
    call print_msg_and_number

    ; Calculate 7!
    add esi, 4
    mov eax, [esi]
    call factorial
    mov [int_result], eax
    mov ecx, msg4
    call print_msg_and_number

    ; Calculate 11!
    add esi, 4
    mov eax, [esi]
    call factorial
    mov [int_result], eax
    mov ecx, msg5
    call print_msg_and_number

    ret

; This subroutine prints message then number
print_msg_and_number:
    mov eax, 4
    mov ebx, 1
    mov edx, 5
    int 0x80

    ; Convert number to string
    mov eax, [int_result]
    mov ecx, buffer
    add ecx, 19
    mov byte [ecx], 0
.convert_loop:
    xor edx, edx
    mov ebx, 10
    div ebx
    add dl, '0'
    dec ecx
    mov [ecx], dl
    test eax, eax
    jnz .convert_loop

    ; Print number
    mov eax, 4
    mov ebx, 1
    mov edx, buffer + 20
    sub edx, ecx
    mov ecx, ecx
    int 0x80

    ; Print newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ret

_start:

    ; This block calls Primer to calculate and print results
    call Primer

    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80

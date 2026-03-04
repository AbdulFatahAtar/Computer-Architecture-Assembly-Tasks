section .data
    ; This section define the values for A, T and R from my last name ATAR
    A dd 2
    T dd 3
    R dd 4
    constant dd 5
    msg db "Result is: ", 0
    newline db 10
    buffer db 20

section .bss
    final_result resd 1

section .text
    global _start

_start:

    ; This block calculate A^2 and store it in eax
    mov eax, [A]
    imul eax, eax

    ; This block add T to the result
    add eax, [T]

    ; This block calculate R * A and add to result
    mov ebx, [R]
    imul ebx, [A]
    add eax, ebx

    ; This block add the constant value 5
    add eax, [constant]

    ; Store the final result
    mov [final_result], eax

    ; Print the message
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, 11
    int 0x80

    ; This block convert number to text so we can print it
    mov eax, [final_result]
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

    ; Print the number
    mov eax, 4
    mov ebx, 1
    mov edx, buffer + 20
    sub edx, ecx
    mov ecx, ecx
    int 0x80


    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80

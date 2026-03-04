; This section define pi as a float, R value and b value
section .data
    pi dd 3.14          
    R dd 5.0                  
    b dd 2.0                  
    half dd 2.0               
    msg db "The result is: ", 0
    newline db 10             
    buffer db 20              

section .bss
    ; Reserve space to store the integer result
    int_result resd 1         

section .text
    global _start

; This subroutine calculates A = (pi * R^2 * b) / 2 and saves it as an integer
calculate:
    fld dword [R]             
    fmul st0, st0             
    fld dword [pi]            
    fmul st0, st1             
    fld dword [b]             
    fmul st0, st1             
    fld dword [half]          
    fdiv st1, st0             
    fstp st1
    fistp dword [int_result] 
    ret

_start:

    ; This block calls the subroutine to perform the calculation
    call calculate

    ; This block prints the message "The result is: "
    mov eax, 4                
    mov ebx, 1                
    mov ecx, msg              
    mov edx, 15               
    int 0x80

    ; This block changes the number to text so we can print it
    mov eax, [int_result]     
    mov ecx, buffer           
    add ecx, 19               
    mov byte [ecx], 0

    ; This loop turns the number into text one digit at a time so we can print it
.convert_loop:
    xor edx, edx              
    mov ebx, 10               
    div ebx                   
    add dl, '0'               
    dec ecx                   
    mov [ecx], dl             
    test eax, eax             
    jnz .convert_loop         


    ; This block prints the actual number
    mov eax, 4 
    mov ebx, 1              
    mov edx, buffer + 20    
    sub edx, ecx             
    mov ecx, ecx            
    int 0x80


    ; This the final part to exits the program
    mov eax, 1               
    xor ebx, ebx              
    int 0x80

%include "io.inc"

section .data
l dw 250

section .text
global CMAIN
CMAIN:
    mov ebp, esp     ; for correct debugging

    mov eax, [l]
    mov ebx, [l]
    mul ebx
    mul ebx
    PRINT_DEC 4, eax
    
    xor eax, eax
    ret
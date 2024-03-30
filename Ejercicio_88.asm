%include "io.inc"

section .data
    R1 dw 0, 3      ; Coordenadas del punto R1
    R2 dw 2, 7      ; Coordenadas del punto R2
    P1 dw 0, 1      ; Coordenadas del punto P1
    P2 dw 1, 0      ; Coordenadas del punto P2

section .text
global CMAIN
CMAIN:
    mov ebp, esp    ; for correct debugging

    ; Calcular la pendiente de la recta R1-R2
    mov ax, [R2]    ; ax = y2
    sub ax, [R1]    ; ax = y2 - y1
    mov bx, [R2+2]  ; bx = x2
    sub bx, [R1+2]  ; bx = x2 - x1

    ; Calcular la pendiente de la recta P1-P2
    mov cx, [P2]    ; cx = y4
    sub cx, [P1]    ; cx = y4 - y3
    mov dx, [P2+2]  ; dx = x4
    sub dx, [P1+2]  ; dx = x4 - x3

    ; Verificar si las rectas son paralelas
    imul ax, dx     ; (y2 - y1) * (x4 - x3)
    imul bx, cx     ; (x2 - x1) * (y4 - y3)
    cmp ax, bx
    je son_paralelas

    ; Las rectas no son paralelas
    PRINT_CHAR 'F'
    jmp fin

son_paralelas:
    ; Las rectas son paralelas
    PRINT_CHAR 'T'

fin:
    xor eax, eax
    ret

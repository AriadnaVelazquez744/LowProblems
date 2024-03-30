%include "io.inc"

section .data
    A dw 0, 0      ; Coordenadas del punto A
    B dw 0, 1      ; Coordenadas del punto B
    C dw 1, 0      ; Coordenadas del punto C

section .text
global CMAIN
CMAIN:
    ; Calcular los vectores AB, BC y CA
    mov ax, [B]     ; ax = x2
    sub ax, [A]     ; ax = x2 - x1 (componente x del vector AB)
    mov bx, [B+2]   ; bx = y2
    sub bx, [A+2]   ; bx = y2 - y1 (componente y del vector AB)

    mov cx, [C]     ; cx = x3
    sub cx, [B]     ; cx = x3 - x2 (componente x del vector BC)
    mov dx, [C+2]   ; dx = y3
    sub dx, [B+2]   ; dx = y3 - y2 (componente y del vector BC)

    mov si, [C]     ; si = x3
    sub si, [A]     ; si = x3 - x1 (componente x del vector CA)
    mov di, [C+2]   ; di = y3
    sub di, [A+2]   ; di = y3 - y1 (componente y del vector CA)

    ; Calcular los productos escalares entre los vectores
    imul_result:
        mov eax, 0      ; Inicializar eax
        mov ebx, 0      ; Inicializar ebx
        imul ax, cx     ; Multiplicar componente x de AB por componente x de BC
        imul bx, dx     ; Multiplicar componente y de AB por componente y de BC
        add eax, ebx    ; Sumar al producto anterior

        mov ebx, 0      ; Inicializar ebx
        imul bx, di     ; Multiplicar componente y de AB por componente y de CA
        add eax, ebx    ; Sumar al producto anterior
        
        mov ebx, 0      ; Inicializar ebx
        imul bx, si     ; Multiplicar componente x de BC por componente x de CA
        add eax, ebx    ; Sumar al producto anterior (producto escalar BC · CA)

        cmp eax, 0      ; Comparar el producto escalar con cero
        jne no_es_rectangulo

        mov eax, 'T'     ; Triángulo es rectángulo
        jmp fin

    no_es_rectangulo:
        mov eax, 'F'     ; Triángulo no es rectángulo

fin:
    PRINT_CHAR eax

    xor eax, eax
    ret
%include "io.inc"

section .data
n dd 4          ; Tamaño de la lista
array dd 4, 3, 5, 6  ; Lista de números

section .text
global CMAIN
CMAIN:
    mov ebp, esp     ; for correct debugging
    
    ; Calcular la media
    mov eax, 0      ; Inicializar el acumulador
    mov ebx, [n]    ; ebx = n
    mov ecx, 0      ; Contador
    mov esi, array  ; esi apunta al inicio del array

calcular_media:
    add eax, [esi + ecx * 4]  ; Sumar el elemento actual al acumulador
    inc ecx         ; Incrementar el contador
    cmp ecx, ebx    ; Comparar el contador con n
    jne calcular_media  ; Si no son iguales, seguir sumando

    mov edx, 0      ; Inicializar edx
    mov ebx, [n]    ; ebx = n
    div ebx         ; eax = eax / ebx (media)
    mov ebx, eax    ; ebx = media

    ; Calcular la varianza
    mov eax, 0      ; Inicializar el acumulador
    mov ecx, 0      ; Contador
    mov esi, array  ; esi apunta al inicio del array

calcular_varianza:
    mov edx, [esi + ecx * 4]  ; edx = elemento actual
    sub edx, ebx    ; edx = elemento actual - media
    imul edx, edx   ; edx = (elemento actual - media)^2
    add eax, edx    ; Sumar al acumulador
    inc ecx         ; Incrementar el contador
    cmp ecx, [n]    ; Comparar el contador con n
    jne calcular_varianza  ; Si no son iguales, seguir sumando

    mov ebx, [n]    ; ebx = n
    dec ebx         ; ebx = n - 1
    mov edx, 0      ; Inicializar edx
    div ebx         ; eax = eax / (n - 1) (varianza)

    ; Imprimir la varianza
    PRINT_DEC 4, eax
    
    xor eax, eax
    ret
section .data  
    sen1 db 'Nhap: '
    len1 equ $-sen1
    newLine db 'Xuong dong', 10
    lenNewLine equ $-newLine

section .bss
    sen2 resb 100
    len2 resb 100
    pos resd 100

section .text
    global _start:

_start:
    ;hien thi "Nhap: "
    mov eax, 4
    mov ebx, 1
    mov ecx, sen1
    mov edx, len1
    int 0x80
    ;Nhap tu ban phim
    mov eax, 3
    mov ebx, 0
    mov ecx, sen2
    mov edx, 100
    int 0x80
    mov [len2], eax
    mov eax, 2              ;gan gia tri cho pos
    mov [pos], eax
    ;hien thi chuoi vua nhap

    mov ecx, sen2
    add ecx, [pos]
    cmp byte [ecx], '5'
    jg step1
    jmp step2

    step1:
    mov eax, 4
    mov ebx, 1
    mov edx, 1
    int 0x80

    step2:
    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, lenNewLine
    int 0x80

_last:
    mov eax, 1
    int 0x80


;nasm -f elf PrintCharacter.asm
;ld -m elf_i386 -s -o PrintCharacter PrintCharacter.o
;./PrintCharacter

section .data
    msg1 db 'Nhap chuoi: '
    len1 equ $-msg1

    msg2 db 'Chuoi da nhap: '
    len2 equ $-msg2

section .bss
    msg3 resb 100
    len3 resb 100
    pos resb 100

section .text
    global _start

_start:
    
    ;In hien thi man hinh   ********************
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80

    ;Nhap vao mot chuoi ************************
    mov eax, 3
    mov ebx, 0
    mov ecx, msg3
    mov edx, 100
    int 0x80

    mov [len3], eax         ; danh giau chieu dai chuoi vao bien len3

    jmp step1               ; Nhay den step1 (dong 50)
    ;   ****************************************
    step3:
        inc esi             ; tang esi len 1 don vi
        mov [pos], esi      ; luu vao bien [pos]
        jmp step1           ; Quay lai vong lap kiem tra
    step2:
        call print          ; Goi print (muc dich la in ki tu thu [pos])
        inc esi             ; Tang esi len 1 don vi
        mov [pos], esi      ; Luu lai vao bien pos
        jmp step1           ; Quay lai vong lap kiem tra
    step1:
    mov esi, [pos]          ; Dua gia tri cua bien pos vao thanh esi
    cmp esi, [len3]         ; So sanh gia tri cua thanh esi voi len3 (chieu dai cua chuoi)
    jge _last               ; Neu esi >= len3 (Ket thuc chuong trinh)
    mov ecx, msg3           ; Neu esi < len3 thi dua chuoi nhap vao thanh ecx
    add ecx, esi            ; Muc dich la chuyen den vi tri thu [pos] trong chuoi
    cmp byte [ecx], '0'     ; So sanh byte thu [pos] trong chuoi voi ki tu '0'
    jl step2                ; Neu nho hon '0', nhay den step 2 (dong 45)
    cmp byte [ecx], '9'     ; Neu ki tu >= '0', so sanh voi ki tu '9'
    jg step2                ; Neu lon hon '9', nhay den step 2 (dong 45)
    jmp step3               ; Neu <= '9', nhay den step 3 (dong 41)

_last:
    mov eax, 1              ; Che do [1] la exit 
    int 0x80                ; call

print:                      ; Chuc nang la in ki tu thu k trong chuoi
    mov eax, 4              ; Che do [4] la write
    mov ebx, 1              ; Che do [1] la stdout
    mov ecx, msg3           ; Dua con tro cua msg3 vao thanh ecx
    add ecx, esi            ; Dich con tro den ki tu thu k trong chuoi
    mov edx, 1              ; In voi 1 ki tu
    int 0x80                ; Call
    ret                     ; Return
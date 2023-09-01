[org 0x0100]

    jmp start


start:
    mov ax, 0xB800
    push ax
    pop es

    mov di,0

nextchar:
    mov ah,0x7F
    mov al,'M'
    mov [es:di],ax
    add di,2
    mov al,0x20
    mov [es:di],ax
    add di,2
    cmp di,4000
    jne nextchar

mov ax,0x4c00
int 21h
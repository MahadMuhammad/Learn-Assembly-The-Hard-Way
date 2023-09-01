[org 0x0100]
    jmp start

message: db 'Hello World'

start:
    mov ah,13h
    mov al,1
    mov bh,0
    mov bl,7
    mov dx,0A03h
    mov cx,11

    push cs
    pop es
    mov bp,message
    int 10h    
   
mov ax, 0x4c00
int 21h
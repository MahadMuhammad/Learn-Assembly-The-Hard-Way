[org 0x0100]
    jmp start
   
start:
    mov ax,7
    mov bx,4
    div bx
   
mov ax, 0x4c00
int 21h
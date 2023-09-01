[org 0x0100]
    jmp start
   
start:
    mov ax,85h
    add ax,92h
   
mov ax, 0x4c00
int 21h
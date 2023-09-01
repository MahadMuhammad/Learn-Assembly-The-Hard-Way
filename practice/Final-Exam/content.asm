[org 0x0100]
    jmp start
num1: db 0xA
dw 0x1234
dd 0xABCDEF09
   
start:
    mov ax,[num1+5]
    add ax,[num1+2]
    mov [num1],ax
    
   
mov ax, 0x4c00
int 21h
[org 0x0100]
        jmp start
   
start:
        pusha

        mov ax,0

        popa
   
mov ax, 0x4c00
int 21h
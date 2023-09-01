[org 0x0100]

jmp start

start:
    mov ax,2
l1:
    push ax ; infinite loop
    jmp start
    


mov  ax, 0x4c00         
int  0x21
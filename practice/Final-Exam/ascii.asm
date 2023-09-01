[org 0x0100]
    jmp start
; a code to convert ascii
   
start:
    mov ah,0
    int 16h
    
mov ax, 0x4c00
int 21h
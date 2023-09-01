[org 0x0100]
    jmp start
   
start:
    mov ah, 0 ; service 0 – get keystroke 
    int 0x16 ; call BIOS keyboard service 
   
mov ax, 0x4c00
int 21h
; This program finds factorial using subroutines
[org 0x0100]
    jmp start
    n: dw 6
l1:

    mov cx,ax
    mov si,[n]
    sub cx,1
l2:

    mul cx
    sub cx,1
    jnz l2
    mov bx,ax   ; answer stored in bx
    ret     
start:
    
    mov ax,[n]
    call l1      
exit:
 
    mov ax, 0x4c00
    int 0x21
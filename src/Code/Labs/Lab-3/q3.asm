[org 0x0100] 

    mov ax,0
    mov bx,0
    mov cx,10
    mov dx,0

loo1:   mov ax,[fab+bx]
        mov bx,[fab+bx+1]
        add dx,ax
        add dx,bx
        mov [fab+bx+2],dx
        add bx,1
        sub cx,1
        jnz loo1


 mov ax,0x4c00 ; terminate program
     int 0x21


fab :dw 1,1,0,0,0,0,0,0,0,0,0,0
foo :dw 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144


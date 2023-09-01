[org 0x0100] 
    mov cx,0
    mov cx,[num] ;stores value
    mov bx,[num] ; loop control variable

    mov ax,0 ; initializing ax to zero
l1: add ax,cx 
    dec bx ; decreament bx by 1 count
    jnz l1

    mov [square],ax

mov ax,0x4c00 ; terminate program
int 0x21

num :dw 5
square :dw 0
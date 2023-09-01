[org 0x0100]

mov ax,3
mov cx,10
mov bx,0

l1: 

add bx,ax
sub cx,1
jnz l1

mov ax,0x4c00
int 0x21



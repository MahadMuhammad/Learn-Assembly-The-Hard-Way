[org 0x0100]

primenum: dw 2,3,5,7,11,13,17,19,23,29

mov ax,0
mov bx,0
mov cx,10
mov dx,0

l1:
mov ax,[primenum + bx]
add bx,2
add dx,ax
sub cx,1
cmp cx,0
jnz l1

mov ax,0x4c00
int 0x21





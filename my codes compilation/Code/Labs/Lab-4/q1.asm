[org 0x0100]

mov ax,5176h
xor cx,cx
mov cx,0xAAAA;to save odd
mov dx,5555h

and cx,ax
and dx,ax
shl dx,1
shr cx,1
or cx,dx


mov ax,0x4c00
int 0x21
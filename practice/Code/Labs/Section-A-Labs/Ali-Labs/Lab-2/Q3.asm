[org 0x0100]

mov ax, 200h
mov bx, 150h

mov dx, 50h
mov [0x250], dx
mov dx,  25h
mov [0x200], dx

mov bx, 0x200
mov ax, [bx]

mov cx, [0x250]

mov ax, 0x4c00
int 0x21

Arrau: dw 1, 2, 7, 5, 10
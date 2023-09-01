[org 0x0100]

mov ax, 25h
mov cx, ax
mov ax, bx
mov bx, cx ; Swap complete

mov cx, [0x270]

mov ax, 0
mov cx, 3
mov bx, 0
l1:
mov al, [num + bx]
sub cx, 1
add bx, 1
jnz l1

mov ax, 0x4c00
int 0x21

num: db 12, 25, 10
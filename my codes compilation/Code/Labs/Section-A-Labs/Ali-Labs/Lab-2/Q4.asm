[org 0x100]

mov ax, 0
mov bx, 0

l1:
add ax, [Array + bx]
add bx, 2
cmp bx, 24
jne l1
 
mov ax, 0x4c00
int 0x21

Array: dw 111, 999, 888, 888, 11, 99, 88, 88, 1, 9, 8, 8
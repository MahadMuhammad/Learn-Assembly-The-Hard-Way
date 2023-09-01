[org 0x0100]

mov ax, 0
add ax, [n]
add ax, [n + 2]
add ax, [n + 4]
add ax, [n + 6]
add ax, [n + 8]

mov [sum], ax

mov ax, 0x4c00
int 0x21

n: dw 10, 20, 30, 40, 50
sum: dw 0
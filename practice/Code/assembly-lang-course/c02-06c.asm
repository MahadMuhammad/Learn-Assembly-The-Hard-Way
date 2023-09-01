; a program to add three numbers using byte variables
;Know the concept of direct & indirect addressing
[org 0x0100]

    mov dx, num1
; This is the same c02-05.asm
    mov  ax, [dx]; THis is indirect addressing

    mov  bx, [num1+1];This is direct addressing
    add  ax, bx
    
    mov  bx, [num1+2]
    add  ax, bx

    mov  [num1+3], ax
    
    mov  ax, 0x4c00
    int  0x21

num1: db  5, 10, 15, 0

; a program to add three numbers using byte variables
[org 0x0100]

    mov  ax, [num1]

    mov  bx, [num1+1]
    add  ax, bx
    
    mov  bx, [num1+2]
    add  ax, bx

    mov  [num1+3], ax
    
    mov  ax, 0x4c00
    int  0x21
;db= define byte
;dw= define word
;Here [num1]=05 (Not 0005)
num1: db  5, 10, 15, 0
; when we define the db then we cannot move this into a 16 bit register

; something's wrong with this code. 
; let's figure out what that is! 
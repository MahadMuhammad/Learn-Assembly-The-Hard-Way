; a program to add three numbers accessed using a single label
[org 0x0100]

    mov  ax, [num1]           
    mov  bx, [num1 + 2]       
    add  ax, bx
    mov  bx, [num1 + 4]
    add  ax, bx
    mov  [num1 + 6], ax
    mov  ax, 0x4c00
    int  0x21
; we can define just like this 
; Just like we do in C++ (By using int one time for different variables)
; e.g., int a,b,c,d;
num1:   dw  5,  10,  15,  0

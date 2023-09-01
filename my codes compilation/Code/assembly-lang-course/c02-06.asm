; a program to add three numbers using byte variables
[org 0x0100]
    ; mov  ax, 0x8787
    ; xor  ax, ax             ; We need to make sure AX is empty! Or do we? 

    mov  ah, [num1]         ; Intel Sotware Developer Manual - Figure 3-5 (Page 76) 

    mov  bl, [num1+1]
    add  ah, bh
    
    mov  bh, [num1+2]
    add  ah, bh

    mov  [num1+3], ah
    
    mov  ax, 0x4c00
    int  0x21

num1: db  5, 10, 15, 0

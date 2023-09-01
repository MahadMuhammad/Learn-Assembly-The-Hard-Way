; a program to add three numbers using byte variables
[org 0x0100]

    ; initialize stuff 
    mov  ax, 0              ; reset the accumulator 
    mov  bx, 0              ; set the counter 
    
    outerloop: 
        add  ax, [num1 + bx]
        add  bx, 2

        cmp bx, 20          ; sets ZF=0 when they are equal 
        jne  outerloop 
    

    mov  [result], ax
    
    mov  ax, 0x4c00
    int  0x21


    ; Intel Sotware Developer Manual - EFLAGS and Instructions (Page 435) 

num1: dw   10, 20, 30, 40, 50, 10, 20, 30, 40, 50
result: dw 0 
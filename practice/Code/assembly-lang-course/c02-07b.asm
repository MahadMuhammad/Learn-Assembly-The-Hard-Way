; a program to add three numbers using byte variables
; flags stores the result of the previous passed function 
[org 0x0100]


     ; for (int c = 3    c > 0     c--) { 
     ;   result += data[c]; 
     ;}


    ; initialize stuff 
    mov  ax, 0              ; reset the accumulator 
    ;int cx=3
    mov  cx, 3              ; set the iterator count we have to move 3 times the loop 
    mov  bx, num1           ; set the base 
    
    ;This is same the loop as c02-07
    outerloop: 
        add  ax, [bx];   result += data[c];
        add  bx, 2  

        ;This is c--
        sub  cx, 1   
        ;Jump is zero flag is not set       
        jnz  outerloop 
    

    mov  [result], ax
    
    mov  ax, 0x4c00
    int  0x21


    ; Intel Sotware Developer Manual - EFLAGS and Instructions (Page 435) 

num1: dw  5, 10, 15
result: dw 0 

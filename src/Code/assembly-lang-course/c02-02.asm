; a program to add three numbers accessed using a single label
[org 0x0100]

    mov  ax, [num1]
    mov  bx, [num1 + 2]     ; notice how we can do arithmetic here 
    add  ax, bx             ; also, why +2 and not +1?  
    mov  bx, [num1 + 4]
    add  ax, bx
    mov  [num1 + 6], ax     ; store sum at num1+6
    mov  ax, 0x4c00
    int  0x21

;num1 is the only label which is only used for our own memory
;This is just the facility provide by the assembler
num1:   dw  5 
        dw  10
        dw  15
        dw  0
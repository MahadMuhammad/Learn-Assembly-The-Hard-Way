[org 0x0100]

jmp start       

num1:   dw 0x40FF    ; 4400,  40FF

dest:   dw 0x40FF
src:    dw 0x1001 


start: 

    ; shift 
    shl byte [num1], 1
    rcl byte [num1 + 1], 1 







    ; addition 
    xor ax, ax   ; clear 

    mov al, byte[src]
    add byte[dest], al 

    mov al, [src  + 1]
    adc byte[dest + 1], al 



    mov  ax, 0x4c00 
    int  0x21 


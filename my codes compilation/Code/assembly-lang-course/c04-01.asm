[org 0x0100]

jmp start       

multiplicand: db 13      ; 4-bit number, save space of 8-bits 
multiplier:   db 5       ; 4-bit 

result:       db 0       ; 8-bit result 

start: 

    mov  cl, 4            ; how many times we need to run the loop 
    mov  bl, [multiplicand]
    mov  dl, [multiplier]


    checkbit: 
        shr  dl, 1        ; do the rotation so that right bit is thrown in CF 
        jnc  skip 
            add [result], bl     ; only add if CF IS SET 


        skip: 
        shl  bl, 1         ; always shift the multiplicand 

    dec  cl 
    jnz  checkbit 


    mov  ax, 0x4c00 
    int  0x21 
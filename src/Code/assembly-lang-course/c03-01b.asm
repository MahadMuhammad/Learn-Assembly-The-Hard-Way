[org 0x0100]

jmp start       

data: dw   6, 2, 4, 5
swap: db   0    ; use this as a flag 

start: 
    ; mov  cx, 4                          ; make 10 passes, has to be outside the loop! 

    outerloop: 
        mov  bx, 0    
        mov  byte [swap], 0             ; why the "byte"? 
        
        innerloop: 
            mov  ax, [data + bx]
            cmp  ax, [data + bx + 2]    ; why did we move the value to AX? 
            
            jbe  noswap                 ; if we don't have to swap, we just jump over the swap thing 

                ; the swap potion 
                mov  dx, [data + bx + 2]
                mov  [data + bx + 2], ax    ; again with the AX? 
                mov  [data + bx], dx
                mov  byte [swap], 1 

            noswap:
            add  bx, 2
            cmp  bx, 6
            jne  innerloop

        ; if we didn't swap even once, we should be done 
        cmp  byte [swap], 1     ; don't need to load this in register?
        je   outerloop 

        ; check outer loop termination 
        ; sub cx, 1 
        ; jnz outerloop 


    ; exit system call 
    mov  ax, 0x4c00
    int  0x21




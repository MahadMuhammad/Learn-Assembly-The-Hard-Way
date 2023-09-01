[org 0x100]

jmp start 

data:   dw  60, 55, 45, 50 
swapflag:   db  0 


swap: 
    mov  ax, [bx + si]          ; this changes ax 
    xchg ax, [bx + si + 2]
    mov  [bx + si], ax 

    ret  


bubblesort: 
    dec  cx 
    shl  cx, 1                   ; This changes cx 

    mainloop:  
        mov  si, 0               ; This changes si 
        mov  byte[swapflag], 0   

        innerloop: 
            mov  ax, [bx + si]   ; This changes ax 
            cmp  ax, [bx + si + 2]
            jbe  noswap 

               call swap          ; another call here 
               mov  byte[swapflag], 1

            noswap: 
            add  si, 2 
            cmp  si, cx
            jne  innerloop

        cmp  byte[swap], 1 
        je   mainloop 

    ret    ; notice this!! 




start: 
    mov  bx, data 
    mov  cx, 4 

    ; make a function call 
    call bubblesort 

    ; data is now sorted! 

    mov ax, 0x4c00 
    int 0x21 
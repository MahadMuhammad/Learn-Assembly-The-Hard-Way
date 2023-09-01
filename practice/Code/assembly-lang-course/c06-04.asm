[org 0x100]

jmp start 

data:   dw  60, 55
swapflag:   db  0 


swap: 
    push ax  ; -----------------------; 
                                      ; 
    mov  ax, [bx + si]                ; 
    xchg ax, [bx + si + 2]            ; 
    mov  [bx + si], ax                ; 
                                      ; 
    pop ax   ; -----------------------; 

    ret       


bubblesort: 
    ; handle stack issue for parameters -------------
    push bp 
    mov  bp, sp 


    mov  bx, [bp + 6]   ; address of data to sort 
    mov  cx, [bp + 4]   ; number of elements to sort 

    ; same old code from here ----------------------- 
    dec  cx 
    shl  cx, 1                   

    mainloop:  
        mov  si, 0                   ; use as array index 
        mov  byte[swapflag], 0       ; reset swap flag for this iteration 

        innerloop: 
            mov  ax, [bx + si]
            cmp  ax, [bx + si + 2]
            jbe  noswap 

               call swap    ; another call here 
               mov  byte[swapflag], 1

            noswap: 
            add  si, 2 
            cmp  si, cx
            jne  innerloop

        cmp  byte[swap], 1 
        je   mainloop 


    ; handle parameter stack issue at end again -------------------
    pop si 
    pop cx 
    pop bx       ; check removal 
    ; pop ax 
    pop bp       ; bp was the first thing pushed, so last popped! 
    ; stack cleared? ----------------------------------------------

    ret 4        ; what is this guy?



start: 
    mov  bx, data 
    mov  cx, 2 

    push bx 
    push cx 
    ; make a function call 
    call bubblesort 

    ; data is now sorted! 

    mov ax, 0x4c00 
    int 0x21 
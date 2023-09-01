[org 0x0100]
    jmp  start

clrscr:
    push es
    push ax
    push cx
    push di

    mov  ax, 0xb800             ; same as before 
    mov  es, ax

    xor  di, di                 ; starting at index 0 
    
    mov  ax, 0x0720             ; what to write
    mov  cx, 2000               ; how many times to write 
                                ; holds the count, NOT bytes! 

    cld                         ; auto-increment 
    rep stosw                   ; automatically writes starting from [es:di]

    pop di
    pop  cx
    pop  ax
    pop  es
    ret

start: 
    call clrscr
    mov  ax, 0x4c00
    int  0x21

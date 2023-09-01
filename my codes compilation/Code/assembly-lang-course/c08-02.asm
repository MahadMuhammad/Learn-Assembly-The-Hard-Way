[org 0x0100]

    jmp start

message: db 'hello world', 0

clrscr:
    push es
    push ax
    push cx
    push di

    mov  ax, 0xb800
    mov  es, ax
    xor  di, di
    mov  ax, 0x0720
    mov  cx, 2000

    cld                 ; auto-increment mode 
    rep stosw           ; rep cx times, store words 
                        ; source is ax for word, al for bytes 
                        ; destination is es:di 
                        ; inc/dec di as well by 2 bytes 

    pop  di
    pop  cx
    pop  ax
    pop  es
    ret

printnum: 
    push bp 
    mov  bp, sp
    push es 
    push ax 
    push bx 
    push cx 
    push dx 
    push di 

    ; first, let's split digits and push them onto the stack 

    mov ax, [bp+4]   ; number to print 
    mov bx, 10       ; division base 10 
    mov cx, 0        ; total digit counter 

    nextdigit: 
        mov dx, 0    ; zero out  
        div bx       ; divides ax/bx .. quotient in ax, remainder in dl 
        add dl, 0x30 ; convert to ASCII 
        push dx      ; push to stack for later printing 
        inc cx       ; have another digit 
        cmp ax, 0    ; is there something in quotient? 
        jnz nextdigit 

    ; now let's do the printing 

    mov ax, 0xb800 
    mov es, ax 

    mov di, 0 
    nextpos: 
        pop dx          ; digit to output. Already in ASCII 
        mov dh, 0x07    ; why is this inside the loop here? 
        mov [es:di], dx 
        add di, 2 
        loop nextpos    ; cx has already been set, use that 

    pop di 
    pop dx 
    pop cx 
    pop bx 
    pop ax 
    pop es
    pop bp 
    ret 2 


strlen:
    push bp
    mov  bp,sp
    push es
    push cx
    push di

    les  di, [bp+4]     ; load DI from BP+4 and ES from BP+6
    mov  cx, 0xffff     ; maximum possible length 
    
    xor  al, al         ; value to find 
    repne scasb         ; repeat until scan does not become NE to AL 
                        ; decrement CX each time 

    mov  ax, 0xffff     
    sub  ax, cx         ; find how many times CX was decremented 

    dec  ax             ; exclude null from the length 

    pop  di
    pop  cx
    pop  es
    pop  bp
    ret  4


start: 
    call clrscr 

    push ds
    mov  ax, message
    push ax
    call strlen          ; return value is in AX 

    push ax             
    call printnum        ; print out the length 


    mov  ah, 0x1
    int 0x21
    mov  ax, 0x4c00
    int 0x21 
[org 0x0100]

    jmp start

clrscr:     
    push es
    push ax
    push di

    mov  ax, 0xb800
    mov  es, ax
    mov  di, 0

    nextloc:
        mov  word [es:di], 0x0720
        add  di, 2
        cmp  di, 4000
        jne  nextloc

    pop  di 
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
        mov dh, 0x04    ; why is this inside the loop here? 
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



start: 
    call clrscr 

    mov ax, 452
    push ax 
    call printnum


    ; wait for keypress 
    mov  ah, 0x1        ; input char is 0x1 in ah 
    int 0x21 

    mov ax, 0x4c00 
    int 0x21 

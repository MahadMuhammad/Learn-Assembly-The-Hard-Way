[org 0x0100]

    jmp start

message:     db   'hello world'   
length:      dw   11

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


printstr:
    push bp
    mov  bp, sp
    push es
    push ax
    push cx 
    push si 
    push di 

    mov ax, 0xb800 
    mov es, ax 
    mov di, 0               


    mov si, [bp + 6]
    mov cx, [bp + 4]
    mov ah, 0x07 ; only need to do this once 

    nextchar: 
        mov al, [si]
        mov [es:di], ax 
        add di, 2 
        add si, 1 
        
        ; dec cx 
        ; jnz nextchar     

        ; alternatively 
        loop nextchar 


    pop di 
    pop si 
    pop cx 
    pop ax 
    pop es 
    pop bp 
    ret 4 


start: 
    call clrscr 

    mov ax, message 
    push ax 
    push word [length]
    call printstr 



    ; wait for keypress 
    mov ah, 0x1        ; input char is 0x1 in ah 
    int 0x21 

    mov ax, 0x4c00 
    int 0x21 

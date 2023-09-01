; Terminate & stay resident
[org 0x0100] 
    jmp start 

oldisr: dd 0 ; space for saving old isr
ifapressed: db "He has food dna drinks",0 ; message to be displayed on screen
ifbpressed: db "He sah food and drinks",0 ; message to be displayed on screen
ifcpressed: db "He has food and drinks",0 ; message to be displayed on screen
strl: dw 23 ; length of message


printapressed:
    ;push es
    ;push ax
    ;push cx
    ;push di

    ;mov ax,0xb800 ; video memory
    ;mov es,ax   ; es:di points to video memory
    ;mov di,0    ; offset 0
    ;mov cx,[strl] ; length of message

    ;cld
    ;rep movsb  ; copy message to video memory

    ;pop di
    ;pop cx
    ;pop ax
    ;pop es

    mov byte [es:0], 'H' ; yes, print H at first column 
    mov byte [es:2], 'e' ; yes, print e at first column 
    mov byte [es:4], ' ' ; yes, print ' '  at first column 
    mov byte [es:6], 'h' ; yes, print h at first column
    mov byte [es:8], 'a' ; yes, print a at first column
    mov byte [es:10], 's' ; yes, print s at first column
    mov byte [es:12], ' ' ; yes, print ' ' at first column
    mov byte [es:14], 'f' ; yes, print f at first column
    mov byte [es:16], 'o' ; yes, print o at first column
    mov byte [es:18], 'o' ; yes, print o at first column
    mov byte [es:20], 'd' ; yes, print d at first column
    mov byte [es:22], ' ' ; yes, print ' ' at first column
    mov byte [es:24], 'd' ; yes, print d at first column
    mov byte [es:26], 'n' ; yes, print n at first column
    mov byte [es:28], 'a' ; yes, print a at first column
    mov byte [es:30], ' ' ; yes, print ' ' at first column
    mov byte [es:32], 'd' ; yes, print d at first column
    mov byte [es:34], 'r' ; yes, print r at first column
    mov byte [es:36], 'i' ; yes, print i at first column
    mov byte [es:38], 'n' ; yes, print n at first column
    mov byte [es:40], 'k' ; yes, print k at first column
    mov byte [es:42], 's' ; yes, print s at first column 
    ret
printbpressed:
    mov byte [es:0], 'H' ; yes, print H at first column
    mov byte [es:2], 'e' ; yes, print e at first column
    mov byte [es:4], ' ' ; yes, print ' '  at first column
    mov byte [es:6], 's' ; yes, print s at first column
    mov byte [es:8], 'a' ; yes, print a at first column
    mov byte [es:10], 'h' ; yes, print h at first column
    mov byte [es:12], ' ' ; yes, print ' ' at first column
    mov byte [es:14], 'f' ; yes, print f at first column
    mov byte [es:16], 'o' ; yes, print o at first column
    mov byte [es:18], 'o' ; yes, print o at first column
    mov byte [es:20], 'd' ; yes, print d at first column
    mov byte [es:22], ' ' ; yes, print ' ' at first column
    mov byte [es:24], 'a' ; yes, print a at first column
    mov byte [es:26], 'n' ; yes, print n at first column
    mov byte [es:28], 'd' ; yes, print d at first column
    mov byte [es:30], ' ' ; yes, print ' ' at first column
    mov byte [es:32], 'd' ; yes, print d at first column
    mov byte [es:34], 'r' ; yes, print r at first column
    mov byte [es:36], 'i' ; yes, print i at first column
    mov byte [es:38], 'n' ; yes, print n at first column
    mov byte [es:40], 'k' ; yes, print k at first column
    mov byte [es:42], 's' ; yes, print s at first column

    ret
clrscr2: 
    mov ah, 0x0 
    mov al, 0x0 
    int 0x10 
    ret
clrscr:
    push es
    push ax
    push cx
    push di

    mov ax, 0xb800
    mov es, ax
    mov di, 0
    mov ax,0x0720
    mov cx, 80*25

    cld 
    rep stosw


    pop di
    pop cx
    pop ax
    pop es
    ret

; keyboard interrupt service routine 
kbisr: 
        push ax 
        push es 

        mov ax, 0xb800 
        mov es, ax ; point es to video memory 

        in al, 0x60 ; read a char from keyboard port 
        cmp al, 0x2a ; has the left shift pressed 
        jne nextcmp ; no, try next comparison 
        call printapressed
        ;mov byte [es:0], 'L' ; yes, print L at first column 

        jmp exit ; leave interrupt routine 

            nextcmp: 
                cmp al, 0x36 ; has the right shift pressed 
                jne nextcmp2 ; no, try next comparison
                ;mov byte [es:0], 'R' ; yes, print R at second column
                call printbpressed
                jmp exit ; leave interrupt routine 

            nextcmp2: 
                cmp al, 0xaa ; has the left shift released 
                jne nextcmp3 ; no, try next comparison 
                call clrscr
                ;mov byte [es:0], ' ' ; yes, clear the first column 
                jmp exit ; leave interrupt routine 

            nextcmp3: 
                cmp al, 0xb6 ; has the right shift released 
                jne nomatch ; no, chain to old ISR 
                call clrscr
                ;mov byte [es:0], ' ' ; yes, clear the second column 
                jmp exit ; leave interrupt routine 

            nomatch: 
                pop es 
                pop ax 
                jmp far [cs:oldisr] ; call the original ISR 

            exit: 
                mov al, 0x20 
                out 0x20, al ; send EOI to PIC 
                pop es 
                pop ax 
                iret ; return from interrupt 
start: 
    ; wait for keypress 
    mov ah, 0x1        ; input char is 0x1 in ah 
    int 0x21 
    call clrscr        ; call clrscr function


    xor ax, ax 
    mov es, ax ; point es to IVT base 
    mov ax, [es:9*4] 
    mov [oldisr], ax ; save offset of old routine 
    mov ax, [es:9*4+2] 
    mov [oldisr+2], ax ; save segment of old routine 
    cli ; disable interrupts 
    mov word [es:9*4], kbisr ; store offset at n*4 
    mov [es:9*4+2], cs ; store segment at n*4+2 
    sti ; enable interrupts 
    mov dx, start ; end of resident portion 
    add dx, 15 ; round up to next para 
    mov cl, 4 
    shr dx, cl ; number of paras 
mov ax, 0x3100 ; terminate and stay resident 
int 0x21 


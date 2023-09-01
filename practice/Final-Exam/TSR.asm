; TSR to show status of shift keys on top left of screen 
[org 0x0100] 
    jmp start 
oldisr: dd 0 ; space for saving old isr 
; keyboard interrupt service routine 
kbisr: 
        push ax 
        push es 
        mov ax, 0xb800 
        mov es, ax ; point es to video memory 
        in al, 0x60 ; read a char from keyboard port 
        cmp al, 0x2a ; has the left shift pressed 
        jne nextcmp ; no, try next comparison 
        mov byte [es:0], 'L' ; yes, print L at first column 
        jmp exit ; leave interrupt routine 
nextcmp: 
        cmp al, 0x36 ; has the right shift pressed 
        jne nextcmp2 ; no, try next comparison 
        mov byte [es:0], 'R' ; yes, print R at second column 
        jmp exit ; leave interrupt routine 
nextcmp2: 
        cmp al, 0xaa ; has the left shift released 
        jne nextcmp3 ; no, try next comparison 
        mov byte [es:0], ' ' ; yes, clear the first column 
        jmp exit ; leave interrupt routine 
nextcmp3: 
        cmp al, 0xb6 ; has the right shift released 
        jne nomatch ; no, chain to old ISR 
        mov byte [es:2], ' ' ; yes, clear the second column 
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
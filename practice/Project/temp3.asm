; differentiate left and right shift keys with scancodes 
[org 0x0100] 
 jmp start 
; keyboard interrupt service routine 
kbisr: 
    push ax 
    push es 
    mov ax, 0xb800 
    mov es, ax ; point es to video memory 
    in al, 0x60 ; read a char from keyboard port 
    cmp al, 0x02 ; is the key left shift 
    jne nextcmp ; no, try next comparison 
    mov byte [es:0], 'L' ; yes, print L at top left 
    jmp nomatch ; leave interrupt routine 
nextcmp: 
    cmp al, 0x03 ; is the key right shift 
    jne nomatch ; no, leave interrupt routine 
    mov byte [es:0], 'R' ; yes, print R at top left 
nomatch: 
    mov al, 0x20 
    out 0x20, al ; send EOI to PIC 
    pop es 
    pop ax 
    iret 
start: 
    xor ax, ax 
    mov es, ax ; point es to IVT base 
    cli ; disable interrupts 
    mov word [es:9*4], kbisr ; store offset at n*4 
    mov [es:9*4+2], cs ; store segment at n*4+2 
    sti ; enable interrupts
 
 jmp $
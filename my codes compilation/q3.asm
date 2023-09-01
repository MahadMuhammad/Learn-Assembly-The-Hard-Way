[org 0x0100]
jmp start
; write a program to get two keystrokes using interrupt number 0x16 one afer the other.
; On first keystroke it should clear the screen
; 1e & 30 are the scan codes for the keys


ifapressed: db "He has food dna drinks" ; message to be displayed on screen
ifbpressed: db "He sah food and drinks" ; message to be displayed on screen
ifcpressed: db "He has food and drinks" ; message to be displayed on screen
strl: dw 22





printapressed:
    pusha  ; save all registers
    mov ah, 0x13 ; print string
    mov al,1
    mov bh,0
    mov bl,7 ; white on black
    mov dx, 0
    mov cx, [strl] ; length of string

   

    push cs 
    pop es 
    mov bp, ifapressed
    int 0x10

    popa ; restore all registers

    ret
printbpressed:
    pusha  ; save all registers
    mov ah, 0x13 ; print string
    mov al,1
    mov bh,0
    mov bl,7 ; white on black
    mov dx, 0
    mov cx, [strl] ; length of string

   

    push cs 
    pop es 
    mov bp, ifbpressed
    int 0x10

    popa ; restore all registers

    ret

printcpressed:
    pusha  ; save all registers
    mov ah, 0x13 ; print string
    mov al,1
    mov bh,0
    mov bl,7 ; white on black
    mov dx, 0
    mov cx, [strl] ; length of string

    push cs 
    pop es 
    mov bp, ifcpressed
    int 0x10

    popa ; restore all registers

    ret


oldisr: dd 0 ; space for saving old isr 
; keyboard interrupt service routine 
kbisr: 
    push ax 
    push es 
    mov ax, 0xb800 
    mov es, ax ; point es to video memory 
    in al, 0x60 ; read a char from keyboard port 
    cmp al, 0x2a ; is the key left shift 
    jne nextcmp ; no, try next comparison 
    ;mov byte [es:0], 'L' ; yes, print L at top left 
    call printapressed
    jmp nomatch ; leave interrupt routine 
nextcmp: 
    cmp al, 0x36 ; is the key right shift 
    jne nomatch ; no, leave interrupt routine 
    ;mov byte [es:0], 'R' ; yes, print R at top left
    call printbpressed 
          ; call clrscr function
    
nomatch: 
    ; mov al, 0x20 
    ; out 0x20, al 
    call clrscr
    pop es 
    pop ax 
    jmp far [cs:oldisr] ; call the original ISR 
    ; iret 

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
l1: 
 mov ah, 0 ; service 0 – get keystroke 
 int 0x16 ; call BIOS keyboard service 
 cmp al, 27 ; is the Esc key pressed 
 jne start ; if no, check for next key 

 mov ax, 0x4c00 ; terminate program 
 int 0x21 

clrscr: 
    mov ah, 0x0 
    mov al, 0x0 
    int 0x10 
    ret




 
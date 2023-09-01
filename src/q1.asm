[org 0x0100]
jmp start
; write a program to get two keystrokes using interrupt number 0x16 one afer the other.
; On first keystroke it should clear the screen
; 1e & 30 are the scan codes for the keys


ifapressed: db "Hi, You pressed a" ; message to be displayed on screen
ifbpressed: db "Hi, You pressed b" ; message to be displayed on screen
ifcpressed: db "Hi, You entered wrong credentials" ; message to be displayed on screen
strl: dw 17         ;   length of the string
strl1: dw 33         ;   length of the string

printapressed:
    pusha  ; save all registers
    mov ah, 0x13 ; print string
    mov al,1    ; print on screen
    mov bh,0    ;   page number
    mov bl,7 ; white on black
    mov dx, 0   ;   row
    mov cx, [strl] ; length of string

   

    push cs     ;   segment of string
    pop es    ;   segment of string
    mov bp, ifapressed  ;   offset of string
    int 0x10    ;   print string

    popa ; restore all registers

    ret ; return to caller
printbpressed:
    pusha  ; save all registers
    mov ah, 0x13 ; print string
    mov al,1    ; print on screen
    mov bh,0    ;   page number
    mov bl,7 ; white on black
    mov dx, 0   ;   row
    mov cx, [strl] ; length of string

   

    push cs     ;   segment of string
    pop es      ;   segment of string
    mov bp, ifbpressed  ;   offset of string
    int 0x10    ;   print string

    popa ; restore all registers

    ret ;   return to caller

printcpressed:
    pusha  ; save all registers
    mov ah, 0x13 ; print string
    mov al,1    ; print on screen
    mov bh,0    ;   page number
    mov bl,7 ; white on black
    mov dx, 0   ;   row
    mov cx, [strl1] ; length of string

    push cs     ;   segment of string
    pop es  ;   segment of string
    mov bp, ifcpressed  ;   offset of string
    int 0x10    ;   print string

    popa ; restore all registers

    ret ;   return to caller


oldisr: dd 0 ; space for saving old isr 
; keyboard interrupt service routine 
kbisr: 
    push ax 
    push es 
    mov ax, 0xb800 
    mov es, ax ; point es to video memory 
    in al, 0x60 ; read a char from keyboard port 
    cmp al, 0x1e ; is the key left shift 
    jne nextcmp ; no, try next comparison 
    ;mov byte [es:0], 'L' ; yes, print L at top left 
    call printapressed
    jmp nomatch ; leave interrupt routine 
nextcmp: 
    cmp al, 0x30 ; is the key right shift 
    jne nomatch ; no, leave interrupt routine 
    ;mov byte [es:0], 'R' ; yes, print R at top left
    call printbpressed 
          ; call clrscr function
    
nomatch: 
    ; mov al, 0x20 
    ; out 0x20, al 
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
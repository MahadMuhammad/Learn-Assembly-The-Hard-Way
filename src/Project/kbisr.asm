; another attempt to terminate program with Esc that hooks 
; keyboard interrupt 
[org 0x100] 
 jmp start 
oldisr: dd 0 ; space for saving old isr 
WRONGKEY: db 'Error! Wrong Key Pressed'          ;   Wrong Key Pressed message
; keyboard interrupt service routine 
PrintWRONGKEY:
        pusha

        mov ah,0x13     ;   Service 13h - Write Character and Attribute to Cursor Position
        mov al,1        ;   subservice - update cursor position
        mov bh,0        ;   page number
        mov bl,9Ch        ;   attribute byte
        mov dx,0x1616   ;   row 22, column 33
        mov cx,24       ;   number of characters to write (Length of string)
        push cs         ;   push the segment of the string
        pop es          ;   pop the segment of the string 

        mov bp,WRONGKEY    ;   set the pointer to the string
        int 0x10        ;   call the interrupt


        popa            ;   Restore the registers
        ret            ;   Return
;   --------------------------------------------------------
kbisr: 
    push ax 
    in al, 0x60 ; read a char from keyboard port 
nextcmp0:
    cmp al, 0x02 ; Is 1 Pressed
    jne nextcmp ; no, try next comparison 
    cmp byte [BOARD+0], 2 ; Is 1 already pressed?
    jne Ocupied
    mov byte [BOARD+0], 0 ; mark 1 as pressed
    mov byte [P!P1ORP2],1
    jmp exit ; leave interrupt routine 
nextcmp: 
    cmp al, 0x03 ; is 2 Pressed
    jne nextcmpcheck1 ; no, try next comparison 
    mov byte [es:0], '2' ; yes, print 2 at second column 
    jmp exit ; leave interrupt routine 
nextcmpcheck1: 
    cmp al, 0x04 ; is 3 Pressed
    jne nextcmpcheck2 ; no, try next comparison 
    mov byte [es:0], '3' ; yes, print 3 at second column 
    jmp exit ; leave interrupt routine
nextcmpcheck2:
    cmp al, 0x05 ; is 4 Pressed
    jne nextcmpcheck3 ; no, try next comparison 
    mov byte [es:0], '4' ; yes, print 4 at second column 
    jmp exit ; leave interrupt routine
nextcmpcheck3:
    cmp al, 0x10 ; is Q Pressed
    jne nextcmpcheck4 ; no, try next comparison 
    mov byte [es:0], 'Q' ; yes, print Q at second column 
    jmp exit ; leave interrupt routine
nextcmpcheck4:
    cmp al, 0x11 ; is W Pressed
    jne nextcmpcheck5 ; no, try next comparison 
    mov byte [es:0], 'W' ; yes, print W at second column 
    jmp exit ; leave interrupt routine
nextcmpcheck5:
    cmp al, 0x12 ; is E Pressed
    jne nextcmpcheck6 ; no, try next comparison 
    mov byte [es:0], 'E' ; yes, print E at second column 
    jmp exit ; leave interrupt routine
nextcmpcheck6:
    cmp al, 0x13 ; is R Pressed
    jne nextcmpcheck7 ; no, try next comparison 
    mov byte [es:0], 'R' ; yes, print R at second column 
    jmp exit ; leave interrupt routine
nextcmpcheck7:
    cmp al, 0x1e ; is A Pressed
    jne nextcmpcheck8 ; no, try next comparison 
    mov byte [es:0], 'A' ; yes, print A at second column 
    jmp exit ; leave interrupt routine
nextcmpcheck8:
    cmp al, 0x1f ; is S Pressed
    jne nextcmpcheck9 ; no, try next comparison 
    mov byte [es:0], 'S' ; yes, print S at second column 
    jmp exit ; leave interrupt routine
nextcmpcheck9:
    cmp al, 0x20 ; is D Pressed
    jne nextcmpcheck10 ; no, try next comparison 
    mov byte [es:0], 'D' ; yes, print D at second column 
    jmp exit ; leave interrupt routine
nextcmpcheck10:
    cmp al, 0x21 ; is F Pressed
    jne nextcmpcheck11 ; no, try next comparison 
    mov byte [es:0], 'F' ; yes, print F at second column 
    jmp exit ; leave interrupt routine
nextcmpcheck11:
    cmp al, 0x2c ; is Z Pressed
    jne nextcmpcheck12 ; no, try next comparison 
    mov byte [es:0], 'Z' ; yes, print Z at second column 
    jmp exit ; leave interrupt routine
nextcmpcheck12:
    cmp al, 0x2d ; is X Pressed
    jne nextcmpcheck13 ; no, try next comparison 
    mov byte [es:0], 'X' ; yes, print X at second column 
    jmp exit ; leave interrupt routine
nextcmpcheck13:
    cmp al, 0x2e ; is C Pressed
    jne nextcmpcheck14 ; no, try next comparison 
    mov byte [es:0], 'C' ; yes, print C at second column 
    jmp exit ; leave interrupt routine
nextcmpcheck14:
    cmp al, 0x2f ; is V Pressed
    jne nextcmp2 ; no, try next comparison 
    mov byte [es:0], 'V' ; yes, print V at second column 
    jmp exit ; leave interrupt routine
nextcmp2: 
    cmp al, 0x82 ; has the 1 key released 
    jne nextcmp3 ; no, try next comparison 
    mov byte [es:0], ' ' ; yes, clear the first column 
    jmp exit ; leave interrupt routine 
nextcmp3: 
    cmp al, 0x83 ; has the 2 key released 
    jne nextcmp4 ; no, chain to old ISR 
    mov byte [es:0], ' ' ; yes, clear the second column 
    jmp exit ; leave interrupt routine
nextcmp4:
    cmp al, 0x84 ; has the 3 key released 
    jne nextcmp5 ; no, chain to old ISR 
    mov byte [es:0], ' ' ; yes, clear the second column 
    jmp exit ; leave interrupt routine
nextcmp5:
    cmp al, 0x85 ; has the 4 key released 
    jne nextcmp6 ; no, chain to old ISR 
    mov byte [es:0], ' ' ; yes, clear the second column 
    jmp exit ; leave interrupt routine
nextcmp6:
    cmp al, 0x90 ; has the Q key released 
    jne nextcmp7 ; no, chain to old ISR 
    mov byte [es:0], ' ' ; yes, clear the second column 
    jmp exit ; leave interrupt routine
nextcmp7:
    cmp al, 0x91 ; has the W key released 
    jne nextcmp8 ; no, chain to old ISR 
    mov byte [es:0], ' ' ; yes, clear the second column 
    jmp exit ; leave interrupt routine
nextcmp8:
    cmp al, 0x92 ; has the E key released 
    jne nextcmp9 ; no, chain to old ISR 
    mov byte [es:0], ' ' ; yes, clear the second column 
    jmp exit ; leave interrupt routine
nextcmp9:
    cmp al, 0x93 ; has the R key released 
    jne nextcmp10 ; no, chain to old ISR 
    mov byte [es:0], ' ' ; yes, clear the second column 
    jmp exit ; leave interrupt routine
nextcmp10:
    cmp al, 0x9e ; has the A key released 
    jne nextcmp11 ; no, chain to old ISR 
    mov byte [es:0], ' ' ; yes, clear the second column 
    jmp exit ; leave interrupt routine
nextcmp11:
    cmp al, 0x9f ; has the S key released 
    jne nextcmp12 ; no, chain to old ISR 
    mov byte [es:0], ' ' ; yes, clear the second column 
    jmp exit ; leave interrupt routine
nextcmp12:
    cmp al, 0xa0 ; has the D key released 
    jne nextcmp13 ; no, chain to old ISR 
    mov byte [es:0], ' ' ; yes, clear the second column 
    jmp exit ; leave interrupt routine
nextcmp13:
    cmp al, 0xa1 ; has the F key released 
    jne nextcmp14 ; no, chain to old ISR 
    mov byte [es:0], ' ' ; yes, clear the second column 
    jmp exit ; leave interrupt routine
nextcmp14:
    cmp al, 0xac ; has the Z key released 
    jne nextcmp15 ; no, chain to old ISR 
    mov byte [es:0], ' ' ; yes, clear the second column 
    jmp exit ; leave interrupt routine
nextcmp15:
    cmp al, 0xad ; has the X key released 
    jne nextcmp16 ; no, chain to old ISR 
    mov byte [es:0], ' ' ; yes, clear the second column 
    jmp exit ; leave interrupt routine
nextcmp16:
    cmp al, 0xae ; has the C key released 
    jne nextcmp17 ; no, chain to old ISR 
    mov byte [es:0], ' ' ; yes, clear the second column 
    jmp exit ; leave interrupt routine
nextcmp17:
    cmp al, 0xaf ; has the V key released 
    jne nomatch ; no, chain to old ISR 
    mov byte [es:0], ' ' ; yes, clear the second column 
    jmp exit ; leave interrupt routine
nomatch: 
    pop ax 
    jmp far [cs:oldisr] ; call the original ISR 
exit: 
    mov al, 0x20 
    out 0x20, al ; send EOI to PIC 
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
l1: 
    mov ah, 0 ; service 0 – get keystroke 
    int 0x16 ; call BIOS keyboard service 
    cmp al, 27 ; is the Esc key pressed 
    jne l1 ; if no, check for next key 
    mov ax, [oldisr] ; read old offset in ax 
    mov bx, [oldisr+2] ; read old segment in bx 
    cli ; disable interrupts 
    mov [es:9*4], ax ; restore old offset from ax 
    mov [es:9*4+2], bx ; restore old segment from bx 
    sti ; enable interrupts 
 mov ax, 0x4c00 ; terminate program 
 int 0x21 
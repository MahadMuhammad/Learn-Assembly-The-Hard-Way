; differentiate left and right shift keys with scancodes 
[org 0x0100] 
 jmp start 
; keyboard interrupt service routine 
oldisr: dd 0 ; space for saving old isr

InputFromUser:
        pusha           ;   Save the registers

        mov ah,0x0
        mov dl,0x0
        int 0x16
        mov [INPUT],al

        popa            ;   Restore the registers
        ret             ;   Return

kbisr: 
    push ax 
    push es 
    mov ax, 0xb800 
    mov es, ax ; point es to video memory 
    in al, 0x60 ; read a char from keyboard port 



    ;k0:
    ;    cmp al, 0x01 ; Esc
    ;    jne l2
    ;    mov byte [es:0], 'M'
    ;

    K1:
        cmp al, 0x02 ; Is 1 Pressed
        jne k2 ; no, try next comparison 
        mov byte [es:0], '1' ; yes, print 2 at top left 
        jmp nomatch ; leave interrupt routine 
    k2: 
        cmp al, 0x03 ; is 2 Pressed
        jne k3 ; no, try next comparison 
        mov byte [es:0], '2' ; yes, print 2 at top left 
        jmp nomatch ; leave interrupt routine
    k3:
        cmp al, 0x04 ; is 3 Pressed
        jne k4 ; no, try next comparison 
        mov byte [es:0], '3' ; yes, print 3 at top left 
        jmp nomatch ; leave interrupt routine
    k4:
        cmp al, 0x05 ; is 4 Pressed
        jne k5 ; no, try next comparison 
        mov byte [es:0], '4' ; yes, print 4 at top left 
        jmp nomatch ; leave interrupt routine
    k5:
        cmp al, 0x10 ; is Q Pressed
        jne k6 ; no, try next comparison 
        mov byte [es:0], 'Q' ; yes, print Q at top left 
        jmp nomatch ; leave interrupt routine
    k6:
        cmp al, 0x11 ; is W Pressed
        jne k7 ; no, try next comparison 
        mov byte [es:0], 'W' ; yes, print W at top left 
        jmp nomatch ; leave interrupt routine
    k7:
        cmp al, 0x12 ; is E Pressed
        jne k8 ; no, try next comparison 
        mov byte [es:0], 'E' ; yes, print E at top left 
        jmp nomatch ; leave interrupt routine
    k8:
        cmp al, 0x13 ; is R Pressed
        jne k9 ; no, try next comparison 
        mov byte [es:0], 'R' ; yes, print R at top left 
        jmp nomatch ; leave interrupt routine
    k9:
        cmp al, 0x1e ; is A Pressed
        jne k10 ; no, try next comparison 
        mov byte [es:0], 'A' ; yes, print A at top left 
        jmp nomatch ; leave interrupt routine
    k10:
        cmp al, 0x1f ; is S Pressed
        jne k11 ; no, try next comparison 
        mov byte [es:0], 'S' ; yes, print S at top left 
        jmp nomatch ; leave interrupt routine
    k11:
        cmp al, 0x20 ; is D Pressed
        jne k12 ; no, try next comparison 
        mov byte [es:0], 'D' ; yes, print D at top left 
        jmp nomatch ; leave interrupt routine
    k12:
        cmp al, 0x21 ; is F Pressed
        jne k13 ; no, try next comparison 
        mov byte [es:0], 'F' ; yes, print F at top left 
        jmp nomatch ; leave interrupt routine
    k13:
        cmp al, 0x2c ; is Z Pressed
        jne k14 ; no, try next comparison 
        mov byte [es:0], 'Z' ; yes, print Z at top left 
        jmp nomatch ; leave interrupt routine
    k14:
        cmp al, 0x2d ; is X Pressed
        jne k15 ; no, try next comparison 
        mov byte [es:0], 'X' ; yes, print X at top left 
        jmp nomatch ; leave interrupt routine
    k15:
        cmp al, 0x2e ; is C Pressed
        jne k16 ; no, try next comparison 
        mov byte [es:0], 'C' ; yes, print C at top left 
        jmp nomatch ; leave interrupt routine
    k16:
        cmp al, 0x2f ; is V Pressed
        jne nomatch ; no, try next comparison 
        mov byte [es:0], 'V' ; yes, print V at top left 
        jmp nomatch ; leave interrupt routine

nomatch: 
    mov al, 0x20 
    out 0x20, al ; send EOI to PIC 
    pop es 
    pop ax 
    iret 

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
end:
    mov ax, 0x4c00 ; terminate program 
    int 0x21 


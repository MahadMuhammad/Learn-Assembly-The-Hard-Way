[org 0x0100]
    jmp start


result: dw 1234 




printnum: 
        push bp 
        mov bp, sp 
        push es 
        push ax 
        push bx 
        push cx 
        push dx 
        push di 
        mov ax, 0xb800 
        mov es, ax ; point es to video base 
        mov ax, [bp+4] ; load number in ax 
        mov bx, 10 ; use base 10 for division 
        mov cx, 0 ; initialize count of digits    
nextdigit: 
        mov dx, 0 ; zero upper half of dividend 
        div bx ; divide by 10 
        add dl, 0x30 ; convert digit into ascii value 
        push dx ; save ascii value on stack 
        inc cx ; increment count of values 
        cmp ax, 0 ; is the quotient zero 
        jnz nextdigit ; if no divide it again 
        mov di, 0 ; point di to top left column   
nextpos: 
        pop dx ; remove a digit from the stack 
        mov dh, 0x07 ; use normal attribute 
        mov [es:di], dx ; print char on screen 
        add di, 2 ; move to next screen location 
        loop nextpos ; repeat for all digits on stack
        pop di 
        pop dx 
        pop cx 
        pop bx 
        pop ax 
        pop es 
        pop bp 
        ret 2 

clrscr: 
        push es 
        push ax 
        push cx 
        push di 
        mov ax, 0xb800 
        mov es, ax ; point es to video base 
        xor di, di ; point di to top left column 
        mov ax, 0x0720 ; space char in normal attribute 
        mov cx, 2000 ; number of screen locations 
        cld ; auto increment mode 
        rep stosw ; clear the whole screen 
        pop di
        pop cx 
        pop ax 
        pop es 
        ret

Delay:                    ;   Delay function 
        pusha             ;   Save the registers
	
        mov cx,0xffff     ;   Set the counter to 0xffff
	    
            LoopDelay:                  ;   LoopDelay label
	    	    loop LoopDelay      ;   Loop the LoopDelay label
        
        popa               ;   Restore the registers
        ret                ;   Return to the caller




start:
    call clrscr

    mov ah,0
    int 0x16
    push ax ; place number on stack 
    call printnum ; call the printnum subroutine
    call Delay
    call Delay
    call Delay
    call Delay
    call Delay
    jmp start

mov ax, 0x4c00
int 21h

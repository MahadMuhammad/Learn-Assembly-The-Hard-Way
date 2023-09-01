[org 0x0100]
    jmp start

message: db 'hello world ! I am studying assembly', 0 ; null terminated string
message2: db 'hello world !', 0 ; null terminated string
temp: db 0
temp2: dw 0


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

strlen: 
 push bp 
 mov bp,sp 
 push es 
 push cx 
 push di 
 les di, [bp+4] ; point es:di to string 
 mov cx, 0xffff ; load maximum number in cx 
 xor al, al ; load a zero in al 
 repne scasb ; find zero in the string 
 mov ax, 0xffff ; load maximum number in ax 
 sub ax, cx ; find change in cx 
 ;dec ax ; exclude null from length 
 pop di 
 pop cx 
 pop es 
 pop bp 
 ret 4 


printstr: push bp 
 mov bp, sp 
 push es 
 push ax 
 push cx 
 push si 
 push di 
 push ds ; push segment of string 
 mov ax, [bp+4] 
 push ax ; push offset of string 
 call strlen ; calculate string length
 cmp ax, 0 ; is the string empty 
 jz exit ; no printing if string is empty
 mov cx, ax ; save length in cx 
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov al, 80 ; load al with columns per row 
 mul byte [bp+8] ; multiply with y position 
 add ax, [bp+10] ; add x position 
 shl ax, 1 ; turn into byte offset 
 mov di,ax ; point di to required location 
 mov si, message ; point si to string 
 mov ah, [bp+6] ; load attribute in ah 
 cld ; auto increment mode 
 mov bx,0
 mov byte[temp],al
 mov word[temp2],cx
 mov cx,[temp2]

copymystr:
    mov al,[message+bx]
    mov byte[message2+bx], al
    inc bx
    loop copymystr

mov cx,[temp2]
mov al,[temp]
nextchar: lodsb ; load next char in al 
 stosw ; print char/attribute pair 
 mov byte[message2+bx], al
    inc bx
 
 loop nextchar ; repeat for the whole string 
 ;mov byte[message2+bx], 0
exit: pop di 
 pop si 
 pop cx 
 pop ax 
 pop es 
 pop bp 
 ret 8


 AnyKeyPress:                ;   Wait for any key press  (Used in Intro function)
        pusha               ;   Save the registers
        mov ah,0x00         ;   Set the interrupt number
        int 0x16            ;   Call the interrupt

        popa                ;   Restore the registers
        ret                 ;   Return (to the Intro function)


Delay:                    ;   Delay function 
        pusha             ;   Save the registers
	
        mov cx,0xffff     ;   Set the counter to 0xffff
	    
            LoopDelay:                  ;   LoopDelay label
	    	    loop LoopDelay      ;   Loop the LoopDelay label
        
        popa               ;   Restore the registers
        ret                ;   Return to the caller

LongDelay:
    call Delay
    call Delay
    call Delay
    call Delay
    call Delay
    call Delay
    call Delay
    call Delay
    call Delay
    call Delay
    call Delay
    call Delay
    call Delay
    call Delay
    call Delay
    call Delay
    call Delay
    ret
;   --------------------------------------------------------
start: 


;;first printing second message

call clrscr ; call the clrscr subroutine 
 mov ax, 0
 push ax ; push x position 
 mov ax, 0 
 push ax ; push y position 
 mov ax, 0x71 ; blue on white attribute 
 push ax ; push attribute 
 mov ax, message2 
 push ax ; push address of message 
 call printstr ; call the printstr subroutine


;; copied message to message2 & printing message 1

   ; call LongDelay
call clrscr ; call the clrscr subroutine 
 mov ax, 0
 push ax ; push x position 
 mov ax, 0 
 push ax ; push y position 
 mov ax, 0x71 ; blue on white attribute 
 push ax ; push attribute 
 mov ax, message 
 push ax ; push address of message 
 call printstr ; call the printstr subroutine

;call AnyKeyPress
 call LongDelay

 call clrscr ; call the clrscr subroutine 
 mov ax, 0
 push ax ; push x position 
 mov ax, 0 
 push ax ; push y position 
 mov ax, 0x71 ; blue on white attribute 
 push ax ; push attribute 
 mov ax, message2 
 push ax ; push address of message 
 call printstr ; call the printstr subroutine



 mov ax, 0x4c00 ; terminate program 
 int 0x21 
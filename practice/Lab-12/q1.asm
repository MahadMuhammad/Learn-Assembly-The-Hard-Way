[org 0x0100]
    jmp start

num1: dw   2,2,2,2,3
num1_size: dw 5
result: dw 0 



calculate_sum:
    ; initialize stuff 
    mov  ax, 0              ; reset the accumulator 
    mov  bx, 0              ; set the counter 
    
    mov cx,[num1_size]

    calculate_sum_loop: 

        add  ax, [num1 + bx]
        add  bx, 2

        loop calculate_sum_loop
    

    mov  [result], ax

    ret

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





start:
   
     
    call calculate_sum
    mov ax, [result] 
    push ax ; place number on stack 
    call printnum ; call the printnum subroutine

mov ax, 0x4c00
int 21h
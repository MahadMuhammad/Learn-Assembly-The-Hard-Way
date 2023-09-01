; bubble sort subroutine using swap subroutine 
[org 0x0100] 
 jmp start 
data: dw 10,9,8,7,6,5,4,3,2,1
dataLength: dw 10


swapflag: db 0 

temp: dw 0

temp2: dw 0

AnyKeyPress:                ;   Wait for any key press  (Used in Intro function)
        pusha               ;   Save the registers

        mov ah,0x00         ;   Set the interrupt number
        int 16h            ;   Call the interrupt

        popa                ;   Restore the registers
        ret                 ;   Return (to the Intro function)
;   --------------------------------------------------------

ClearScreen:                ;   CLear Screen with spaces
        pusha               ;   Save the registers  

        mov ax,0xb800       ;   Set the video memory address
        mov es,ax           ;   Set the video memory segment
        mov di,0            ;   Set a pointer to the start of the video memory
        mov ax,0x0720       ;   Set the attribute byte (0x0e)
        mov cx,2000         ;   Set the number of characters to write

        cld
        rep stosw           ;   Fill the video memory with the attribute byte

        popa                ;   Restore the registers
        ret                 ;   Return (to the Intro function)
;   --------------------------------------------------------
printarray:
    pusha

    mov ax, 0xb800 
    mov es, ax ; point es to video base 
    mov bx,[temp2]
    mov ax, [data+bx] ; load number in ax 
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
                mov di, [temp] ; point di to top left column 

                nextpos:
                            pop dx ; remove a digit from the stack 
                            mov dh, 0x07 ; use normal attribute 
                            mov [es:di], dx ; print char on screen 
                            add di, 2 ; move to next screen location 
                            loop nextpos ; repeat for all digits on stack 
    mov ax,0x0720
    mov [es:di],ax
    mov ax,[temp]
    add ax,4
    mov [temp],ax
    add word[temp2],2

    popa
    ret

bubblesort: 
        push bp ; save old value of bp 
        mov bp, sp ; make bp our reference point 
        push ax ; save old value of ax 
        push bx ; save old value of bx 
        push cx ; save old value of cx 
        push si ; save old value of si 
        mov bx, [bp+6] ; load start of array in bx 
        mov cx, [bp+4] ; load count of elements in cx 
        dec cx ; last element not compared 
        shl cx, 1 ; turn into byte count 
mainloop: 
        mov si, 0 ; initialize array index to zero 
        mov byte [swapflag], 0 ; reset swap flag to no swaps 
innerloop: 
        mov ax, [bx+si] ; load number in ax 
        cmp ax, [bx+si+2] ; compare with next number 
        jbe noswap ; no swap if already in order 
        xchg ax, [bx+si+2] ; exchange ax with second number 
        mov [bx+si], ax ; store second number in first 
        mov byte [swapflag], 1 ; flag that a swap has been done 
noswap: 
        add si, 2 ; advance si to next index 
        cmp si, cx ; are we at last index 
        jne innerloop ; if not compare next two 
        cmp byte [swapflag], 1 ; check if a swap has been done 
        je mainloop ; if yes make another pass 
        pop si ; restore old value of si 
        pop cx ; restore old value of cx 
        pop bx ; restore old value of bx 
        pop ax ; restore old value of ax 
        pop bp ; restore old value of bp 
        ret 4 ; go back and remove two params 
 




start: 
    call ClearScreen
        mov cx,10

        myloop:
            call printarray
            loop myloop

        mov word[temp],0
        mov word[temp2],0

        call AnyKeyPress
        
        call ClearScreen

        mov ax, data 
        push ax ; place start of array on stack 
        mov ax, 10 
        push ax ; place element count on stack 
        call bubblesort ; call our subroutine 

        mov cx,10

        myloop2:
            call printarray
            loop myloop2

mov ax, 0x4c00 ; terminate program 
int 0x21

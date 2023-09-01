[org 0x0100]

    jmp start
data: dw 1,2,3,4,5,6,7,8,9,10
data2: dw 328, 329, 898, 8923, 8293, 2345, 10, 877, 355, 98 
        dw 888, 533, 2000, 1020, 30, 200, 761, 167, 90, 5 


bubblesort:
    push bp
    mov bp,sp
    sub sp,2

    push ax
    push bx
    push cx
    push si

    mov ax,[bp+6] ; starting value of data
    mov cx, [bp+4]
    dec cx
    shl cx,1

    mainloop:
        mov si,0
        mov word[bp-2],0  ;local variable

        innerloop:
            mov ax,[bx+si]
            cmp ax,[bx+si+2]
            jbe noswap
            
            xchg ax,[bx+si+2]
            mov ax,[bx+si]
            mov word[bp-2],1 ; flag swap has done

            noswap:
                add si,2
                cmp si,cx
                jne innerloop

                cmp word [bp-2],1
                je mainloop

                pop si
                pop cx
                pop bx
                pop ax
                mov sp,bp
                pop bp
                ret 4

start:
    mov ax,data
    push ax
    mov ax,10
    push ax

    call bubblesort


mov ax,0x4c00
int 21h
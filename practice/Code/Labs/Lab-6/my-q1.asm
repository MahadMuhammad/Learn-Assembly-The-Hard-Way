[org 0x0100]
    jmp start

array: db 0,0,0,0,0,0,0,0,0,0



FillArray:         
            push bp ; save old value of bp
            mov bp, sp ; make bp our reference point
            push ax ; save old value of ax
            push bx ; save old value of bx
            push cx ; save old value of cx
            push si ; save old value of si   

            mov bx, [bp+7] ; load start of array in bx
            
mainloop: 
            mov si, 0 ; initialize array index to zero

FillArray2:
            mov bx,0
            mov cx,10
            mov [array+bx],cx
            inc bx
            dec cx
            cmp cx,0
            jz FillArray2

            ret

start: 
            mov ax,array
            push ax 
            mov ax,10
            push ax 
            call FillArray;  subroutine called







end:
            mov ax, 0x4c00
            int 0x21

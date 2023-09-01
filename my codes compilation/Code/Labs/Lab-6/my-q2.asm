[org 0x0100]
    jmp start




Stack:         
            push bp ; save old value of bp
            mov bp, sp ; make bp our reference point
            push ax ; save old value of ax
            push bx ; save old value of bx
            push cx ; save old value of cx
            push si ; save old value of si   

            mov ax, 1 ; load start of array in bx
            mov bx,2
            mov cx,3
            
mainloop: 
            cmp ax,bx
            jz second

third:
            mov dx,bx
            ret
second: 
            mov dx,ax
            cmp bx,cx
            jz  third



start: 
            mov ax,1
            push ax 
            mov ax,2
            push ax 
            mov ax,3
            push ax 
            call Stack;  subroutine called







end:
            mov ax, 0x4c00
            int 0x21

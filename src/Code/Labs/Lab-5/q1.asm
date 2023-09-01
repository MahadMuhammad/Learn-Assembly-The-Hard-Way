[org 0x0100]

        jmp start


start:  mov ax,30
        mov bx,20
        mov cx,10


        cmp ax,bx
        jl start2


start2:     cmp bx,cx
            jl l3
            mov dx,1
            jmp end

l3:         mov dx,0

end:    mov ax,0x4c00
        int 0x21
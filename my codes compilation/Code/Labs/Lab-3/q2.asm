[org 0x0100] 
    mov ax,0
    mov bx,0

 l1:    mov cx,[digits+0]
        add ax,2
        cmp [temp], cx
        jnz l1

nf:   mov ax,0x4c00 ; terminate program
            int 0x21



digits :dw 1,1,2,1,1,-1
temp :dw 1,1,2,1,1

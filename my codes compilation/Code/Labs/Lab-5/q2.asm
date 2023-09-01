[org 0x0100]

        mov ax,1        ;ax=1             
        mov bx,0        ;bx=0
        mov si,0

start:  add si,1         ; counts number of times the loop continues
        add bx,ax       ; bx= 1+0 =1 
        add ax,3        ; ax=1+3=4
        cmp si,65535
        jo start;

 l2:       mov dx,7        

end:    mov ax,0x4c00
        int 0x21
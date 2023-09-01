; hello world in assembly
[org 0x0100]
        jmp start

num: dw 1234
 denum: dw 0

reset:     

        mov ax,0
        mov bx,0
        mov cx,0
        mov dx,0        
        ret

start: 
        
        mov ax,[num]
          mov bx,10
          div bx 
          
          mov [num],ax 
          mov ax,10
          mul dx
          
          mov [denum],ax

         mov ax,0
        mov bx,0
        mov cx,0
        mov dx,0 
;2
mov ax,[num]
          mov bx,10
          div bx 
          
          mov [num],ax 
          mov ax,10
          mul dx
          
          mov [denum],ax
          
         mov ax,0
        mov bx,0
        mov cx,0
        mov dx,0 
;3
mov ax,[num]
          mov bx,10
          div bx 
          
          mov [num],ax 
          mov ax,10
          mul dx
          
          mov [denum],ax
          
         mov ax,0
        mov bx,0
        mov cx,0
        mov dx,0 
;4
mov ax,[num]
          mov bx,10
          div bx 
          
          mov [num],ax 
          mov ax,10
          mul dx
          
          mov [denum],ax
          
         mov ax,0
        mov bx,0
        mov cx,0
        mov dx,0 

 mov ax, 0x4c00 ; terminate program
 int 0x21
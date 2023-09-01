[org 0x0100]

jmp start

numbers:dw 5,18,9


maxno:
push bp
mov bp,sp
push 0 ;creating local variable
;push ax
push si
push dx

mov si,8

mov ax,[bp+si]
mov [bp-2],ax

loop1:
mov ax,[bp+si]
cmp ax,[bp+si-2]
jae lop2


mov dx,[bp+si-2]
mov [bp-2],dx

lop2:
sub si,2
cmp si,4
jne loop1

mov ax,[bp-2]
pop dx
pop si
add sp,2
pop bp

ret 6





start:
push bx
mov bx,0
loop12:
mov ax,[numbers+bx]
push ax
add bx,2
cmp bx,6
jne loop12
 
 call maxno
 pop bx
 


mov ax,0x4c00
int 0x21
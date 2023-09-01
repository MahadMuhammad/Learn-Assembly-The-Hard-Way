[org 0x0100]
jmp start
scrollleft:
mov ax,0xb800
mov es,ax
mov ds,ax
mov cx,40
l0:
push cx
mov di,0
mov si,2
mov cx,25
l1:
push cx
mov cx,80
cld
rep movsw

pop cx
loop l1

push di
mov di,158
mov cx,25
mov ax,0x0720
l2:
mov [es:di],ax
add di,160

loop l2
pop di
pop cx
loop l0
ret
start:
call scrollleft
mov ah,0x1
int 0x21
mov ax,0x4c00
int 0x21
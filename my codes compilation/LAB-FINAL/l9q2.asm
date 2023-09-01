[org 0x0100]
jmp start
string1: db 'zaki haider',0
strlen:
push bp
mov bp, sp
push ax
push es
push dx
push cx
;bp + 4 has the message
mov ax, ds
mov es, ax
mov di, [bp+4]
mov cx, 0xffff
mov ax, 0
repne scasb
mov ax, 0xffff
sub ax, cx
sub ax, 1
mov [bp+6], ax
pop cx
pop dx
pop es
pop ax
pop bp
ret 2
reverseKardenPlease:
push bp
mov bp, sp
push ax
push bx
push si
push di
mov si,0
mov di, 0
mov ax, [bp+4]
sub sp,2
push ax
call strlen
pop di
sub di, 1
mov bx, [bp+4]
l1:
mov al, [bx+si]
xchg al, [bx+di]
mov [bx+si], al
add si, 1
sub di, 1
cmp si, di
jbe l1
pop di
pop si
pop bx
pop ax
pop bp
ret 2
printStr:
push bp
mov bp, sp
;bp+4 has the the row
;bp+6 has the col
;bp+8 has the message
mov si, [bp+8]
sub sp,2
push si
call strlen
pop cx
mov ax, [bp+4]
mov bx, 80
mul bx
add ax, [bp+6]
shl ax,1
mov di, ax ; designation cell address
mov dx, 0xb800
mov es,dx
cld
mov ah, 0x0b
l2:
lodsb
stosw
loop l2
pop bp
ret 2
clrscr:
push di
push ax
push es
mov di, 0
mov ax, 0xb800
mov es, ax
l12:
mov word [es:di],0x0720
add di, 2;
cmp di, 4000
jne l12
pop es
pop ax
pop di
ret
start:
mov ax, string1
push ax
mov ax,1
push ax
push ax
call printStr
mov ax, string1
push ax
call reverseKardenPlease
push ax
mov ax,2
push ax
push ax
call printStr
mov ax, 0x4C00
int 0x21
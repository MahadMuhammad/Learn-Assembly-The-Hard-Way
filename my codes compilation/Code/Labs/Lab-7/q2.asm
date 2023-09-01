
[org 0x100]
jmp start

clearscreen:
push bp
mov bp, sp
push ax
push es
push cx
push bx
mov cx, 2000
mov ax, 0xb800
mov es, ax
mov bx, 0
loop1:
mov word[es:bx], 0x0720
add bx, 2
loop loop1
pop bx
pop cx
pop es
pop ax
pop bp
ret

draw:
push bp
mov bp, sp
push ax
push cx
push bx
push es

mov ax, 0xb800
mov es, ax
mov bx, 0
mov cx, 79
mov word[es:bx], 0x72a
add bx, 2
loop2:
call delay
mov word[es:bx - 2], 0x720
mov word[es:bx], 0x72a
add bx, 2
loop loop2
call delay
mov word[es:bx - 2], 0x720

mov bx, 318
mov word[es:bx], 0x72a
add bx, 160
mov cx, 23
loop4:
call delay
mov word[es:bx - 160], 0x720
mov word[es:bx], 0x72a
add bx, 160
loop loop4
call delay
mov word[es:bx - 160], 0x720

mov bx, 3998
mov cx, 79
mov word[es:bx], 0x72a
sub bx, 2
loop5:
call delay
mov word[es:bx + 2], 0x720
mov word[es:bx], 0x72a
sub bx, 2
loop loop5
call delay
mov word[es:bx + 2], 0x720

mov bx, 3680
mov word[es:bx], 0x72a
sub bx, 160
mov cx, 23
loop6:
call delay
mov word[es:bx + 160], 0x720
mov word[es:bx], 0x72a
sub bx, 160
loop loop6
call delay
mov word[es:bx + 160], 0x720

pop es
pop bx
pop cx
pop ax
pop bp
ret

delay:
push bp
mov bp, sp
push ax
mov ax, 0xFFFF
loop3:
sub ax, 1
cmp ax, 0
jne loop3
pop ax
pop bp
ret

start:
call clearscreen
call draw
mov ax, 0x4c00
int 21h
[org 0x0100]
jmp start
clrscr:
push di
push ax
push es
mov di, 0
mov ax, 0xb800
mov es, ax
l1:
mov word [es:di],0x0720
add di, 2;
cmp di, 4000
jne l1
pop es
pop ax
pop di
ret
sleep:
push ax
push bx
mov ax, 0x01ef
ol:
mov bx, 0x00ff
il:
sub bx,1
jnz il
sub ax, 1
jnz ol
pop ax
pop bx
ret
counter:
push bp
mov bp, sp
push ax
push bx
push cx
push dx
push si
push di
mov ax, 0xb800
mov es, ax
; bp + 4 has the cell value
; bp + 6 has the cell location
; bp + 8 has the attr
mov ax, [bp+4]
mov di, [bp+6]
mov bx, 0x10
mov cx, 0
l4:
mov dx, 0
div bx
add dx, 0x30
mov dh, [bp+8]
push dx
add cx,1
cmp ax,0
jnz l4
l5:
pop dx
mov word [es:di], dx
add di, 2
loop l5
mov dh, [bp+8]
mov dl , 0x07
mov word [es:di], dx
pop di
pop si
pop dx
pop cx
pop bx
pop ax
pop bp
ret 4
start:
mov ax, 0
mov di , 160
mov cx,2000
l2:
call clrscr
mov dx, 0xb7
push dx
push di
push ax
call counter
call sleep
add ax, 1
add di, 2
call clrscr
mov dx, 0x07
push dx
push di
push ax
call counter
call sleep
add ax, 1
add di, 2
loop l2
mov ax, 0x4C00
int 0x21
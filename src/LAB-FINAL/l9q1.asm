[org 0x0100]
jmp start
string1: db 'Mr. Ali, Usman, & Anwar! Doing what???? want to travel????',0
string2: db 'Mr. Ali, Usman, & Anwar! Doing what???? want to travel????',0
removePunctations:
push bp ; save the base pointer
mov bp, sp          ; set the base pointer
; bp+4 s1
; bp+6 s2
mov si, [bp+4]          ; si = s1
mov di, [bp+6]          ; di = s2
sub sp,2                ; reserve 2 bytes on the stack
push si                 ; push si on the stack
call strlen             ; call strlen
pop cx                  ; pop cx from the stack
l3:                    ; loop l3
lodsb              ; load a byte from si to al
cmp al, '?'
je ex
cmp al, '.'
je ex
cmp al, '&';
je ex
cmp al ,' '
je ex
cmp al,','
je ex
cmp al,'!'
je ex
mov byte [di], al
add di,1
ex:
loop l3
mov byte [di],0
pop bp
ret 4
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
call clrscr
mov ax, string2
push ax
mov ax, string1
push ax
call removePunctations
mov ax, string1
push ax
mov ax, 1
push ax
push ax
call printStr
mov ax, string2
push ax
mov ax, 1
push ax
mov ax, 2
push ax
call printStr
mov ax, 0x4C00
int 0x21
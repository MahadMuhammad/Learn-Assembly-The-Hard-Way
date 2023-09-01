[org 0x0100]
jmp code
w equ 50 ; width offset
x equ 50 ; starting x coordinate of line
y equ 100 ; starting y coordinate of line
c equ 60 ; color
code:
mov ah, 0
mov al, 13h
int 10h
; draw diagonal 11:
mov cx, x
mov dx, y
mov al, c
u1:
inc dx
mov ah, 0ch ; put pixel
int 10h
inc cx
cmp cx, x+w
jbe u1
;wait for keypress
;mov ah,00
;int 16h
u2:
dec dx
mov ah, 0ch ; put pixel
int 10h
inc cx
cmp cx, x+y
jbe u2
;wait for keypress
;mov ah,00
;int 16h
mov cx, 50
mov dx, 100
mov al, c
u3:
dec dx
mov ah, 0ch ; put pixel
int 10h
inc cx
cmp cx, x+w
jbe u3
;wait for keypress
;mov ah,00
;int 16h
u4:
inc dx
mov ah, 0ch ; put pixel
int 10h
inc cx
cmp cx, x+y
jbe u4
;wait for keypress
mov ah,00
int 16h
mov ax, 0x4c00
int 21h
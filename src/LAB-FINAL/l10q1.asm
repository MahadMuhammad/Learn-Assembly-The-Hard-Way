[org 0x0100]
jmp start

printstr:
        push bp
        mov bp, sp
        push es
        push ax
        push cx
        push si
        push di
        push ds
        pop es ; load ds in es
        mov di, [bp+4] ; point di to string
        mov cx, 0xffff ; load maximum number in cx
        xor al, al ; load a zero in al
        repne scasb ; find zero in the string
        mov ax, 0xffff ; load maximum number in ax
        sub ax, cx ; find change in cx
        dec ax ; exclude null from length
        jz exit ; no printing if string is empty
        mov cx, ax ; load string length in cx
        mov ax, 0xb800
        mov es, ax ; point es to video base
        mov al, 80 ; load al with columns per row
        mul byte [bp+8] ; multiply with y position
        add ax, [bp+10] ; add x position
        shl ax, 1 ; turn into byte offset
        mov di,ax ; point di to required location
        mov si, [bp+4] ; point si to string
        mov ah, [bp+6] ; load attribute in ah
        cld ; auto increment mode
nextchar2:
lodsb ; load next char in al
stosw ; print char/attribute pair
loop nextchar2 ; repeat for the whole string
exit:
pop di
pop si
pop cx
pop ax
pop es
pop bp
ret 8
clrscr:
push es
push ax
push di
mov ax,0xb800
mov es,ax
mov di,0
nextloc:
mov word[es:di],0x0720
add di,2
cmp di,4000
jne nextloc
pop di
pop ax
pop es
ret
printscr:
push bp
mov bp,sp
push es
push ax
push cx
push si
push di
mov ax,0xb800
mov es,ax
mov al,80
mul byte [bp+10]
add ax,[bp+12]
shl ax,1
mov di,ax
mov si,[bp+6]
mov cx,[bp+4]
mov ah,[bp+8]
nextchar:
mov al,[si]
mov [es:di],ax
add di,2
add si,1
loop nextchar
pop di
pop si
pop cx
pop ax
pop es
pop bp
ret 10
m1: db "Hi! I am Syed zaki haider.", 0
m2: db "I am sad.", 0
m3: db "I am from FAST.", 0
m4: db "Roll no : 21l-5290.",0
start:
call clrscr
mov ah, 0x10 ; service 10 – vga attributes
mov al, 03 ; subservice 3 – toggle blinking
mov bl, 01 ; enable blinking bit
int 0x10 ; call BIOS video service
mov ah, 0 ; service 0 – get keystroke
int 0x16 ; call BIOS keyboard service
call clrscr ; clear the screen
mov ah, 0 ; service 0 – get keystroke
int 0x16 ; call BIOS keyboard service
mov ax, 35
push ax ; push x position
mov ax, 10
push ax ; push y position
mov ax, 0x07 ; blue on black
push ax ; push attribute
mov ax, m1
push ax ; push offset of string
call printstr ; print the string
mov ah, 0 ; service 0 – get keystroke
int 0x16 ; call BIOS keyboard service
mov ax, 35
push ax ; push x position
mov ax, 11
push ax ; push y position
mov ax, 0x07 ; blue on white
push ax ; push attribute
mov ax, m2
push ax ; push offset of string
call printstr ; print the string
mov ah, 0 ; service 0 – get keystroke
int 0x16 ; call BIOS keyboard service
mov ax, 35
push ax ; push x position
mov ax, 12
push ax ; push y position
mov ax, 0x07 ; red on white blinking
push ax ; push attribute
mov ax, m3
push ax ; push offset of string
call printstr ; print the string
mov ah, 0 ; service 0 – get keystroke
int 0x16 ; call BIOS keyboard service
mov ax, 35
push ax ; push x position
mov ax, 13
push ax ; push y position
mov ax, 0x07 ; red on white blinking
push ax ; push attribute
mov ax, m4
push ax ; push offset of string
call printstr ; print the string
mov ah, 0 ; service 0 – get keystroke
int 0x16 ; call BIOS keyboard service
mov ax, 0x4c00 ; terminate program
int 0x21

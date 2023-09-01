[org 0x0100]
jmp start
clrscr: push es
push ax
push di
mov ax, 0xb800
mov es, ax 
mov di, 0 
nextloc: mov word [es:di], 0x0720 
add di, 2 
cmp di, 4000 
jne nextloc
pop di
pop ax
pop es
ret
printnum: push bp
mov bp, sp
push es
push ax
push bx
push cx
push dx
push di
mov ax, 0xb800
mov es, ax 
mov ax, [bp+4] 
mov bx, 10 
mov cx, 0 
nextdigit: mov dx, 0 
div bx
add dl, 0x30 
push dx
inc cx 
cmp ax, 0 
jnz nextdigit 
mov di, [bp+6]
nextpos: pop dx 
mov dh, 0x07 
mov [es:di], dx 
add di, 2 
loop nextpos 
pop di
pop dx
pop cx
pop bx
pop ax
pop es
pop bp
ret 4
start:
call clrscr
waitForMouseClick:
mov ax, 0001h 			;to show mouse
int 33h
mov ax,0003h
int 33h
or bx,bx
jz short waitForMouseClick
mov ax, 0002h 			;hide mouse after clicking
int 33h
push 170                        ;printing index 
push cx                         ;cx has x coordinate. Value of x is in pixels
call printnum 			;call the printnum subroutine
push 270                        ;printing index
push dx                         ;dx has y coordinate. Value of y is in pixels
call printnum                   ;call the printnum subroutine

mov si,dx                    
mov dx,0
mov ax,cx
mov bx,8
div bx                         ;dividing by 8 to convert it into row column format.
push 330                       ;printing index
push ax
call printnum 		       ;call the printnum subroutine
mov ax,si
mov dx,0
div bx                         ;dividing by 8 to convert it into row column format.
push 430                       ;printing index
push ax                         
call printnum                  ;call the printnum subroutine
mov ax, 0x4c00 ; terminate program
int 0x21
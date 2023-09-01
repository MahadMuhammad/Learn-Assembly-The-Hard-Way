[org 0x0100]

jmp start
bits_str: dw 1110111100001010b
pattern:dw 1111110b
index: dw 0
found:

	push bp
	mov bp,sp
	push ax
	push bx
	push cx
	push dx
	push si
	
	mov  ax,[bp+6] ;1st 16 bit number 
	mov  dx,[bp+6] ;1st 16 bit number
	mov  bx,[bp+4] ;n bit pattren
	
	mov cx,16
	mov si,16

loop1:

	sub cx,1
	cmp cx,0
	je  notexist
	cmp ax,bx
	je exist
	shr dx,1
	mov ax,dx
	cmp al,bl
	je exist
	jmp loop1

exist:

	sub si,cx
	mov bx,[bp+8]
	mov [bx],si
	jmp terminate

notexist:

	mov cx,-1
	mov bx,[bp+8]
	mov [bx],cx

terminate:

	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp
	ret 6

start:mov ax,index
	push ax
	mov ax,[bits_str] ;16bit number
	push ax
	mov ax,[pattern] ;nbit pattren
	push ax
	call found
mov ax,0x4c00
int 0x21
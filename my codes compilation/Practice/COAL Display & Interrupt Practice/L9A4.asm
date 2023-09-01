	[org 0x0100]

	jmp start

clrscr:
	push ax
	push es
	push di
	push cx	

	mov ax, 0xb800
	mov es, ax
	mov di, 0

	mov cx, 2000
	mov ax, 0x0720

	rep stosw

	pop cx
	pop di
	pop es
	pop ax
	ret

printnum:							;Receives the number to print as well as the print location as parameters
	push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push di

	mov ax, 0xb800
	mov es, ax
	mov ax, [bp+6]
	mov bx, 10
	mov cx, 0

nextdigit:	
	mov dx, 0
	div bx
	add dl, 0x30
	push dx
	inc cx
	cmp ax, 0
	jnz nextdigit

	mov di, [bp+4]

nextpos:
	pop dx
	mov dh, 0xFA
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

sleep:
	push ax
	push cx

	mov cx, 0x000F

sleepl1:
	mov ax, 0x5FFF
	
sleepl2:
	dec ax
	cmp ax, 0
	ja sleepl2

	dec cx
	cmp cx, 0
	ja sleepl1
	
	pop cx
	pop ax
	ret

RANDOMPOS:							;Requires space for the output. Receives a seed/number as a parameter
	push bp
	mov bp, sp
	push ax
	push bx
	push dx

	mov ax, [bp+4]

	shl ax, 2
	mul al
		
	cmp ax, 3998
	jae decrease

decrease:
	sub ax, 520
	cmp ax, 3998
	jae decrease
	
RANDOMPOSEnd:
	mov [bp+6], ax
	
	pop dx
	pop bx
	pop ax
	pop bp
	ret 2

start:
	mov cx, 0
	
	mov ax, 0xb800
	mov es, ax
	
	mov di, 0

l1:
	push cx
	call RANDOMPOS

	pop ax
	
	push cx
	push ax

	call printnum

	call sleep
	call clrscr

	inc cx
	add di, 2
	cmp di, 3998
	je topRow
	jmp l1

topRow:
	mov di, 0
	jmp l1

	mov ax, 0x4c00
	int 0x21
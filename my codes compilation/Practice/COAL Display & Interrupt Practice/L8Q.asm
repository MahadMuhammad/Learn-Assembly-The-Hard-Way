	[org 0x0100]

	jmp start

m1: db 'Name: Muhammad Ali Butt', 0
m2: db 'Institute: FAST-NUCES', 0
m3: db 'Batch 2021', 0
m4: db 'Roll number: 21L-7646', 0
m5: db 'Lorem ipsum dolor', 0

sleep:
	push ax
	push cx

	mov cx, 0x000F

sleepl1:
	mov ax, 0xFFFF
	
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

printstrWithLength:
	push bp
	mov bp, sp
	push es
	push ax
	push cx
	push si
	push di
	
	mov ax, 0xb800
	mov es, ax

	mov cx, [bp+4]

	mov ax, 80
	mul byte [bp+10]
	add ax, [bp+12]
	shl ax, 1

	mov di, ax

	mov si, [bp+6]
	
	mov ah, [bp+8]

	cld
	
nextchar:
	lodsb
	stosw
	loop nextchar	
	
	pop di
	pop si
	pop cx
	pop ax
	pop es
	pop bp
	ret 10

strlen:
	push bp
	mov bp, sp
	push es
	push cx
	push di

	les di, [bp+4]
	mov cx, 0xFFFF
	mov al, 0
	repne scasb
	mov ax, 0xFFFF
	sub ax, cx
	dec ax

	pop di
	pop cx
	pop es
	pop bp
	ret 4

printstr:
	push bp
	mov bp, sp
	push es
	push ax
	push cx
	push si
	push di

	push ds
	push word [bp+4]

	call strlen
	;ax now has the length of the string

	cmp ax, 0
	jz exit
	mov cx, ax

	mov ax, 0xb800
	mov es, ax
	mov al, 80
	mul byte [bp+8]
	add ax, [bp+10]

	shl ax, 1
	mov di, ax
	
	mov si, [bp+4]
	mov ah, [bp+6]

	cld

printstrl1:
	lodsb
	stosw
	loop printstrl1

exit:
	pop di
	pop si
	pop cx
	pop ax
	pop es
	pop bp
	ret 8

scrollup:
	push bp
	mov bp, sp
	push ax
	push cx
	push si
	push di
	push es
	push ds

	mov ax, 80
	mul byte [bp+4]
	mov si, ax
	push si
	shl si, 1

	mov cx, 2000
	sub cx, ax

	mov ax, 0xb800
	mov es, ax
	mov ds, ax

	mov di, 0
	
	cld

	rep movsw
	
	mov ax, 0x0720
	pop cx
	rep stosw
	
	pop ds
	pop es
	pop di
	pop si
	pop cx
	pop ax
	pop bp
	ret 2

start:
	call sleep

	call clrscr

	push word 30			;x-position
	push word 10			;y-position
	push word 0xFA			;Attribute
	push word m1
	call printstr
	call sleep	

	push word 1
	call scrollup

	push word 30			;x-position
	push word 10			;y-position
	push word 0xFA			;Attribute
	push word m2
	call printstr
	call sleep
	
	push word 1
	call scrollup

	push word 30			;x-position
	push word 10			;y-position
	push word 0xFA			;Attribute
	push word m3
	call printstr
	call sleep
	
	push word 1
	call scrollup

	push word 30			;x-position
	push word 10			;y-position
	push word 0xFA			;Attribute
	push word m4
	call printstr
	call sleep
	
	push word 1
	call scrollup

	push word 30			;x-position
	push word 10			;y-position
	push word 0xFA			;Attribute
	push word m5
	call printstr
	call sleep
	
	mov ah, 0x1
	int 0x21	

	mov ax, 0x4c00
	int 0x21
















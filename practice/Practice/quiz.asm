	[org 0x0100]

	jmp start

copyAFDIntro:
	push ax
	push ds
	push si
	push es
	push di
	push cx

	mov ax, 0xb800
	mov es, ax
	mov ds, ax

	mov si, 0
	mov di, 2880

	mov cx, 560
	
	cld

	rep movsw

	pop cx
	pop di
	pop es
	pop si
	pop ds
	pop ax
	ret

start:
	call copyAFDIntro

	mov ah, 0x1
	int 0x21

	mov ax, 0x4c00
	int 0x21	
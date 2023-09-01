[org 0x0100]
	mov si,0
l1:		mov bx,[Array1+si]
		add ax,3
		inc si
		cmp	si,10
		jl l1
mov ax, 0x4c00
int 0x21

Array1: dw 1,2,3,4,5,6,7,8,9,10
Array_x3: dw 0,0,0,0,0,0,0,0,0,0
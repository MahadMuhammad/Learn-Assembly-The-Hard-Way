[org 0x0100]
	mov dx,[Number]
	
	mov si,0
	mov di,[Number]
l1:		add ax,di
		dec dx
		mov di,dx
		inc si
		cmp si,dx
		jl l1
		
mov ax, 0x4c00
int 0x21

Number: db 10
Factorial: dw 0
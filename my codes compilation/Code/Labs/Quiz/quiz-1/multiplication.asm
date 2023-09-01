[org 0x0100] ;generic multiplication func. to mul. 5 & 2
	mov si,0
	mov di,5
l1:		add ax,di
		mov di,5
		inc si
		cmp si,2
		jl l1
	
	
	
mov ax, 0x4c00
int 0x21



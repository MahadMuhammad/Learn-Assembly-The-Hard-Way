[org 0x0100]
	
	mov bx,0 ;initialize array index
	mov ax,0 ;initialize sum to zero
	
	mov ax,	[array1+bx]
	add ax, [array2+bx]
	mov [array3+bx],ax
	
	add bx,2
	mov ax,	[array1+bx]
	add ax, [array2+bx]
	mov [array3+bx],ax
	
	add bx,2
	mov ax,	[array1+bx]
	add ax, [array2+bx]
	mov [array3+bx],ax
	
	add bx,2
	mov ax,	[array1+bx]
	add ax, [array2+bx]
	mov [array3+bx],ax
	
	add bx,2
	mov ax,	[array1+bx]
	add ax, [array2+bx]
	mov [array3+bx],ax
	
	add bx,2
	mov ax,	[array1+bx]
	add ax, [array2+bx]
	mov [array3+bx],ax
	
	add bx,2
	mov ax,	[array1+bx]
	add ax, [array2+bx]
	mov [array3+bx],ax
	
	add bx,2
	mov ax,	[array1+bx]
	add ax, [array2+bx]
	mov [array3+bx],ax
	
	add bx,2
	mov ax,	[array1+bx]
	add ax, [array2+bx]
	mov [array3+bx],ax
	
	add bx,2
	mov ax,	[array1+bx]
	add ax, [array2+bx]
	mov [array3+bx],ax
	
mov ax, 0x4c00 ; terminate program
int 0x21	
array1: dw 101, 200, 500,320,550, 632, 400, 100, 200, 900 ;variables
array2: dw 50, 99, 256, 230, 550, 600, 220, 100, 200, 300
array3: dw 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
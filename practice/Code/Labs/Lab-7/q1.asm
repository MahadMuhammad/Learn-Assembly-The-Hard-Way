[org 0x0100]
jmp start
printnum:
        push bp
        mov bp,sp
		push ax
		push bx
		push dx
		
		mov ax,[bp+4]
		mov bx,10
		
digits:
        mov dx,0	
		div bx
		add dx,0x30
		cmp ax,0
		jnz digits
		mov [array],dx
		
		pop dx
		pop bx
		pop ax
		mov sp,bp
		pop bp
		ret 2	

start:
        mov ax,1234
        push ax
        call printnum
mov ax,0x4c00
int 0x21
array:dw 0

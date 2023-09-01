
[org 0x0100]
	jmp start

	found: db 'found'
	notfound: db 'notfound'
	array: dw 1, 2, 3, 4, 5, 6, 7
	size: dw 7
	find_key: dw 0

cls:		mov ax, 0xb800
		mov es, ax
		mov di, 0
clear_screen:
		mov word[es:di], 0x0720
		add di, 2
		cmp di, 4000
		jne clear_screen
		ret

printfound:	call cls
		push si
		push di
		push ax
		push cx

		mov si, found
		mov di, 160
		mov ax, 0xb800
		mov es, ax
		mov cx, 5		
print:		mov al, [si]	
		mov ah, 0x82
		mov word[es:di], ax
		add si, 1
		add di, 2
		loop print
		pop cx
		pop ax
		pop di
		pop si
		ret 

printnotfound:	call cls
		push si
		push di
		push ax
		push cx

		mov si, notfound
		mov di, 160
		mov ax, 0xb800
		mov es, ax
		mov cx, 8		;load lenght of string
print_:		mov al, [si]		; load character
		mov ah, 0x04
		mov word[es:di], ax
		add si, 1
		add di, 2
		loop print_
		pop cx
		pop ax
		pop di
		pop si
		ret 

search_key:
		push bp
		mov bp, sp
		push ax
		push bx
		push si
		push cx
		push dx
		mov bx, [bp + 8]	
		mov cx, [bp + 6]
		mov ax, [bp + 4]
		mov si, 0
mainloop:
		mov dx, [bx + si]
		cmp dx, ax
		je end_
		add si, 2
		loop mainloop
		pop dx
		pop cx
		pop si
		pop bx
		pop ax
		pop bp
		call printnotfound
		ret 6

end_:		pop dx
		pop cx
		pop si
		pop bx
		pop ax
		pop bp
		call printfound
		ret 6

start:		;call cls
		mov bx, array	
		push bx
		mov ax, [size]
		push ax
		mov word[find_key], 5
		push word[find_key]
		call search_key
		mov ax, 0x4c00
		int 0x21

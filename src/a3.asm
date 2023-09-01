[org 0x100]
	jmp start
	string : db 'I am a student of COAL', 0
	substring : db 'student', 0
	
	start:

	call Main
	
	mov ax, 0x4c00
	int 21h
	
	
Main:
	mov bx, string
	push string
	mov bx, substring
	push substring
	
	call findSubstring
	
	pop di
	pop si
	
	mov bx, string
	push string
	push si
	push di
	
	call printStringH
	
	ret
	
findSubstring:
	push bp
	mov bp, sp
	push ax
	push bx
	push si
	push di
	
	mov bx, [bp + 4]
	mov di, [bp + 6]
	mov si, 0
	
	substringL1:
		mov al, 0
		cmp [di], al
		je breakSSL1
		cmp [bx+si], al
		je foundSubstring
		
		mov al, [di]
		cmp [bx+si], al
		je foundLetter
		backSSL1:
			inc di
			
		jmp substringL1
	
	breakSSL1:
		mov ax, 0
		mov [bp + 4], ax
		mov [bp + 6], ax
		
	backSS:
		
	pop di
	pop si
	pop bx
	pop ax
	pop bp
	ret
	
foundLetter:
	inc si
	jmp backSSL1
	
foundSubstring:
	mov bx, [bp + 6]
	sub di, bx
	mov [bp + 4], di
	sub di, si
	mov [bp + 6], di
	jmp backSS
	

printStringH:
	push bp
	mov bp, sp
	push ax
	push bx
	push si
	push di
	push es
	
	mov bx, [bp + 8]
	push bx
	
	call printString
	
	mov ax, 0xb800
	mov es, ax
	
	mov bx, [bp + 6]
	mov si, [bp + 4]
	
	cmp bx, si
	je breakPSH
	
	mov di, 160
	
	sub si, bx
	
	shl bx, 1
	add di, bx
	
	highlightL1:
		mov ax, [es:di]
		mov ah, 0x47
		stosw
		dec si
		jnz highlightL1
	
	breakPSH:
		
	pop es
	pop di
	pop si
	pop bx
	pop ax
	pop bp
	
	ret 6
	

	
printString:
	push bp
	mov bp, sp
	push ax
	push bx
	push cx
	push si
	push di
	push es
	
	call clrscr
	
	push ds
	pop es
	
	mov di, [bp + 4]
	mov cx, 0xFFFF
	xor al, al
	repne scasb
	mov ax, 0xFFFF
	sub ax, cx
	mov cx, ax
	dec cx
	
	mov ax, 0xb800
	mov es, ax
	
	mov si, [bp + 4]
	mov ah, 0x07
	mov di, 160
	
	cld
	printStringL1:
		lodsb
		stosw
		
		loop printStringL1

	pop es
	pop di
	pop si
	pop cx
	pop bx
	pop ax
	pop bp
	
	ret 2
	
	
clrscr:
	push es
	push ax
	push di
	push cx
	
	mov ax, 0xb800
	mov es, ax
	
	mov ax, 0x0720
	
	mov di, 0
	
	mov cx, 2000
	
	cld
	rep stosw
	
	pop cx
	pop di
	pop ax
	pop es
	
	ret
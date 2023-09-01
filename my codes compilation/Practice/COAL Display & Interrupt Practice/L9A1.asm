	[org 0x0100]
	
	jmp start
		
String1: db 'a man, a plan, a canal, Panama!!!', 0
String2: db '                     ', 0
String3: db '                     ', 0
m1: db 'The given string is a palindrome', 0
m2: db 'The given string is not a palindrome', 0

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

	cld
	rep stosw

	pop cx
	pop di
	pop es
	pop ax
	ret

getStringLength:					;Starting address of the string passed as parameter
	push bp
	mov bp, sp
	push ax
	push es
	push di
	push cx	
	
	mov cx, 0xFFFF

	mov ax, ds
	mov es, ax
	
	mov ax, 0

	mov di, [bp+4]
	
	cld
	repne scasb
	mov ax, 0xFFFF
	
	sub ax, cx
	dec ax

	mov [bp+6], ax

	pop cx
	pop di
	pop es
	pop ax
	pop bp	
	ret 2

removePunctuations:					;Receives the starting addresses of the string to be processed and the starting address of where the result is to be stored
	push bp
	mov bp, sp
	push ax
	push bx
	push cx
	push si
	push di

	sub sp, 2					;Result space
	mov si, [bp+6]					;Store the address of the string to be processed in si
	push si

	call getStringLength
	pop cx
	cmp cx, 0
	je endRemovePunctuations

	mov bx, [bp+4]					;Store the address of where the resultant string is to be stored in bx
	mov di, 0

removePunctuationsL1:
	cmp byte [si], '.'
	je nextChar
	cmp byte [si], ' '
	je nextChar
	cmp byte [si], ','
	je nextChar
	cmp byte [si], '&'
	je nextChar
	cmp byte [si], '!'
	je nextChar
	cmp byte [si], '?'
	je nextChar

	mov al, [si]
	mov [bx], al
	
	inc bx

nextChar:
	inc si
	loop removePunctuationsL1

endRemovePunctuations:
	mov byte [bx], 0
	pop di
	pop si
	pop cx
	pop bx
	pop ax
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

	sub sp, 2
	push word [bp+10]

	call getStringLength
	pop ax

	cmp ax, 0
	jz exit
	mov cx, ax

	mov ax, 0xb800
	mov es, ax
	mov al, 80
	mul byte [bp+6]
	add ax, [bp+8]

	shl ax, 1
	mov di, ax
	
	mov si, [bp+10]
	mov ah, [bp+4]

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
	
reverseString:						;Receives the starting addresses of the string to be processed and the starting address of where the result is to be stored
	push bp
	mov bp, sp
	push ax
	push bx
	push cx
	push si
	push di

	sub sp, 2					;Result space
	mov si, [bp+6]					;Store the address of the string to be processed in si
	push si

	call getStringLength
	pop cx
	cmp cx, 0
	je endRemovePunctuations

	add si, cx
	dec si						;Pointing si to the end of the string

	mov bx, [bp+4]					;Store the address of where the resultant string is to be stored in bx
	mov di, 0

reverseStringL1:
	mov al, [si]
	mov [bx], al
	
	dec si
	inc bx
	
	loop reverseStringL1

endReverseString:
	mov byte [bx], 0
	pop di
	pop si
	pop cx
	pop bx
	pop ax
	pop bp
	ret 4

areEqual:						;Requires a result space and receives the starting addresses of the two strings which are to be compared
	push bp
	mov bp, sp
	push ax
	push cx
	push ds
	push si
	push es
	push di
	
	sub sp, 2
	mov si, [bp+6]
	push si
	
	call getStringLength
	pop cx

	sub sp, 2
	mov di, [bp+4]
	push di
	
	call getStringLength
	pop ax

	cmp cx, ax
	jne notEqual

	mov ax, ds
	mov es, ax

	cld
	repe cmpsb
	jcxz Equal

notEqual:
	mov word [bp+8], 0
	jmp exitAreEqual

Equal:
	mov word [bp+8], 1
	
exitAreEqual:
	pop di
	pop es
	pop si
	pop ds
	pop cx
	pop ax
	pop bp
	ret 4

start:
	call clrscr
	
	push word String1
	push word 0			;x-position
	push word 0			;y-position
	push word 0x7A			;Attribute
	call printstr

	push word String1
	push word String2
	
	call removePunctuations

	push word String2
	push word 0			;x-position
	push word 1			;y-position
	push word 0x7A			;Attribute
	call printstr

	push word String2
	push word String3
	
	call reverseString

	push word String3
	push word 0			;x-position
	push word 2			;y-position
	push word 0x7A			;Attribute
	call printstr

	sub sp, 2
	push word String2
	push word String3

	call areEqual

	pop ax

	cmp ax, 1
	jne notPalindrome
	push word m1
	push word 0			;x-position
	push word 4			;y-position
	push word 0x7A			;Attribute
	call printstr
	jmp endProgram
	
notPalindrome:
	push word m2
	push word 0			;x-position
	push word 4			;y-position
	push word 0x7A			;Attribute
	call printstr

endProgram:
	mov ah, 0x1
	int 0x21	

	mov ax, 0x4c00
	int 0x21
	[org 0x100]
	
	jmp start

data: db 10111100b
msg: db 'It is not a palindrome', 0

checkPalindrome:
	push bp
	mov bp, sp
	push ax
	push cx

	mov ah, 0
	mov al, [bp+4]		;al now has the byte to be checked
	mov bx, ax		;The byte to be checked has been copied into bx
	
	mov cx, 8

checkPalindromel1:
	rol al, 1
	jc checkFor1
	jnc checkFor0

checkFor0:
	ror bl, 1
	jnc reiterate
	jc checkPalindromeEnd	

checkFor1:
	ror bl, 1
	jc reiterate
	jnc checkPalindromeEnd

reiterate:
	loop checkPalindromel1
	jcxz truePalindrome
	jmp falsePalindrome

truePalindrome:
	mov word [bp+4], 1
	jmp checkPalindromeEnd

falsePalindrome:
	mov word [bp+4], 0

checkPalindromeEnd:
	pop cx
	pop ax
	pop bp
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

printstr:						;Receives the starting address of the message, x-position, y-position and the attribute in the form of a word.
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
	
start:
	;Reutilizes the space in stack, for the data pushed, to return the value
	mov al, [data]
	push ax
	call checkPalindrome
	pop ax

	cmp ax, 1
	je resultTrue
	cmp ax, 0
	jne resultFalse	

resultTrue:
	mov bl, 0xAA
	mov ah, 0
	mov al, [data]
	push ax
	jmp programEnd	

resultFalse:
	mov bl, 0x00
	call clrscr
	push word msg
	push word 0
	push word 0
	push word 0x7A
	call printstr
	jmp programEnd

programEnd:
	mov ah, 0x1
	int 0x21

	mov ax, 0x4c00
	int 0x21
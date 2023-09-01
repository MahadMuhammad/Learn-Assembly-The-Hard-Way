[org 0x0100]

jmp Main

FillArray:
	push bp
	mov bp, sp
	mov ax, [bp+6]		; Number
	mov si, [bp+4]		; Array Address
	
	cmp ax, 1
	jge Recursive		; if(Number>=1)
	jl Return			; else Return
	
	Recursive: 
		mov [si], ax	; M0ve number to array
		add si, 2		; Increment array address
		sub ax, 1		; Decrement Number
		
		push ax			; Push Number
		push si			; Push Array Address
		call FillArray	; Call Subroutein Rcursively

	Return:
		pop bp
		ret 4

Main:
	push word [Number]	; Push Number
	push word Array		; Push Array address
	call FillArray		; Call Subroutein


Terminate:				; End Program
	mov ax, 0x4c00
	int 21h
	
DataLabel:
	Number: dw 12345h
	Array: db 0
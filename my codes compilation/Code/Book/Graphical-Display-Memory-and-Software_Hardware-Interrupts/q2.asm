;Write a subroutine “splitScreen” to reverse the screen i.e. left becomes right and right becomes left. 
;Similarly top becomes bottom and bottom becomes top. You cannot use any temporary array. 
;Only a word variable can be declared if needed.

[org 0x0100]


start:	call splitScreen
		
end:	mov ax, 0x4c00
		int 21h



splitScreen:	push bp
				mov bp, sp
				pusha


				mov ax, 0xb800
				mov es, ax

				mov si, 0
				mov di, 3998

				mov cx, 1000

l1:				mov ax, [es:si]
				xchg [es:di], ax 
				mov [es:si], ax

				add si, 2
				sub di, 2

				cmp si, di
				loop l1


return:			popa
				pop bp
				ret
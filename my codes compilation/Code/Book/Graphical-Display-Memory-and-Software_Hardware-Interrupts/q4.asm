;Q4. Write a subroutine findSubstr that takes a null terminated string and a null terminated substring as its parameters
; and prints “Substring Found.” on video screen if that substring is found in that string and prints “Substring Not Found.” otherwise.



[org 0x0100]

	jmp start

mainStr: db 'Marry has a little lamb.',0
subStr1: db '.',0             	; findSubstr  prints “Substring Found.” for this substring.
subStr2: db 'lame',0            	; findSubstr  prints “Substring Not Found.” for this substring.


stringFound:	db 'Substring Found', 0
stringNotFound:	db 'Substring Not Found', 0

;-----------------------------------------------------------------------------------------------------------

start:		call clrscr

			push mainStr
			push subStr1

			call findSubstr


end:		mov ax, 0x4c00
			int 21h


;-----------------------------------------------------------------------------------------------------------

;Clear Screen
clrscr:			pusha

				mov ax, 0xb800
				mov es, ax
				xor di,di
				mov ax,0x0720
				mov cx,2000

				cld
				rep stosw
			
				popa

				ret


;-----------------------------------------------------------------------------------------------------------

strLen:			push bp
				mov bp, sp
				pusha

				push es

				push ds
				pop es

				mov di, [bp+4]		;Point di to string 
				mov cx, 0xFFFF		;Load Maximum No. in cx
				mov al, 0 			;Load a zero in al
				repne scasb			;find zero in the string

				mov ax, 0xFFFF 		;Load Maximum No. in ax
				sub ax, cx          ;Find change in cx
				dec ax				;Exclude null from length

				mov [bp+6], ax


				pop es

				popa
				pop bp
				ret 2

;-----------------------------------------------------------------------------------------------------------



printStr:		push bp
				mov bp, sp
				pusha

				mov ax, 0xb800
				mov es, ax

				mov di, [bp+6]			;Printing Location
				mov si, [bp+4]			;Point si to string


				sub sp, 2
				push word [bp+4]
				call strLen

				pop cx

				mov ah, 0x07

nextChar:		mov al, [si]
				mov [es:di], ax

				add di, 2
				add si, 1
				loop nextChar

				popa
				pop bp
				ret 4



;-----------------------------------------------------------------------------------------------------------




findSubstr:		push bp
				mov bp, sp
				pusha

				;bp + 4 - subStr
				;bp + 6 - str

				sub sp, 2
				push word [bp+6]
				call strLen

				pop ax				;Storing length of str in ax

				sub sp, 2
				push word [bp+4]
				call strLen

				pop bx				;Storing Length of subStr in bx


				cmp ax, bx			;If the size of the substring is greater than the main string
				jl notFound

				push ds
				pop es

				mov dx, ax			;Making a copy of the main str size

				mov si, [bp+4]		;Point si to the substr
				mov al, [si]		;Storing the first character of subStr in al


				mov ah, 0
	

				mov di, [bp+6]		;Point di to main string

				mov cx, dx			;Loading the length of Main string in cx


				;----------------------------------------------------------------------------------------------------



l1:				repne scasb
				jcxz notFound		;Substring not Found

				;if first character of subStr is found in str

				dec di
				inc cx

				;dec cx				;Because one character has already been checked

				push di 			;Saving the index where the first character of sub string is found 
				push cx				;Saving the count for which index of mainstring to start the comparision from 

				mov si, [bp+4]		;Point si to sub string
				;inc si 				;Because one character has already been checked
				mov cx, bx			;Loading length of sub string in cx

				repe cmpsb
				jz found 			;If sub string is found

				;If substring not found, then check the remaining main string 'str'

				pop cx
				pop di

				inc di
				dec cx

				jmp l1


found:			push 160
				push stringFound
				call printStr

				pop cx
				pop di

				jmp return

notFound:		push 160
				push stringNotFound
				call printStr
				jmp return				


return:			popa
				pop bp
				ret 4


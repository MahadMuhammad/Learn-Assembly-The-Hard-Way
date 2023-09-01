;Write an assembly program that takes a 16 bit number as input from user and calculates whether the number is a happy number or unhappy. 
;If the number is a happy number, display ‘Happy’ on the screen else display ‘UnHappy’. 
;A happy number is defined by the following process: 

;Starting with the given number, replace that number by the sum of the squares of its digits. 
;Repeat the process on the replaced number until the number either equals 1 within 256 iterations of the process. 
;The number for which this process ends in 1 within 256 iterations is called a happy number; otherwise it is called an unhappy number. 
;Use ah =01 service of int 21h to take input from user and ah=09 service of int 21h to print string on the screen.




[org 0x0100]

	jmp start

isHappy: db 'Happy $'
notHappy: db 'UnHappy $'
prompt:	  db 'Enter the Number in the range 0 - 65535 :  $'
emptySpace: db '  $'
inalidInput: db '            Invalid Input. $'

;5 digits because of the fact that 65535 has 5 digits
digits:		db -1, -1, -1, -1, -1

;----------------------------------------------------------------------------------

start:	call clrscr

		call happyNumber
			
end:	 mov ax, 0x4c00
		 int 21h



;----------------------------------------------------------------------------------


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


;-----------------------------------------------------------------------------------------------------------

happyNumber:	pusha
		
				;Prompt to enter the number
				mov ah, 09
				mov dx, prompt
				int 21h

				;-------------------

				mov cx, 0 				
				mov bx, 0
				mov ah, 01


				;Taking the input


l1:				int 21h

				cmp al, 13				;Comparing with ASCII Key of Enter
				jz l2					;Break the loop if Enter key is pressed

				sub al, 48 				;To get the exact number
				mov [cs:digits + bx], al 

				inc bx
				inc cx

				cmp cx, 5 				;Because of 5 digits
				jnz l1


;Checks for Input
;--------------------------------------------------------------------------
l2:				cmp byte [cs:digits], -1
				jz InvalidInput1

				;If the number exceeds 65535
				cmp cx, 5 
				jnz a1

				cmp byte [cs:digits], 6
				jg InvalidInput1

				cmp byte [cs: digits + 1], 5
				jg InvalidInput

				cmp byte [cs: digits + 2], 5
				jg InvalidInput

				cmp byte [cs: digits + 3], 3
				jg InvalidInput

				cmp byte [cs: digits + 4], 5
				jg InvalidInput			
;---------------------------------------------------------------------------
;Main Working
				;Now squaring and adding the digits


a1:				mov di, 0
				mov bx, 0
				mov ax, 0
				mov dx, 0

l3:				mov dl, [cs:digits + di]
				mov al, dl

				mul dl 

 				add bx, ax

 				inc di

 				loop l3

 				mov ax, bx
			
				;Now ax contains the number after squaring the digits and adding the sum for the first time

				;Now doing the processing

				mov di, 256 								;No. of iterations

				cmp ax, 1
				jz happy



processing:		mov bx, 10									;Divide by 10
				mov cx, 0 									;Initialize count of digits								

nextdigit:		mov dx, 0 
				div bx
				push dx
				inc cx

				cmp ax, 0
				jnz nextdigit

				mov ax, 0

				mov si, cx
				mov cx, 0

				jmp squaringAndSum


InvalidInput1:  jmp InvalidInput 							;Intermediate Jump


squaringAndSum:	pop dx

				mov al, dl 							;Because the maximum digit is 9 and the sqaure of 9 is 81 which can be placed in one byte

				mov bl, dl

				mul bl

				add cx, ax

				dec si
				cmp si, 0
				jnz squaringAndSum


				dec di 						;Decrementing di once an interation is complete

				;After adding the sum of square of each digit 

				mov ax, cx

				cmp ax, 1
				jz  happy

				cmp di, 0
				jnz processing

				jz unHappy

;-------------------------------------------------------------------------------------
;Just output stuff

InvalidInput:	mov ah, 09
				mov dx, inalidInput
				int 21h

				jmp return				



happy:			mov ah, 09
 				mov dx, emptySpace
 				int 21h

 				mov dx, isHappy
 				int 21h

				jmp return


unHappy:		mov ah, 09
 				mov dx, emptySpace
 				int 21h

 				mov dx, notHappy
 				int 21h

				jmp return


return:			popa
				ret











; ;-----------------------------------------------------------------------------------------------------------		 

;Another method when the input is taken in Hexadecimal Form 


; ;-----------------------------------------------------------------------------------------------------------		 

; ;---------------------------------------------------------------------------------------------------------------------------------------
; ;IMPORTANT NOTE				

; ;In a number of 16 bits, we have 4 nibbles. Each nibble represents one digit of the number. So we have a total of 4 digits in 16 bits.
; ;Now the range of a 16 bit number is upto 65535 or FFFF. Since the user is allowed to enter a 16 bit number, he must be allowed to enter the
; ;maximum number also which is FFFF. The user will give the input digit by digit since the ah =01 service of int 21h only takes one digit at a 
; ;time. So the user will be prompted to enter 4 digits, one at a time. All this is because of the fact that there are 4 digits in a 16 bit number.
; ;Also the digits entered will be in the order, MSB to LSB

; ;One case is also possible that the user is prompted to enter two digits and each digit is supposed to be of 8 bits. But this doesn't make sense
; ;because in this the user can at max enter a number "99" which doesn't match the maximum number in a 16 bit range i.e FFFF.

; ;ALSO THE NUMBER IS TAKEN IN HEXA DECIMAL FORM

; ;---------------------------------------------------------------------------------------------------------------------------------------

; ;Helper Function

; hex:		cmp al, 57
; 			jle a1

; 			sub al, 55 					;In case the digit is from A-F

; 			jmp return1

; a1:			sub al, 48 					;In case the digit is from 0-9

; return1:	ret

; ;----------------------------------------------------------------------------------------------------------------------------------------

; happyNumber:	pusha

; 				;Prompt to enter the number
; 				mov ah, 09
; 				mov dx, prompt
; 				int 21h

; 				;-------------------

; 				mov ax, 0
; 				mov bx, 0
; 				mov cx, 0
; 				mov dx, 0

; 				mov ah, 01

; 				;1st digit
; 				int 21h
; 				call hex
; 				mov bl, al
		
; 				;2nd digit
; 				int 21h
; 				call hex
; 				mov cl, al
			
; 				;3rd digit
; 				int 21h
; 				call hex
; 				mov dl, al
			
; 				;4th digit
; 				int 21h
; 				call hex

; 				mov ah, 0
			
; 				;Now making a 16 bit number

; 				shl bx, 12
; 				shl cx, 8
; 				shl dx, 4
		

; 				add bx, cx
; 				add bx, dx
; 				add bx, ax
				
; 				;Now ax contains the 16 bit number which the user entered
; 				mov ax, bx

; 				;Now doing the processing

; 				mov di, 256 								;No. of iterations

; 				cmp ax, 1
; 				jz happy



; processing:		mov bx, 16									;Divide by 16
; 				mov cx, 4 									;Because of 4 digits

; l1:				mov dx, 0 
; 				div bx
; 				push dx

; 				loop l1


; 				mov ax, 0

; 				mov cx, 0

; 				mov si, 4


; squaringAndSum:	pop dx

; 				mov al, dl 							;Because the maximum digit is F and the sqaure of F is 225 which can be placed in one byte

; 				mov bl, dl

; 				mul bl

; 				add cx, ax

; 				dec si
; 				cmp si, 0
; 				jnz squaringAndSum


; 				dec di

; 				;After adding the sum of square of each digit 

; 				mov ax, cx

; 				cmp ax, 1
; 				jz  happy

; 				cmp di, 0
; 				jnz processing

; 				jz unHappy


; happy:			mov ah, 09
; 				mov dx, emptySpace
; 				int 21h

; 				mov dx, isHappy
; 				int 21h

; 				jmp return


; unHappy:		mov ah, 09
; 				mov dx, emptySpace
; 				int 21h

; 				mov dx, notHappy
; 				int 21h

; 				jmp return


; return:			popa
; 				ret
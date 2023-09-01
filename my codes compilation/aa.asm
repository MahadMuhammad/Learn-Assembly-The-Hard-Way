[org 0x100] 


jmp start 

word1:	dw 	'coal ',0
count: db 0
correct : db 0

oldisr:	dd 0

msg1:	 db	'+------+       '
         db '|      |       '
         db '|              '
         db '|              '
         db '|              '
         db '|              '
         db '+------------+ '
		 db '|////////////| ' 
         db '+------------+ ',0; null terminated string
msg2:
		 db '+------+       '
         db '|      |       '
         db '|      O       '
         db '|      |       '
		 db '|              ' 
		 db '|              '
		 db '"+-----------+ '
		 db '|////////////| '
		 db '+------------+ ',0
		 
msg3:
		 db '+------+       '
         db '|      |       '
         db '|      O       '
         db '|     /|\      '
         db '|              '
         db '|              '
		 db '+------------+ '
         db '|////////////| '
		 db '+------------+ ',0
msg4:
		 db '+------+       '
         db '|      |       '
         db '|      O       '
         db '|     /|\      '
         db '|     / \      '
         db '|              '
		 db '+------------+ '
         db '|////////////| '
		 db '+------------+ ',0

		

clrscr:
 push es 
 push ax 
 push cx 
 push di 
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 xor di, di ; point di to top left column 
 mov ax, 0x0720 ; space char in normal attribute 
 mov cx, 2000 ; number of screen locations 
 cld ; auto increment mode 
 rep stosw ; clear the whole screen 
 pop di
 pop cx 
 pop ax 
 pop es 
 ret 
 
 
print:
push bp 
 mov bp, sp 
 push es 
 push ax 

 push di 
 
 
 
	mov ax,0xb800
	mov es,ax
	mov di, [bp+6]
	mov ax, [bp+4]
	mov [es:di], ax
	
	
	pop di
	pop ax
	pop es
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
 push ds 
 pop es ; load ds in es 
 
 mov di, [bp+4] ; point di to string 
 mov cx, 0xffff ; load maximum number in cx 
 xor al, al ; load a zero in al 
 repne scasb ; find zero in the string 

 mov ax, 0xffff ; load maximum number in ax 
 sub ax, cx ; find change in cx 
 dec ax ; exclude null from length 
 jz exit ; no printing if string is empty
 mov cx, ax 
 sub cx,8; load string length in cx 
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov al, 80 ; load al with columns per row 
 mul byte [bp+8] ; multiply with y position 
 add ax, [bp+10] ; add x position 
 shl ax, 1 ; turn into byte offset 
 mov di,ax
 ; point di to required location 
 mov si, [bp+4] ; point si to string 
 mov ah, [bp+6] ; load attribute in ah 
 cld 
; auto increment mode 
l:mov dx,0
 add di,130
nextchar: lodsb ; load next char in al 
 stosw ; print 
 inc dx
 cmp dx,15
 je l
 loop nextchar ; repeat for the whole string 

exit: pop di 
 pop si 
 pop cx 
 pop ax 
 pop es 
 pop bp 
 ret 8 
 
 
 
 
start: 	


call clrscr
mov cx, 8

l1:

mov ah,0
int 0x16
in al,0x60

cmp al,0x2E

jne nextcmp
			mov di,40
			push di
			
			mov bx , [word1]
			push bx
			call print
			inc word[correct]
			loop l1

			
nextcmp:	cmp al, 0x18
			jne  nextcmp1
			
			mov di,42
			push di
			mov bx , [word1+1]
			push bx
			call print
			inc word[correct]
			loop l1

nextcmp1:	cmp al, 0x1E
			jne nextcmp2
			
			mov di,44
			push di
			mov bx , [word1+2]
			push bx
			call print
			inc word[correct]
			loop l1
			
nextcmp2:	cmp al, 0x26
			jne nomatch
			
			mov di,46
			push di
			mov bx , word[word1+3]
			push bx
			call print
			inc word[correct]
		    loop l1
			
nomatch:

cmp word[correct], 4
je exxii

inc word[count]	

cmp word[count], 1
jne nc1
 mov ax, 20 
 push ax ; push x position 
 mov ax, 10 
 push ax ; push y position 
 mov ax, 1 ; blue on black attribute 
 push ax ; push attribute 
 mov ax, msg1
 push ax ; push address of msg1
 call printstr
 
 nc1:
 cmp word[count], 2
 jne nc2
 mov ax, 20 
 push ax ; push x position 
 mov ax, 10 
 push ax ; push y position 
 mov ax, 1 ; blue on black attribute 
 push ax ; push attribute 
 mov ax, msg2
 push ax ; push address of msg1
 call printstr
 
 nc2:
 cmp word[count], 3
 jne nc3
 mov ax, 20 
 push ax ; push x position 
 mov ax, 10 
 push ax ; push y position 
 mov ax, 1 ; blue on black attribute 
 push ax ; push attribute 
 mov ax, msg3
 push ax ; push address of msg1
 call printstr
 
 nc3:
 cmp word[count], 4
 jne exi
 mov ax, 20 
 push ax ; push x position 
 mov ax, 10 
 push ax ; push y position 
 mov ax, 1 ; blue on black attribute 
 push ax ; push attribute 
 mov ax, msg4
 push ax ; push address of msg1
 call printstr
 
exi:
 sub cx, 1
 jnz l1 

exxii:
 mov ax  , 0x4c00 ; terminate program 
 
 int 0x21
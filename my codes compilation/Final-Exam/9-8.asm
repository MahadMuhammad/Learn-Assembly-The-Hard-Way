; display a tick count while the left shift key is down 
[org 0x0100] 
 jmp start 
seconds: dw 0 
timerflag: dw 0 
oldkb: dd 0 

printnum: push bp 
 mov bp, sp 
 push es 
 push ax 
 push bx 
 push cx 
 push dx 
 push di 
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov ax, [bp+4] ; load number in ax 
 mov bx, 10 ; use base 10 for division 
 mov cx, 0 ; initialize count of digits
 nextdigit: mov dx, 0 ; zero upper half of dividend 
 div bx ; divide by 10 
 add dl, 0x30 ; convert digit into ascii value 
 push dx ; save ascii value on stack 
 inc cx ; increment count of values 
 cmp ax, 0 ; is the quotient zero 
 jnz nextdigit ; if no divide it again 
 mov di, 140 ; point di to 70th column 
nextpos: pop dx ; remove a digit from the stack 
 mov dh, 0x07 ; use normal attribute 
 mov [es:di], dx ; print char on screen 
 add di, 2 ; move to next screen location 
 loop nextpos ; repeat for all digits on stack 
 pop di 
 pop dx 
 pop cx 
 pop bx 
 pop ax
 pop es 
 pop bp 
 ret 2 

; keyboard interrupt service routine 
kbisr: push ax 
 in al, 0x60 ; read char from keyboard port 
 cmp al, 0x2a ; has the left shift pressed 
 jne nextcmp ; no, try next comparison 
 cmp word [cs:timerflag], 1; is the flag already set 
 je exit ; yes, leave the ISR 
 mov word [cs:timerflag], 1; set flag to start printing 
 jmp exit ; leave the ISR 
nextcmp: cmp al, 0xaa ; has the left shift released 
 jne nomatch ; no, chain to old ISR 
 mov word [cs:timerflag], 0; reset flag to stop printing
 jmp exit ; leave the interrupt routine 
nomatch: pop ax 
 jmp far [cs:oldkb] ; call original ISR 
exit: mov al, 0x20 
 out 0x20, al ; send EOI to PIC 
 pop ax 
 iret ; return from interrupt 
; timer interrupt service routine 
;timer: push ax 
; cmp word [cs:timerflag], 1 ; is the printing flag set 
; jne skipall ; no, leave the ISR 
; inc word [cs:seconds] ; increment tick count 
; push word [cs:seconds] 
; call printnum ; print tick count 
;skipall: mov al, 0x20 
; out 0x20, al ; send EOI to PIC 
; pop ax 
; iret ; return from interrupt 

 timer:	                push ax
		push bx
		push dx
		cmp word[cs:timerflag],1
		jne skipall

		inc word [cs:seconds]
		mov ax, [cs:seconds]
		mov dx, 0
		mov bx, 2
		div bx
		cmp dx, 0
		je skipall
		push word [cs:seconds]
		call printnum

skipall:                   mov al, 0x20
	                out 0x20, al

		pop dx
		pop bx
		pop ax
		iret
start: xor ax, ax 
 mov es, ax ; point es to IVT base 
 mov ax, [es:9*4] 
 mov [oldkb], ax ; save offset of old routine 
 mov ax, [es:9*4+2] 
 mov [oldkb+2], ax ; save segment of old routine 
 cli ; disable interrupts 
 mov word [es:9*4], kbisr ; store offset at n*4 
 mov [es:9*4+2], cs ; store segment at n*4+2 
 mov word [es:8*4], timer ; store offset at n*4 
 mov [es:8*4+2], cs ; store segment at n*4+ 
 sti ; enable interrupts 
 mov dx, start ; end of resident portion 
 add dx, 15 ; round up to next para 
 mov cl, 4 
 shr dx, cl ; number of paras 
 mov ax, 0x3100 ; terminate and stay resident 
 int 0x21 
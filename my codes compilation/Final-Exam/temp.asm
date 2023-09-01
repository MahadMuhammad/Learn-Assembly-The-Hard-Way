[org 0x0100]

jmp start

welcommsg: db 'Hello Welcome Press P for Play or Press ESC to Exit'
gameover:  db 'Press P for Play again or Press ESC to Exit'
instructions: db 'Press Esc to game end, A for right, D for left'
instructions1: db 'Game will start in seconds'

clrscr: 
	 push es
	 push ax            ;Clear Screen Funtion
	 push cx
	 push di   
	 mov ax, 0xb800
	 mov es, ax 
	 xor di, di 
	 mov ax, 0x0720 
	 mov cx, 2000 
	 cld 
	 rep stosw
	 pop di 
	 pop cx
	 pop ax
	 pop es
	 ret 

delay:
	push cx
	mov cx, 250 ; change the values  to increase delay time
	delay_loop1:
		push cx
		mov cx, 0xFFFF
	delay_loop2:
		loop delay_loop2
		pop cx
		loop delay_loop1
		pop cx
	ret

delay1:
	push cx
	mov cx, 30 ; change the values  to increase delay time
	delay_loop11:
		push cx
		mov cx, 0xFFFF
	delay_loop12:
		loop delay_loop2
		pop cx
		loop delay_loop1
		pop cx
	ret
	
Welcome_Funtion:
	call clrscr
	mov ah, 0x13    			; service 13 - print string
	mov al, 1 						; subservice 01 – update cursor
	mov bh, 0 						; output on page 0
	mov bl, 7 						; normal attrib
	mov dx, 0x080F 				; row 8 column 15
	mov cx, 51 					; length of string
	push cs
	pop es 						; segment of string
	mov bp, welcommsg 				; offset of string
	int 0x10 	                    ; call BIOS video service
	ret
	
command:      ; Command Function for keyborad keys
	push ax
	push bx
	push cx
	push dx    
	push es	
	push cs
	pop ds
	
	in al,0x60               ;checking keys
	cmp al,0x19              ; P key checker for play again 
	je interruptdisplay   
	cmp al,0x01           ;Esc checker
	je Terminater
	cmp al,0x20; hex of D's scan code
	jne left
	
	right:
		call PlayerCarR       ;Rigth part
		jmp exit
	left:
		cmp al,0x1e      ; Left part
		jne exit
		call PlayerCarL
		jmp exit		
	Terminater:
	    call Terminate
	interruptdisplay:
	    call DISPLAY
	
    exit:
		mov al,0x20
		out 0x20,al
		pop es
		pop dx
		pop cx
		pop bx
		pop ax
		iret	

DISPLAY:             ; Display Fubtion 
  
	itr:
		mov ax,0
		mov es,ax
		cli
		mov word [es:9*4],command
		mov [es:9*4+2],cs
		sti
	 
	call Instructions
	call delay 
	DisplaySub:          ; Calling Sub Display Funtions
		call DISPLAY1
		call delay1
		call DISPLAY2
		call delay1
		call DISPLAY3
		call delay1
		call DISPLAY4
		call delay1
		call DISPLAY5
		call delay1
		call DISPLAY6
		call delay1
		call DISPLAY7
		call delay1
		call DISPLAY8
		call delay1
		call DISPLAY9
		call delay1
		call DISPLAY10
		call delay1
		call DISPLAY1
		call delay1
		call DISPLAY2
		call delay1
		call DISPLAY3
		call delay1
		call DISPLAY4
		call delay1
		call DISPLAY5
		call delay1
		call DISPLAY6
		call delay1
		call DISPLAY7
		call delay1
		call DISPLAY8
		call delay1
		call DISPLAY9
		call delay1
		call DISPLAY10
		call delay1
		jmp Terminate
		
	Instructions:

		 call clrscr
		 mov ah, 0x13    			; service 13 - print string
		 mov al, 1 						; subservice 01 – update cursor
		 mov bh, 0 						; output on page 0
		 mov bl, 7 						; normal attrib
		 mov dx, 0x050F 				; row 5 column 15
		 mov cx, 46					; length of string
		 push cs
		 pop es 						; segment of string
		 mov bp, instructions 				; offset of string
		 int 0x10 	                    ; call BIOS video service
		 mov ah, 0x13    			; service 13 - print string
		 mov al, 1 						; subservice 01 – update cursor
		 mov bh, 0 						; output on page 0
		 mov bl, 1 						; normal attrib
		 mov dx, 0x0714 				; row 7 column 16
		 mov cx, 26 					; length of string
		 push cs
		 pop es 						; segment of string
		 mov bp, instructions1 				; offset of string
		 int 0x10 	                    ; call BIOS video service
		 ret	

	DISPLAY1:

		mov ax,0xb800
		mov es,ax	
		mov si,160	
		mov bx,6
		
		call firstwhiteline	    ; Calling Graphics functions
		call sideroad	
		call secondwhiteline
		call leftyellowside1
		call mainroad1
		call rightyellowside1
		call beachwater
		call SEA
		call Greenery
		
		mov ds,ax
		mov cx,2000	
		mov si,0
		mov di,160
		cld
		rep movsw
		
		call FinishFlag1
		call IPINFO
		call Distance
		call FuelInfo
		call scoreInfo1
		call Lane1
		call Hurdlecars1
		call BonusCar1
		call PlayerCarL
		ret
		
	DISPLAY2:

		mov ax,0xb800
		mov es,ax	
		mov si,0	
		mov bx,6
		
		call firstwhiteline	
		call sideroad	
		call secondwhiteline
		call leftyellowside2
		call mainroad2
		call rightyellowside2
		call beachwater
		call SEA
		call Greenery
		
		mov ds,ax
		mov cx,2000	
		mov si,0
		mov di,160
		cld
		rep movsw
		
		call FinishFlag2
		call IPINFO
		call Distance
		call FuelInfo
		call scoreInfo2
		call Lane2
		call Hurdlecars2
		call BonusCar2
		call PlayerCarL
		ret
	 
	DISPLAY3:
		
		mov ax,0xb800
		mov es,ax	
		mov si,0	
		mov bx,6
		
		call firstwhiteline	
		call sideroad	
		call secondwhiteline
		call leftyellowside3
		call mainroad3
		call rightyellowside3
		call beachwater
		call SEA
		call Greenery
		
		mov ds,ax
		mov cx,2000	
		mov si,0
		mov di,160
		cld
		rep movsw
		
		call FinishFlag3
		call IPINFO
		call Distance
		call FuelInfo
		call scoreInfo3
		call Lane3
		call Hurdlecars3
		call BonusCar3
		call PlayerCarL
		ret

	DISPLAY4:
		
		mov ax,0xb800
		mov es,ax	
		mov si,0	
		mov bx,6
		
		call firstwhiteline	
		call sideroad	
		call secondwhiteline
		call leftyellowside4
		call mainroad4
		call rightyellowside4
		call beachwater
		call SEA
		call Greenery
		
		mov ds,ax
		mov cx,2000	
		mov si,0
		mov di,160
		cld
		rep movsw
		
		call FinishFlag4
		call IPINFO
		call Distance
		call FuelInfo
		call scoreInfo4
		call Lane4
		call Hurdlecars4
		call BonusCar4
		call PlayerCarL
		ret 

	DISPLAY5:

		mov ax,0xb800
		mov es,ax	
		mov si,0	
		mov bx,6
		
		call firstwhiteline	
		call sideroad	
		call secondwhiteline
		call leftyellowside5
		call mainroad5
		call rightyellowside5
		call beachwater
		call SEA
		call Greenery
		
		mov ds,ax
		mov cx,2000	
		mov si,0
		mov di,160
		cld
		rep movsw
		
		call FinishFlag5
		call IPINFO
		call Distance
		call FuelInfo
		call scoreInfo5
		call Lane5
		call Hurdlecars5
		call BonusCar5
		call PlayerCarL
		ret 

	DISPLAY6:
		
		mov ax,0xb800
		mov es,ax	
		mov si,0	
		mov bx,6
		
		call firstwhiteline	
		call sideroad	
		call secondwhiteline
		call leftyellowside6
		call mainroad6
		call rightyellowside6
		call beachwater
		call SEA
		call Greenery
		
		mov ds,ax
		mov cx,2000	
		mov si,0
		mov di,160
		cld
		rep movsw
		
		call FinishFlag6
		call IPINFO
		call Distance
		call FuelInfo
		call scoreInfo6
		call Lane6
		call Hurdlecars6
		call BonusCar6
		call PlayerCarL
		ret 

	DISPLAY7:

		mov ax,0xb800
		mov es,ax	
		mov si,0	
		mov bx,6
		
		call firstwhiteline	
		call sideroad	
		call secondwhiteline
		call leftyellowside7
		call mainroad7
		call rightyellowside7
		call beachwater
		call SEA
		call Greenery
		
		mov ds,ax
		mov cx,2000	
		mov si,0
		mov di,160
		cld
		rep movsw
		
		call FinishFlag7
		call IPINFO
		call Distance
		call FuelInfo
		call scoreInfo7
		call Lane7
		call Hurdlecars7
		call BonusCar7
		call PlayerCarL
		ret 

	DISPLAY8:

		mov ax,0xb800
		mov es,ax	
		mov si,0	
		mov bx,6
		
		call firstwhiteline	
		call sideroad	
		call secondwhiteline
		call leftyellowside8
		call mainroad8
		call rightyellowside8
		call beachwater
		call SEA
		call Greenery
		
		mov ds,ax
		mov cx,2000	
		mov si,0
		mov di,160
		cld
		rep movsw
		
		call FinishFlag8
		call IPINFO
		call Distance
		call FuelInfo
		call scoreInfo8
		call Lane8
		call Hurdlecars8
		call BonusCar8
		call PlayerCarL
		ret 

	DISPLAY9:
		
		mov ax,0xb800
		mov es,ax	
		mov si,0	
		mov bx,6
		
		call firstwhiteline	
		call sideroad	
		call secondwhiteline
		call leftyellowside9
		call mainroad9
		call rightyellowside9
		call beachwater
		call SEA
		call Greenery
		
		mov ds,ax
		mov cx,2000	
		mov si,0
		mov di,160
		cld
		rep movsw
		
		call FinishFlag9
		call IPINFO
		call Distance
		call FuelInfo
		call scoreInfo9
		call Lane9
		call Hurdlecars9
		call BonusCar9
		call PlayerCarL
		ret 

	DISPLAY10:

		mov ax,0xb800
		mov es,ax	
		mov si,0	
		mov bx,6
		
		call firstwhiteline	
		call sideroad	
		call secondwhiteline
		call leftyellowside10
		call mainroad10
		call rightyellowside10
		call beachwater
		call SEA
		call Greenery
		
		mov ds,ax
		mov cx,2000	
		mov si,0
		mov di,160
		cld
		rep movsw
		
		call FinishFlag10
		call IPINFO
		call Distance
		call FuelInfo
		call scoreInfo10
		call Lane10
		call Hurdlecars10
		call BonusCar10
		ret 
		
	firstwhiteline:
		push si
		mov si,bx
		mov word[es:si],0x0FDE ;first white line
		add si,2	
		mov bx,0000
		mov bx,si    ;bx=8
		pop si
		ret 
		
	sideroad:
		push cx
		push si
		mov si,bx  ;bx =8
		mov cx,8
		loopgrey:		
			mov word[es:si],0x77DB ; side gray road
			add si,2
		loop loopgrey
		mov bx,0000
		mov bx,si  ;bx=24
		pop si
		pop cx
		ret
		
	secondwhiteline:
			
			push si
			mov si,bx	    ;bx=24
			mov word[es:si],0x7FDE   ; third white line
			add si,2
			mov bx,0000
			mov bx,si ;bx=26
			pop si
			ret
			
	leftyellowside1:
		push cx
		push si
		mov si,bx  ;bx=26
		mov cx,10
		loopyellow1:		
			mov word[es:si],0x0EDB ; fourth yellow side
			add si,2
		loop loopyellow1
		mov bx,0000
		mov bx,si  ;bx=46
		pop si
		pop cx
		ret
		
	mainroad1:
		
		mov word[es:42],0x07DB ; gray dotted side
		mov word[es:42],0x7004 ; dots on side
		mov word[es:44],0x70B4		
		push cx
		push si
		mov si,bx ;bx=46
		mov cx,14
		road1:		
			mov word[es:si],0x77DB ; second gray road
			add si,2
		loop road1
		call lane1
		mov bx,0000
		mov bx,si   ;bx=74
		pop si
		pop cx	
		mov word[es:72],0x07DB ; gray dotted side
		mov word[es:72],0x7004 ; dots on side
		mov word[es:70],0x70C3	
		ret

	Lane1:
		mov word [es:378],0x77DB
		mov word [es:538],0x77DB
		mov word [es:1178],0x77DB
		mov word [es:1338],0x77DB
		mov word [es:1978],0x77DB
		mov word [es:2138],0x77DB
		mov word [es:2778],0x77DB
		mov word [es:2938],0x77DB
		mov word [es:3578],0x77DB
		mov word [es:3738],0x77DB
		ret
		
	leftyellowside2:
		push cx
		push si
		mov si,bx  ;bx=26
		mov cx,10
		loopyellow2:		
			mov word[es:si],0x0EDB ; fourth yellow side
			add si,2
		loop loopyellow2
		mov bx,0000
		mov bx,si  ;bx=46
		pop si
		pop cx
		ret
		
	mainroad2:
		
		mov word[es:42],0x07DB ; gray dotted side
		mov word[es:42],0x7004 ; dots on side
		mov word[es:44],0x70B4		
		push cx
		push si
		mov si,bx ;bx=46
		mov cx,14
		road2:		
			mov word[es:si],0x77DB ; second gray road
				add si,2
		loop road2
		call lane2
		mov bx,0000
		mov bx,si   ;bx=74
		pop si
		pop cx	
		mov word[es:72],0x07DB ; gray dotted side
		mov word[es:72],0x7004 ; dots on side
		mov word[es:70],0x70C3	
		ret

	Lane2:
		mov word [es:378],0x77DB
		mov word [es:538],0x77DB
		mov word [es:1178],0x77DB
		mov word [es:1338],0x77DB
		mov word [es:1978],0x77DB
		mov word [es:2138],0x77DB
		mov word [es:2778],0x77DB
		mov word [es:2938],0x77DB
		mov word [es:3578],0x77DB
		mov word [es:3738],0x77DB
		ret

	leftyellowside3:
		push cx
		push si
		mov si,bx  ;bx=26
		mov cx,10
		loopyellow3:		
			mov word[es:si],0x0EDB ; fourth yellow side
			add si,2
		loop loopyellow3
		mov bx,0000
		mov bx,si  ;bx=46
		pop si
		pop cx
		ret
		
	mainroad3:
		
		mov word[es:42],0x07DB ; gray dotted side
		mov word[es:42],0x7004 ; dots on side
		mov word[es:44],0x70B4		
		push cx
		push si
		mov si,bx ;bx=46
		mov cx,14
		road3:	
			mov word[es:si],0x77DB ; second gray road
				add si,2
		loop road3
		call lane3
		mov bx,0000
		mov bx,si   ;bx=74
		pop si
		pop cx	
		mov word[es:72],0x07DB ; gray dotted side
		mov word[es:72],0x7004 ; dots on side
		mov word[es:70],0x70C3	
		ret

	Lane3:
		mov word [es:378],0x77DB
		mov word [es:538],0x77DB
		mov word [es:1178],0x77DB
		mov word [es:1338],0x77DB
		mov word [es:1978],0x77DB
		mov word [es:2138],0x77DB
		mov word [es:2778],0x77DB
		mov word [es:2938],0x77DB
		mov word [es:3578],0x77DB
		mov word [es:3738],0x77DB
		ret

	leftyellowside4:
		push cx
		push si
		mov si,bx  ;bx=26
		mov cx,10
		loopyellow4:		
			mov word[es:si],0x0EDB ; fourth yellow side
			add si,2
		loop loopyellow4
		mov bx,0000
		mov bx,si  ;bx=46
		pop si
		pop cx
		ret
		
	mainroad4:
		
		mov word[es:42],0x07DB ; gray dotted side
		mov word[es:42],0x7004 ; dots on side
		mov word[es:44],0x70B4		
		push cx
		push si
		mov si,bx ;bx=46
		mov cx,14
		road4:	
			mov word[es:si],0x77DB ; second gray road
				add si,2
		loop road4
		call lane4
		mov bx,0000
		mov bx,si   ;bx=74
		pop si
		pop cx	
		mov word[es:72],0x07DB ; gray dotted side
		mov word[es:72],0x7004 ; dots on side
		mov word[es:70],0x70C3	
		ret

	Lane4:
		mov word [es:378],0x77DB
		mov word [es:538],0x77DB
		mov word [es:1178],0x77DB
		mov word [es:1338],0x77DB
		mov word [es:1978],0x77DB
		mov word [es:2138],0x77DB
		mov word [es:2778],0x77DB
		mov word [es:2938],0x77DB
		mov word [es:3578],0x77DB
		mov word [es:3738],0x77DB
		ret

	leftyellowside5:
		push cx
		push si
		mov si,bx  ;bx=26
		mov cx,10
		loopyellow5:		
			mov word[es:si],0x0EDB ; fourth yellow side
			add si,2
		loop loopyellow5
		mov bx,0000
		mov bx,si  ;bx=46
		pop si
		pop cx
		ret
		
	mainroad5:
		
		mov word[es:42],0x07DB ; gray dotted side
		mov word[es:42],0x7004 ; dots on side
		mov word[es:44],0x70B4		
		push cx
		push si
		mov si,bx ;bx=46
		mov cx,14
		road5:		
			mov word[es:si],0x77DB ; second gray road
				add si,2
		loop road5
		call lane5
		mov bx,0000
		mov bx,si   ;bx=74
		pop si
		pop cx	
		mov word[es:72],0x07DB ; gray dotted side
		mov word[es:72],0x7004 ; dots on side
		mov word[es:70],0x70C3	
		ret

	Lane5:
		mov word [es:378],0x77DB
		mov word [es:538],0x77DB
		mov word [es:1178],0x77DB
		mov word [es:1338],0x77DB
		mov word [es:1978],0x77DB
		mov word [es:2138],0x77DB
		mov word [es:2778],0x77DB
		mov word [es:2938],0x77DB
		mov word [es:3578],0x77DB
		mov word [es:3738],0x77DB
		ret

	leftyellowside6:
		push cx
		push si
		mov si,bx  ;bx=26
		mov cx,10
		loopyellow6:		
			mov word[es:si],0x0EDB ; fourth yellow side
			add si,2
		loop loopyellow6
		mov bx,0000
		mov bx,si  ;bx=46
		pop si
		pop cx
		ret
		
	mainroad6:
		
		mov word[es:42],0x07DB ; gray dotted side
		mov word[es:42],0x7004 ; dots on side
		mov word[es:44],0x70B4		
		push cx
		push si
		mov si,bx ;bx=46
		mov cx,14
		road6:		
			mov word[es:si],0x77DB ; second gray road
				add si,2
		loop road6
		call lane6
		mov bx,0000
		mov bx,si   ;bx=74
		pop si
		pop cx	
		mov word[es:72],0x07DB ; gray dotted side
		mov word[es:72],0x7004 ; dots on side
		mov word[es:70],0x70C3	
		ret

	Lane6:
		mov word [es:378],0x77DB
		mov word [es:538],0x77DB
		mov word [es:1178],0x77DB
		mov word [es:1338],0x77DB
		mov word [es:1978],0x77DB
		mov word [es:2138],0x77DB
		mov word [es:2778],0x77DB
		mov word [es:2938],0x77DB
		mov word [es:3578],0x77DB
		mov word [es:3738],0x77DB
		ret

	leftyellowside7:
		push cx
		push si
		mov si,bx  ;bx=26
		mov cx,10
		loopyellow7:		
			mov word[es:si],0x0EDB ; fourth yellow side
			add si,2
		loop loopyellow7
		mov bx,0000
		mov bx,si  ;bx=46
		pop si
		pop cx
		ret
		
	mainroad7:
		
		mov word[es:42],0x07DB ; gray dotted side
		mov word[es:42],0x7004 ; dots on side
		mov word[es:44],0x70B4		
		push cx
		push si
		mov si,bx ;bx=46
		mov cx,14
		road7:	
			mov word[es:si],0x77DB ; second gray road
				add si,2
		loop road7
		call lane7
		mov bx,0000
		mov bx,si   ;bx=74
		pop si
		pop cx	
		mov word[es:72],0x07DB ; gray dotted side
		mov word[es:72],0x7004 ; dots on side
		mov word[es:70],0x70C3	
		ret

	Lane7:
		mov word [es:378],0x77DB
		mov word [es:538],0x77DB
		mov word [es:1178],0x77DB
		mov word [es:1338],0x77DB
		mov word [es:1978],0x77DB
		mov word [es:2138],0x77DB
		mov word [es:2778],0x77DB
		mov word [es:2938],0x77DB
		mov word [es:3578],0x77DB
		mov word [es:3738],0x77DB
		ret

	leftyellowside8:
		push cx
		push si
		mov si,bx  ;bx=26
		mov cx,10
		loopyellow8:		
			mov word[es:si],0x0EDB ; fourth yellow side
			add si,2
		loop loopyellow8
		mov bx,0000
		mov bx,si  ;bx=46
		pop si
		pop cx
		ret
		
	mainroad8:
		
		mov word[es:42],0x07DB ; gray dotted side
		mov word[es:42],0x7004 ; dots on side
		mov word[es:44],0x70B4		
		push cx
		push si
		mov si,bx ;bx=46
		mov cx,14
		road8:		
			mov word[es:si],0x77DB ; second gray road
				add si,2
		loop road8
		call lane8
		mov bx,0000
		mov bx,si   ;bx=74
		pop si
		pop cx	
		mov word[es:72],0x07DB ; gray dotted side
		mov word[es:72],0x7004 ; dots on side
		mov word[es:70],0x70C3	
		ret

	Lane8:
		mov word [es:378],0x77DB
		mov word [es:538],0x77DB
		mov word [es:1178],0x77DB
		mov word [es:1338],0x77DB
		mov word [es:1978],0x77DB
		mov word [es:2138],0x77DB
		mov word [es:2778],0x77DB
		mov word [es:2938],0x77DB
		mov word [es:3578],0x77DB
		mov word [es:3738],0x77DB
		ret

	leftyellowside9:
		push cx
		push si
		mov si,bx  ;bx=26
		mov cx,10
		loopyellow9:		
			mov word[es:si],0x0EDB ; fourth yellow side
			add si,2
		loop loopyellow9
		mov bx,0000
		mov bx,si  ;bx=46
		pop si
		pop cx
		ret
		
	mainroad9:
		
		mov word[es:42],0x07DB ; gray dotted side
		mov word[es:42],0x7004 ; dots on side
		mov word[es:44],0x70B4		
		push cx
		push si
		mov si,bx ;bx=46
		mov cx,14
		road9:		
			mov word[es:si],0x77DB ; second gray road
				add si,2
		loop road9
		call lane9
		mov bx,0000
		mov bx,si   ;bx=74
		pop si
		pop cx	
		mov word[es:72],0x07DB ; gray dotted side
		mov word[es:72],0x7004 ; dots on side
		mov word[es:70],0x70C3	
		ret

	Lane9:
		mov word [es:378],0x77DB
		mov word [es:538],0x77DB
		mov word [es:1178],0x77DB
		mov word [es:1338],0x77DB
		mov word [es:1978],0x77DB
		mov word [es:2138],0x77DB
		mov word [es:2778],0x77DB
		mov word [es:2938],0x77DB
		mov word [es:3578],0x77DB
		mov word [es:3738],0x77DB
		ret

	leftyellowside10:
		push cx
		push si
		mov si,bx  ;bx=26
		mov cx,10
		loopyellow10:		
			mov word[es:si],0x0EDB ; fourth yellow side
			add si,2
		loop loopyellow10
		mov bx,0000
		mov bx,si  ;bx=46
		pop si
		pop cx
		ret
		
	mainroad10:
		
		mov word[es:42],0x07DB ; gray dotted side
		mov word[es:42],0x7004 ; dots on side
		mov word[es:44],0x70B4		
		push cx
		push si
		mov si,bx ;bx=46
		mov cx,14
		road10:		
			mov word[es:si],0x77DB ; second gray road
				add si,2
		loop road10
		call lane10
		mov bx,0000
		mov bx,si   ;bx=74
		pop si
		pop cx	
		mov word[es:72],0x07DB ; gray dotted side
		mov word[es:72],0x7004 ; dots on side
		mov word[es:70],0x70C3	
		ret

	Lane10:
		mov word [es:378],0x77DB
		mov word [es:538],0x77DB
		mov word [es:1178],0x77DB
		mov word [es:1338],0x77DB
		mov word [es:1978],0x77DB
		mov word [es:2138],0x77DB
		mov word [es:2778],0x77DB
		mov word [es:2938],0x77DB
		mov word [es:3578],0x77DB
		mov word [es:3738],0x77DB
		ret	
		
	PlayerCarR:
		
		mov ax,0xb800
		mov es,ax
		mov word [es:3422],0x0E08
		mov word [es:3424],0x0E08
		mov word [es:3420],0x7011
		mov word [es:3426],0x7010
		mov word [es:3582],0x79DB
		mov word [es:3584],0x79DB
		mov word [es:3740],0x7011
		mov word [es:3746],0x7010
		mov word [es:3742],0x71DB
		mov word [es:3744],0x71DB
		
		mov word [es:3422-12],0x07DB
		mov word [es:3424-12],0x07DB
		mov word [es:3420-12],0x07DB
		mov word [es:3426-12],0x07DB
		mov word [es:3582-12],0x07DB
		mov word [es:3584-12],0x07DB
		mov word [es:3740-12],0x07DB
		mov word [es:3746-12],0x07DB
		mov word [es:3742-12],0x07DB
		mov word [es:3744-12],0x07DB
		ret

	PlayerCarL:
		mov ax,0xb800
		mov es,ax
		mov word [es:3422-12],0x0E08
		mov word [es:3424-12],0x0E08
		mov word [es:3420-12],0x7011
		mov word [es:3426-12],0x7010
		mov word [es:3582-12],0x79DB
		mov word [es:3584-12],0x79DB
		mov word [es:3740-12],0x7011
		mov word [es:3746-12],0x7010
		mov word [es:3742-12],0x71DB
		mov word [es:3744-12],0x71DB
		
		mov word [es:3422],0x07DB
		mov word [es:3424],0x07DB
		mov word [es:3420],0x07DB
		mov word [es:3426],0x07DB
		mov word [es:3582],0x07DB
		mov word [es:3584],0x07DB
		mov word [es:3740],0x07DB
		mov word [es:3746],0x07DB
		mov word [es:3742],0x07DB
		mov word [es:3744],0x07DB
		ret	
		
	Hurdlecars1:

		mov word [es:528],0x7011
		mov word [es:534],0x7010
		mov word [es:530],0x74DB
		mov word [es:532],0x74DB
		mov word [es:688],0x7011
		mov word [es:694],0x7010
		mov word [es:690],0x74DB
		mov word [es:692],0x74DB
		
		mov word [es:2142],0x7011
		mov word [es:2148],0x7010
		mov word [es:2144],0x74DB
		mov word [es:2146],0x74DB
		mov word [es:2302],0x7011
		mov word [es:2308],0x7010
		mov word [es:2304],0x74DB
		mov word [es:2306],0x74DB	
		ret	
		
	BonusCar1:
		
		mov word [es:1342],0x7011
		mov word [es:1348],0x7010
		mov word [es:1344],0x7BDB
		mov word [es:1346],0x7FDB
		mov word [es:1502],0x7011
		mov word [es:1508],0x7010
		mov word [es:1504],0x7BDB
		mov word [es:1506],0x7FDB
		ret
		
	Hurdlecars2:

		mov word [es:688],0x7011
		mov word [es:694],0x7010
		mov word [es:690],0x74DB
		mov word [es:692],0x74DB
		mov word [es:848],0x7011
		mov word [es:854],0x7010
		mov word [es:850],0x74DB
		mov word [es:852],0x74DB
		
		mov word [es:2142+160],0x7011
		mov word [es:2148+160],0x7010
		mov word [es:2144+160],0x74DB
		mov word [es:2146+160],0x74DB
		mov word [es:2302+160],0x7011
		mov word [es:2308+160],0x7010
		mov word [es:2304+160],0x74DB
		mov word [es:2306+160],0x74DB	
		ret	
		
	BonusCar2:
		
		mov word [es:1342+160],0x7011
		mov word [es:1348+160],0x7010
		mov word [es:1344+160],0x7BDB
		mov word [es:1346+160],0x7FDB
		mov word [es:1502+160],0x7011
		mov word [es:1508+160],0x7010
		mov word [es:1504+160],0x7BDB
		mov word [es:1506+160],0x7FDB
		ret

	Hurdlecars3:

		mov word [es:528+320],0x7011
		mov word [es:534+320],0x7010
		mov word [es:530+320],0x74DB
		mov word [es:532+320],0x74DB
		mov word [es:688+320],0x7011
		mov word [es:694+320],0x7010
		mov word [es:690+320],0x74DB
		mov word [es:692+320],0x74DB
		
		mov word [es:2142+320],0x7011
		mov word [es:2148+320],0x7010
		mov word [es:2144+320],0x74DB
		mov word [es:2146+320],0x74DB
		mov word [es:2302+320],0x7011
		mov word [es:2308+320],0x7010
		mov word [es:2304+320],0x74DB
		mov word [es:2306+320],0x74DB	
		ret	
		
	BonusCar3:
		
		mov word [es:1342+320],0x7011
		mov word [es:1348+320],0x7010
		mov word [es:1344+320],0x7BDB
		mov word [es:1346+320],0x7FDB
		mov word [es:1502+320],0x7011
		mov word [es:1508+320],0x7010
		mov word [es:1504+320],0x7BDB
		mov word [es:1506+320],0x7FDB
		ret

	Hurdlecars4:

		mov word [es:528+480],0x7011
		mov word [es:534+480],0x7010
		mov word [es:530+480],0x74DB
		mov word [es:532+480],0x74DB
		mov word [es:688+480],0x7011
		mov word [es:694+480],0x7010
		mov word [es:690+480],0x74DB
		mov word [es:692+480],0x74DB
		
		mov word [es:2142+480],0x7011
		mov word [es:2148+480],0x7010
		mov word [es:2144+480],0x74DB
		mov word [es:2146+480],0x74DB
		mov word [es:2302+480],0x7011
		mov word [es:2308+480],0x7010
		mov word [es:2304+480],0x74DB
		mov word [es:2306+480],0x74DB	
		ret	
		
	BonusCar4:
		
		mov word [es:1342+480],0x7011
		mov word [es:1348+480],0x7010
		mov word [es:1344+480],0x7BDB
		mov word [es:1346+480],0x7FDB
		mov word [es:1502+480],0x7011
		mov word [es:1508+480],0x7010
		mov word [es:1504+480],0x7BDB
		mov word [es:1506+480],0x7FDB
		ret

	Hurdlecars5:

		mov word [es:528+640],0x7011
		mov word [es:534+640],0x7010
		mov word [es:530+640],0x74DB
		mov word [es:532+640],0x74DB
		mov word [es:688+640],0x7011
		mov word [es:694+640],0x7010
		mov word [es:690+640],0x74DB
		mov word [es:692+640],0x74DB
		
		mov word [es:2142+640],0x7011
		mov word [es:2148+640],0x7010
		mov word [es:2144+640],0x74DB
		mov word [es:2146+640],0x74DB
		mov word [es:2302+640],0x7011
		mov word [es:2308+640],0x7010
		mov word [es:2304+640],0x74DB
		mov word [es:2306+640],0x74DB	
		ret	
		
	BonusCar5:
		
		mov word [es:1342+640],0x7011
		mov word [es:1348+640],0x7010
		mov word [es:1344+640],0x7BDB
		mov word [es:1346+640],0x7FDB
		mov word [es:1502+640],0x7011
		mov word [es:1508+640],0x7010
		mov word [es:1504+640],0x7BDB
		mov word [es:1506+640],0x7FDB
		ret

	Hurdlecars6:

		mov word [es:528+800],0x7011
		mov word [es:534+800],0x7010
		mov word [es:530+800],0x74DB
		mov word [es:532+800],0x74DB
		mov word [es:688+800],0x7011
		mov word [es:694+800],0x7010
		mov word [es:690+800],0x74DB
		mov word [es:692+800],0x74DB
		
		mov word [es:2142+800],0x7011
		mov word [es:2148+800],0x7010
		mov word [es:2144+800],0x74DB
		mov word [es:2146+800],0x74DB
		mov word [es:2302+800],0x7011
		mov word [es:2308+800],0x7010
		mov word [es:2304+800],0x74DB
		mov word [es:2306+800],0x74DB	
		ret	
		
	BonusCar6:
		
		mov word [es:1342+800],0x7011
		mov word [es:1348+800],0x7010
		mov word [es:1344+800],0x7BDB
		mov word [es:1346+800],0x7FDB
		mov word [es:1502+800],0x7011
		mov word [es:1508+800],0x7010
		mov word [es:1504+800],0x7BDB
		mov word [es:1506+800],0x7FDB
		ret

	Hurdlecars7:

		mov word [es:528+960],0x7011
		mov word [es:534+960],0x7010
		mov word [es:530+960],0x74DB
		mov word [es:532+960],0x74DB
		mov word [es:688+960],0x7011
		mov word [es:694+960],0x7010
		mov word [es:690+960],0x74DB
		mov word [es:692+960],0x74DB
		
		mov word [es:2142+960],0x7011
		mov word [es:2148+960],0x7010
		mov word [es:2144+960],0x74DB
		mov word [es:2146+960],0x74DB
		mov word [es:2302+960],0x7011
		mov word [es:2308+960],0x7010
		mov word [es:2304+960],0x74DB
		mov word [es:2306+960],0x74DB	
		ret	
		
	BonusCar7:
		
		mov word [es:1342+960],0x7011
		mov word [es:1348+960],0x7010
		mov word [es:1344+960],0x7BDB
		mov word [es:1346+960],0x7FDB
		mov word [es:1502+960],0x7011
		mov word [es:1508+960],0x7010
		mov word [es:1504+960],0x7BDB
		mov word [es:1506+960],0x7FDB
		ret

	Hurdlecars8:

		mov word [es:528+1120],0x7011
		mov word [es:534+1120],0x7010
		mov word [es:530+1120],0x74DB
		mov word [es:532+1120],0x74DB
		mov word [es:688+1120],0x7011
		mov word [es:694+1120],0x7010
		mov word [es:690+1120],0x74DB
		mov word [es:692+1120],0x74DB
		
		mov word [es:2142-2080],0x7011
		mov word [es:2148-2080],0x7010
		mov word [es:2144-2080],0x74DB
		mov word [es:2146-2080],0x74DB
		mov word [es:2302-2080],0x7011
		mov word [es:2308-2080],0x7010
		mov word [es:2304-2080],0x74DB
		mov word [es:2306-2080],0x74DB	
		ret	
		
	BonusCar8:
		
		mov word [es:1342+1120],0x7011
		mov word [es:1348+1120],0x7010
		mov word [es:1344+1120],0x7BDB
		mov word [es:1346+1120],0x7FDB
		mov word [es:1502+1120],0x7011
		mov word [es:1508+1120],0x7010
		mov word [es:1504+1120],0x7BDB
		mov word [es:1506+1120],0x7FDB
		ret

	Hurdlecars9:

		mov word [es:528+1280],0x7011
		mov word [es:534+1280],0x7010
		mov word [es:530+1280],0x74DB
		mov word [es:532+1280],0x74DB
		mov word [es:688+1280],0x7011
		mov word [es:694+1280],0x7010
		mov word [es:690+1280],0x74DB
		mov word [es:692+1280],0x74DB
		
		mov word [es:2142-1920],0x7011
		mov word [es:2148-1920],0x7010
		mov word [es:2144-1920],0x74DB
		mov word [es:2146-1920],0x74DB
		mov word [es:2302-1920],0x7011
		mov word [es:2308-1920],0x7010
		mov word [es:2304-1920],0x74DB
		mov word [es:2306-1920],0x74DB	
		ret	
		
	BonusCar9:
		
		mov word [es:1342+1280],0x7011
		mov word [es:1348+1280],0x7010
		mov word [es:1344+1280],0x7BDB
		mov word [es:1346+1280],0x7FDB
		mov word [es:1502+1280],0x7011
		mov word [es:1508+1280],0x7010
		mov word [es:1504+1280],0x7BDB
		mov word [es:1506+1280],0x7FDB
		ret

	Hurdlecars10:

		mov word [es:528+1440],0x7011
		mov word [es:534+1440],0x7010
		mov word [es:530+1440],0x74DB
		mov word [es:532+1440],0x74DB
		mov word [es:688+1440],0x7011
		mov word [es:694+1440],0x7010
		mov word [es:690+1440],0x74DB
		mov word [es:692+1440],0x74DB
		
		mov word [es:2142-1760],0x7011
		mov word [es:2148-1760],0x7010
		mov word [es:2144-1760],0x74DB
		mov word [es:2146-1760],0x74DB
		mov word [es:2302-1760],0x7011
		mov word [es:2308-1760],0x7010
		mov word [es:2304-1760],0x74DB
		mov word [es:2306-1760],0x74DB	
		ret	
		
	BonusCar10:
		
		mov word [es:1342+1440],0x7011
		mov word [es:1348+1440],0x7010
		mov word [es:1344+1440],0x7BDB
		mov word [es:1346+1440],0x7FDB
		mov word [es:1502+1440],0x7011
		mov word [es:1508+1440],0x7010
		mov word [es:1504+1440],0x7BDB
		mov word [es:1506+1440],0x7FDB
		ret	
		
	rightyellowside1:
		push cx
		push si
		mov si,bx  ;bx=74
		mov cx,10
		loopyellow11:
			mov word[es:si],0x0EDB ;  yellow side
			add si,2
		loop loopyellow11
		mov bx,0000
		mov bx,si  ;bx=94
		pop si
		pop cx	
		ret

	rightyellowside2:
		push cx
		push si
		mov si,bx  ;bx=74
		mov cx,10
		loopyellow12:
			mov word[es:si],0x0EDB ;  yellow side
			add si,2
		loop loopyellow12
		mov bx,0000
		mov bx,si  ;bx=94
		pop si
		pop cx	
		ret

	rightyellowside3:
		push cx
		push si
		mov si,bx  ;bx=74
		mov cx,10
		loopyellow13:
			mov word[es:si],0x0EDB ;  yellow side
			add si,2
		loop loopyellow13
		mov bx,0000
		mov bx,si  ;bx=94
		pop si
		pop cx	
		ret

	rightyellowside4:
		push cx
		push si
		mov si,bx  ;bx=74
		mov cx,10
		loopyellow14:
			mov word[es:si],0x0EDB ;  yellow side
			add si,2
		loop loopyellow14
		mov bx,0000
		mov bx,si  ;bx=94
		pop si
		pop cx	
		ret

	rightyellowside5:
		push cx
		push si
		mov si,bx  ;bx=74
		mov cx,10
		loopyellow15:
			mov word[es:si],0x0EDB ;  yellow side
			add si,2
		loop loopyellow15
		mov bx,0000
		mov bx,si  ;bx=94
		pop si
		pop cx	
		ret

	rightyellowside6:
		push cx
		push si
		mov si,bx  ;bx=74
		mov cx,10
		loopyellow16:
			mov word[es:si],0x0EDB ;  yellow side
			add si,2
		loop loopyellow16
		mov bx,0000
		mov bx,si  ;bx=94
		pop si
		pop cx	
		ret

	rightyellowside7:
		push cx
		push si
		mov si,bx  ;bx=74
		mov cx,10
		loopyellow17:
			mov word[es:si],0x0EDB ;  yellow side
			add si,2
		loop loopyellow17
		mov bx,0000
		mov bx,si  ;bx=94
		pop si
		pop cx	
		ret

	rightyellowside8:
		push cx
		push si
		mov si,bx  ;bx=74
		mov cx,10
		loopyellow18:
			mov word[es:si],0x0EDB ;  yellow side
			add si,2
		loop loopyellow18
		mov bx,0000
		mov bx,si  ;bx=94
		pop si
		pop cx	
		ret

	rightyellowside9:
		push cx
		push si
		mov si,bx  ;bx=74
		mov cx,10
		loopyellow19:
			mov word[es:si],0x0EDB ;  yellow side
			add si,2
		loop loopyellow19
		mov bx,0000
		mov bx,si  ;bx=94
		pop si
		pop cx	
		ret

	rightyellowside10:
		push cx
		push si
		mov si,bx  ;bx=74
		mov cx,10
		loopyellow110:
			mov word[es:si],0x0EDB ;  yellow side
			add si,2
		loop loopyellow110
		mov bx,0000
		mov bx,si  ;bx=94
		pop si
		pop cx	
		ret	
		
	beachwater:
		push cx
		push si
		mov si,bx ;bx=94
		mov cx,10
		beachwat:
			mov word[es:si],0x0BDB ;  beachwater
			add si,2
		loop beachwat
		mov bx,0000
		mov bx,si ;bx=114
		pop si
		pop cx	
		mov word[es:92],0x3F08	
		ret
		
	SEA:
		push cx
		push si
		mov si,bx  ;bx=114
		mov cx,10
		sea:
			mov word[es:si],0x09DB ;  sea
			add si,2
		loop sea
		mov bx,0000
		mov bx,si   ;bx=134
		pop si
		pop cx	
		mov word[es:112],0x3FAE
		;mov word[es:114],0x3F08
		ret

	FinishFlag1:
		mov word[es:330],0x7FB3
		mov word[es:332],0x7910
		mov word[es:334],0x7910
		mov word[es:490],0x7FB3
		 ret

	FinishFlag2:
		mov word[es:330+160],0x7FB3
		mov word[es:332+160],0x7910
		mov word[es:334+160],0x7910
		mov word[es:490+160],0x7FB3
		 ret

	FinishFlag3:
		mov word[es:330+320],0x7FB3
		mov word[es:332+320],0x7910
		mov word[es:334+320],0x7910
		mov word[es:490+320],0x7FB3
		 ret
	FinishFlag4:
		mov word[es:330+480],0x7FB3
		mov word[es:332+480],0x7910
		mov word[es:334+480],0x7910
		mov word[es:490+480],0x7FB3
		 ret
	FinishFlag5:
		mov word[es:330+640],0x7FB3
		mov word[es:332+640],0x7910
		mov word[es:334+640],0x7910
		mov word[es:490+640],0x7FB3
		 ret
	FinishFlag6:
		mov word[es:330+800],0x7FB3
		mov word[es:332+800],0x7910
		mov word[es:334+800],0x7910
		mov word[es:490+800],0x7FB3
		 ret
	FinishFlag7:
		mov word[es:330+960],0x7FB3
		mov word[es:332+960],0x7910
		mov word[es:334+960],0x7910
		mov word[es:490+960],0x7FB3
		 ret
	FinishFlag8:
		mov word[es:330+1120],0x7FB3
		mov word[es:332+1120],0x7910
		mov word[es:334+1120],0x7910
		mov word[es:490+1120],0x7FB3
		 ret
	FinishFlag9:
		mov word[es:330+1280],0x7FB3
		mov word[es:332+1280],0x7910
		mov word[es:334+1280],0x7910
		mov word[es:490+1280],0x7FB3
		 ret	
	FinishFlag10:
		mov word[es:330+1440],0x7FB3
		mov word[es:332+1440],0x7910
		mov word[es:334+1440],0x7910
		mov word[es:490+1440],0x7FB3
		 ret
		 
	IPINFO:	 
		mov word[es:618],0x0700+'I'
		mov word[es:620],0x0700+'P'
		mov word[es:778],0x0700+'1'
		mov word[es:780],0x0700+'2'
		mov word[es:782],0x0700+'4'
		mov word[es:784],0x0700+'5'
		mov word[es:786],0x0700+'8'
		ret
		
	Distance:	
		mov word[es:1258],0x0700+'2'
		mov word[es:1260],0x0700+'9'
		mov word[es:1262],0x0700+'3'
		mov word[es:1266],0x0700+'k'
		mov word[es:1268],0x0700+'m'
		mov word[es:1270],0x0700+'/'
		mov word[es:1272],0x0700+'h'
		ret
	FuelInfo:	
		mov word[es:1898],0x0700+'F'
		mov word[es:1900],0x0700+'e'
		mov word[es:1902],0x0700+'u'
		mov word[es:1904],0x0700+'l'
		mov word[es:2064],0x0700+'1'
		mov word[es:2066],0x0700+'2'
		ret
		
	scoreInfo1:
		mov word[es:2538],0x0700+'S'
		mov word[es:2540],0x0700+'c'
		mov word[es:2542],0x0700+'o'
		mov word[es:2544],0x0700+'r'
		mov word[es:2546],0x0700+'e'
		mov word[es:2698],0x0700+'0'
		mov word[es:2700],0x0700+'1'
		ret
	scoreInfo2:
		mov word[es:2538],0x0700+'S'
		mov word[es:2540],0x0700+'c'
		mov word[es:2542],0x0700+'o'
		mov word[es:2544],0x0700+'r'
		mov word[es:2546],0x0700+'e'
		mov word[es:2698],0x0700+'0'
		mov word[es:2700],0x0700+'2'
		ret
	scoreInfo3:
		mov word[es:2538],0x0700+'S'
		mov word[es:2540],0x0700+'c'
		mov word[es:2542],0x0700+'o'
		mov word[es:2544],0x0700+'r'
		mov word[es:2546],0x0700+'e'
		mov word[es:2698],0x0700+'0'
		mov word[es:2700],0x0700+'3'
		ret
	scoreInfo4:
		mov word[es:2538],0x0700+'S'
		mov word[es:2540],0x0700+'c'
		mov word[es:2542],0x0700+'o'
		mov word[es:2544],0x0700+'r'
		mov word[es:2546],0x0700+'e'
		mov word[es:2698],0x0700+'0'
		mov word[es:2700],0x0700+'4'
		ret
	scoreInfo5:
		mov word[es:2538],0x0700+'S'
		mov word[es:2540],0x0700+'c'
		mov word[es:2542],0x0700+'o'
		mov word[es:2544],0x0700+'r'
		mov word[es:2546],0x0700+'e'
		mov word[es:2698],0x0700+'0'
		mov word[es:2700],0x0700+'5'
		ret
	scoreInfo6:
		mov word[es:2538],0x0700+'S'
		mov word[es:2540],0x0700+'c'
		mov word[es:2542],0x0700+'o'
		mov word[es:2544],0x0700+'r'
		mov word[es:2546],0x0700+'e'
		mov word[es:2698],0x0700+'0'
		mov word[es:2700],0x0700+'6'
		ret
	scoreInfo7:
		mov word[es:2538],0x0700+'S'
		mov word[es:2540],0x0700+'c'
		mov word[es:2542],0x0700+'o'
		mov word[es:2544],0x0700+'r'
		mov word[es:2546],0x0700+'e'
		mov word[es:2698],0x0700+'0'
		mov word[es:2700],0x0700+'7'
		ret
	scoreInfo8:
		mov word[es:2538],0x0700+'S'
		mov word[es:2540],0x0700+'c'
		mov word[es:2542],0x0700+'o'
		mov word[es:2544],0x0700+'r'
		mov word[es:2546],0x0700+'e'
		mov word[es:2698],0x0700+'0'
		mov word[es:2700],0x0700+'8'
		ret
	scoreInfo9:
		mov word[es:2538],0x0700+'S'
		mov word[es:2540],0x0700+'c'
		mov word[es:2542],0x0700+'o'
		mov word[es:2544],0x0700+'r'
		mov word[es:2546],0x0700+'e'
		mov word[es:2698],0x0700+'0'
		mov word[es:2700],0x0700+'9'
		ret
	scoreInfo10:
		mov word[es:2538],0x0700+'S'
		mov word[es:2540],0x0700+'c'
		mov word[es:2542],0x0700+'o'
		mov word[es:2544],0x0700+'r'
		mov word[es:2546],0x0700+'e'
		mov word[es:2698],0x0700+'1'
		mov word[es:2700],0x0700+'0'
		ret	
		
	Greenery:		
		
		mov word[es:34],0x2E08
		mov word[es:36],0x2E08
		mov word[es:38],0x2E08		  
		mov word[es:74],0x2E08
		mov word[es:76],0x2E08
		mov word[es:78],0x2E08
		mov word[es:80],0x2E08		  
		ret
		
	lane1: 		
		push si
		mov si, bx
		add si,12
		mov word [es:si],0x7FDB
		pop si
		ret		
	lane2: 		
		push si
		mov si, bx
		add si,12
		mov word [es:si],0x7FDB
		pop si
		ret
	lane3: 
		push si
		mov si, bx
		add si,12
		mov word [es:si],0x7FDB
		pop si
		ret
	lane4:		
		push si
		mov si, bx
		add si,12
		mov word [es:si],0x7FDB
		pop si
		ret
	lane5:		
		push si
		mov si, bx
		add si,12
		mov word [es:si],0x7FDB
		pop si
		ret
	lane6:		
		push si
		mov si, bx
		add si,12
		mov word [es:si],0x7FDB
		pop si
		ret
	lane7:		
		push si
		mov si, bx
		add si,12
		mov word [es:si],0x7FDB
		pop si
		ret
	lane8:		
		push si
		mov si, bx
		add si,12
		mov word [es:si],0x7FDB
		pop si
		ret
	lane9:		
		push si
		mov si, bx
		add si,12
		mov word [es:si],0x7FDB
		pop si
		ret
	lane10:		
		push si
		mov si, bx
		add si,12
		mov word [es:si],0x7FDB
		pop si
		ret	
Gameover:
		mov word[es:1024],0x7400+'G'
		mov word[es:1026],0x7400+'A'
		mov word[es:1028],0x7400+'M'
		mov word[es:1030],0x7400+'E'
		;mov word[es:2208],0x0700+' '
		mov word[es:1034],0x7400+'O'
		mov word[es:1036],0x7400+'V'
		mov word[es:1038],0x7400+'E'
		mov word[es:1040],0x7400+'R'
ret		
	 
Terminate:
	call clrscr
	call Gameover
	mov ah, 0x13    			; service 13 - print string
	mov al, 1 						; subservice 01 – update cursor
	mov bh, 0 						; output on page 0
	mov bl, 7 						; normal attrib
	mov dx, 0x090F 				; row 9 column 15
	mov cx, 43					; length of string
	push cs
	pop es 						; segment of string
	mov bp, gameover 				; offset of string
	int 0x10 	                    ; call BIOS video service
	again1:	
		mov ax,0
		mov ah,0
		int 0x16
		cmp al, 27
		je Terminate1
		cmp al, 0x50
		je DISPLAY
		cmp al, 0x70
		je DISPLAY
		jmp again1

start:
	mov cx,2
	call Welcome_Funtion
	mov ax,0
	mov ah,0
	int 0x16
	cmp al, 27
	je Terminate1
	cmp al, 0x50
	je DISPLAY
	cmp al, 0x70
	je DISPLAY
	jmp start
 
Terminate1:
	mov ax, 0x4c00 ; terminate program
	int 0x21
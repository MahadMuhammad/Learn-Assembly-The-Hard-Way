[org 0x0100]
jmp start

		; ax,bx,ip,cs,flags storage area
pcb:	dw 0, 0, 0, 0, 0 ; task0 regs[cs:pcb + 0]
		dw 0, 0, 0, 0, 0 ; task1 regs start at [cs:pcb + 10]
		dw 0, 0, 0, 0, 0 ; task2 regs start at [cs:pcb + 20]
		dw 0, 0, 0, 0, 0 ; task3 regs start at [cs:pcb + 30]
		dw 0, 0, 0, 0, 0 ; task4 regs start at [cs:pcb + 40]

current:	db 0 ; index of current task
chars:		db '\|/-' ; shapes to form a bar

;---------------------------------------------------------------------------
; one task to be multitasked
;---------------------------------------------------------------------------
taskone:	mov al, [chars+bx]			; read the next shape
			mov [es:0], al				; write at top left of screen 
			inc bx						; increment to next shape
			and bx, 3					; taking modulus by 4
			jmp taskone					; infinite task

;---------------------------------------------------------------------------
; second task to be multitasked
;---------------------------------------------------------------------------
tasktwo:	mov al, [chars+bx]			; read the next shape...0
			mov [es:158], al			; write at top right of screen
			inc bx						; increment to next shape
			and bx, 3					; taking modulus by 4
			jmp tasktwo					; infinite task


;---------------------------------------------------------------------------
; third task to be multitasked
;---------------------------------------------------------------------------
taskthree:	 
           
			mov al, [chars+bx]			; read the next shape..
			mov [es:3200], al			; write at top right of screen
			inc bx						; increment to next shape
			and bx, 3					; taking modulus by 4
			jmp taskthree
			


;---------------------------------------------------------------------------
; fourth task to be multitasked
;---------------------------------------------------------------------------
taskfour:	
			mov al, [chars+bx]			; read the next shape...0
			mov [es:3358], al			; write at top right of screen
			inc bx						; increment to next shape
			and bx, 3					; taking modulus by 4
			jmp taskfour
			


;---------------------------------------------------------------------------
; timer interrupt service routine
;---------------------------------------------------------------------------
timer:		push ax
			push bx

			mov bl, [cs:current]				; read index of current task ... bl = 0
			mov ax, 10							; space used by one task
			mul bl								; multiply to get start of task.. 10x0 = 0
			mov bx, ax							; load start of task in bx....... bx = 0

			pop ax								; read original value of bx
			mov [cs:pcb+bx+2], ax				; space for current task's BX

			pop ax								; read original value of ax
			mov [cs:pcb+bx+0], ax				; space for current task's AX

			pop ax								; read original value of ip
			mov [cs:pcb+bx+4], ax				; space for current task

			pop ax								; read original value of cs
			mov [cs:pcb+bx+6], ax				; space for current task

			pop ax								; read original value of flags
			mov [cs:pcb+bx+8], ax					; space for current task

			inc byte [cs:current]				; update current task index...1
			cmp byte [cs:current], 5			; is task index out of range
			jne skipreset						; no, proceed
			mov byte [cs:current], 0			; yes, reset to task 0

skipreset:	mov bl, [cs:current]				; read index of current task
			mov ax, 10							; space used by one task
			mul bl								; multiply to get start of task
			mov bx, ax							; load start of task in bx... 10
			
			mov al, 0x20
			out 0x20, al						; send EOI to PIC

			push word [cs:pcb+bx+8]				; flags of new task... pcb+10+8
			push word [cs:pcb+bx+6]				; cs of new task ... pcb+10+6
			push word [cs:pcb+bx+4]				; ip of new task... pcb+10+4
			mov ax, [cs:pcb+bx+0]				; ax of new task...pcb+10+0
			mov bx, [cs:pcb+bx+2]				; bx of new task...pcb+10+2

			iret								; return to new task

;---------------------------------------------------------------------------
start:		
mov ax, 1100
out 0x40, al
mov al, ah
out 0x40, al


			mov word [pcb+10+4], taskone			; initialize ip
			mov [pcb+10+6], cs						; initialize cs
			mov word [pcb+10+8], 0x0200				; initialize flags

			mov word [pcb+20+4], tasktwo			; initialize ip
			mov [pcb+20+6], cs						; initialize cs
			mov word [pcb+20+8], 0x0200				; initialize flags

			mov word [pcb+30+4], taskthree			; initialize ip
			mov [pcb+30+6], cs						; initialize cs
			mov word [pcb+30+8], 0x0200				; initialize flags


			mov word [pcb+40+4], taskfour			; initialize ip
			mov [pcb+40+6], cs						; initialize cs
			mov word [pcb+40+8], 0x0200				; initialize flags
			mov word [current], 0						; set current task index
			xor ax, ax
			mov es, ax									; point es to IVT base
			
			cli
			mov word [es:8*4], timer
			mov [es:8*4+2], cs							; hook timer interrupt
			mov ax, 0xb800
			mov es, ax									; point es to video base
			xor bx, bx									; initialize bx for tasks, bx=0
			sti

			jmp $										; infinite loop ... Task 0
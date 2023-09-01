[org 0x0100]
jmp start 

; place final outputs in these variables
topAvg:    dw 0   
bottomAvg: dw 0

; the data array and its size
; change these two to ensure your program works correctly all the time
marks:     dw 25, 26, 13, 47, 36, 32, 5, 40, 18, 11, 22, 25, 33, 28, 29, 16, 20, 23, 26, 20, 42, 31, 32, 29, 11
size:      dw 25

;------------------------------------------------------------------ 
; bubblesort subroutine (Example 5.6 from BH)
; Required parameters (on stack): array start address, array size
; Returns: nothing
;------------------------------------------------------------------
bubblesort:   push bp                 ; save old value of bp 
              mov  bp, sp             ; make bp our reference point 
              sub sp, 2               ; make two byte space on stack
              push ax                 ; save old values of registers
              push bx 
              push cx 
              push si 
 
              mov  bx, [bp+6]         ; load start of array in bx 
              mov  cx, [bp+4]         ; load count of elements in cx 
              dec  cx                 ; last element not compared 
              shl  cx, 1              ; turn into byte count 
 
mainloop:     mov  si, 0              ; initialize array index to zero 
              mov  word [bp-2], 0     ; reset swap flag to no swaps 
 
innerloop:    mov  ax, [bx+si]        ; load number in ax 
              cmp  ax, [bx+si+2]      ; compare with next number 
              jbe  noswap             ; no swap if already in order 
 
              xchg ax, [bx+si+2]      ; exchange ax with second number 
              mov  [bx+si], ax        ; store second number in first 
              mov  word [bp-2], 1     ; flag that a swap has been done 
 
noswap:       add  si, 2              ; advance si to next index 
              cmp  si, cx             ; are we at last index 
              jne  innerloop          ; if not compare next two 
              cmp word [bp-2], 1      ; check if a swap has been done 
              je   mainloop           ; if yes make another pass  
 
              pop  si                 ; restore old value of registers 
              pop  cx
              pop  bx
              pop  ax
              mov  sp, bp             ; remove space created on stack
              pop  bp                 ; restore old value of bp 
              ret  4                  ; go back and remove two params
;------------------------------------------------------------------
; list_avg subroutine
; Required parameters (on stack): array start address, array size
; Returns (again, on stack): the average value
;------------------------------------------------------------------
;------------------------------------------------------------------
; list_avg subroutine
; Required parameters (on stack): array start address, array size
; Returns (again, on stack): the average value
;------------------------------------------------------------------
list_avg:
    push bp
    mov bp, sp
    push bx
    push si
    push cx
    xor ax, ax
    mov cx, [bp+4]      ; cx has size of array
    mov bx, [bp+6]      ; bx has address of first element in array
    mov si, cx          ; copy size of array to si for division later
loop_start:
    add ax, [bx]        ; adding the values of array one by one
    add bx, 2           ; adding bx with 2 to go to next element of array
    loop loop_start     ; looping through array elements
    mov dx, 0
    mov bx, si          ; copy size of array to bx for division
    div bx              ; divide sum by size to get the average
    mov [bp+8], ax      ; store the average on the stack for return
    pop cx
    pop si
    pop bx
    pop bp
    ret 4

;------------------------------------------------------------------
; divide subroutine
; Required parameters (on stack): dividend, divisor
; Returns (on stack): the integer quotient
;------------------------------------------------------------------
divide:
    push bp
    mov bp, sp
    push ax
    mov ax, [bp+4]      ; move dividend to ax
    xor dx, dx
    div word[bp+6] ; divide by divisor
    mov [bp+8], ax      ; store quotient on the stack for return
    pop ax
    pop bp
    ret 4                ; go back and remove two params

;------------------------------------------------------------------ 
; Main program
; Sorts the marks array using bubblesort subroutine, then 
; calls list_avg subroutine on a sublist of first 3 elements
; and then on a sublist of last 3 elements
;------------------------------------------------------------------
start:       
	mov ax,marks
	push ax
	mov ax,[size]
	push ax

	; calling bubblesort to sort the array

	call bubblesort 

	;now calling list_avg to find the average of first three elements

	sub sp,2		;make space for output
	mov ax,marks		;placing the address of first element of array
	push ax
	mov ax,3		;placing the size of array
	push ax
	call list_avg
	pop dx			;popping the output from list_avg into dx
	mov [topAvg],dx		;placing the average of first three elements of array in memory labeled as topAvg
	
	;now calling list_avg to find the average of last three elements
	
	mov cx,[size]	;moving the size of array
	sub cx,3	; subtracting the 3 from array to go on third last element
	add cx,cx	;as we have to deal in bytes and each word takes 2 bytes 
	mov ax,2	;the reason i have put 2 in ax is because in the next line si has alrady the address of first element of array so either to start with zero which led to 2nd last element i put 2 so i reach the third last element
	mov si,marks

again:			;this whole label purpose is to reach the third last element as si has address of first element of array it is increment by 2 in each iteration until the ax and cx become equal as cx has the number in byte where the third element will be in list
	add si,2
	add ax,2
	cmp ax,cx
	jne again

	sub sp,2		;make space for output
	mov ax,si		;placing the address of third last element of array
	push ax
	mov ax,3		;placing the size of array
	push ax
	call list_avg
	pop dx			;popping the output from list_avg into dx
	mov [bottomAvg],dx	;placing the average of last three elements of array in memory labeled as bottomAvg
	     

finish:
  mov  ax, 0x4c00   ; exit program
  int  21h

              
[org 0x0100]
jmp start 

; place final outputs in these variables
topAvg:    dw 0   
bottomAvg: dw 0

; the data array and its size
; change these two to ensure your program works correctly all the time
marks:     dw  1, 2, 3, 36, 32, 5, 40, 168, 1, 22, 25, 3, 208, 29, 160, 2, 23, 26, 210, 42, 31, 32, 29, 11
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
list_avg:     
	push bp
	mov bp,sp
	push bx
	push si
	push cx
	mov cx,[bp+4]   ;so cx has size of array
	add cx,cx
	mov bx,[bp+6]   ;bx has address of first element in array
	mov si,0;
	mov ax,0
doitagain:
	add ax,[bx+si]  ;adding the values of array one by one
	add si,2	; adding si with 2 to go to next element of array
	sub cx,2	; At first cx has size of array but to restrict the array that how many times it will iterate we subtract cx with 2 in every iteration until it become zero
	cmp cx,0
	jne doitagain	; if cx is not equal to zero hence there are remaining elements in the array to be addressed hence jump to the label doitagain
	
	sub sp,2	;making space for output
	push ax  	;pushing dividend
	mov ax,[bp+4]
	push ax  	 ;pushing divisor
	call divide	 ; calling divide subroutine
	pop dx		 ;placing the output of divide subrotine in dx
	mov [bp+8],dx	 ;moving the ouptut from divide subroutine to output of list_avg which will be popped later in start

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
	mov bp,sp
	push ax
	mov cx,0;
	mov ax,[bp+6]  ;ax has the sum of array
check:
	cmp ax,[bp+4]	;[bp+4] has divisor
	jge subtract    ;whenever the ax is greater then size of array jump to subtract label
	mov [bp+8],cx   ;[bp+8] has the final value of average 

	pop ax
	pop bp

	ret 4



subtract:   	;the code in this label subtract the the size of array which is [bp+4] from ax until ax become less than the size of array
sub ax,[bp+4]  	;bp+4 has the size of array
inc cx		; cx will the incremented by one until the ax become less than the size of array (cx is used here as to record how many iteration have taken until the ax become less than the size of array)
		;in short at the last iteration cx will have the quotient
jmp check









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
	     
              
finish:       mov ax, 0x4c00
              int 21h
              
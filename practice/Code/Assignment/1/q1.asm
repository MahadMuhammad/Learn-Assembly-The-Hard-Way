[org 0x0100]

jmp start

;; a subroutine that takes two parameters a 16 bit number and an n-bit pattern (n<16)
;; now we have to do some bit shifting to find the pattern in the 16 bit number 
;; if pattern found return the starting index of the pattern else return -1
;; we will use the following variables
;; ax - 16 bit number
;; bx - 16 bit pattern


findpattern:
    push bp
    mov bp, sp
    mov ax, [bp+6] ; 16 bit number
    mov bx, [bp+4] ; 16 bit pattern
    mov cx, 0 ; counter
    mov dx, 0 ; flag
    mov si, 0 ; index
    ;; we use xor to find the pattern
    xor ax, bx ; and shift the pattern to the right
    ;; now we have to check if the pattern is found or not
    
    cmp ax, 0                   ;if ax is not zero then the pattern is not found
    jne notfound                ; if not found then jump to notfound
    cmp ax, 0                   ; if the result is 0 then the pattern is found
    jz found                    ;; if found then jump to found label
                                ;; if this is true then goto start label

                                ;; if the pattern is not found then we shift the pattern to the left & repeat the loop


found:
;; return the index of the pattern
    mov ax, si
    pop bp
    ret

notfound:
    inc si
    cmp si, 15 ;; if the index is 15 then the pattern is not found 
    jz notfound
    shl bx, 1  ;; shift the pattern to the left
    jmp findpattern


start:
    mov ax,1110111100001010b     ;; loads 0xEF0A into ax register (1110 1111 0000 1010b)
    push ax                         ;; pushes ax register onto the stack
    mov bx,111100b                  ;; loads 111100b into bx register
    push bx                         ;; pushes bx register onto the stack
    call findpattern                ;; calls the findpattern subroutine

end:  
mov  ax, 0x4c00         
int  0x21
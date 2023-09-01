[org 0x0100] 
    jmp start 
;Write a function named statsOfArray that takes an array as input and returns its min, max and
;median as output. All the input and output parameters should be passed on stack. You cannot sort the array
;in statsOfArray function, however, you can call BubbleSort function in statsOfArray. Template of this
;function is given below, your code should work for every array. 



array1: dw 6, 8,3, 9, 100, 5, 1, 50 
swap:   db  0 
lenArray1: dw 8

bubblesort: 
;; this subroutine sorts the array in ascending order & returns the sorted array in the same array
     push bp
        mov bp, sp
        push ax
        push bx
        push cx
        push dx
        push si
        push di

        mov ax, [bp+6] ; array address
        mov bx, [bp+8] ; array length
        mov cx, bx  
        dec cx

        mainloop:  
        mov  si, 0 
        mov  byte[swap], 0  

        innerloop: ;
            mov  ax, [bx + si] ; load the first element
            cmp  ax, [bx + si + 2] ; compare with the next element
            jbe  noswap ; if the first element is less than or equal to the next element, then no swap is required

                mov  dx, [bx + si + 2] ; swap the elements
                mov  [bx + si], dx ; store the second element in the first element
                mov  [bx + si + 2], ax ; store the first element in the second element
                mov  byte[swap], 1 ; set the swap flag

            noswap: 
            add  si, 2 
            cmp  si, cx
            jne  innerloop

        cmp  byte[swap], 1 
        je   mainloop


statOfArray:
; return the min, max and median of the array with input array and its length as input parameters
    push bp
    mov bp, sp
    sub sp, 6 ;reserve space for min, max, median, and 3 temp variables
    push bx
    push cx
    push dx
    push si
    push di
    push ax

    mov cx, [lenArray1] ;length of array
    mov si, array1

    call bubblesort

    ;;return min
    mov ax, [si]
    mov [bp-2], ax

    ;;return max
    mov ax, [si  - 2]
    mov [bp-4], ax

    ;;return median without multiplying by 2 & dividing by 2
    mov ax, cx
    shr ax, 1
    mov bx, [si  - 2]
    mov [bp-6], bx

;;return values
    pop ax
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    mov sp, bp
    pop bp
    ret 2  ;;return min, max, median


start:

    mov ax,[array1]
    mov bx,[lenArray1]
    push ax
    push bx
    call statOfArray

    mov ax, [bp - 4] ; min
    mov bx, [bp - 2] ; max
    mov cx, [bp] ; median




end:
    mov ax, 0x4c00 
    int 21h
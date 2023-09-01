[org 0x0100]

    jmp start

function:
    push bp 
    mov  bp, sp 

    sub sp,10 ; 5 local variables

    mov ax, [bp+4] ; input 1
    mov bx, [bp+6] ; input 2
    mov si, [bp+8] ; input 3
    mov di, [bp+10] ; input 4

    mov [bp-10], ax ; local 1
    mov [bp-8], bx ; local 2
    mov [bp-6], si ; local 3
    mov [bp-4], di ; local 4
    mov [bp-2], cx ; local 5

    ; operations performs 

    mov ax, [bp-10] ; local 1
    mov bx, [bp-8] ; local 2
    mov cx, [bp-6] ; local 3
    mov si, [bp-4] ; local 4
    mov di, [bp-2] ; local 5

    ;return 3 outputs
    mov [bp+12], ax
    mov [bp+14], bx
    mov [bp+16], cx


    mov sp, bp
    pop bp
    ret 8


start:
    sub sp,6
    mov ax, 1010 ;first variable
    push ax
    mov bx, 2020 ;second variable
    push bx
    mov cx, 3030 ;third variable
    push cx
    mov dx, 4040 ;fourth variable
    push dx
    call function

end:
    mov  ax, 0x4c00 
    int  0x21              


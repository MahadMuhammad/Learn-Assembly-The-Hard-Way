; hello world in assembly
[org 0x0100]
    jmp start
message: db 'I am From Pakistan' ; string to be printed
length: dw 18 ; length of the string
; subroutine to clear the screen
clrscr: 
    push es
    push ax
    push di
    mov ax, 0xb800
    mov es, ax ; point es to video base
    mov di, 0 ; point di to top left column
nextloc: 
    mov word [es:di], 0x0720 ; clear next char on screen
    add di, 2 ; move to next screen location
    cmp di, 4000 ; has the whole screen cleared
    jne nextloc ; if no clear next position
    pop di
    pop ax
    pop es
    ret
; subroutine to print a string at top left of screen
; takes address of string and its length as parameters
printstr: 
    push bp
    mov bp, sp
    push es
    push ax
    push cx
    push si
    push di
    mov ax, 0xb800
    mov es, ax ; point es to video base
    mov di, 0 ; point di to top left column
    mov si, [bp+6] ; point si to string
    mov cx, [bp+4] ; load length of string in cx
    mov ah, 0x07 ; normal attribute fixed in al
nextchar: 
    mov al, [si] ; load next char of string
    cmp  al,0x20 ; ASCII of space
    je skip
    mov [es:di], ax ; show this char on screen   
    add di, 2 ; move to next screen location
    add si, 1 ; move to next char in string
    loop nextchar ; repeat the operation cx times
    pop di
    pop si
    pop cx
    pop ax
    pop es
    pop bp
    ret 4

skip:
    ;add di, 2 ; move to next screen location
    mov [es:di], ax ; show this char on screen  
    add si, 1 ; move to next char in string
    loop nextchar ; repeat the operation cx times
    pop di
    pop si
    pop cx
    pop ax
    pop es
    pop bp
    ret 4
start: 
    call clrscr ; call the clrscr subroutine
    mov ax, message
    push ax ; push address of message
    push word [length] ; push message length
    call printstr ; call the printstr subroutine
 mov ax, 0x4c00 ; terminate program
 int 0x21 
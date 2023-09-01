; Copy the element
[org 0x0100]
    mov ax, 0xb800 ; load video base in ax
    mov es, ax ; point es to video base
    mov di, 2080 ; point di to top left columni
    mov si, 0
copy:    
    mov bx,word [es:si]
    mov word [es:di], bx ; clear next char on screen
    ;mov bx,word [es:si]
    add di, 2 ; move to next screen location
    add si,2
    cmp di, 4000 ; has the whole screen cleared
    jne copy ; if no clear next position

 mov ax, 0x4c00 ; terminate program
 int 0x21 
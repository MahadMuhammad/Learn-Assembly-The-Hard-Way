; clear the screen 
[org 0x0100] 
    jmp start
                    ; return to caller

red:
    mov di,0
    call topred ;;this subroutine will print red color in the top quarter screen from x(0,40) & y (0,12)
    
    add di,80
    call topred

    add di,80
    call topred

    add di,80
    call topred

    add di,80
    call topred

    add di,80
    call topred

    add di,80
    call topred

    add di,80
    call topred

    add di,80
    call topred

    add di,80
    call topred

    add di,80
    call topred

    add di,80
    call topred
    ret
topred:
    mov ax, 0xb800 ; load video base in ax 
    mov es, ax ; point es to video base 
    ;mov di, 0 ; point di to top left column 
    mov cx,di
    add cx,80

        nextchar: 
            ; print red background
            mov ah, 0x40            ; print space
            mov al, 0x20            ; red background
            mov [es:di], ax         ; print attribute
            add di, 2               ; move to next screen location 
            cmp di, cx           ; has the whole screen cleared 
            jne nextchar            ; if no clear next position 
    ret 

green:
    mov di,80
    call topgreen ;;this subroutine will print red color in the top quarter screen from x(0,40) & y (0,12)
    
    add di,80
    call topgreen

    add di,80
    call topgreen

    add di,80
    call topgreen

    add di,80
    call topgreen

    add di,80
    call topgreen

    add di,80
    call topgreen

    add di,80
    call topgreen

    add di,80
    call topgreen

    add di,80
    call topgreen

    add di,80
    call topgreen

    add di,80
    call topgreen
ret
topgreen:
    mov ax, 0xb800 ; load video base in ax 
    mov es, ax ; point es to video base 
    ;mov di, 0 ; point di to top left column 
    mov cx,di
    add cx,80

        nextchar2: 
            ; move green in ah
            mov ah, 0x20
            mov al, 0x20            ; red background
            mov [es:di], ax         ; print attribute
            add di, 2               ; move to next screen location 
            cmp di, cx           ; has the whole screen cleared 
            jne nextchar2            ; if no clear next position 
    ret 

staric:
    mov di,960
    call botstar ;;this subroutine will print red color in the top quarter screen from x(0,40) & y (0,12)
    
    add di,80
    call botstar

    add di,80
    call botstar

    add di,80
    call botstar

    add di,80
    call botstar

    add di,80
    call botstar

    add di,80
    call botstar

    add di,80
    call botstar

    add di,80
    call botstar

    add di,80
    call botstar

    add di,80
    call botstar

    add di,80
    call botstar
ret
botstar:
    mov ax, 0xb800 ; load video base in ax 
    mov es, ax ; point es to video base 
    ;mov di, 0 ; point di to top left column 
    mov cx,di
    add cx,80

        nextchar3: 
            ; move green in ah
            mov ah, 0x00
            mov al, '*'          ; red background
            mov [es:di], ax         ; print attribute
            add di, 2               ; move to next screen location 
            cmp di, cx           ; has the whole screen cleared 
            jne nextchar3            ; if no clear next position 
    ret 


start:
    mov bx,12  ; y-axis
    call red

    mov bx,12
    call green

    mov bx,12
    call botstar


    
end:
 mov ax, 0x4c00 ; terminate program 
 int 0x21
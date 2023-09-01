wholered:
    mov ax, 0xb800 ; load video base in ax 
    mov es, ax ; point es to video base 
    mov di, 0 ; point di to top left column 
    
        nextchar: 
            ; print red background
            mov ah, 0x40            ; print space
            mov al, 0x20            ; red background
            mov [es:di], ax         ; print attribute
            add di, 2               ; move to next screen location 
            cmp di, 4000            ; has the whole screen cleared 
            jne nextchar            ; if no clear next position 
    ret 
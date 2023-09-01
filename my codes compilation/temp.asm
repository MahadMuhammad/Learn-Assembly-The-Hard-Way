[org 0x0100]
    jmp start
oldisr: dd 0 ; space for saving old isr
ifapressed: db "He has food dna drinks",0 ; message to be displayed on screen
ifbpressed: db "He sah food and drinks",0 ; message to be displayed on screen
ifcpressed: db "He has food and drinks",0 ; message to be displayed on screen
strl: dw 23 ; length of message


start:


        mov ah,0x13     ;   Service 13h - Write Character and Attribute to Cursor Position
        mov al,1        ;   subservice - update cursor position
        mov bh,0        ;   page number
        mov bl,07h        ;   attribute byte
        mov dx,0x0   ;   row 22, column 33
        mov cx,[strl]       ;   number of characters to write (Length of string)
        push cs         ;   push the segment of the string
        pop es          ;   pop the segment of the string 

        mov bp,ifbpressed    ;   set the pointer to the string
        int 0x10        ;   call the interrupt
;   --------------------------------------------------------
   
mov ax, 0x4c00
int 21h
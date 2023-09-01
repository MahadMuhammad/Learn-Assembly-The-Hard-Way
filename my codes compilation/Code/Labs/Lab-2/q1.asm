; a program to add three numbers using memory variables
[org 0x0100]
	mov ax, [0025] ;
	mov [0x0FFF],bx  ; 
	mov bx, [0100]
	mov [0x0025],bx

mov ax, 0x4c00 ; 
int 0x21
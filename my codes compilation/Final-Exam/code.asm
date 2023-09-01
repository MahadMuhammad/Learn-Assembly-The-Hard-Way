[org 0x0100]
	jmp start
                tickcount: dw 0

kbisr:
                 in al, 0x60
                 cmp al, 0x2a
                 jne end
                 mov bl, 0x2a

end:
                 mov al, 0x20 
                 out 0x20, al
                  iret

timerISR:
                  ;---assume that keyboard was pressed by user at this point   
                  ;mov ah, 0x0
                  ;int 16h
                  push ax 
                  inc word [cs:tickcount]; increment tick count
                  mov al, 0x20 
                  out 0x20, al ; end of interrupt pop ax 
                  iret

start:
xor ax, ax 
mov es, ax 
cli 
mov word [es:9*4], kbisr 
mov [es:9*4+2], cs 
mov word [es:8*4], timerISR 
mov [es:8*4+2], cs 
;-------------------int 8h occurred here
 
sti 

mov ah, 0x0
int 16h
mov ax, 20
mov bx,15
add ax, bx
mov ax, 0x4C00
int 0x21	;Write your Answer here that is the sequence in which instructions executed




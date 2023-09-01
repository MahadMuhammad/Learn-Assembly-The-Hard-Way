[org 0x0100]

; start of code 

mov  ax, 5              ; move the constant 5 into register ax 
mov  bx, 10             
;mov [num1],[num2] ;illeagal
add  ax, bx             ; add value of bx into the value of ax 

mov  bx, 15             ; add constant 15 into the value of bx 
add  ax, bx

mov  ax, 0x4c00         ; exit .. 
int  0x21               ; .. is what the OS should do for me





; watch the listing carefully 
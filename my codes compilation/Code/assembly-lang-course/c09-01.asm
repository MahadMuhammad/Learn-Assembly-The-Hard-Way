SECTION .DATA
	hello:     db 'Hello from ASM!',10
	helloLen:  equ $-hello

SECTION .TEXT
GLOBAL say_hi


say_hi:
    mov rax, rdi          ; first param goes in RDI 
	push rax   			  ; save the value sent to us 

	mov eax, 4            ; write()
	mov ebx, 1            ; STDOUT
	mov ecx, hello
	mov edx, helloLen

	int 80h              ; Interrupt

	pop rax 			 ; get the value sent to us 
	inc rax 			 ; increment it 
	ret                  ; return val is in rax 



# Assemble using: nasm -f elf64 c09-01.asm  -o c09-01-asm.o 
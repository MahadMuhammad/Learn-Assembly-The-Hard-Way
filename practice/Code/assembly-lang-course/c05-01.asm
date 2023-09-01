; Let's run a 32-bit program in Ubuntu! 

; Install NASM in Ubuntu: 
; 	sudo apt install nasm

; Create this code file 

; Assemble: 
; 	nasm -f elf32 -l c05-01.lst -o c05-01.o c05-01.asm 
; 
; 	We want to create a format that Linux understand
;	i.e. ELF format in 32-bits 
; 	(we also create a listing file)
;   Read more about ELF here: https://linux-audit.com/elf-binaries-on-linux-understanding-and-analysis/ 

; Link with shared library that 'understands' the format: ld.so in Linux 
; 	ld -m elf_i386 -o c05-01 c05-01.o

; Run it: 
; 	./c05-01 



; Now let's discuss the code! 

; in modern OSs, programs do not start executing 
; "from the first instruction"

; Instead, there is a library (ld.so) that looks for the "start symbol"
; and executes from there. 


; a section "directive" marks the parts of a program 
; for the ELF format  (or whatever binary format you are using)
SECTION .text: 

; We mark the start for this library using the following: 
GLOBAL _start 

_start: 
	; write the string to console 
	mov eax, 0x4 				; write syscall is 0x4 
	mov ebx, 1 					; param - std output should be used 
	mov ecx, message 			; the string to write 
	mov edx, message_length 	; the length of the string 		
	int 0x80 					; invoke the system call 


	; exit the program 
	mov eax, 0x1 				; exit system call is 0x1 
	mov ebx, 0 					; exit code is 0 (return 0) 
	int 0x80 					; Comment out and see!  

	; note that int is NOT the right way to do things!   
	; (more on this later)


; data section here. We can also move it above .code 
SECTION .data: 
	; 0xA is new line, 0x0 is null terminator 
	message: db "Hello!",  0xA,  0x0 
	message_length: equ $-message 

	; message_length: equ 8 
	; .... is exactly the same as 
	; #define message_length 8 
	


; Some useful ELF details 
; readelf -a c05-01.o 		; shows everything 

; readelf -h c05-01.o		; shows headers 
; readelf -S c05-01.o     	; shows sections 

; readelf -x 2 c05-01.o		; shows section number 2 
; readelf -x 2 c05-01  		; see the difference between above and this 





; View program in GDB 

; gdb ./c05-01 
; layout regs       ; shows registers and disassembled code 
; starti 			; start the program interactively 
; si 				; execute one machine instruction 
; quit 				; exit GDB 


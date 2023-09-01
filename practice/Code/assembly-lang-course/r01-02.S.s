# This example shows an implementation of addition with function call 

.data
arg1:     .word   2
arg2:     .word   3 

.text
main:
        lw  a0, arg1   # Load argument from static data
		lw  a1, arg2 
        jal ra, addit       # Jump-and-link to the 'addit' label


        # Exit program
        li a7, 10
        ecall

addit:
        add a0, a0, a1
        jr x1

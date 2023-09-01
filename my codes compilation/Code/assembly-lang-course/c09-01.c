/* example.c */
#include <stdio.h> 
extern int say_hi();


int main(int argc, char *argv[]) {
    int val; 

    printf("Hello from C! \n");
	val = say_hi(5);
    printf("Value returned: %d \n", val);
}



// Compile and link using: gcc -no-pie c09-01.c c09-01-asm.o -o hello
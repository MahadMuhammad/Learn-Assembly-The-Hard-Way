;   --------------------------------------------------------
;   Author: Muhammad Mahad
;   4x4 TIC TAC TOE
;   Architechture: Intel IAPX-88 (8080) 16 bit
;   Emulator: DOSBOX
;   --------------------------------------------------------
;___________________________________________________________
;   --------------------------------------------------------
;   BOARD LAYOUT (0-15) IN BACKGROUND
;   --------------------------------------------------------
;           1 | 2 | 3 | 4
;           Q | W | E | R
;           A | S | D | F
;           Z | X | C | V
;   --------------------------------------------------------
;___________________________________________________________
;   --------------------------------------------------------
;   GAMEPLAY
;   --------------------------------------------------------
;        Player 1 is X and Player 2 is O
; STARTING: 
;   1. Player 1 starts the game
;   2. Player 1 chooses a position of X on the board
;   3. Player 2 chooses a position of O on the board
;   4. Repeat until a player wins or the board is full
; ERROR:
;   1. If a player chooses a position that is already taken
;      the game will display an error message and the player
;      will have to choose another position
;   2. If a player chooses a position that is not on the board
;      the game will display an error message and the player
;      will have to choose another position
; WINNING / DRAW :
;   1. If a player gets 4 X's or O's in a row, column, or diagonal
;      the game will display a message and the player will win
;   2. If the board is full and no player has won, the game will
;      display a message and the game will end in a tie
;   --------------------------------------------------------
;___________________________________________________________
;   --------------------------------------------------------
;   GAME LOGIC
;   --------------------------------------------------------
;   1. The game is won if any of the following conditions are true
;       a. The first row is filled with Xs or Os
;       b. The second row is filled with Xs or Os
;       c. The third row is filled with Xs or Os
;       d. The fourth row is filled with Xs or Os
;       e. The first column is filled with Xs or Os
;       f. The second column is filled with Xs or Os
;       g. The third column is filled with Xs or Os
;       h. The fourth column is filled with Xs or Os
;       i. The first diagonal is filled with Xs or Os
;       j. The second diagonal is filled with Xs or Os
;   2. The game is a draw if all the positions are filled and no player has won
; Links https://kb.iu.edu/d/aanc
;   --------------------------------------------------------
;___________________________________________________________
;   --------------------------------------------------------
;   DATA STRUCTURES / BACKEND
;   --------------------------------------------------------
;   1. The board is represented by a 4x4 array
;   2. The array is initialized with 0s
;   3. The array is updated with 1s and 2s
;   4. 1 represents X and 2 represents O
;   --------------------------------------------------------
;___________________________________________________________
;   --------------------------------------------------------
;   ALGORITHM
;   --------------------------------------------------------
;   1. Initialize the board with 0s
;   2. Display the board
;   3. Player 1 enters the position where he wants to place X
;   4. Update the board
;   5. Display the board
;   6. Check if the game is won or a draw
;   7. If the game is won or a draw, display the result and exit
;   8. If the game is not won or a draw, go to step 3
;   --------------------------------------------------------
;___________________________________________________________




;   --------------------------------------------------------
;   CODE
;   --------------------------------------------------------
[org 0x0100]        ;   Start of the program
    jmp main        ; jump to main

;   --------------------------------------------------------
;   DEFINITIONS
;   --------------------------------------------------------

BOARD:                      ;   Board array
        db 2,2,2,2          ; 1 | 2 | 3 | 4
        db 2,2,2,2          ; Q | W | E | R
        db 2,2,2,2          ; A | S | D | F
        db 2,2,2,2          ; Z | X | C | V 

COUNTS:  db 15             ;   Number of positions on the board

P1ORP2:  db 0              ;   Player 1 or Player 2

P1WIN: db 'Player-1 Wins!'  ;   Player 1 wins message

P2WIN: db 'Player-2 Wins!'  ;   Player 2 wins message

DRAW:  db 'The Game Draw!'           ;   Game Draw message

ERROR: db 'Error! (Change the Position), Box Occupied'          ;   Game Error message

WRONGKEY: db 'Error! Wrong Key Pressed'          ;   Wrong Key Pressed message

WELCOME: db 'Welcome to 4x4 TIC TAC TOE'          ;   Welcome message

GAME_ENDED: db 'The Game Ended! (Good Bye!)'          ;   Game Ended message

PRESSANYKEYTOCONTINUE: db 'Press any key to continue'          ;   Press any key to continue message

P1TURN: db 'Player-1 Turn'          ;   Player 1 Turn message

P2TURN: db 'Player-2 Turn'          ;   Player 2 Turn message

MESSAGETICTACTOE: db 'Welcome To TIC TAC TOE by MAHAD', 0       ;  Message to be displayed at the top of screen

P1OldIser: dd 0 ; space for saving old Old P1 isr 

P2OldIser: dd 0 ; space for saving old Old P2 isr


;   --------------------------------------------------------
;   BASIC FUNCTIONS
;   --------------------------------------------------------

Intro:                             ;   First Prints DOT on screen, wait for user & prints grey color on screen 
                                   ;   Used in main function
            call PrintWELCOME       ;   Call the AnyKeyPress function
            call Dot               ;   Call the Dot function
            
            pusha                  ;   Save the registers

            mov ax,0xb800   ;   Set the video memory address
            mov es,ax       ;   Set the video memory segment
            mov di,0        ;   Set a pointer to the start of the video memory
            mov ah,0x77     ;   set color ASCII code (0111 0111)
            mov al,20h      ;   set the blank character     
            mov cx,80*1     ;   set the number of characters to write (Only First Line)
            cld             ;   clear direction flag
            rep stosw       ;   Fill the video memory with the attribute byte


            mov ax,0xb800   ;   Set the video memory address
            mov es,ax       ;   Set the video memory segment
            mov di,160      ;   Set a pointer to the start of the video memory
            mov ah,0x60     ;   set color ASCII code (0111 1111)
            mov al,20h      ;   set the blank character     
            mov cx,2000-80  ;   set the number of characters to write
            cld             ;   clear direction flag
            rep stosw       ;   Fill the video memory with the attribute byte

            mov ax,0xb800   ;   Set the video memory address
            mov es,ax       ;   Set the video memory segment
            mov di,160*24        ;   Set a pointer to the start of the video memory
            mov ah,0x30     ;   set color ASCII code (0111 1111)
            mov al,20h      ;   set the blank character     
            mov cx,80*25    ;   set the number of characters to write
            cld             ;   clear direction flag
            rep stosw       ;   Fill the video memory with the attribute byte


    
            popa            ;   Restore the registers
            ret             ;   Return (to the main function)
;   --------------------------------------------------------
DisplayBoard:                   ; Display the board & call P1Turn function
        pusha                  ;   Save the registers

        

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160+2     ;   Set a pointer to the start of the video memory
                        mov ah,0     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-2   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        
                        
                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*2+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*3+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*4+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*5+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*6+4     ;   Set a pointer to the start of the video memory
                        mov ah,00     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*7+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*8+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*9+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*10+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*11+4     ;   Set a pointer to the start of the video memory
                        mov ah,000     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*12+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*13+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*14+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*15+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*16+4     ;   Set a pointer to the start of the video memory
                        mov ah,00     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*17+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*18+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*19+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*20+4     ;   Set a pointer to the start of the video memory
                        mov ah,060     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-4   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        ; Horizontal Black Line
                        mov ax,0xb800   ;   Set the video memory address
                        mov es,ax       ;   Set the video memory segment
                        mov di,160*21+2     ;   Set a pointer to the start of the video memory
                        mov ah,0     ;   set color ASCII code (0111 1111)
                        mov al,20h      ;   set the blank character     
                        mov cx,80-2   ;   set the number of characters to write
                        cld             ;   clear direction flag
                        rep stosw       ;   Fill the video memory with the attribute byte

                        ; Print Centre & left line
                        mov ax, 0xb800 ; load video base in ax 
                        mov es, ax ; point es to video base 
                        mov di, 160*2+2 ; point di to top left column 
                                nextchar: 
                                                mov word [es:di], 0x0020 ; clear next char on screen 
                                                add di, 80 ; move to next screen location 
                                                cmp di, 3362 ; has the whole screen cleared 
                                                jne nextchar ; if no clear next position 
                        
                        ; Print Right vertical Line
                        mov ax, 0xb800 ; load video base in ax 
                        mov es, ax ; point es to video base 
                        mov di, 160*3-4 ; point di to top left column 
                                nextchar2: 
                                                mov word [es:di], 0x0020 ; clear next char on screen 
                                                add di, 160 ; move to next screen location 
                                                cmp di, 3516 ; has the whole screen cleared 876
                                                jne nextchar2 ; if no clear next position

                         ; Print Right vertical Line
                        mov ax, 0xb800 ; load video base in ax 
                        mov es, ax ; point es to video base 
                        mov di, 362 ; point di to top left column  (160*2+2)+(322+80)= 724 | 724/2=362
                                nextchar3: 
                                                mov word [es:di], 0x0020 ; clear next char on screen 
                                                add di, 80 ; move to next screen location 
                                                cmp di, 3402 ; has the whole screen cleared 876
                                                jne nextchar3 ; if no clear next position

                        




        popa            ;   Restore the registers
        ;call PrintP1TURN    ;   Call the PrintP1TURN function
        call PrintMESSAGETICTACTOE
        ret             ;   Return (to the main function)




;   --------------------------------------------------------
ClearThatUserSegment:
        pusha           ;   Save the registers

        mov ax,0xb800   ;   Set the video memory address
        mov es,ax       ;   Set the video memory segment
        mov di,160*22+2     ;   Set a pointer to the start of the video memory
        mov ah,0x60     ;   set color ASCII code (0111 1111)
        mov al,20h      ;   set the blank character     
        mov cx,80-2   ;   set the number of characters to write
        cld             ;   clear direction flag
        rep stosw       ;   Fill the video memory with the attribute byte

        popa            ;   Restore the registers
        ret             ;   Return
;   --------------------------------------------------------
ClearThatUpperSegment:
        pusha           ;   Save the registers

        mov ax,0xb800   ;   Set the video memory address
        mov es,ax       ;   Set the video memory segment
        mov di,160+2     ;   Set a pointer to the start of the video memory
        mov ah,0     ;   set color ASCII code (0111 1111)
        mov al,20h      ;   set the blank character     
        mov cx,80-2   ;   set the number of characters to write
        cld             ;   clear direction flag
        rep stosw       ;   Fill the video memory with the attribute byte

        popa            ;   Restore the registers
        ret             ;   Return
;   --------------------------------------------------------

;___________________________________________________________
;   --------------------------------------------------------
;   EXTRA FUNCTIONS
;   --------------------------------------------------------
Dot:                        ;   Prints dots on screen  (Used in Intro function)
        pusha               ;   Save the registers  

        mov ax,0xb800       ;   Set the video memory address
        mov es,ax           ;   Set the video memory segment
        mov di,0            ;   Set a pointer to the start of the video memory
        mov ah,0x0e         ;   Set the attribute byte (0x0e)
        mov al,0x07         ;   Set the color to white
        mov [es:di],al      ;   Set the color to white
        mov cx,2000

        cld
        rep stosw           ;   Fill the video memory with the attribute byte

        popa                ;   Restore the registers
        call AnyKeyPress        ;   Wait for any key press
        ret                 ;   Return (to the Intro function)
;   --------------------------------------------------------
AnyKeyPress:                ;   Wait for any key press  (Used in Intro function)
        pusha               ;   Save the registers

        mov ah,0x00         ;   Set the interrupt number
        int 0x16            ;   Call the interrupt

        popa                ;   Restore the registers
        ret                 ;   Return (to the Intro function)
;   --------------------------------------------------------
ClearScreen:                ;   CLear Screen with spaces
        pusha               ;   Save the registers  

        mov ax,0xb800       ;   Set the video memory address
        mov es,ax           ;   Set the video memory segment
        mov di,0            ;   Set a pointer to the start of the video memory
        mov ax,0x0720       ;   Set the attribute byte (0x0e)
        mov cx,2000         ;   Set the number of characters to write

        cld
        rep stosw           ;   Fill the video memory with the attribute byte

        popa                ;   Restore the registers
        ret                 ;   Return (to the Intro function)
;   --------------------------------------------------------
Delay:                    ;   Delay function 
        pusha             ;   Save the registers
	
        mov cx,0xffff     ;   Set the counter to 0xffff
	    
            LoopDelay:                  ;   LoopDelay label
	    	    loop LoopDelay      ;   Loop the LoopDelay label
        
        popa               ;   Restore the registers
        ret                ;   Return to the caller
;   --------------------------------------------------------
LongDelay:
        pusha             ;   Save the registers
        
        mov cx,100    ;   Set the counter to 0xffff
            
            LoopDelay2:                  ;   LoopDelay label
                    call Delay
            	    loop LoopDelay2      ;   Loop the LoopDelay label
        
        popa               ;   Restore the registers
        ret                ;   Return to the caller
PrintP1WIN:
        call ClearThatUpperSegment
        pusha

        mov ah,0x13     ;   Service 13h - Write Character and Attribute to Cursor Position
        mov al,1        ;   subservice - update cursor position
        mov bh,0        ;   page number
        mov bl,9Ch        ;   attribute byte ;1Ch
        mov dx,0x1621   ;   row 22, column 33
        mov cx,14       ;   number of characters to write (Length of string)
        push cs         ;   push the segment of the string
        pop es          ;   pop the segment of the string 

        mov bp,P1WIN    ;   set the pointer to the string
        int 0x10        ;   call the interrupt



        popa            ;   Restore the registers
        call AnyKeyPress        ;   Wait for any key press
        ret            ;   Return 
;   --------------------------------------------------------
PrintP2WIN:
        pusha

        mov ah,0x13     ;   Service 13h - Write Character and Attribute to Cursor Position
        mov al,1        ;   subservice - update cursor position
        mov bh,0        ;   page number
        mov bl,9Ch        ;   attribute byte
        mov dx,0x1621   ;   row 22, column 33
        mov cx,14       ;   number of characters to write (Length of string)
        push cs         ;   push the segment of the string
        pop es          ;   pop the segment of the string 

        mov bp,P2WIN    ;   set the pointer to the string
        int 0x10        ;   call the interrupt



        popa            ;   Restore the registers
        call AnyKeyPress        ;   Wait for any key press
        ret            ;   Return 
;   --------------------------------------------------------
PrintDRAW:
        pusha

        mov ah,0x13     ;   Service 13h - Write Character and Attribute to Cursor Position
        mov al,1        ;   subservice - update cursor position
        mov bh,0        ;   page number
        mov bl,1Ch        ;   attribute byte
        mov dx,0x1621   ;   row 22, column 33
        mov cx,14       ;   number of characters to write (Length of string)
        push cs         ;   push the segment of the string
        pop es          ;   pop the segment of the string 

        mov bp,DRAW    ;   set the pointer to the string
        int 0x10        ;   call the interrupt


        popa            ;   Restore the registers
        ret            ;   Return 
;   --------------------------------------------------------
PrintERROR:
        pusha

        mov ah,0x13     ;   Service 13h - Write Character and Attribute to Cursor Position
        mov al,1        ;   subservice - update cursor position
        mov bh,0        ;   page number
        mov bl,9Ch        ;   attribute byte
        mov dx,0x1614   ;   row 22, column 33
        mov cx,42       ;   number of characters to write (Length of string)
        push cs         ;   push the segment of the string
        pop es          ;   pop the segment of the string 

        mov bp,ERROR    ;   set the pointer to the string
        int 0x10        ;   call the interrupt


        popa            ;   Restore the registers
        ret            ;   Return 
;   --------------------------------------------------------
PrintWRONGKEY:
        pusha

        mov ah,0x13     ;   Service 13h - Write Character and Attribute to Cursor Position
        mov al,1        ;   subservice - update cursor position
        mov bh,0        ;   page number
        mov bl,9Ch        ;   attribute byte
        mov dx,0x1616   ;   row 22, column 33
        mov cx,24       ;   number of characters to write (Length of string)
        push cs         ;   push the segment of the string
        pop es          ;   pop the segment of the string 

        mov bp,WRONGKEY    ;   set the pointer to the string
        int 0x10        ;   call the interrupt


        popa            ;   Restore the registers
        ret            ;   Return
;   --------------------------------------------------------
PrintWELCOME:
        call ClearScreen        ;   Clear the screen


        pusha

        mov ah,0x13     ;   Service 13h - Write Character and Attribute to Cursor Position
        mov al,1        ;   subservice - update cursor position
        mov bh,0        ;   page number
        mov bl,1Ch        ;   attribute byte
        mov dx,0x0C18   ;   row 22, column 33
        mov cx,26       ;   number of characters to write (Length of string)
        push cs         ;   push the segment of the string
        pop es          ;   pop the segment of the string 

        mov bp,WELCOME    ;   set the pointer to the string
        int 0x10        ;   call the interrupt
        

        popa            ;   Restore the registers
        call PrintPRESSANYKEYTOCONTINUE
        call AnyKeyPress        ;   Wait for any key press
        ret            ;   Return
;   --------------------------------------------------------
PrintGAME_ENDED:
        call ColorWhiteScreen        ;   Clear the screen

        pusha

        mov ah,0x13     ;   Service 13h - Write Character and Attribute to Cursor Position
        mov al,1        ;   subservice - update cursor position
        mov bh,0        ;   page number
        mov bl,1Ch        ;   attribute byte
        mov dx,0x0C18   ;   row 22, column 33
        mov cx,27       ;   number of characters to write (Length of string)
        push cs         ;   push the segment of the string
        pop es          ;   pop the segment of the string 

        mov bp,GAME_ENDED    ;   set the pointer to the string
        int 0x10        ;   call the interrupt
        

        popa            ;   Restore the registers
        call PrintPRESSANYKEYTOCONTINUE
        call AnyKeyPress        ;   Wait for any key press
        call EndGame    ;   End the game
        ret            ;   Return
;   -------------------------------------------------------
PrintPRESSANYKEYTOCONTINUE:
        ;call ClearScreen        ;   Clear the screen
        
        pusha

        mov ah,0x13     ;   Service 13h - Write Character and Attribute to Cursor Position
        mov al,1        ;   subservice - update cursor position
        mov bh,0        ;   page number
        mov bl,9Ch        ;   attribute byte
        mov dx,0x1614   ;   row 22, column 33
        mov cx,25       ;   number of characters to write (Length of string)
        push cs         ;   push the segment of the string
        pop es          ;   pop the segment of the string 

        mov bp,PRESSANYKEYTOCONTINUE    ;   set the pointer to the string
        int 0x10        ;   call the interrupt
        

        popa            ;   Restore the registers
        call AnyKeyPress        ;   Wait for any key press
        ret            ;   Return
;   -------------------------------------------------------
PrintP1TURN:
        ;call ClearScreen        ;   Clear the screen

        pusha

        mov ah,0x13     ;   Service 13h - Write Character and Attribute to Cursor Position
        mov al,1        ;   subservice - update cursor position
        mov bh,0        ;   page number
        mov bl,9Ch        ;   attribute byte
        mov dx,0x0118   ;   row 22, column 33
        mov cx,13       ;   number of characters to write (Length of string)
        push cs         ;   push the segment of the string
        pop es          ;   pop the segment of the string 

        mov bp,P1TURN    ;   set the pointer to the string
        int 0x10        ;   call the interrupt
        

        popa            ;   Restore the registers
        ret            ;   Return
;     -------------------------------------------------------
PrintP2TURN:
        ;call ClearScreen        ;   Clear the screen

        pusha

        mov ah,0x13     ;   Service 13h - Write Character and Attribute to Cursor Position
        mov al,1        ;   subservice - update cursor position
        mov bh,0        ;   page number
        mov bl,9Ch        ;   attribute byte
        mov dx,0x0118   ;   row 22, column 33
        mov cx,13       ;   number of characters to write (Length of string)
        push cs         ;   push the segment of the string
        pop es          ;   pop the segment of the string 

        mov bp,P2TURN    ;   set the pointer to the string
        int 0x10        ;   call the interrupt
        

        popa            ;   Restore the registers
        ret            ;   Return
;     -------------------------------------------------------
StringLength:           ; This function return length of string in ax register
    push bp             ;   Save the base pointer
    mov bp,sp           ;   Set the base pointer to the stack pointer
    push es             ;   Save the segment register
    push cx             ;   Save the counter
    push di             ;   Save the index register

    les di, [bp+4]      ; point es:di to string 
    mov cx, 0xffff      ; load maximum number in cx 
    mov al,0            ; load a zero in al 
    repne scasb         ; find zero in the string 
    mov ax, 0xffff      ; load maximum number in ax 
    sub ax, cx          ; find change in cx 
    dec ax              ; exclude null from length 

    pop di 
    pop cx 
    pop es 
    pop bp 
    ret 4 
;  -------------------------------------------------------  
printstr:                       ; subroutine to print a string
    push bp                     ; takes the x position, y position, attribute, and address of a null 
    mov bp, sp                  ; terminated string as parameters
    push es 
    push ax 
    push cx 
    push si 
    push di 
    push ds                     ; push segment of string 


    mov ax, [bp+4] 
    push ax                     ; push offset of string 
    call StringLength           ; calculate string length
    cmp ax, 0                   ; is the string empty 
    jz printstr_exit            ; no printing if string is empty
    mov cx, ax                  ; save length in cx 
    mov ax, 0xb800 
    mov es, ax                  ; point es to video base 
    mov al, 80                  ; load al with columns per row 
    mul byte [bp+8]             ; multiply with y position 
    add ax, [bp+10]             ; add x position 
    shl ax, 1                   ; turn into byte offset 
    mov di,ax                   ; point di to required location 
    mov si, [bp+4]              ; point si to string 
    mov ah, [bp+6]              ; load attribute in ah 
    cld                         ; auto increment mode 


        printstr_nextchar: 
                lodsb                   ; load next char in al 
                stosw                   ; print char/attribute pair 
                loop printstr_nextchar  ; repeat for the whole string 
        printstr_exit: 
                pop di 
                pop si 
                pop cx 
                pop ax 
                pop es 
                pop bp 
                ret 8 
;  -------------------------------------------------------
PrintMESSAGETICTACTOE:
        pusha           ;   Save the registers

        mov ax, 22      ;  Move the x position
        push ax         ; push x position 
        mov ax, 0       ;  Move the y position
        push ax         ; Move the y position
        mov ax,0x74     ; Red on White Blinking
        push ax         ; push attribute 
        mov ax, MESSAGETICTACTOE        ;  Move the address of the string 
        push ax         ; push offset of string 
        call printstr   ; print the string 
        mov ah, 0       ; service 0 – get keystroke 
        int 0x16        ; call BIOS keyboard service

        popa            ;   Restore the registers
        ret             ;   Return
;  -------------------------------------------------------
ColorWhiteScreen:
        pusha        ;   Save the registers

        mov ax,0xb800       ;   Set the video memory address
        mov es,ax           ;   Set the video memory segment
        mov di,0            ;   Set a pointer to the start of the video memory
        mov ax,0x7020       ;   Set the attribute byte (0x0e)
        mov cx,2000         ;   Set the number of characters to write

        cld
        rep stosw           ;   Fill the video memory with the attribute byte

        popa          ;   Restore the registers
        ret           ;   Return
;  -------------------------------------------------------


;___________________________________________________________
;   --------------------------------------------------------
;   GAME LOGIC
;   --------------------------------------------------------
P1Win:
                call PrintP1WIN
                call LongDelay
                jmp PrintGAME_ENDED
                pop ax
;  -------------------------------------------------------
P2Win:
                call PrintP2WIN
                call LongDelay
                jmp PrintGAME_ENDED
                pop ax
;  -------------------------------------------------------
CheckWinP1:
        pusha

                P1R1:
                        cmp byte [BOARD+0],0         ; Check if the first row is filled with 0
                        jne P1R2                ; If not, jump to P1R2
                        cmp byte [BOARD+1],0       ; Check if the second row is filled with 0
                        jne P1R2                ; If not, jump to P1R2
                        cmp byte [BOARD+2],0       ; Check if the third row is filled with 0
                        jne P1R2                ; If not, jump to P1R2
                        cmp byte [BOARD+3],0       ; Check if the fourth row is filled with 0
                        je P1Win                ; If yes, jump to P1Win
                P1R2:
                        cmp byte [BOARD+4],0       ; Check if the first row is filled with 0
                        jne P1R3                ; If not, jump to P1R3
                        cmp byte [BOARD+5],0       ; Check if the second row is filled with 0
                        jne P1R3                ; If not, jump to P1R3
                        cmp byte [BOARD+6],0       ; Check if the third row is filled with 0
                        jne P1R3                ; If not, jump to P1R3
                        cmp byte [BOARD+7],0       ; Check if the fourth row is filled with 0
                        je P1Win                ; If yes, jump to P1Win
                P1R3:
                        cmp byte [BOARD+8],0       ; Check if the first row is filled with 0
                        jne P1R4                ; If not, jump to P1R4
                        cmp byte [BOARD+9],0       ; Check if the second row is filled with 0
                        jne P1R4                ; If not, jump to P1R4
                        cmp byte [BOARD+10],0      ; Check if the third row is filled with 0
                        jne P1R4                ; If not, jump to P1R4
                        cmp byte [BOARD+11],0      ; Check if the fourth row is filled with 0
                        je P1Win                ; If yes, jump to P1Win
                P1R4:   
                        cmp byte [BOARD+12],0      ; Check if the first row is filled with 0
                        jne P1C1                ; If not, jump to P1C1
                        cmp byte [BOARD+13],0      ; Check if the second row is filled with 0
                        jne P1C1                ; If not, jump to P1C1
                        cmp byte [BOARD+14],0      ; Check if the third row is filled with 0
                        jne P1C1                ; If not, jump to P1C1
                        cmp byte [BOARD+15],0      ; Check if the fourth row is filled with 0
                        je P1Win                ; If yes, jump to P1Win
                P1C1:
                        cmp byte [BOARD+0],0      ; Check if the first row is filled with 0
                        jne P1C2                ; If not, jump to P1C2
                        cmp byte [BOARD+4],0       ; Check if the second row is filled with 0
                        jne P1C2                ; If not, jump to P1C2
                        cmp byte [BOARD+8],0       ; Check if the third row is filled with 0
                        jne P1C2                ; If not, jump to P1C2
                        cmp byte [BOARD+12],0      ; Check if the fourth row is filled with 0
                        je P1Win                ; If yes, jump to P1Win
                P1C2:
                        cmp byte [BOARD+1],0      ; Check if the first row is filled with 0
                        jne P1C3                ; If not, jump to P1C3
                        cmp byte [BOARD+5],0       ; Check if the second row is filled with 0
                        jne P1C3                ; If not, jump to P1C3
                        cmp byte [BOARD+9],0       ; Check if the third row is filled with 0
                        jne P1C3                ; If not, jump to P1C3
                        cmp byte [BOARD+13],0      ; Check if the fourth row is filled with 0
                        je P1Win                ; If yes, jump to P1Win
                P1C3:
                        cmp byte [BOARD+2],0      ; Check if the first row is filled with 0
                        jne P1C4                ; If not, jump to P1C4
                        cmp byte [BOARD+6],0       ; Check if the second row is filled with 0
                        jne P1C4                ; If not, jump to P1C4
                        cmp byte [BOARD+10],0      ; Check if the third row is filled with 0
                        jne P1C4                ; If not, jump to P1C4
                        cmp byte [BOARD+14],0      ; Check if the fourth row is filled with 0
                        je P1Win                ; If yes, jump to P1Win
                P1C4:
                        cmp byte [BOARD+3],0       ; Check if the first row is filled with 0
                        jne P1D1                ; If not, jump to P1D1
                        cmp byte [BOARD+6],0       ; Check if the second row is filled with 0
                        jne P1D1                ; If not, jump to P1D1
                        cmp byte [BOARD+9],0       ; Check if the third row is filled with 0
                        jne P1D1                ; If not, jump to P1D1
                        cmp byte [BOARD+12],0      ; Check if the fourth row is filled with 0
                        je P1Win                ; If yes, jump to P1Win
                P1D1:
                        cmp byte [BOARD+0],0       ; Check if the first row is filled with 0
                        jne P1D2                ; If not, jump to P1D2
                        cmp byte [BOARD+5],0       ; Check if the second row is filled with 0
                        jne P1D2                ; If not, jump to P1D2
                        cmp byte [BOARD+10],0      ; Check if the third row is filled with 0
                        jne P1D2                ; If not, jump to P1D2
                        cmp byte [BOARD+15],0      ; Check if the fourth row is filled with 0
                        je P1Win                ; If yes, jump to P1Win 
                P1D2:
                        cmp byte [BOARD+3],0      ; Check if the first row is filled with 0
                        jne P1NotWin                ; If not, jump to P1D3 
                        cmp byte [BOARD+6],0       ; Check if the second row is filled with 0
                        jne P1NotWin                ; If not, jump to P1D3
                        cmp byte [BOARD+9],0       ; Check if the third row is filled with 0
                        jne P1NotWin                ; If not, jump to P1D3
                        cmp byte [BOARD+12],0      ; Check if the fourth row is filled with 0
        
        
        P1NotWin:
                popa
                ret
;   ------------------------------------------------------
CheckWinP2:
        pusha

        mov ax,BOARD    ; Points ax to the start of the board

                P2R1:
                        cmp byte [BOARD+0],1       ; Check if the first row is filled with 1
                        jne P2R2                ; If not, jump to P2R2
                        cmp byte [BOARD+1],1       ; Check if the second row is filled with 1
                        jne P2R2                ; If not, jump to P2R2
                        cmp byte [BOARD+2],1       ; Check if the third row is filled with 1
                        jne P2R2                ; If not, jump to P2R2
                        cmp byte [BOARD+3],1       ; Check if the fourth row is filled with 1
                        je P2Win                ; If yes, jump to P2Win
                P2R2:
                        cmp byte [BOARD+4],1       ; Check if the first row is filled with 1
                        jne P2R3                ; If not, jump to P2R3
                        cmp byte [BOARD+5],1       ; Check if the second row is filled with 1
                        jne P2R3                ; If not, jump to P2R3
                        cmp byte [BOARD+6],1       ; Check if the third row is filled with 1
                        jne P2R3                ; If not, jump to P2R3
                        cmp byte [BOARD+7],1       ; Check if the fourth row is filled with 1
                        je P2Win                ; If yes, jump to P2Win
                P2R3:
                        cmp byte [BOARD+8],1       ; Check if the first row is filled with 1
                        jne P2R4                ; If not, jump to P2R4
                        cmp byte [BOARD+9],1       ; Check if the second row is filled with 1
                        jne P2R4                ; If not, jump to P2R4
                        cmp byte [BOARD+10],1      ; Check if the third row is filled with 1
                        jne P2R4                ; If not, jump to P2R4
                        cmp byte [BOARD+11],1      ; Check if the fourth row is filled with 1
                        je P2Win                ; If yes, jump to P2Win
                P2R4:
                        cmp byte [BOARD+12],1      ; Check if the first row is filled with 1
                        jne P2C1                ; If not, jump to P2C1
                        cmp byte [BOARD+13],1      ; Check if the second row is filled with 1
                        jne P2C1                ; If not, jump to P2C1
                        cmp byte [BOARD+14],1      ; Check if the third row is filled with 2
                        jne P2C1                ; If not, jump to P2C1
                        cmp byte [BOARD+15],1      ; Check if the fourth row is filled with 1
                        je P2Win                ; If yes, jump to P2Win
                P2C1:
                        cmp byte [BOARD+0],1       ; Check if the first row is filled with 1
                        jne P2C2                ; If not, jump to P2C2
                        cmp byte [BOARD+4],1       ; Check if the second row is filled with 1
                        jne P2C2                ; If not, jump to P2C2
                        cmp byte [BOARD+8],1       ; Check if the third row is filled with 1
                        jne P2C2                ; If not, jump to P2C2
                        cmp byte [BOARD+12],1      ; Check if the fourth row is filled with 1
                        je P2Win                ; If yes, jump to P2Win
                P2C2:
                        cmp byte [BOARD+1],1       ; Check if the first row is filled with 1
                        jne P2C3                ; If not, jump to P2C3
                        cmp byte [BOARD+5],1       ; Check if the second row is filled with 1
                        jne P2C3                ; If not, jump to P2C3
                        cmp byte [BOARD+9],1       ; Check if the third row is filled with 1
                        jne P2C3                ; If not, jump to P2C3
                        cmp byte [BOARD+13],1      ; Check if the fourth row is filled with 1
                        je P2Win                ; If yes, jump to P2Win
                P2C3:
                        cmp byte [BOARD+2],1       ; Check if the first row is filled with 1
                        jne P2C4                ; If not, jump to P2C4
                        cmp byte [BOARD+6],1       ; Check if the second row is filled with 1
                        jne P2C4                ; If not, jump to P2C4
                        cmp byte [BOARD+10],1      ; Check if the third row is filled with 1
                        jne P2C4                ; If not, jump to P2C4
                        cmp byte [BOARD+14],1      ; Check if the fourth row is filled with 1
                        je P2Win                ; If yes, jump to P2Win
                P2C4:
                        cmp byte [BOARD+3],1       ; Check if the first row is filled with 1
                        jne P2D1                ; If not, jump to P2D1
                        cmp byte [BOARD+6],1       ; Check if the second row is filled with 1
                        jne P2D1                ; If not, jump to P2D1
                        cmp byte [BOARD+9],1       ; Check if the third row is filled with 1
                        jne P2D1                ; If not, jump to P2D1
                        cmp byte [BOARD+12],1      ; Check if the fourth row is filled with 1
                        je P2Win                ; If yes, jump to P2Win
                P2D1:
                        cmp byte [BOARD+0],1       ; Check if the first row is filled with 1
                        jne P2D2                ; If not, jump to P2D2
                        cmp byte [BOARD+5],1       ; Check if the second row is filled with 1
                        jne P2D2                ; If not, jump to P2D2
                        cmp byte [BOARD+10],1      ; Check if the third row is filled with 1
                        jne P2D2                ; If not, jump to P2D2
                        cmp byte [BOARD+15],1      ; Check if the fourth row is filled with 1
                        je P2Win                ; If yes, jump to P2Win
                P2D2:
                        cmp byte [BOARD+3],1       ; Check if the first row is filled with 1
                        jne P2NotWin              ; If not, jump to P2Draw
                        cmp byte [BOARD+6],1       ; Check if the second row is filled with 1
                        jne P2NotWin              ; If not, jump to P2Draw
                        cmp byte [BOARD+9],1       ; Check if the third row is filled with 1
                        jne P2NotWin              ; If not, jump to P2Draw
                        cmp byte [BOARD+12],1      ; Check if the fourth row is filled with 1
                        je P2Win                ; If yes, jump to P2Win

        P2NotWin:
                popa
                ret
;   --------------------------------------------------------
InsertValuesInBoard:
        pusha           ;   Save the registers

        mov ax,0xb800           ;   Set the segment register to the video memory
        mov es,ax               ;   Set the segment register to the video memory
        mov ah,0x3F             ;   Set the attribute byte;3Ch is the attribute byte for the board
        

        ;   Print the first row
        mov cx,4
        mov di,160*4+20           ;   Set the index register to the start of the video memory
        mov si,0                ;   Set the value to be written to the video memory
                L1InsertValuesInBoard:  ;   Loop 1

                        mov bl,[BOARD+si]          ;   Get the value from the board
                        cmp bl,2                        ;   Check if the value is 2
                        je L1InsertValuesInBoardStart
                        cmp bl,1                ;   Check if the board is empty
                        je InsertValuesInBoard1 ;   If the board is empty, then insert the values in the board
                        mov al,79       ;   Set the character byte
                        jmp InsertValuesInBoard2 ;   Jump to the next step
                                        InsertValuesInBoard1:           mov al,88       ;   Set the character byte
                                        InsertValuesInBoard2:           mov  [es:di],ax      ;   Insert M in the board

                        L1InsertValuesInBoardStart:     
                                                add di,40
                                                inc si
                                                loop L1InsertValuesInBoard

        ;   Print the second row
        mov cx,4
        mov di,160*9+20           ;   Set the index register to the start of the video memory
        mov si,4                ;   Set the value to be written to the video memory
        L2InsertValuesInBoard:  ;   Loop 1
                
                mov bl,[BOARD+si]          ;   Get the value from the board
                cmp bl,2                ;   Check if the board is empty
                je L2InsertValuesInBoardStart
                cmp bl,1
                je L2InsertValuesInBoard1 ;   If the board is empty, then insert the values in the board
                mov al,79       ;   Set the character byte
                jmp L2InsertValuesInBoard2 ;   Jump to the next step
                        L2InsertValuesInBoard1:           mov al,88       ;   Set the character byte
                        L2InsertValuesInBoard2:           mov  [es:di],ax      ;   Insert M in the board
        L2InsertValuesInBoardStart:
                                       add di,40
                                        inc si
                                        loop L2InsertValuesInBoard


        ;   Print the third row
        mov cx,4
        mov di,160*14+20           ;   Set the index register to the start of the video memory
        mov si,8                ;   Set the value to be written to the video memory
        L3InsertValuesInBoard:  ;   Loop 1
                
                mov bl,[BOARD+si]          ;   Set the attribute byte
                cmp bl,2                ;   Check if the board is empty
                je L3InsertValuesInBoardStart
                cmp bl,1                ;   Check if the board is empty
                je L3InsertValuesInBoard1 ;   If the board is empty, then insert the values in the board
                mov al,79       ;   Set the character byte
                jmp L3InsertValuesInBoard2 ;   Jump to the next step
                                L3InsertValuesInBoard1:           mov al,88       ;   Set the character byte
                                L3InsertValuesInBoard2:           mov  [es:di],ax      ;   Insert M in the board
          L3InsertValuesInBoardStart:      
                add di,40
                inc si
                loop L3InsertValuesInBoard

        ;  Print the fourth row
        mov cx,4
        mov di,160*19+20           ;   Set the index register to the start of the video memory
        mov si,12                ;   Set the value to be written to the video memory
        L4InsertValuesInBoard:  ;   Loop 1
                
                mov bl,[BOARD+si]          ;   Set the attribute byte
                cmp bl,2                ;   Check if the board is empty
                je L4InsertValuesInBoardStart
                cmp bl,1                ;   Check if the board is empty
                je L4InsertValuesInBoard1 ;   If the board is empty, then insert the values in the board
                mov al,79       ;   Set the character byte
                jmp L4InsertValuesInBoard2 ;   Jump to the next step
                        L4InsertValuesInBoard1:           mov al,88       ;   Set the character byte
                        L4InsertValuesInBoard2:           mov  [es:di],ax      ;   Insert M in the board
                L4InsertValuesInBoardStart:
                                add di,40
                                inc si
                                loop L4InsertValuesInBoard
        

        popa            ;   Restore the registers
        ret             ;   Return
;  -------------------------------------------------------
OccupiedP1:
        cli
        call ClearThatUserSegment
        call PrintERROR
        call LongDelay
        call ClearThatUserSegment
        sti
        jmp P1EXIT
;  -------------------------------------------------------
InputFromUser1:
        push ax
        in al, 0x60 ; read a char from keyboard port 
        P1KBISR: 
                    P11Pressed:
                        cmp al, 0x02 ; is 1 Pressed
                        jne P11Released ; no, try next comparison 
                        cmp byte [BOARD+0],2
                        jne OccupiedP1
                        jmp P1EXIT ; leave interrupt routine
                    P11Released:
                        cmp al,0x82     ;  Check if 1 is released
                        jne P12Pressed
                        cmp byte [BOARD+0],2
                        jne P12Pressed
                        mov byte [BOARD+0],0
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],1
                        call DECCOUNT
                        jmp P1EXIT
                    P12Pressed:
                        cmp al, 0x03 ; is 2 Pressed
                        jne P12Released ; no, try next comparison 
                        cmp byte [BOARD+1],2
                        jne OccupiedP1
                        jmp P1EXIT ; leave interrupt routine
                    P12Released:
                        cmp al,0x83     ;  Check if 2 is released
                        jne P13Pressed
                        cmp byte [BOARD+1],2
                        jne P13Pressed
                        mov byte [BOARD+1],0
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],1
                        call DECCOUNT
                        jmp P1EXIT
                    P13Pressed:
                        cmp al, 0x04 ; is 3 Pressed
                        jne P13Released ; no, try next comparison
                        cmp byte [BOARD+2],2
                        jne OccupiedP1
                        jmp P1EXIT ; leave interrupt routine
                    P13Released:
                        cmp al,0x84     ;  Check if 3 is released
                        jne P14Pressed
                        cmp byte [BOARD+2],2
                        jne P14Pressed
                        mov byte [BOARD+2],0
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],1
                        call DECCOUNT
                        jmp P1EXIT
                    P14Pressed:
                        cmp al, 0x05 ; is 4 Pressed
                        jne P14Released ; no, try next comparison
                        cmp byte [BOARD+3],2
                        jne OccupiedP1
                        jmp P1EXIT ; leave interrupt routine
                    P14Released:
                        cmp al,0x85     ;  Check if 4 is released
                        jne P1QPressed
                        cmp byte [BOARD+3],2
                        jne P1QPressed
                        mov byte [BOARD+3],0
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],1
                        call DECCOUNT
                        jmp P1EXIT
                    P1QPressed:
                        cmp al, 0x10 ; is Q Pressed
                        jne P1QReleased ; no, try next comparison
                        cmp byte [BOARD+4],2
                        jne OccupiedP1
                        jmp P1EXIT ; leave interrupt routine
                    P1QReleased:
                        cmp al,0x90     ;  Check if Q is released
                        jne P1WPressed
                        cmp byte [BOARD+4],2
                        jne P1WPressed
                        mov byte [BOARD+4],0
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],1
                        call DECCOUNT
                        jmp P1EXIT    
                     P1WPressed:
                        cmp al, 0x11 ; is W Pressed
                        jne P1WReleased ; no, try next comparison
                        cmp byte [BOARD+5],2
                        jne OccupiedP1
                        jmp P1EXIT ; leave interrupt routine
                     P1WReleased:
                        cmp al,0x91     ;  Check if W is released
                        jne P1EPressed
                        cmp byte [BOARD+5],2
                        jne P1EPressed
                        mov byte [BOARD+5],0
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],1
                        call DECCOUNT
                        jmp P1EXIT
                      P1EPressed:
                        cmp al, 0x12 ; is E Pressed
                        jne P1EReleased ; no, try next comparison
                        cmp byte [BOARD+6],2
                        jne OccupiedP1
                        jmp P1EXIT ; leave interrupt routine
                      P1EReleased:
                        cmp al,0x92     ;  Check if E is released
                        jne P1RPressed
                        cmp byte [BOARD+6],2
                        jne P1RPressed
                        mov byte [BOARD+6],0
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],1
                        call DECCOUNT
                        jmp P1EXIT 
                P1RPressed:
                        cmp al, 0x13 ; is R Pressed
                        jne P1RReleased ; no, try next comparison
                        cmp byte [BOARD+7],2
                        jne OccupiedP1
                        jmp P1EXIT ; leave interrupt routine
                P1RReleased: 
                        cmp al,0x93     ;  Check if R is released
                        jne P1APressed
                        cmp byte [BOARD+7],2
                        jne P1APressed
                        mov byte [BOARD+7],0
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],1
                        call DECCOUNT
                        jmp P1EXIT  
                P1APressed:
                        cmp al, 0x1E ; is A Pressed
                        jne P1AReleased ; no, try next comparison
                        cmp byte [BOARD+8],2
                        jne OccupiedP1
                        jmp P1EXIT ; leave interrupt routine
                P1AReleased:
                        cmp al,0x9E     ;  Check if A is released
                        jne P1SPressed
                        cmp byte [BOARD+8],2
                        jne P1SPressed
                        mov byte [BOARD+8],0
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],1
                        call DECCOUNT
                        jmp P1EXIT
                P1SPressed:
                        cmp al, 0x1F ; is S Pressed
                        jne P1SReleased ; no, try next comparison
                        cmp byte [BOARD+9],2
                        jne OccupiedP1
                        jmp P1EXIT ; leave interrupt routine
                P1SReleased:
                        cmp al,0x9F     ;  Check if S is released
                        jne P1DPressed
                        cmp byte [BOARD+9],2
                        jne P1DPressed
                        mov byte [BOARD+9],0
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],1
                        call DECCOUNT
                        jmp P1EXIT
                P1DPressed:
                        cmp al, 0x20 ; is D Pressed
                        jne P1DReleased ; no, try next comparison
                        cmp byte [BOARD+10],2
                        jne OccupiedP1
                        jmp P1EXIT ; leave interrupt routine
                P1DReleased:
                        cmp al,0xA0     ;  Check if D is released
                        jne P1FPressed
                        cmp byte [BOARD+10],2
                        jne P1FPressed
                        mov byte [BOARD+10],0
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],1
                        call DECCOUNT
                        jmp P1EXIT
                P1FPressed:
                        cmp al, 0x21 ; is F Pressed
                        jne P1FReleased ; no, try next comparison
                        cmp byte [BOARD+11],2
                        jne OccupiedP1
                        jmp P1EXIT ; leave interrupt routine
                P1FReleased:
                        cmp al,0xA1     ;  Check if F is released
                        jne P1ZPressed
                        cmp byte [BOARD+11],2
                        jne P1ZPressed
                        mov byte [BOARD+11],0
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],1
                        call DECCOUNT
                        jmp P1EXIT
                P1ZPressed:
                        cmp al, 0x2C ; is Z Pressed
                        jne P1ZReleased ; no, try next comparison
                        cmp byte [BOARD+12],2
                        jne OccupiedP1
                        jmp P1EXIT ; leave interrupt routine
                P1ZReleased:
                        cmp al,0xAC     ;  Check if Z is released
                        jne P1XPressed
                        cmp byte [BOARD+12],2
                        jne P1XPressed
                        mov byte [BOARD+12],0
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],1
                        call DECCOUNT
                        jmp P1EXIT
                P1XPressed:
                        cmp al, 0x2D ; is X Pressed
                        jne P1XReleased ; no, try next comparison
                        cmp byte [BOARD+13],2
                        jne OccupiedP1
                        jmp P1EXIT ; leave interrupt routine
                P1XReleased:
                        cmp al,0xAD     ;  Check if X is released
                        jne P1CPressed
                        cmp byte [BOARD+13],2
                        jne P1CPressed
                        mov byte [BOARD+13],0
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],1
                        call DECCOUNT
                        jmp P1EXIT
                P1CPressed:
                        cmp al, 0x2E ; is C Pressed
                        jne P1CReleased ; no, try next comparison
                        cmp byte [BOARD+14],2
                        jne OccupiedP1
                        jmp P1EXIT ; leave interrupt routine
                P1CReleased:
                        cmp al,0xAE     ;  Check if C is released
                        jne P1VPressed
                        cmp byte [BOARD+14],2
                        jne P1VPressed
                        mov byte [BOARD+14],0
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],1
                        call DECCOUNT
                        jmp P1EXIT
                P1VPressed:
                        cmp al, 0x2F ; is V Pressed
                        jne P1VReleased ; no, try next comparison
                        cmp byte [BOARD+15],2
                        jne OccupiedP1
                        jmp P1EXIT ; leave interrupt routine
                P1VReleased:
                        cmp al,0xAF     ;  Check if V is released
                        jne P1nomatch
                        cmp byte [BOARD+15],2
                        jne P1nomatch
                        mov byte [BOARD+15],0
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],1
                        call DECCOUNT
                        jmp P1EXIT
        P1nomatch: 
            pop ax
            jmp far [cs:P1OldIser] ; call the original ISR 
        P1EXIT: 
            mov al, 0x20 
            out 0x20, al ; send EOI to PIC 
            pop ax
            iret ; r

        
;  -------------------------------------------------------
OccupiedP2:
        cli
        call ClearThatUserSegment
        call PrintERROR
        call LongDelay
        call ClearThatUserSegment
        sti
        jmp P2EXIT
;  -------------------------------------------------------
InputFromUser2:
        push ax
        in al, 0x60 ; read the scancode from the keyboard

        P2KBISR:
                P21Pressed:
                        cmp al, 0x02 ; is 1 Pressed
                        jne P21Released ; no, try next comparison
                        call ColorWhiteScreen
                        cmp byte [BOARD+0],2
                        jne OccupiedP2
                        jmp P2EXIT ; leave interrupt routine
                P21Released:
                        cmp al,0x82     ;  Check if 1 is released
                        jne P22Pressed
                        cmp byte [BOARD+0],2
                        jne P22Pressed
                        mov byte [BOARD+0],1
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],0
                        call DECCOUNT
                        jmp P2EXIT
                P22Pressed:
                        cmp al, 0x03 ; is 2 Pressed
                        jne P22Released ; no, try next comparison
                        cmp byte [BOARD+1],2
                        jne OccupiedP2
                        jmp P2EXIT ; leave interrupt routine
                P22Released:
                        cmp al,0x83     ;  Check if 2 is released
                        jne P23Pressed
                        cmp byte [BOARD+1],2
                        jne P23Pressed
                        mov byte [BOARD+1],1
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],0
                        call DECCOUNT
                        jmp P2EXIT
                P23Pressed:
                        cmp al, 0x04 ; is 3 Pressed
                        jne P23Released ; no, try next comparison
                        cmp byte [BOARD+2],2
                        jne OccupiedP2
                        jmp P2EXIT ; leave interrupt routine
                P23Released:
                        cmp al,0x84     ;  Check if 3 is released
                        jne P24Pressed
                        cmp byte [BOARD+2],2
                        jne P24Pressed
                        mov byte [BOARD+2],1
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],0
                        call DECCOUNT
                        jmp P2EXIT
                P24Pressed:
                        cmp al, 0x05 ; is 4 Pressed
                        jne P24Released ; no, try next comparison
                        cmp byte [BOARD+3],2
                        jne OccupiedP2
                        jmp P2EXIT ; leave interrupt routine
                P24Released:
                        cmp al,0x85     ;  Check if 4 is released
                        jne P2QPressed
                        cmp byte [BOARD+3],2
                        jne P2QPressed
                        mov byte [BOARD+3],1
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],0
                        call DECCOUNT
                        jmp P2EXIT
                P2QPressed:
                        cmp al, 0x10 ; is Q Pressed
                        jne P2QReleased ; no, try next comparison
                        cmp byte [BOARD+4],2
                        jne OccupiedP2
                        jmp P2EXIT ; leave interrupt routine
                P2QReleased:
                        cmp al,0x90     ;  Check if Q is released
                        jne P2WPressed
                        cmp byte [BOARD+4],2
                        jne P2WPressed
                        mov byte [BOARD+4],1
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],0
                        call DECCOUNT
                        jmp P2EXIT
                P2WPressed:
                        cmp al, 0x11 ; is W Pressed
                        jne P2WReleased ; no, try next comparison
                        cmp byte [BOARD+5],2
                        jne OccupiedP2
                        jmp P2EXIT ; leave interrupt routine
                P2WReleased:
                        cmp al,0x91     ;  Check if W is released
                        jne P2EPressed
                        cmp byte [BOARD+5],2
                        jne P2EPressed
                        mov byte [BOARD+5],1
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],0
                        call DECCOUNT
                        jmp P2EXIT
                P2EPressed:
                        cmp al, 0x12 ; is E Pressed
                        jne P2EReleased ; no, try next comparison
                        cmp byte [BOARD+6],2
                        jne OccupiedP2
                        jmp P2EXIT ; leave interrupt routine
                P2EReleased:
                        cmp al,0x92     ;  Check if E is released
                        jne P2RPressed
                        cmp byte [BOARD+6],2
                        jne P2RPressed
                        mov byte [BOARD+6],1
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],0
                        call DECCOUNT
                        jmp P2EXIT
                P2RPressed:
                        cmp al, 0x13 ; is R Pressed
                        jne P2RReleased ; no, try next comparison
                        cmp byte [BOARD+7],2
                        jne OccupiedP2
                        jmp P2EXIT ; leave interrupt routine
                P2RReleased:
                        cmp al,0x93     ;  Check if R is released
                        jne P2APressed
                        cmp byte [BOARD+7],2
                        jne P2APressed
                        mov byte [BOARD+7],1
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],0
                        call DECCOUNT
                        jmp P2EXIT
                P2APressed:
                        cmp al, 0x1E ; is A Pressed
                        jne P2AReleased ; no, try next comparison
                        cmp byte [BOARD+8],2
                        jne OccupiedP2
                        jmp P2EXIT ; leave interrupt routine
                P2AReleased:
                        cmp al,0x9E     ;  Check if A is released
                        jne P2SPressed
                        cmp byte [BOARD+8],2
                        jne P2SPressed
                        mov byte [BOARD+8],1
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],0
                        call DECCOUNT
                        jmp P2EXIT
                P2SPressed:
                        cmp al, 0x1F ; is S Pressed
                        jne P2SReleased ; no, try next comparison
                        cmp byte [BOARD+9],2
                        jne OccupiedP2
                        jmp P2EXIT ; leave interrupt routine
                P2SReleased:
                        cmp al,0x9F     ;  Check if S is released
                        jne P2DPressed
                        cmp byte [BOARD+9],2
                        jne P2DPressed
                        mov byte [BOARD+9],1
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],0
                        call DECCOUNT
                        jmp P2EXIT
                P2DPressed:
                        cmp al, 0x20 ; is D Pressed
                        jne P2DReleased ; no, try next comparison
                        cmp byte [BOARD+10],2
                        jne OccupiedP2
                        jmp P2EXIT ; leave interrupt routine
                P2DReleased:
                        cmp al,0xA0     ;  Check if D is released
                        jne P2FPressed
                        cmp byte [BOARD+10],2
                        jne P2FPressed
                        mov byte [BOARD+10],1
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],0
                        call DECCOUNT
                        jmp P2EXIT
                P2FPressed:
                        cmp al, 0x21 ; is F Pressed
                        jne P2FReleased ; no, try next comparison
                        cmp byte [BOARD+11],2
                        jne OccupiedP2
                        jmp P2EXIT ; leave interrupt routine
                P2FReleased:
                        cmp al,0xA1     ;  Check if F is released
                        jne P2ZPressed
                        cmp byte [BOARD+11],2
                        jne P2ZPressed
                        mov byte [BOARD+11],1
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],0
                        call DECCOUNT
                        jmp P2EXIT
                P2ZPressed:
                        cmp al, 0x2C ; is Z Pressed
                        jne P2ZReleased ; no, try next comparison
                        cmp byte [BOARD+12],2
                        jne OccupiedP2
                        jmp P2EXIT ; leave interrupt routine
                P2ZReleased:
                        cmp al,0xAC     ;  Check if Z is released
                        jne P2XPressed
                        cmp byte [BOARD+12],2
                        jne P2XPressed
                        mov byte [BOARD+12],1
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],0
                        call DECCOUNT
                        jmp P2EXIT
                P2XPressed:
                        cmp al, 0x2D ; is X Pressed
                        jne P2XReleased ; no, try next comparison
                        cmp byte [BOARD+13],2
                        jne OccupiedP2
                        jmp P2EXIT ; leave interrupt routine
                P2XReleased:
                        cmp al,0xAD     ;  Check if X is released
                        jne P2CPressed
                        cmp byte [BOARD+13],2
                        jne P2CPressed
                        mov byte [BOARD+13],1
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],0
                        call DECCOUNT
                        jmp P2EXIT
                P2CPressed:
                        cmp al, 0x2E ; is C Pressed
                        jne P2CReleased ; no, try next comparison
                        cmp byte [BOARD+14],2
                        jne OccupiedP2
                        jmp P2EXIT ; leave interrupt routine
                P2CReleased:
                        cmp al,0xAE     ;  Check if C is released
                        jne P2VPressed
                        cmp byte [BOARD+14],2
                        jne P2VPressed
                        mov byte [BOARD+14],1
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],0
                        call DECCOUNT
                        jmp P2EXIT
                P2VPressed:
                        cmp al, 0x2F ; is V Pressed
                        jne P2VReleased ; no, try next comparison
                        cmp byte [BOARD+15],2
                        jne OccupiedP2
                        jmp P2EXIT ; leave interrupt routine
                P2VReleased:
                        cmp al,0xAF     ;  Check if V is released
                        jne P2nomatch
                        cmp byte [BOARD+15],2
                        jne P2nomatch
                        mov byte [BOARD+15],1
                        cli
                        call InsertValuesInBoard
                        sti
                        mov byte[P1ORP2],0
                        call DECCOUNT
                        jmp P2EXIT
                P2nomatch:
                        pop ax
                        jmp far [cs:P2OldIser]  ;  If no match, return to old ISR
                P2EXIT:
                        mov al, 0x20 
                        out 0x20, al ; send EOI to PIC 
                        pop ax
                        iret ; r
;   --------------------------------------------------------
CheckDraw:              ; Check if the game is a draw
        push cx         ; Save the value of cx
        mov cx,[COUNTS] ; Move the value of COUNTS to cx
        cmp cx,0        ; Check if the value of COUNTS is 0
        je TheGameDraws ; If yes, jump to TheGameDraws
        pop cx          ; Restore the value of cx
        ret
;   --------------------------------------------------------
TheGameDraws:                           ; The game is a draw
        call ClearThatUserSegment       ; Clear the user segment
        call PrintDRAW                  ; Print DRAW
        call PrintGAME_ENDED            ; Print GAME ENDED
;   --------------------------------------------------------

DECCOUNT:
        mov cx,[COUNTS]
        dec cx
        mov [COUNTS],cx
        ret
MainGame:
        call Player1    ;1)
                call DECCOUNT
        call Player2    ;2)
                call DECCOUNT
        call Player1    ;3)
                call DECCOUNT
        call Player2    ;4)
                call DECCOUNT
        call Player1    ;5)
                call DECCOUNT
        call Player2    ;6)
                call DECCOUNT
        call Player1    ;7)
                call DECCOUNT
        call Player2    ;8)
                call DECCOUNT
        call Player1    ;9)
                call DECCOUNT
        call Player2    ;10)
                call DECCOUNT
        call Player1    ;11)
                call DECCOUNT
        call Player2    ;12)
                call DECCOUNT
        call Player1    ;13)
                call DECCOUNT
        call Player2    ;14)
                call DECCOUNT
        call Player1    ;15)
                call DECCOUNT



                        
        ret
;   --------------------------------------------------------

Player1:
        call PrintP1TURN        ;   Print P1 TURN
        ;call ClearThatUserSegment        
        xor ax, ax 
        mov es, ax              ; point es to IVT base 
        mov ax, [es:9*4] 
        mov [P1OldIser], ax     ; save offset of old routine 
        mov ax, [es:9*4+2] 
        mov [P1OldIser+2], ax   ; save segment of old routine 
        cli                     ; disable interrupts 
        mov word [es:9*4], InputFromUser1               ; store offset at n*4 
        mov [es:9*4+2], cs                              ; store segment at n*4+2 
        sti                                             ; enable interrupts 

                Player1l1: 
                                cmp byte [P1ORP2],0
                                je Player1l1
        ;call PrintWELCOME
        mov ax, [P1OldIser] ; read old offset in ax 
        mov bx, [P1OldIser+2] ; read old segment in bx 
        cli ; disable interrupts 
        mov [es:9*4], ax ; restore old offset from ax 
        mov [es:9*4+2], bx ; restore old segment from bx 
        sti ; enable interrupts 
        call InsertValuesInBoard
        call CheckWinP1       ;   Check if the game is won
        call CheckDraw        ;   Check if the game is a draw


        ret
;   --------------------------------------------------------
Player2:
        call PrintP2TURN        ;   Print P2 TURN
        ;call ClearThatUserSegment        
        xor ax, ax 
        mov es, ax ; point es to IVT base 
        mov ax, [es:9*4] 
        mov [P2OldIser], ax ; save offset of old routine 
        mov ax, [es:9*4+2] 
        mov [P2OldIser+2], ax ; save segment of old routine 
        cli ; disable interrupts 
        mov word [es:9*4], InputFromUser2 ; store offset at n*4 
        mov [es:9*4+2], cs ; store segment at n*4+2 
        sti ; enable interrupts 

                Player2l1: 
                                cmp byte [P1ORP2],1
                                je Player2l1
        mov ax, [P2OldIser] ; read old offset in ax 
        mov bx, [P2OldIser+2] ; read old segment in bx 
        cli ; disable interrupts 
        mov [es:9*4], ax ; restore old offset from ax 
        mov [es:9*4+2], bx ; restore old segment from bx 
        sti ; enable interrupts 
        call InsertValuesInBoard
        call CheckWinP2       ;   Check if the game is won
        call CheckDraw        ;   Check if the game is a draw
        ret
;___________________________________________________________
;   --------------------------------------------------------
;   FUNCTION: main
;   --------------------------------------------------------
main:
    call Intro           ; First Prints DOT on screen, wait for user & prints grey color on screen
    call DisplayBoard   ;   Display the board
    call InsertValuesInBoard       ;   Start the game
    temp:
    call Player1
    call Player2
    
    mov cx,[COUNTS]
    cmp cx,0
    jne temp
    call PrintDRAW
    call LongDelay

EndGame:                ; End Function (Terminates the Program)
	mov ax, [P1OldIser] ; read old offset in ax 
        mov bx, [P1OldIser+2] ; read old segment in bx 
        cli ; disable interrupts 
        mov [es:9*4], ax ; restore old offset from ax 
        mov [es:9*4+2], bx ; restore old segment from bx 
        sti ; enable interrupts
    call ClearScreen
     
    mov ax, 0x4c00      ; Exit to DOSBOX
    int 21h             ; Call DOS interrupt
;   --------------------------------------------------------
;   END OF CODE
;   --------------------------------------------------------
;___________________________________________________________


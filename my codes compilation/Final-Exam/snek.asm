[org 0x0100]
        jmp start

        msg: db 'Score: '
        startMsg: db 'Press Any Key to Continue: '
        randNum: db 0
        oldisr: dd 0
        snek: TIMES 300 dw 0
        len: dw 2

startMenu:
        push es
        push ax
        push cx
        push di
        push si

        mov ax, 0xb800
        mov es, ax
        mov di, 1966
        mov cx, 27
        
        mov si, 0
        mov ax, 0xb800

        nextCharStMen:
        mov al, [startMsg + si]
        mov [es:di], ax
        add di, 2
        inc si
        loop nextCharStMen

        mov ah, 0
	int 0x16

        pop si
        pop di
        pop cx
        pop ax
        pop es

        ret

clrscr:
        push cx
        push es
        push di

        mov cx, 0xb800
        mov es, cx
        mov di, 0
        mov cx, 2000

 c1:
        mov word[es:di], 0x0720
        add di, 2
        loop c1

        pop di
        pop es
        pop cx
        ret

                                        ;;              ;;              ;;              ;;      

randGen:
        push bp
        mov bp, sp
        push cx
        push dx
        push ax
        rdtsc                   ;getting a random number in ax dx
        xor dx,dx               ;making dx 0
        mov cx, [bp + 4]
        div cx                  ;dividing by 'Paramter' to get numbers from 0 - Parameter
        mov [randNum], dl      ;moving the random number in variable
        pop ax
        pop dx
        pop cx
        pop bp

        ret 2

                                        ;;              ;;              ;;              ;;      

growSnek:                       ;Pushes entire 'Snek' array one index down, and places new head at start of the array
        push bp
        mov bp, sp
        push ax
        push bx
        push si
        push di

        mov bx, snek
        mov ax, [len]
        mov si, 2
        mul si
        mov si, ax
        sub si, 2
        mov di, si
        sub di, 2

        grSn1:
        mov ax, [bx + di]
        mov [bx + si], ax
        sub di, 2
        sub si, 2
        cmp si, 0
        jne grSn1

        mov si, [bp + 4]                        ;Index of new head i.e. where snake is being grown
        mov word[snek], si

        pop di
        pop si
        pop bx
        pop ax
        pop bp

        ret 2

                                        ;;              ;;              ;;              ;;      

printSnek:                                      ;Prints blue box on every location stored in 'Snek' array
        push ax
        push bx
        push cx
        push dx
        push si
        push di
        push es

        mov ax, 0xb800
        mov es, ax

        mov bx, snek
        mov ax, [len]
        mov si, 2
        mul si
        xor di, di
        prtSn1:
        mov si, [bx + di]
        mov word[es:si], 0x1020
        add di, 2
        cmp di, ax
        jne prtSn1      

        pop es
        pop di
        pop si
        pop dx
        pop cx
        pop bx
        pop ax

        ret

                                        ;;              ;;              ;;              ;;      

changeSnek:                                     ;Moves entire 'Snek' array one index down and updates head based on snake's current direction and 
        push bp                                 ;       ('shr' entire array)
        mov bp, sp
        push ax
        push bx
        push si
        push di
        push es

        mov ax, 0xb800
        mov es, ax

        mov bx, snek
        mov ax, [len]
        mov si, 2
        mul si
        mov si, ax
        sub si, 2

        mov di, [bx + si]
        mov word[es:di], 0x2020                ;Print green block on old tail of the snake

        mov di, si
        sub di, 2

        ch1:
                mov ax, [bx + di]
                mov [bx + si], ax
                sub di, 2
                sub si, 2
                cmp si, 0
                jne ch1

                mov ax, [bp + 4]
                
                cmp ax, 1
                je addRight

                cmp ax, 2
                je addLeft

                cmp ax, 3
                je addDown

                cmp ax, 4
                je addUp

        endCh:
                pop es
                pop di
                pop si
                pop bx
                pop ax
                pop bp

                ret 2

        addRight:
                add word[snek], 2
                jmp endCh

        addLeft:
                sub word[snek], 2
                jmp endCh

        addDown:
                add word[snek], 160
                jmp endCh

        addUp:
        sub word[snek], 160
        jmp endCh

                                        ;;              ;;              ;;              ;;      

genApple:                                       ;Randomize and place apple on board
        push ax
        push bx
        push cx
        push dx
        push es
        push si
        push di

        dontEnd:
                mov ax, 19
                push ax
                call randGen
                xor bx, bx
                mov bl, [randNum]
                add bl, 3
                mov ax, 65
                push ax
                call randGen
                xor cx, cx
                mov cl, [randNum]
                add cl, 5

                mov ax, 80
                mul bx
                add ax, cx
                mov di, 2

                mul di

                mov si, ax
                mov ax, 0xb800
                mov es, ax

                mov ax, si
        
                div di
                cmp dx, 1
                je addOne

        drawApple:
                cmp word[es:si], 0x1020                         ;If apple spawns on snake
                je dontEnd                                      ;Repeat the randomization process
                mov word[es:si], 0x4020                         ;Else place the apple

                pop di
                pop si
                pop es
                pop dx
                pop cx
                pop bx
                pop ax

                ret

        addOne:
        add si, 1
        jmp drawApple
        
                                        ;;              ;;              ;;              ;;      

printScore:                     ;Print string "Score: " in middle of second row
        push es
        push ax
        push cx
        push di
        push si

        mov ax, 0xb800
        mov es, ax
        mov di, 230 
        mov cx, 7
        
        mov si, 0
        mov ah, 0x0D

        nextChar:
        mov al, [msg + si]
        mov [es:di], ax
        add di, 2
        inc si
        loop nextChar

        pop si
        pop di
        pop cx
        pop ax
        pop es

        ret

                                        ;;              ;;              ;;              ;;      
                                        
updateScore:                            ;Print current score in middle of sencond row (in front of string)
        push bp
        mov bp, sp
        push es
        push ax
        push bx
        push cx
        push dx
        push di

        mov ax, 0xb800
        mov es, ax
        
        mov ax, [bp + 4]
        mov bx, 10
        mov cx, 0
        nextDig:
                mov dx, 0
                div bx
                add dl, 0x30
                push dx
                inc cx
                cmp ax, 0
                jnz nextDig

                mov di, 244
        nextPos:
        pop dx
        mov dh, 0x0D
        mov [es:di], dx
        add di, 2
        loop nextPos
        
        pop di
        pop dx
        pop cx
        pop bx
        pop ax
        pop es
        pop bp

        ret 2
        
                                        ;;              ;;              ;;              ;;      
                                        
delay:                                  ;To show a delay effect whenever snake moves
        push cx
        push ax
        mov cx, 0xffff
        mov ax, 0
        d1:
                add ax, 1
                loop d1

                mov cx, 0xffff
                mov ax, 0
        d2:
                add ax, 1
                loop d2

                mov cx, 0xffff
                mov ax, 0
        d3:
        add ax, 1
        loop d3

        pop ax
        pop cx
        ret

                                        ;;              ;;              ;;              ;;      

printBoard:                             ;Called once to print the game board and snake in its initial position
        push ax
        push bx
        push cx
        push dx
        push es
        push si
        push di

        mov ax, 0xb800
        mov es, ax

        ;                   To Print Border Rectangle

        mov si, 2               ; currRow (y-pos)
        mov bx, 4              ; currCol (x-pos)
 
        p1:
                mov cx, 0
                mov ax, 80
                mul si
                add ax, bx
                shl ax, 1
                mov di, ax
        p2:
                mov word[es:di], 0x6020
                add di, 2
                inc cx
                cmp cx, 72
                jne p2

                inc si
                cmp si, 23
                jne p1

                ;                   To FIll Rectangle w/ Green

                mov si, 3               ; currRow (y-pos)
                mov bx, 5              ; currCol (x-pos)
        
        p3:
                mov cx, 0
                mov ax, 80
                mul si
                add ax, bx
                shl ax, 1
                mov di, ax
        p4:
        mov word[es:di], 0x2020
        add di, 2
        inc cx
        cmp cx, 70
        jne p4

        inc si
        cmp si, 22
        jne p3

        ;               To Print Snake
        ;          Starting Point is (12, 17)

        mov si, 12               ; currRow (y-pos)
        mov bx, 17              ; currCol (x-pos)

        mov ax, 80
        mul si
        add ax, bx
        shl ax, 1
        mov di, ax
        mov word[es:di], 0x1020
        sub di, 2
        mov word[es:di], 0x1020

        pop di
        pop si
        pop es
        pop dx
        pop cx
        pop bx
        pop ax

        ret

                                        ;;              ;;              ;;              ;;      

controlSnek:                  ;Actual control of the entire game
        push ax
        push bx
        push cx
        push dx
        push es
        push si
        push di

        mov ax, 0xb800
        mov es, ax

        xor dx, dx
        mov si, 12             
        mov bx, 17
        mov ax, 80
        mul si
        add ax, bx
        shl ax, 1
        mov di, ax
        mov [snek], ax                  ; di holds head of snale
        mov si, di
        sub si, 2                   ; si holds tail of snake
        mov [snek + 2], si

        call printScore
        call genApple

        mov cx, 0                   ; Holds Score (Count of Apples eaten)
        mov bx, 1                   ; BX = 1 -> Right, 2 ->Left, 3 -> Down, 4 -> Up

        inputAgain:
                push cx
                call updateScore
                call delay
                mov di, [snek]

                cmp bx, 1
                je checkRight

                cmp bx, 2
                je checkLeft

                cmp bx, 3
                je checkDown

                cmp bx, 4
                je checkUp

                jmp inputAgain

                checkRight:
                        add di, 2
                        jmp check

                checkLeft:
                        sub di, 2
                        jmp check
                        
                checkDown:
                        add di, 160
                        jmp check
                        
                checkUp:
                        sub di, 160
                        jmp check
                        
                check:
                        cmp word[es:di], 0x4020
                        je newScore

                        cmp word[es:di], 0x1020
                        je death

                        cmp word[es:di], 0x6020
                        je death

                        push bx 
                        call changeSnek                 ;TODO:  clear Old Snake by pritning Green and then print new snake                          
                        call printSnek

                        jmp inputAgain

                newScore:
                        inc cx                      ; Keeping track of score
                        add word[len], 1
                        push di
                        call growSnek
                        call genApple
                        ;        push bx
                        ;        call changeSnek               
                        ;        call printSnek
                        jmp inputAgain

                death:
                call clrscr
                call printScore
                push cx
                call updateScore

        end:
        pop di
        pop si
        pop es
        pop dx
        pop cx
        pop bx
        pop ax

        ret

                                        ;;              ;;              ;;              ;;      

kbisr:
        push bx
        mov bl, 1
        in al, 0x60
        pop bx

        cmp al, 0x48
        je up
        cmp al, 0x4B
        je left
        cmp al, 0x4D
        je right
        cmp al, 0x50
        je down

        jmp far [cs:oldisr]

        up:
                cmp bx, 3
                jne changeUp
                jmp far [cs:oldisr]

        changeUp:
                mov bx, 4
                jmp far [cs:oldisr]

        down:
                cmp bx, 4
                jne changeDown
                jmp far [cs:oldisr]

        changeDown:
                mov bx, 3
                jmp far [cs:oldisr]

        right:
                cmp bx, 2
                jne changeRight
                jmp far [cs:oldisr]

        changeRight:
                mov bx, 1
                jmp far [cs:oldisr]

        left:
                cmp bx, 1
                jne changeLeft
                jmp far [cs:oldisr]

        changeLeft:
        mov bx, 2
        jmp far [cs:oldisr]

                                        ;;              ;;              ;;              ;;      

start:
        call clrscr
        call startMenu

        xor ax, ax                      ;Hooking Interrupt
	mov es, ax
	mov ax, [es:9 * 4]
        mov [oldisr], ax
	mov ax, [es:9 * 4 + 2]
	mov [oldisr + 2], ax
	
        cli
	mov word[es:9 * 4], kbisr
	mov [es:9 * 4 + 2], cs
	sti

        call clrscr
        call printBoard             
        call controlSnek

        xor ax, ax                      ;Unhooking Interrupt
	mov es, ax
        mov ax, [oldisr]
	mov bx, [oldisr + 2]

	cli
	mov [es:9 * 4], ax
	mov [es:9 * 4 + 2], bx
	sti

        mov ax, 0x4c00
        int 0x21

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;___________________________________________________________
;   --------------------------------------------------------
;   GAME FUNCTIONS
;   --------------------------------------------------------

Game:
 

        GameLoop:
                        call Player1        ;   Player 1 turn
                        call CheckWinP1       ;   Check if the game is won
                        mov cx,[COUNTS]         ; mov cx, COUNTS
                        dec cx                   ; dec cx
                        mov [COUNTS],cx         ; mov COUNTS, cx

                        
                        call Player2        ;   Player 2 turn
                        call CheckWinP2       ;   Check if the game is won
                        mov cx,[COUNTS]
                        dec cx
                        mov [COUNTS],cx
                        call CheckDraw      ;   Check if the game is a draw

                        mov cx,[COUNTS]
                        cmp cx,0
                        jne GameLoop       ;   Loop the GameLoop label
        ret
;   --------------------------------------------------------
Player1:
        pusha
        


        popa
        ret
Player2:
        ret
CheckWinP1:
        pusha

        mov ax,BOARD    ; Points ax to the start of the board

                P1R1:
                        cmp byte [ax+0],1         ; Check if the first row is filled with 1
                        jne P1R2                ; If not, jump to P1R2
                        cmp byte [ax+1],1       ; Check if the second row is filled with 1
                        jne P1R2                ; If not, jump to P1R2
                        cmp byte [ax+2],1       ; Check if the third row is filled with 1
                        jne P1R2                ; If not, jump to P1R2
                        cmp byte [ax+3],1       ; Check if the fourth row is filled with 1
                        je P1Win                ; If yes, jump to P1Win
                P1R2:
                        cmp byte [ax+4],1       ; Check if the first row is filled with 1
                        jne P1R3                ; If not, jump to P1R3
                        cmp byte [ax+5],1       ; Check if the second row is filled with 1
                        jne P1R3                ; If not, jump to P1R3
                        cmp byte [ax+6],1       ; Check if the third row is filled with 1
                        jne P1R3                ; If not, jump to P1R3
                        cmp byte [ax+7],1       ; Check if the fourth row is filled with 1
                        je P1Win                ; If yes, jump to P1Win
                P1R3:
                        cmp byte [ax+8],1       ; Check if the first row is filled with 1
                        jne P1R4                ; If not, jump to P1R4
                        cmp byte [ax+9],1       ; Check if the second row is filled with 1
                        jne P1R4                ; If not, jump to P1R4
                        cmp byte [ax+10],1      ; Check if the third row is filled with 1
                        jne P1R4                ; If not, jump to P1R4
                        cmp byte [ax+11],1      ; Check if the fourth row is filled with 1
                        je P1Win                ; If yes, jump to P1Win
                P1R4:   
                        cmp byte [ax+12],1      ; Check if the first row is filled with 1
                        jne P1C1                ; If not, jump to P1C1
                        cmp byte [ax+13],1      ; Check if the second row is filled with 1
                        jne P1C1                ; If not, jump to P1C1
                        cmp byte [ax+14],1      ; Check if the third row is filled with 1
                        jne P1C1                ; If not, jump to P1C1
                        cmp byte [ax+15],1      ; Check if the fourth row is filled with 1
                        je P1Win                ; If yes, jump to P1Win
                P1C1:
                        cmp byte [ax+0],1       ; Check if the first row is filled with 1
                        jne P1C2                ; If not, jump to P1C2
                        cmp byte [ax+4],1       ; Check if the second row is filled with 1
                        jne P1C2                ; If not, jump to P1C2
                        cmp byte [ax+8],1       ; Check if the third row is filled with 1
                        jne P1C2                ; If not, jump to P1C2
                        cmp byte [ax+12],1      ; Check if the fourth row is filled with 1
                        je P1Win                ; If yes, jump to P1Win
                P1C2:
                        cmp byte [ax+1],1       ; Check if the first row is filled with 1
                        jne P1C3                ; If not, jump to P1C3
                        cmp byte [ax+5],1       ; Check if the second row is filled with 1
                        jne P1C3                ; If not, jump to P1C3
                        cmp byte [ax+9],1       ; Check if the third row is filled with 1
                        jne P1C3                ; If not, jump to P1C3
                        cmp byte [ax+13],1      ; Check if the fourth row is filled with 1
                        je P1Win                ; If yes, jump to P1Win
                P1C3:
                        cmp byte [ax+2],1       ; Check if the first row is filled with 1
                        jne P1C4                ; If not, jump to P1C4
                        cmp byte [ax+6],1       ; Check if the second row is filled with 1
                        jne P1C4                ; If not, jump to P1C4
                        cmp byte [ax+10],1      ; Check if the third row is filled with 1
                        jne P1C4                ; If not, jump to P1C4
                        cmp byte [ax+14],1      ; Check if the fourth row is filled with 1
                        je P1Win                ; If yes, jump to P1Win
                P1C4:
                        cmp byte [ax+3],1       ; Check if the first row is filled with 1
                        jne P1D1                ; If not, jump to P1D1
                        cmp byte [ax+6],1       ; Check if the second row is filled with 1
                        jne P1D1                ; If not, jump to P1D1
                        cmp byte [ax+9],1       ; Check if the third row is filled with 1
                        jne P1D1                ; If not, jump to P1D1
                        cmp byte [ax+12],1      ; Check if the fourth row is filled with 1
                        je P1Win                ; If yes, jump to P1Win
                P1D1:
                        cmp byte [ax+0],1       ; Check if the first row is filled with 1
                        jne P1D2                ; If not, jump to P1D2
                        cmp byte [ax+5],1       ; Check if the second row is filled with 1
                        jne P1D2                ; If not, jump to P1D2
                        cmp byte [ax+10],1      ; Check if the third row is filled with 1
                        jne P1D2                ; If not, jump to P1D2
                        cmp byte [ax+15],1      ; Check if the fourth row is filled with 1
                        je P1Win                ; If yes, jump to P1Win 
                P1D2:
                        cmp byte [ax+3],1       ; Check if the first row is filled with 1
                        jne P1NotWin                ; If not, jump to P1D3 
                        cmp byte [ax+6],1       ; Check if the second row is filled with 1
                        jne P1NotWin                ; If not, jump to P1D3
                        cmp byte [ax+9],1       ; Check if the third row is filled with 1
                        jne P1NotWin                ; If not, jump to P1D3
                        cmp byte [ax+12],1      ; Check if the fourth row is filled with 1

        


        P1Win:
                call PrintP1WIN
                call PrintGAME_ENDED
        P1NotWin:
        popa
        ret
;   --------------------------------------------------------
CheckWinP2:
        pusha

        mov ax,BOARD    ; Points ax to the start of the board

                P2R1:
                        cmp byte [ax+0],2       ; Check if the first row is filled with 2
                        jne P2R2                ; If not, jump to P2R2
                        cmp byte [ax+1],2       ; Check if the second row is filled with 2
                        jne P2R2                ; If not, jump to P2R2
                        cmp byte [ax+2],2       ; Check if the third row is filled with 2
                        jne P2R2                ; If not, jump to P2R2
                        cmp byte [ax+3],2       ; Check if the fourth row is filled with 2
                        je P2Win                ; If yes, jump to P2Win
                P2R2:
                        cmp byte [ax+4],2       ; Check if the first row is filled with 2
                        jne P2R3                ; If not, jump to P2R3
                        cmp byte [ax+5],2       ; Check if the second row is filled with 2
                        jne P2R3                ; If not, jump to P2R3
                        cmp byte [ax+6],2       ; Check if the third row is filled with 2
                        jne P2R3                ; If not, jump to P2R3
                        cmp byte [ax+7],2       ; Check if the fourth row is filled with 2
                        je P2Win                ; If yes, jump to P2Win
                P2R3:
                        cmp byte [ax+8],2       ; Check if the first row is filled with 2
                        jne P2R4                ; If not, jump to P2R4
                        cmp byte [ax+9],2       ; Check if the second row is filled with 2
                        jne P2R4                ; If not, jump to P2R4
                        cmp byte [ax+10],2      ; Check if the third row is filled with 2
                        jne P2R4                ; If not, jump to P2R4
                        cmp byte [ax+11],2      ; Check if the fourth row is filled with 2
                        je P2Win                ; If yes, jump to P2Win
                P2R4:
                        cmp byte [ax+12],2      ; Check if the first row is filled with 2
                        jne P2R5                ; If not, jump to P2R5
                        cmp byte [ax+13],2      ; Check if the second row is filled with 2
                        jne P2R5                ; If not, jump to P2R5
                        cmp byte [ax+14],2      ; Check if the third row is filled with 2
                        jne P2R5                ; If not, jump to P2R5
                        cmp byte [ax+15],2      ; Check if the fourth row is filled with 2
                        je P2Win                ; If yes, jump to P2Win
                P2C1:
                        cmp byte [ax+0],2       ; Check if the first row is filled with 2
                        jne P2C2                ; If not, jump to P2C2
                        cmp byte [ax+4],2       ; Check if the second row is filled with 2
                        jne P2C2                ; If not, jump to P2C2
                        cmp byte [ax+8],2       ; Check if the third row is filled with 2
                        jne P2C2                ; If not, jump to P2C2
                        cmp byte [ax+12],2      ; Check if the fourth row is filled with 2
                        je P2Win                ; If yes, jump to P2Win
                P2C2:
                        cmp byte [ax+1],2       ; Check if the first row is filled with 2
                        jne P2C3                ; If not, jump to P2C3
                        cmp byte [ax+5],2       ; Check if the second row is filled with 2
                        jne P2C3                ; If not, jump to P2C3
                        cmp byte [ax+9],2       ; Check if the third row is filled with 2
                        jne P2C3                ; If not, jump to P2C3
                        cmp byte [ax+13],2      ; Check if the fourth row is filled with 2
                        je P2Win                ; If yes, jump to P2Win
                P2C3:
                        cmp byte [ax+2],2       ; Check if the first row is filled with 2
                        jne P2C4                ; If not, jump to P2C4
                        cmp byte [ax+6],2       ; Check if the second row is filled with 2
                        jne P2C4                ; If not, jump to P2C4
                        cmp byte [ax+10],2      ; Check if the third row is filled with 2
                        jne P2C4                ; If not, jump to P2C4
                        cmp byte [ax+14],2      ; Check if the fourth row is filled with 2
                        je P2Win                ; If yes, jump to P2Win
                P2C4:
                        cmp byte [ax+3],2       ; Check if the first row is filled with 2
                        jne P2D1                ; If not, jump to P2D1
                        cmp byte [ax+6],2       ; Check if the second row is filled with 2
                        jne P2D1                ; If not, jump to P2D1
                        cmp byte [ax+9],2       ; Check if the third row is filled with 2
                        jne P2D1                ; If not, jump to P2D1
                        cmp byte [ax+12],2      ; Check if the fourth row is filled with 2
                        je P2Win                ; If yes, jump to P2Win
                P2D1:
                        cmp byte [ax+0],2       ; Check if the first row is filled with 2
                        jne P2D2                ; If not, jump to P2D2
                        cmp byte [ax+5],2       ; Check if the second row is filled with 2
                        jne P2D2                ; If not, jump to P2D2
                        cmp byte [ax+10],2      ; Check if the third row is filled with 2
                        jne P2D2                ; If not, jump to P2D2
                        cmp byte [ax+15],2      ; Check if the fourth row is filled with 2
                        je P2Win                ; If yes, jump to P2Win
                P2D2:
                        cmp byte [ax+3],2       ; Check if the first row is filled with 2
                        jne P2NotWin              ; If not, jump to P2Draw
                        cmp byte [ax+6],2       ; Check if the second row is filled with 2
                        jne P2NotWin              ; If not, jump to P2Draw
                        cmp byte [ax+9],2       ; Check if the third row is filled with 2
                        jne P2NotWin              ; If not, jump to P2Draw
                        cmp byte [ax+12],2      ; Check if the fourth row is filled with 2
                        je P2Win                ; If yes, jump to P2Win
                ret
        P1Win:

        
        ret


        popa
        ret
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
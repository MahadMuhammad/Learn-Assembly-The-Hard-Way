[org 0x0100]

jmp start

gameboard: db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

gamearea: dw 704,732,756,784,1376,1400,1424,1448,2040,2064,2088,3012,3604,3628,3652,3676

winp1: db 'player 1 wins',0

winp2: db 'player 2 wins',0

draw:  db 'Tie',0

occupied: db 'This box is occupied',0

temp: db 0,0



delay:
push cx
mov cx,0xffff
loopdelay:
loop loopdelay
pop cx
ret

p1:
pusha
readcharp1:                         ;reading data for player1
mov ah,0
int 0x16
mov ah, 0

sub ax,49

mov bp, gameboard
add bp, ax

cmp byte [bp],0
jne near occupiedp1

mov byte [bp],1
mov bp, gamearea
shl ax,1
add bp,ax
mov di,[bp]

mov ax, 0xb800
mov es, ax
mov word [es:di],0x344F

checkp1:                                       ;checking conditions fpr player 1 win
mov bp,gameboard
c1:
cmp byte [bp],1
jne c2
cmp byte [bp+4],1
jne c2
cmp byte [bp+8],1
                        jne c2
                        cmp byte [bp+12],1
je near returnp1true
c2:
cmp byte [bp+1],1
jne c3
cmp byte [bp+5],1
jne c3
cmp byte [bp+9],1
                        jne c3
                        cmp byte [bp+13],1
                        je near returnp1true
c3:
cmp byte [bp+2],1
jne c4
cmp byte [bp+6],1
jne c4
cmp byte [bp+10],1
jne c4
cmp byte [bp+14],1
je near returnp1true
                c4:
cmp byte [bp+3],1
jne r1
cmp byte [bp+7],1
jne r1
cmp byte [bp+11],1
jne r1
cmp byte [bp+15],1
je near returnp1true
r1:
cmp byte [bp],1
jne r2
cmp byte [bp+1],1
jne r2
cmp byte [bp+2],1
jne r2
cmp byte [bp+3],1
je near returnp1true
r2:
cmp byte [bp+4],1
jne r3
cmp byte [bp+5],1
jne r3
cmp byte [bp+6],1
jne r3
cmp byte [bp+7],1
je near returnp1true
r3:
cmp byte [bp+8],1
jne r4
cmp byte [bp+9],1
jne r4
cmp byte [bp+10],1
jne r4
cmp byte [bp+11],1
je near returnp1true

r4:
cmp byte [bp+12],1
jne rd
cmp byte [bp+13],1
jne rd
cmp byte [bp+14],1
jne rd
cmp byte [bp+15],1
je near returnp1true
rd:                ;right diagnol
cmp byte [bp],1
jne ld
cmp byte [bp+6],1
jne ld
cmp byte [bp+10],1
jne ld
cmp byte [bp+15],1
je returnp1true
ld:                     ;left diagnol
cmp byte [bp+3],1
jne returnp1false
cmp byte [bp+6],1
jne returnp1false
cmp byte [bp+9],1
je returnp1true
                        cmp byte [bp+12],1
je returnp1true
jmp returnp1false


occupiedp1:                             ;filled boxes for player 1
push ax
mov ax, occupied
push ax
call printstr
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call clrtext
pop ax
jmp readcharp1

returnp1false:
popa
ret

returnp1true:
mov ax, winp1
push ax
call printstr
jmp terminate

clrtext:
pusha
mov ax, 0xb800
mov es, ax
mov di, 3260
mov cx,25
mov ah,00010000b
mov al,20h
cld
rep stosw
popa
ret

p2:
pusha
readcharp2:                                           ;reading p 2 character
mov ah,0
int 0x16
mov ah, 0

sub ax,49

mov bp, gameboard
add bp, ax

cmp byte [bp],0
jne near occupiedp2

mov byte [bp],2
mov bp, gamearea
shl ax,1
add bp,ax
mov di,[bp]

mov ax, 0xb800
mov es, ax
mov word [es:di],0x3458

checkp2:                                                   ;checking condition for player 2 win
mov bp,gameboard
c1p2:
cmp byte [bp],2
jne c2p2
cmp byte [bp+4],2
jne c2p2
cmp byte [bp+8],2
jne c2p2
cmp byte [bp+12],2
je near returnp2true
c2p2:
cmp byte [bp+1],2
jne c3p2
cmp byte [bp+5],2
jne c3p2
cmp byte [bp+9],2
jne c3p2
cmp byte [bp+13],2
je near returnp2true
c3p2:
cmp byte [bp+2],2
jne c4p2
cmp byte [bp+6],2
jne c4p2
cmp byte [bp+10],2
jne c4p2
cmp byte [bp+14],2
je near returnp2true
c4p2:
cmp byte [bp+3],2
jne r1p2
cmp byte [bp+7],2
jne r1p2
cmp byte [bp+9],2
jne r1p2
cmp byte [bp+15],2
je near returnp2true
r1p2:
cmp byte [bp],2
jne r2p2
cmp byte [bp+1],2
jne r2p2
cmp byte [bp+2],2
jne r4p2
cmp byte [bp+3],2
je near returnp2true
r2p2:
cmp byte [bp+4],2
jne r3p2
cmp byte [bp+5],2
jne r3p2
cmp byte [bp+6],2
jne r4p2
cmp byte [bp+7],2
je near returnp2true
r3p2:
cmp byte [bp+8],2
jne r4p2
cmp byte [bp+9],2
jne r4p2
cmp byte [bp+10],2
jne r4p2
cmp byte [bp+11],2
je near returnp2true
r4p2:
cmp byte [bp+12],2
jne rd2
cmp byte [bp+13],2
jne rd2
cmp byte [bp+14],2
jne r4p2
cmp byte [bp+15],2
je near returnp2true






rd2:                ;rightdiagnol
cmp byte [bp],2
jne ld2
cmp byte [bp+6],2
jne ld2
cmp byte [bp+10],2
jne ld2
cmp byte [bp+15],2
je returnp2true








ld2:                   ;leftdiagnol
cmp byte [bp+3],2
jne returnp2false
cmp byte [bp+6],2
jne returnp2false
cmp byte [bp+9],2
je returnp2true
cmp byte [bp+12],2
je returnp2true
jmp returnp2false








occupiedp2:
push ax
mov ax, occupied
push ax
call printstr
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call delay
call clrtext
pop ax
jmp readcharp2

returnp2false:
popa
ret

returnp2true:
mov ax, winp2
push ax
call printstr
jmp terminate


printstr:
push bp
mov bp, sp
pusha

push ds
pop es
mov di,[bp+8]
mov cx, 0xffff
xor al,al
repne scasb
mov ax, 0xffff
sub ax, cx
dec ax
jz exit

mov cx, ax
mov ax, 0xb800
mov es, ax
mov di, 3260
mov si, [bp+8]
mov ah, 01110000b
cld
nextchar:
lodsb
stosw
loop nextchar
exit:
popa
pop bp
ret 3


game:
mov ax, 0xb800
mov es, ax
mov di, 0
mov cx,2000
mov ah,00010000b
mov al,20h
cld
rep stosw

ScreenBorder:
mov di, 164
mov ah,00100000b
mov al,20h
mov cx, 76
continue1:
mov [es:di],ax
add di,4
dec cx
jnz continue1

mov di, 314
mov cx, 23
continue2:
mov [es:di],ax
add di,160
dec cx
jnz continue2

mov di, 3684
mov cx, 76
continue3:
mov [es:di],ax
add di,4
dec cx
jnz continue3

mov di, 164
mov cx, 23
continue4:
mov [es:di],ax
add di,160
dec cx
jnz continue4

GameInner:
mov di, 362
mov ah,00110000b
mov al,20h
mov cx,16
print16times:
add di, 160
mov bx,38
continue:
mov [es:di],ax
add di,4
dec bx
jnz continue
sub di, 76
dec cx
jnz print16times

GameBorder:
mov di, 522
mov ah,01010000b
mov al,20h
mov cx, 38
continue1_:
mov [es:di],ax
add di,3
dec cx
jnz continue1_

mov di, 598
mov cx, 16
continue2_:
mov [es:di],ax
add di,160
dec cx
jnz continue2_

mov di, 2442
mov cx, 39
continue3_:
mov [es:di],ax
add di,3
dec cx
jnz continue3_

mov di, 522
mov cx, 16
continue4_:
mov [es:di],ax
add di,160
dec cx
jnz continue4_

Numbering: 
mov di, 704
mov word [es:di],0x7031
mov di, 732
mov word [es:di],0x7032
mov di, 756
mov word [es:di],0x7033
mov di, 784
mov word [es:di],0x7034
mov di, 1376
mov word [es:di],0x7035
mov di, 1400
mov word [es:di],0x7036
mov di, 1424
mov word [es:di],0x7037
mov di, 1448
mov word [es:di],0x7038
mov di, 2040
                mov word [es:di],0x7039
mov di, 2064
mov word [es:di],0x7040
mov di, 2088
mov word [es:di],0x7041
mov di, 3012
mov word [es:di],0x7042
mov di, 3604
mov word [es:di],0x7043
mov di, 3628
mov word [es:di],0x7044
mov di, 3652
mov word [es:di],0x7045
mov di, 3676
mov word [es:di],0x7046


InnerLines:
mov di, 546
mov cx, 12
continuei1:
mov [es:di],ax
add di,160
dec cx
jnz continuei1

mov di, 574
mov cx, 12
continuei2:
mov [es:di],ax
add di,160
dec cx
jnz continuei2

mov di, 1162
mov cx, 38
continuei3:
mov [es:di],ax
add di,2
dec cx
jnz continuei3

mov di, 1802
mov cx, 38
continuei4:
mov [es:di],ax
add di,2
dec cx
jnz continuei4
ret


start:
call game
mov cx,16
playGame:
call p1
dec cx
jcxz finish
call p2
dec cx
jcxz finish
jmp playGame
finish:
mov ax, draw
push ax
call printstr

terminate:
mov ax, 4c00h
int 21h
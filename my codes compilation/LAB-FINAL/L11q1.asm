CODE:
; circle in graphics mode
[org 0x0100]
jmp start
; coordinates of a circle of radius 24
x24: dw 48,47,44,40,36,30,24,17,12,7,3,0,0,0,3,7,11,17,23,30,36,40,44,47,48
y24: dw 24,30,36,40,44,47,48,47,44,40,36,30,24,17,11,7,3,0,0,0,3,7,11,17,23
; coordinates of a circle of radius 45
x45: dw
90,89,88,86,83,79,75,70,64,58,52,46,40,34,28,22,17,12,8,5,2,0,0,0,0,2,5,8,12,17,22,28,34,40,4
6,52,58,64,70,75,79,83,86,88,89,90
y45: dw
45,51,57,63,68,73,78,82,85,87,89,89,89,88,86,83,80,76,71,66,60,54,48,41,35,29,23,18,13,9,6,3
,1,0,0,0,2,4,7,11,16,21,26,32,38,44
; coordinates of a circle of radius 72
x72: dw
144,143,142,141,139,137,134,130,127,122,118,113,108,102,96,90,84,78,72,65,59,53,47,41,36,
30,25,21,16,13,9,6,4,2,1,0,0,0,1,2,4,6,9,13,16,21,25,30,35,41,47,53,59,65,71,78,84,90,96,102,1
08,113,118,122,127,130,134,137,139,141,142,143,144
y72: dw
72,78,84,90,96,102,108,113,118,122,127,130,134,137,139,141,142,143,144,143,142,141,139,1
37,134,130,127,122,118,113,108,102,96,90,84,78,72,65,59,53,47,41,35,30,25,21,16,13,9,6,4,2,
1,0,0,0,1,2,4,6,9,13,16,21,25,30,35,41,47,53,59,65,71
; coordinates of a circle of radius 120
x120: dw
240,239,239,238,237,235,234,232,229,226,223,220,217,213,209,204,200,195,190,185,180,174
,168,163,157,151,144,138,132,126,120,113,107,101,95,88,82,76,71,65,60,54,49,44,39,35,30,2
6,22,19,16,13,10,7,5,4,2,1,0,0,0,0,0,1,2,4,5,7,10,13,16,19,22,26,30,35,39,44,49,54,59,65,71,76,
82,88,95,101,107,113,119,126,132,138,144,151,157,163,168,174,180,185,190,195,200,204,20
9,213,217,220,223,226,229,232,234,235,237,238,239,239,240
y120: dw
120,126,132,138,144,151,157,163,168,174,180,185,190,195,200,204,209,213,217,220,223,226
,229,232,234,235,237,238,239,239,240,239,239,238,237,235,234,232,229,226,223,220,217,21
3,209,204,200,195,190,185,180,174,168,163,157,151,144,138,132,126,120,113,107,101,95,88,
82,76,71,65,59,54,49,44,39,35,30,26,22,19,16,13,10,7,5,4,2,1,0,0,0,0,0,1,2,4,5,7,10,13,16,19,2
2,26,30,35,39,44,49,54,59,65,71,76,82,88,95,101,107,113,119
; setting up the parameters
counter : db 0;
radius : dw 45; choose radius (24, 45, 72, 120)
xoffset: dw 0 ; change to move circle along x axis
yoffset: dw 0 ; change to move circle along y axis
w: dw 100 ; width offset
x: dw 50 ; starting x coordinate of line
y: dw 100 ; starting y coordinate of line
c: dw 60 ; color
drawHome:
;first we will print the hat of the house
mov word [x], 320
mov word [y], 50
call drawWideDiagnol1
mov word [x], 320
mov word [y], 50
call drawWideDiagnol2
mov word [w], 200
mov word [x], 220
mov word [y], 100
call drawVerticalLine
; now we will draw the below rectangle of the house
mov word [w], 150
mov word [x], 240
mov word [y], 105
call drawVerticalLine
mov word [w], 60
mov word [x], 390
mov word [y], 105
call drawHorizontalLine
mov word [w], 60
mov word [x], 240
mov word [y], 105
call drawHorizontalLine
mov word [w], 150
mov word [x], 240
mov word [y], 165
call drawVerticalLine
;now we will draw the tree
mov word [xoffset], 100
mov word [yoffset], 45
mov word [radius], 24
mov si, x24; change x array as radius
mov di, y24; change y array as radius
call printCircle
mov word [xoffset], 140
mov word [yoffset], 45
mov word [radius], 24
mov si, x24; change x array as radius
mov di, y24; change y array as radius
call printCircle
mov word [xoffset], 120
mov word [yoffset], 25
mov word [radius], 24
mov si, x24; change x array as radius
mov di, y24; change y array as radius
call printCircle
; now we will draw the below of the tree
mov word [w], 20
mov word [x], 130
mov word [y],90
call drawVerticalLine
mov word [w], 100
mov word [x], 150
mov word [y], 90
call drawHorizontalLine
mov word [w], 60
mov word [w], 100
mov word [x], 130
mov word [y], 90
call drawHorizontalLine
mov word [w], 20
mov word [x], 130
mov word [y], 190
call drawVerticalLine
;this prints the bush
mov word [xoffset], 55
mov word [yoffset], 251
mov word [radius], 45
mov si, x45; change x array as radius
mov di, y45; change y array as radius
call printCircle
; this prints the sun
mov word [xoffset], 500
mov word [yoffset], 10
mov word [radius], 45
mov si, x45; change x array as radius
mov di, y45; change y array as radius
call printCircle
; right tree below
mov word [w], 20
mov word [x], 530
mov word [y], 190
call drawVerticalLine
mov word [w], 100
mov word [x], 550
mov word [y], 190
call drawHorizontalLine
mov word [w], 60
mov word [w], 100
mov word [x], 530
mov word [y], 190
call drawHorizontalLine
mov word [w], 20
mov word [x], 530
mov word [y], 290
call drawVerticalLine
mov word [w], 50
mov word [x], 540
mov word [y], 120
call drawDiagonalNormal1
mov word [x], 540
mov word [y], 120
call drawDiagonalNormal2
mov word [x], 540
mov word [y], 140
call drawDiagonalNormal1
mov word [x], 540
mov word [y], 140
call drawDiagonalNormal2
mov word [w], 300
mov word [x], 380
mov word [y], 170
call drawDiagonalNormal1
mov word [x], 320
mov word [y], 170
call drawDiagonalNormal2
ret
drawDiagonalNormal1:
mov si, [x]
add si, [w]
; draw vertical
mov cx, [x]
mov dx, [y]
mov al, [c]
u6:
mov ah, 0ch ; put pixel
int 10h
inc dx
add cx,1
cmp cx,si
jbe u6
ret
drawDiagonalNormal2:
mov si, [x]
sub si, [w]
; draw vertical
mov cx, [x]
mov dx, [y]
mov al, [c]
u7:
mov ah, 0ch ; put pixel
int 10h
inc dx
sub cx,1
cmp cx,si
jge u7
ret
printCircle:
push ax
push bx
push cx
push dx
push si
push di
mov byte [counter],0
mov cx, [si] ; first x position
add cx, [xoffset] ; moving point along x axis
mov dx, [di] ; first y position
add dx, [yoffset] ; moving point along y axis
l1:
int 0x10 ; bios video services
add si, 2 ; next location address
add di, 2 ; next location address
mov cx, [si]
add cx, [xoffset]
mov dx, [di]
add dx, [yoffset]
push ax
mov al, [radius]
inc byte[counter]
cmp [counter], al ; stopping condition
pop ax
jle l1 ; jump if less
pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret
drawVerticalLine:
mov si, [x]
add si, [w]
; draw vertical
mov cx, [x]
mov dx, [y]
mov al, [c]
u1:
mov ah, 0ch ; put pixel
int 10h
inc cx
cmp cx,si
jbe u1
ret
drawHorizontalLine:
mov si, [y]
add si, [w]
; draw vertical
mov cx, [x]
mov dx, [y]
mov al, [c]
u2:
mov ah, 0ch ; put pixel
int 10h
inc dx
cmp dx,si
jbe u2
ret
drawWideDiagnol1:
mov si, [x]
add si, [w]
; draw vertical
mov cx, [x]
mov dx, [y]
mov al, [c]
u3:
mov ah, 0ch ; put pixel
int 10h
inc dx
add cx,2
cmp cx,si
jbe u3
ret
drawWideDiagnol2:
mov si, [x]
sub si, [w]
; draw vertical
mov cx, [x]
mov dx, [y]
mov al, [c]
u4:
mov ah, 0ch ; put pixel
int 10h
inc dx
sub cx,2
cmp cx,si
jge u4
ret
drawTree:
ret
start:
; going into the video memory
mov ax, 0x0010 ; set 640 x 350 graphics mode
int 0x10 ; bios video services
mov ax, 0x0C07 ; put pixel in white color
xor bx, bx ; page number 0
;your code starts here zaki sir
call drawHome
mov ah, 0 ; service 0 – get keystroke
int 0x16 ; bios keyboard services
mov ax, 0x0003 ; 80x25 text mode
int 0x10 ; bios video services
mov ax, 0x4c00 ; terminate program
int 0x21

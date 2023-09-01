; a program to add three numbers using memory variables
[org 0x0100]
	mov ax,0 ;ax=0
	mov bx,0 ;bx=0
	
	mov ax,[Array1+bx] ; ax=0
	add ax,[Array2+bx] ; ax=0+1=1
	mov [Array3+bx],ax ; ax= array3
	sub ax,[Array2+bx] ;ax= array3-array2
	mov [Array2+bx+1],ax ;arr[2]=array3-array2 & ax=a2[1]
	mov ax,[Array1+bx]; ax=array1[0]
	add ax,[Array3+bx] ;
	mov [Array1+bx+1],ax;
	
	add bx,1
	mov ax,0
	mov ax,[Array1+bx] ; ax=0
	add ax,[Array2+bx] ; ax=0+1=1
	mov [Array3+bx],ax ; ax= array3
	sub ax,[Array2+bx] ;ax= array3-array2
	mov [Array2+bx+1],ax ;arr[2]=array3-array2 & ax=a2[1]
	mov ax,[Array1+bx]; ax=array1[0]
	add ax,[Array3+bx] ;
	mov [Array1+bx+1],ax;
	
	add bx,1
	mov ax,0
	mov ax,[Array1+bx] ; ax=0
	add ax,[Array2+bx] ; ax=0+1=1
	mov [Array3+bx],ax ; ax= array3
	sub ax,[Array2+bx] ;ax= array3-array2
	mov [Array2+bx+1],ax ;arr[2]=array3-array2 & ax=a2[1]
	mov ax,[Array1+bx]; ax=array1[0]
	add ax,[Array3+bx] ;
	mov [Array1+bx+1],ax;
	
	add bx,1
	mov ax,0
	mov ax,[Array1+bx] ; ax=0
	add ax,[Array2+bx] ; ax=0+1=1
	mov [Array3+bx],ax ; ax= array3
	sub ax,[Array2+bx] ;ax= array3-array2
	mov [Array2+bx+1],ax ;arr[2]=array3-array2 & ax=a2[1]
	mov ax,[Array1+bx]; ax=array1[0]
	add ax,[Array3+bx] ;
	mov [Array1+bx+1],ax;
	
	add bx,1
	mov ax,0
	mov ax,[Array1+bx] ; ax=0
	add ax,[Array2+bx] ; ax=0+1=1
	mov [Array3+bx],ax ; ax= array3
	sub ax,[Array2+bx] ;ax= array3-array2
	mov [Array2+bx+1],ax ;arr[2]=array3-array2 & ax=a2[1]
	mov ax,[Array1+bx]; ax=array1[0]
	add ax,[Array3+bx] ;
	mov [Array1+bx+1],ax;
	
	mov ax, 0x4c00 ; terminate program
	int 0x21	
Array1: db 0,0,0,0,0	 ;variables
Array2: db 1,0,0,0,0
Array3: db	0,0,0,0,0
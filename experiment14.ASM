assume cs:code

code segment
port: db 9,8,7,4,2,0
clock: db 'YY/MM/DD HH:MM:SS','$'
start:
	mov ax,cs
	mov ds,ax
	mov si,offset port
	mov bx,cs
	mov es,bx
	mov di,offset clock
	mov cx,6
show_clock:
	push cx
	mov al,ds:[si]
	out 70h,al
	in al,71h

	mov ah,al
	mov cl,4
	shr ah,cl
	and al,00001111b

	add ah,30h
	add al,30h

	mov byte ptr es:[di],ah
	mov byte ptr es:[di+1],al
	add di,3
	inc si
	pop cx
	loop show_clock

	mov bh,0
	mov dh,10
	mov dl,20
	mov ah,2
	int 10h

	mov dx,offset clock
	mov ah,9
	int 21h
	jmp start

	mov ax,4c00h
	int 21h
code ends
end start
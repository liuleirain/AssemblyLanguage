assume cs:code 
stack segment stack
	db 128 dup (0)
stack ends
code segment
start:
	mov ax,stack
	mov ss,ax
	mov sp,128

	mov ax,cs
	mov ds,ax
	mov si,offset setscreen
	mov ax,0
	mov es,ax
	mov di,200h
	mov cx,offset setscreenEnd - offset setscreen
	cld
	rep movsb

	cli
	mov word ptr es:[7ch*4],200h
	mov word ptr es:[7ch*4+2],0
	sti
	
	mov al,3
	mov ah,3
	; call setscreen
	int 7ch

	mov ax,4c00h
	int 21h
setscreen:
	jmp short set
	table dw offset sub1 - offset setscreen + 200h,offset sub2 - offset setscreen + 200h,offset sub3 - offset setscreen + 200h,offset sub4 - offset setscreen + 200h
set:
	push bx
	cmp ah,3
	ja sret
	mov bl,ah
	mov bh,0
	add bx,bx
	call word ptr cs:[bx+202h]
sret:
	pop bx
	iret
sub1:
	push ax
	push cx
	push es
	mov bx,0b800h
	mov es,bx
	mov bx,0
	mov cx,2000
sub1s:
	mov word ptr es:[bx],' '
	add bx,2
	loop sub1s
	pop es
	pop cx
	pop ax
	ret
sub2:
	push ax
	push cx
	push es
	mov bx,0b800h
	mov es,bx
	mov bx,1
	mov cx,2000
sub2s:
	and byte ptr es:[bx],11111000b
	or es:[bx],al
	add bx,2
	loop sub2s
	pop es
	pop cx
	pop ax
	ret
sub3:
	push ax
	push cx
	push es
	mov cl,4
	shl al,cl
	mov bx,0b800h
	mov es,bx
	mov bx,1
	mov cx,2000
sub3s:
	and byte ptr es:[bx],10001111b
	or es:[bx],al
	add bx,2
	loop sub3s
	pop es
	pop cx
	pop ax
	ret
sub4:
	push cx
	push si
	push di
	push ds
	push es
	mov bx,0b800h
	mov ds,bx
	mov es,bx
	mov si,160
	mov di,0
	mov cx,24*160
	cld
	rep movsb
	mov cx,80
sub4s:
	mov byte ptr ds:[si],' '
	sub si,2
	loop sub4s
	pop es
	pop ds
	pop di
	pop si
	pop cx
	ret
setscreenEnd:
	nop
code ends
end start
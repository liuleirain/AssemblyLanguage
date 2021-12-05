assume cs:code

data segment
	db 'Welcome to masm!',0
data ends

code segment
start:
	mov dh,8
	mov dl,3
	mov cl,2
	mov ax,data
	mov ds,ax
	mov si,0
	call show_str

	mov ax,4c00h
	int 21h
show_str:
	mov ax,0b800h
	mov es,ax
	mov ax,160
	mul dh
	mov di,ax
	mov ax,2
	mul dl
	add di,ax
	mov bh,cl
	mov ch,0
each_char:
	mov bl,ds:[si]
	mov cl,bl
	jcxz each_char_end
	mov es:[di],bx
	inc si
	add di,2
	jmp each_char
each_char_end:
	ret
code ends
end start
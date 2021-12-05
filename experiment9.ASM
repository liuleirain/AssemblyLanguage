assume cs:code

data segment
	db 'Welcome to masm!',0
data ends

stack segment stack
	db 128 dup (0)
stack ends

code segment
start:
	mov ax,stack
	mov ss,ax
	mov sp,128

	call clean_screen	
	call init_reg
	mov bh,00000010b
	call show_string

	mov bh,00100100b
	call show_string

	mov bh,01110001b
	call show_string
	mov ax,4c00h
	int 21h
show_string:
	push si
	push di
	mov ch,0	
each_char:
	mov bl,ds:[si]
	mov cl,bl
	jcxz each_char_end
	mov es:[di],bx
	add di,2
	inc si
	jmp each_char
each_char_end:
	pop di
	pop si
	add di,160 
	ret
init_reg:
	mov ax,data
	mov ds,ax
	mov si,0
	mov ax,0b800h
	mov es,ax
	mov di,160*10+30*2
	ret
clean_screen:
	mov bx,0700h
	mov ax,0b800h
	mov es,ax
	mov di,0
	mov cx,2000
clear:
	mov es:[di],bx	
	add di,2
	loop clear
	ret
code ends
end start
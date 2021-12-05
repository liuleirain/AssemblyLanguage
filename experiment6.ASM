assume cs:code

stack segment stack
	db 128 dup (0)
stack ends

data segment
	; db '123456789abcdef'
	db '1. display     ','$'
	db '2. brows       ','$'
	db '3. replace     ','$'
	db '4. modify      ','$'
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	mov si,3
	mov bx,0
	mov cx,4
row:
	and byte ptr ds:[bx + si],11011111b
	add bx,16
	loop row

	mov ah,2
	mov dh,10
	mov dl,10
	mov bh,0
	int 10h
	mov cx,4
	mov dx,0
show_row:
	mov ah,9
	int 21h
	add dx,16
	loop show_row
	mov ax,4c00h
	int 21h
code ends
end start
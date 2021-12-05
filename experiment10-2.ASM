assume cs:code

code segment
start:
	mov ax,4240h
	mov dx,000fh
	mov cx,0ah
	call divdw
	; div cx

	mov ax,4c00h
	int 21h
divdw:
	push ax
	mov bp,sp
	mov ax,dx
	mov dx,0
	div cx
	push ax
	mov ax,ss:[bp]
	div cx
	pop dx
	add sp,2
	ret
code ends
end start
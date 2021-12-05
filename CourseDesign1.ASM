assume cs:code

data segment
	db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
	db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
	db '1993','1994','1995'
	dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
	dd 345980,590827,803530,118300,1843000,2759000,3753000,4649000,5937000
	dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
	dw 11542,14430,15257,17800
data ends

table segment
	db 21 dup ('year summ ne ?? ')
table ends

string segment
	db 10 dup ('0')
string ends

stack segment stack
	db 128 dup (0)
stack ends

code segment
start:
	mov ax,stack
	mov ss,ax
	mov sp,128

	mov ax,data
	mov ds,ax
	mov si,0
	mov bx,21*4*2

	mov ax,table
	mov es,ax
	mov di,0
	mov cx,21
data_to_table:
	push cx
	push ds:[si]
	pop es:[di]
	push ds:[si+2]
	pop es:[di+2]

	mov ax,ds:[si+21*4]
	mov es:[di+5],ax
	mov dx,ds:[si+21*4+2]
	mov es:[di+7],dx

	mov cx,ds:[bx]
	mov es:[di+10],cx

	div cx
	mov es:[di+13],ax

	add si,4
	add bx,2
	add di,16
	pop cx
	loop data_to_table

	mov bx,0700h
	mov ax,0b800h
	mov es,ax
	mov di,0
	mov cx,2000
clear_screen:
	mov es:[di],bx
	add di,2
	loop clear_screen

	mov ax,table
	mov ds,ax
	mov si,0
	mov di,160*3

	mov cx,21
show_string:
	push cx
	push si
	push di

	mov cx,4
	add di,3*2
	push si
show_year:
	mov dl,ds:[si]
	mov es:[di],dl
	inc si
	add di,2
	loop show_year
	pop si

	call show_num

	pop di
	pop si
	pop cx
	add di,160
	add si,16
	loop show_string

	mov ax,4c00h
	int 21h
show_num:
	push ax
	push bx
	push cx
	push dx
	push ds
	push es

	call show_summ
	call show_ne
	call show_average

	pop es
	pop ds
	pop dx
	pop cx
	pop bx
	pop ax
	ret
show_average:
	add di,20
	push di
	push ds
	mov ax,string 
	mov es,ax
	mov bx,0
	mov ax,ds:[si+13]	
	mov dx,0
	call num_to_string
	call show_char
	pop ds
	pop di
	ret
show_ne:
	add di,30
	push di
	push ds
	mov ax,string 
	mov es,ax
	mov bx,0
	mov ax,ds:[si+10]	
	mov dx,0
	call num_to_string
	call show_char
	pop ds
	pop di
	ret

show_summ:
	add di,10
	push di
	push ds
	mov ax,string 
	mov es,ax
	mov bx,0
	mov ax,ds:[si+5]	
	mov dx,ds:[si+7]
	call num_to_string
	call show_char
	pop ds
	pop di
	ret
show_char:
	mov ax,string
	mov ds,ax
	mov ax,0b800h
	mov es,ax
	mov cx,bx
	inc cx
each_char:
	mov dl,ds:[bx]
	mov es:[di],dl
	dec bx
	add di,2
	loop each_char
	ret
num_to_string:
	mov cx,dx
	jcxz short_div
	mov cx,10
	push ax
	mov bp,sp
	call long_div
	add cl,30h
	mov es:[bx],cl
	inc bx
	add sp,2
	jmp num_to_string
div_end:
	ret
short_div:
	mov cx,10
	div cx
	add dl,30h
	mov	es:[bx],dl
	mov cx,ax
	jcxz div_end
	inc bx
	mov dx,0
	jmp num_to_string
long_div:
	mov ax,dx
	mov dx,0
	div cx
	push ax
	mov ax,ss:[bp]
	div cx
	mov cx,dx
	pop dx
	ret

code ends
end start

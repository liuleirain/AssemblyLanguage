assume cs:code 

data segment
  db "Welcome to masm!",0
data ends

code segment
start:
  mov ax,0
  mov es,ax
  mov di,200h
  mov ax,cs
  mov ds,ax
  mov si,offset do7c
  mov cx,offset do7cEnd - offset do7c
  cld
  rep movsb

  mov word ptr es:[7ch*4],200h
  mov word ptr es:[7ch*4+2],0

  mov dh,10
  mov dl,10
  mov cl,2
  mov ax,data
  mov ds,ax
  mov si,0
  int 7ch

  mov ax,4c00h
  int 21h
do7c:
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
show_char:
  mov cl,ds:[si]
  jcxz ok
  mov bl,cl
  mov es:[di],bx
  inc si
  add di,2
  jmp show_char

ok:
  iret
do7cEnd:
  nop
code ends
end start
assume cs:code

code segment
start:
  mov ax,cs
  mov ds,ax
  mov si,offset do0

  mov ax,0
  mov es,ax
  mov di,200h
  mov cx,offset do0End - offset do0
  cld
  rep movsb

  mov word ptr es:[0],200h
  mov word ptr es:[2],0

  mov ax,1000h
  mov bx,1
  div bx

  mov ax,4c00h
  int 21h
do0:
  jmp short do0Start
string:
  db 'divide error!',0
do0Start:
  mov ax,0b800h
  mov es,ax
  mov di,160*10+30*2 
  mov ax,0
  mov ds,ax
  mov si,offset string - offset do0 + 200h
  mov ch,0
show_char:
  mov cl,ds:[si]
  jcxz ok
  mov es:[di],cl
  inc si
  add di,2
  jmp show_char
ok:
  iret
do0End:
  nop
code ends
end start
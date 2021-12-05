assume cs:code
code segment
start:
  mov ax,cs
  mov ds,ax
  mov si,offset do7c
  mov ax,0
  mov es,ax
  mov di,200h
  mov cx,offset do7cEnd - offset do7c
  cld
  rep movsb

  mov word ptr es:[7ch*4],200h
  mov word ptr es:[7ch*4+2],0

  mov ax,0b800h
  mov es,ax
  mov di,160*12
  mov bx,offset s-offset se
  mov cx,80
s:
  mov byte ptr es:[di],'!'
  add di,2
  int 7ch
se:
  nop
  mov ax,4c00h
  int 21h
do7c:
  mov bp,sp
  dec cx
  jcxz ok
  add ss:[bp],bx
ok:
  iret
do7cEnd:
  nop
code ends
end start
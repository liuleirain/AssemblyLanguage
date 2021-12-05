assume cs:code

data segment
  db 10 dup (0)
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

  mov ax,12666
  mov bx,data
  mov ds,bx
  mov si,0
  call dtoc

  mov dh,8
  mov dl,3
  mov cl,2
  call show_str

  mov ax,4c00h
  int 21h
clean_screen:
  mov ax,0b800h
  mov es,ax
  mov bx,0700h
  mov di,0
  mov cx,2000
clear_loop:
  mov es:[di],bx
  add di,2
  loop clear_loop
 
  ret
show_str:
  mov ax,0b800h
  mov es,ax
  mov di,160*10+20*2
  mov bh,cl
  mov cx,si
  inc cx
each_char:
  mov bl,ds:[si]
  mov es:[di],bx
  dec si
  add di,2
  loop each_char
  ret 
dtoc:
  mov cx,10
  div cx
  mov cl,dl
  add dl,30h
  mov ds:[si],dl
  mov cx,ax
  jcxz dtoc_end
  inc si
  mov dx,0
  jmp dtoc

dtoc_end:
  ret
code ends
end start
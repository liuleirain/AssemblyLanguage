assume cs:code 
stack segment stack
  db 128 dup (0)
stack ends
code segment
start:
  mov ax,stack
  mov ss,ax
  mov sp,128

  call set_new_int9
testA:
  mov ax,1000h
  jmp testA

  mov ax,4c00h
  int 21h

set_new_int9:
  mov ax,cs
  mov ds,ax
  mov si,offset new_int9
  mov ax,0
  mov es,ax
  mov di,204h
  mov cx,offset new_int9_end - offset new_int9
  cld
  rep movsb

  push es:[9*4]
  pop es:[200h]
  push es:[9*4+2]
  pop es:[202h]

  cli
  mov word ptr es:[9*4],204h
  mov word ptr es:[9*4+2],0
  sti

  ret
new_int9:
  push ax
  push bx
  push cx
  push es

  in al,60h

  pushf
  call dword ptr es:[200h]

  cmp al,9eh
  jne new_int9_ret

  mov ax,0b800h
  mov es,ax
  mov di,0
  mov cx,2000
  mov bl,'A'
show_char:
  mov es:[di],bl
  add di,2
  loop show_char

new_int9_ret:
  pop es
  pop cx
  pop bx
  pop ax
  iret
new_int9_end:
  nop
code ends
end start
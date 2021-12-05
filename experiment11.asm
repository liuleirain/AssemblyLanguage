assume cs:code

data segment
  db "Beginner's All-purpose Symbolic Instruction Code.",0
data ends

code segment
start:
  mov ax,data
  mov ds,ax
  mov si,0
  call letterc

  mov ax,4c00h
  int 21h
letterc:
  mov ax,0b800h
  mov es,ax
  mov di,160*5+4*2
letterc_loop:
  mov dl,ds:[si]
  cmp dl,0
  je letterc_end
  cmp dl,'a'
  jb next_letter
  cmp dl,'z'
  ja next_letter
  and byte ptr ds:[si],11011111b
  and dl,11011111b
next_letter:
  mov es:[di],dl
  add di,2
  inc si
  jmp letterc_loop
letterc_end:
  ret
code ends
end start
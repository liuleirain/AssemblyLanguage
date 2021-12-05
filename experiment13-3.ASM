assume cs:code
code segment
s1: db "Good,better,best,",'$'
s2: db 'Never let it rest,','$'
s3: db 'Till good is better,','$'
s4: db 'And better,best.','$'
s:  dw offset s1, offset s2, offset s3, offset s4
row: db 2,4,6,8

start:
  call clean_screen
  mov ax,cs
  mov ds,ax
  mov bx,offset s
  mov si,offset row
  mov cx,4
ok:
  mov bh,0
  mov dh,ds:[si]
  mov dl,0
  mov ah,2
  int 10h

  mov dx,ds:[bx]
  mov ah,9
  int 21h
  inc si
  add bx,2

  loop ok
  mov ax,4c00h
  int 21h
clean_screen:
  mov bx,0700h
  mov ax,0b800h
  mov es,ax
  mov di,0
  mov cx,2000
clean_loop:
  mov es:[di],bx
  add di,2
  loop clean_loop
  ret
code ends
end start

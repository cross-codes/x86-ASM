.model tiny
.data
  fname      db "task1.txt", 0
  handle     dw ?

  p_name     db "Akshaj Rao"
  p_name_len equ 10

  NL         db 0ah
  NL_len     equ 1

  ID         db "2022B5A70289P"
  ID_len     equ 13

.code
.startup
  ; Create a new file
  mov ah, 3ch
  lea dx, fname
  mov cl, 00h
  int 21h

  mov handle, ax

  ; Write name onto file handle
  mov ah, 40h
  mov bx, handle
  mov cx, p_name_len
  lea dx, p_name
  int 21h

  ; Write '\n' onto file handle
  mov ah, 40h
  mov bx, handle
  mov cx, NL_len
  lea dx, NL
  int 21h

  ; Write ID onto file handle
  mov ah, 40h
  mov bx, handle
  mov cx, ID_len
  lea dx, ID
  int 21h

  ; Close file handle
  mov ah, 3eh
  mov bx, handle
  int 21h

.exit
end

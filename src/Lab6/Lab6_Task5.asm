.model tiny
.data
  name_prompt  db "Enter your name$"
  ID_prompt    db "Enter your ID$"

  max_name_len db 7
  act_name_len db ?
  name_str     db 8 dup(24h)

  NL           db 0ah
  NL_len       equ 1

  max_ID_len   db 14
  act_ID_len   db ?
  ID_str       db 15 dup(24h)

  fname        db "task5.txt", 0
  handle       dw ?
  new_fname    db "task6.txt", 0

.code
.startup
  ; Display name prompt
  lea dx, name_prompt
  mov ah, 09h
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Read input
  lea dx, max_name_len
  mov ah, 0ah
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Display ID prompt
  lea dx, ID_prompt
  mov ah, 09h
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Read input
  lea dx, max_ID_len
  mov ah, 0ah
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Create new file
  mov ah, 3ch
  lea dx, fname
  mov cl, 00h
  int 21h

  mov handle, ax

  ; Write name into file
  mov ah, 40h
  mov bx, handle
  mov cl, act_name_len
  mov ch, 00h
  lea dx, name_str
  int 21h

  ; Write '\n' onto file handle
  mov ah, 40h
  mov bx, handle
  mov cx, NL_len
  lea dx, NL
  int 21h

  ; Write ID into file
  mov ah, 40h
  mov bx, handle
  mov cl, act_ID_len
  mov ch, 00h
  lea dx, ID_str
  int 21h

  ; Close file handle
  mov ah, 3eh
  mov bx, handle
  int 21h

  ; Rename file
  mov ah, 56h
  lea dx, fname
  lea di, new_fname
  mov cl, 00h
  int 21h

.exit
end

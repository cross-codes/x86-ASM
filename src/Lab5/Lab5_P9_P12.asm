.model tiny
.data
  msg_prompt  db "Enter maximum 10 characters$"
  res_prompt  db "The capital letters in the string are$"

  max_len     db 11
  len         db ?
  input_str   db 12 dup(24h)

  res_str     db 11 dup(24h)

.code
.startup
  ; Display prompt
  lea dx, msg_prompt
  mov ah, 09h
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Read input
  lea dx, max_len
  mov ah, 0ah
  int 21h

  ; Iterate and push back capital letters
  lea si, input_str
  mov cl, len
  mov ch, 00h
  lea di, res_str

__ITERATE:
  mov al, [si]
  cmp al, 5ah
  jg __INCREMENT
  mov [di], al
  inc di

__INCREMENT:
  inc si
  dec cx
  jnz __ITERATE

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Display message
  lea dx, res_prompt
  mov ah, 09h
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Show capital letters
  lea dx, res_str
  mov ah, 09h
  int 21h

.exit
end

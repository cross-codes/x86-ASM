.model tiny
.data
  max_chars    db 21
  actual_chars db ?
  input_string db 22 dup(24h)

.code
.startup
  lea dx, max_chars
  mov ah, 0ah
  int 21h

  ; Ouput newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  lea dx, input_string
  mov ah, 09h
  int 21h
.exit
end

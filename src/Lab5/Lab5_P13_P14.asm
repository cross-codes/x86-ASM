.model tiny
.data
  prompt_msg_1 db "Enter a single digit number$"
  prompt_msg_2 db "Enter another single digit number$"
  prompt_msg_3 db "Enter operation$"
  res_msg      db "Result is$"

.code
.startup
  ; Display prompt 1
  lea dx, prompt_msg_1
  mov ah, 09h
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Read digit, store in bl
  mov ah, 01h
  int 21h
  mov bl, al
  sub bl, '0'

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Display prompt 2
  lea dx, prompt_msg_2
  mov ah, 09h
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Read digit, store in cl
  mov ah, 01h
  int 21h
  mov cl, al
  sub cl, '0'

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Display prompt 3
  lea dx, prompt_msg_3
  mov ah, 09h
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Read digit, discard
  mov ah, 01h
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Display result prompt
  lea dx, res_msg
  mov ah, 09h
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  add cl, bl
  add cl, '0'

  ; Display character
  mov dl, cl
  mov ah, 02h
  int 21h

.exit
end

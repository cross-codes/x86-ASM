.model tiny
.data
  uname_prompt        db "Enter User Name$"
  pwd_prompt          db "Enter Password$"
  success_msg         db "Hello akshajpr$"

  expected_uname      db "akshajpr"
  uname_length        equ 8
  expected_pwd        db "cowdo"
  pwd_length          equ 5

  max_uname_length    db 09
  actual_uname_length db ?
  uname               db 10 dup(24h)

  max_pwd_length      db 06
  acutal_pwd_length   db ?
  pwd                 db 07 dup(24h)

.code
.startup
  ; Display username prompt
  lea dx, uname_prompt
  mov ah, 09h
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Read username
  lea dx, max_uname_length
  mov ah, 0ah
  int 21h

  ; Compare username
  lea si, uname
  lea di, expected_uname
  mov cx, uname_length
  repe cmpsb

  cmp cx, 00h
  jnz __TERMINATE

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Display password prompt
  lea dx, pwd_prompt
  mov ah, 09h
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Read password
  lea dx, max_pwd_length
  mov ah, 0ah
  int 21h

  ; Compare password
  lea si, pwd
  lea di, expected_pwd
  mov cx, pwd_length
  repe cmpsb

  cmp cx, 00h
  jnz __TERMINATE

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Display success message
  lea dx, success_msg
  mov ah, 09h
  int 21h

__TERMINATE:

.exit
end

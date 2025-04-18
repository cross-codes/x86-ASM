.model tiny
.data
  user_fname    db "user.txt", 0
  pwd_fname     db "password.txt", 0
  curr_handle   dw ?

  denied_prompt db "Access Denied!$"
  pass_prompt   db "Hello akshajpr$"
  uname         db "akshajpr"
  pwd           db "cowdo"

  entered_uname db 9 dup(24h)
  entered_pwd   db 6 dup(24h)

.code
.startup
  ; Open user.txt
  mov ah, 3dh
  mov al, 0
  lea dx, user_fname
  int 21h

  mov curr_handle, ax

  ; Read username
  mov ah, 3fh
  mov bx, curr_handle
  mov cx, 08
  lea dx, entered_uname
  int 21h

  ; Close file handle
  mov ah, 3eh
  mov bx, curr_handle
  int 21h

  ; Compare usernames
  lea si, uname
  lea di, entered_uname
  cld
  mov cx, 09
  repe cmpsb

  cmp cx, 0
  jnz __TERMINATE

  ; Open password.txt
  mov ah, 3dh
  mov al, 0
  lea dx, pwd_fname
  int 21h

  mov curr_handle, ax

  ; Read password
  mov ah, 3fh
  mov bx, curr_handle
  mov cx, 05
  lea dx, entered_pwd
  int 21h

  ; Close file handle
  mov ah, 3eh
  mov bx, curr_handle
  int 21h

  ; Compare passwords
  lea si, pwd
  lea di, entered_pwd
  cld
  mov cx, 06
  repe cmpsb

  cmp cx, 0
  jnz __TERMINATE

  ; Show success
  lea dx, pass_prompt
  mov ah, 09h
  int 21h
  jmp __END


__TERMINATE:
  ; Display error
  lea dx, denied_prompt
  mov ah, 09h
  int 21h

__END:

.exit
end

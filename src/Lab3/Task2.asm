.model tiny
.data
  DATA1 db 01h, 00h, 12h, 23h, 11h, 00h
        db 0ffh, 00h, 00h, 10h

  count equ 10
.code
.startup
  lea si, DATA1
  mov cx, count

__SCAN:
  mov al, BYTE PTR[si]
  cmp al, 00h
  jnz __INCREMENT
  mov al, 0ffh
  mov BYTE PTR[si], al

__INCREMENT:
  inc si
  dec cx
  jnz __SCAN

.exit
end

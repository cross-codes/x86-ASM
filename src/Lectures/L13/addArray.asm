.model tiny
.data
  dat1 db 50 dup(0ffh)
  count equ 32h

.code
.startup
  lea si, dat1
  mov cx, count

  mov di, 1000h

  mov ax, 4000h
  mov ds, ax

  mov bx, 0000h ; Reset register

addition:
  add bl, es:[si]
  jc carry

iterate:
  inc si
  dec cx
  jnz addition
  jmp terminate

carry:
  inc bh
  jmp iterate


terminate:
  mov ds:[di], bx

.exit
end

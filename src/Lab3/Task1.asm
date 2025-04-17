.model tiny
.data
  DATA1 db "MicroProcessoR"
  count equ 14
.code
.startup
  lea si, DATA1
  mov cx, count

__SCAN:
  mov al, [si]
  cmp al, 61h
  jl __CHANGE

__RETURN:
  inc si
  dec cx
  jnz __SCAN
  jmp __END

__CHANGE:
  add al, 20h
  mov [si], al
  jmp __RETURN

__END:

.exit
end

.model tiny
.data
  counter  db 38
  name_str db "AKSHAJ"

.code
.startup
  ; Set display mode
  mov ah, 00h
  mov al, 03h
  int 10h

  lea si, counter
  lea di, name_str

__ADVANCE:
  ; Set cursor position
  mov cl, [si]
  mov ah, 02h
  mov dh, 12
  mov dl, cl
  mov bh, 00
  int 10h

  ; Write letter
  mov ah, 09h
  mov al, [di]
  mov bh, 0
  mov bl, 10001010b
  mov cx, 1
  int 10h

  mov cl, [si]
  inc cl
  mov [si], cl
  inc di
  cmp cl, 44
  jnz __ADVANCE

  ; Blocking function
  mov ah, 07h
__BLOCK:
  int 21h
  cmp al, 'a'
  jnz __BLOCK

.exit
end

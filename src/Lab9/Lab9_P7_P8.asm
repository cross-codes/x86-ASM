.model tiny
.data
  current_row db 8

.code
.startup
  ; Set display mode
  mov ah, 00h
  mov al, 03h
  int 10h

  ; Print 11 'M's
  lea si, current_row
__VERTICAL:
  mov al, [si]
  cmp al, 19
  jz __HORIZONTAL

  ; Set cursor
  mov ah, 02h
  mov dh, [si]
  mov dl, 40
  mov bh, 0
  int 10h

  ; Print
  mov ah, 09h
  mov al, 'M'
  mov bh, 00h
  mov bl, 00001111b
  mov cx, 1
  int 10h

  mov al, [si]
  inc al
  mov [si], al
  jmp __VERTICAL

__HORIZONTAL:
  ; Set cursor
  mov ah, 02h
  mov dh, 13
  mov dl, 35
  mov bh, 0
  int 10h

  ; Print 11 'M's
  mov ah, 09h
  mov al, 'M'
  mov bh, 00h
  mov bl, 00001111b
  mov cx, 11
  int 10h

  mov ah, 07h
__BLOCK:
  int 21h
  cmp al, 'a'
  jnz __BLOCK

.exit
end

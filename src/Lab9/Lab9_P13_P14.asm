.model tiny
.data
  current_row db 0

.code
.startup
  ; Set display mode
  mov ah, 00h
  mov al, 03h
  int 10h

  ; Print 24 'M's
  lea si, current_row
__VERTICAL:
  mov al, [si]
  cmp al, 25
  jz __HORIZONTAL

  ; Set cursor
  mov ah, 02h
  mov dh, [si]
  mov dl, 40
  mov bh, 0
  int 10h

  ; Print
  mov ah, 09h
  mov al, 'C'
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
  mov dl, 0
  mov bh, 0
  int 10h

  ; Print 79 'C's
  mov ah, 09h
  mov al, 'C'
  mov bh, 00h
  mov bl, 00001111b
  mov cx, 79
  int 10h

  mov ah, 07h
__BLOCK:
  int 21h
  cmp al, 'a'
  jnz __BLOCK

.exit
end

.model tiny
.data
  current_row db 0
  current_col db 79

.code
.startup
  ; Set display mode
  mov ah, 00h
  mov al, 03h
  int 10h

  lea si, current_row
  lea di, current_col
__DISPLAY:
  mov al, [si]
  cmp al, 24
  jz __FINISH

  ; Set cursor position
  mov ah, 02h
  mov dh, [si]
  mov dl, [di]
  mov bh, 0
  int 10h

  ; Print character
  mov ah, 09h
  mov al, 'A'
  mov bh, 00h
  mov bl, 00001111b
  mov cx, 1
  int 10h

  mov al, [si]
  inc al
  mov [si], al

  mov al, [di]
  dec al
  mov [di], al

  jmp __DISPLAY

__FINISH:
  mov ah, 07h
__BLOCK:
  int 21h
  cmp al, 'a'
  jnz __BLOCK

.exit
end

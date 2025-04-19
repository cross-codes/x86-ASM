.model tiny
.data

.code
.startup
  ; Set display mode
  mov ah, 00h
  mov al, 03h
  int 10h

  ; Top left
  mov ah, 02h
  mov dl, 00h
  mov dh, 00h
  mov bl, 00h
  int 10h

  ; Print 'H'
  mov ah, 09h
  mov al, 'H'
  mov bh, 00h
  mov bl, 00001100b
  mov cx, 1
  int 10h

  ; Top right
  mov ah, 02h
  mov dl, 79
  mov dh, 00h
  mov bl, 00h
  int 10h

  ; Print 'E'
  mov ah, 09h
  mov al, 'E'
  mov bh, 00h
  mov bl, 00001100b
  mov cx, 1
  int 10h

  ; Bottom left
  mov ah, 02h
  mov dl, 00h
  mov dh, 24
  mov bl, 00h
  int 10h

  ; Print 'L'
  mov ah, 09h
  mov al, 'L'
  mov bh, 00h
  mov bl, 00001100b
  mov cx, 1
  int 10h

  ; Bottom right
  mov ah, 02h
  mov dl, 79
  mov dh, 24
  mov bl, 00h
  int 10h

  ; Print 'L'
  mov ah, 09h
  mov al, 'L'
  mov bh, 00h
  mov bl, 00001100b
  mov cx, 1
  int 10h

  ; Center
  mov ah, 02h
  mov dl, 40
  mov dh, 12
  mov bl, 00h
  int 10h

  ; Print 'O'
  mov ah, 09h
  mov al, 'O'
  mov bh, 00h
  mov bl, 00001100b
  mov cx, 1
  int 10h

  mov ah, 07h
__BLOCK:
  int 21h
  cmp al, 'a'
  jnz __BLOCK

.exit
end

.model tiny
.data
  current_row db 0

.code
.startup
  ; Set display mode
  mov ah, 00h
  mov al, 03h
  int 10h

  lea si, current_row
__TOP_LEFT:
  mov al, [si]
  cmp al, 3
  jz __TOP_RIGHT_PRE

  ; Set cursor
  mov ah, 02h
  mov dl, 00h
  mov dh, [si]
  mov bh, 00h
  int 10h

  ; Print 3 '1's
  mov ah, 09h
  mov al, '1'
  mov bh, 00h
  mov bl, 00001111b
  mov cx, 3
  int 10h

  mov al, [si]
  inc al
  mov [si], al
  jmp __TOP_LEFT

__TOP_RIGHT_PRE:
  lea si, current_row
  mov al, [si]
  mov al, 0
  mov [si], al

__TOP_RIGHT:
  mov al, [si]
  cmp al, 3
  jz __BOTTOM_LEFT_PRE

  ; Set cursor
  mov ah, 02h
  mov dl, 77
  mov dh, [si]
  mov bh, 00h
  int 10h

  ; Print 3 '2's
  mov ah, 09h
  mov al, '2'
  mov bh, 00h
  mov bl, 00001111b
  mov cx, 3
  int 10h

  mov al, [si]
  inc al
  mov [si], al
  jmp __TOP_RIGHT

__BOTTOM_LEFT_PRE:
  lea si, current_row
  mov al, [si]
  mov al, 22
  mov [si], al

__BOTTOM_LEFT:
  mov al, [si]
  cmp al, 25
  jz __BOTTOM_RIGHT_PRE

  ; Set cursor
  mov ah, 02h
  mov dl, 00h
  mov dh, [si]
  mov bh, 00h
  int 10h

  ; Print 3 '3's
  mov ah, 09h
  mov al, '3'
  mov bh, 00h
  mov bl, 00001111b
  mov cx, 3
  int 10h

  mov al, [si]
  inc al
  mov [si], al
  jmp __BOTTOM_LEFT

__BOTTOM_RIGHT_PRE:
  lea si, current_row
  mov al, [si]
  mov al, 22
  mov [si], al

__BOTTOM_RIGHT:
  mov al, [si]
  cmp al, 25
  jz __CENTER_PRE

  ; Set cursor
  mov ah, 02h
  mov dl, 77
  mov dh, [si]
  mov bh, 00h
  int 10h

  ; Print 3 '4's
  mov ah, 09h
  mov al, '4'
  mov bh, 00h
  mov bl, 00001111b
  mov cx, 3
  int 10h

  mov al, [si]
  inc al
  mov [si], al
  jmp __BOTTOM_RIGHT

__CENTER_PRE:
  lea si, current_row
  mov al, [si]
  mov al, 11
  mov [si], al

__CENTER:
  mov al, [si]
  cmp al, 14
  jz __FINISH

  ; Set cursor
  mov ah, 02h
  mov dl, 40
  mov dh, [si]
  mov bh, 00h
  int 10h

  ; Print 3 '5's
  mov ah, 09h
  mov al, '5'
  mov bh, 00h
  mov bl, 00001111b
  mov cx, 3
  int 10h

  mov al, [si]
  inc al
  mov [si], al
  jmp __CENTER

__FINISH:
  mov ah, 07h
__BLOCK:
  int 21h
  cmp al, 'a'
  jnz __BLOCK

.exit
end

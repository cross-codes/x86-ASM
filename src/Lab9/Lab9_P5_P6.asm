.model tiny
.data
  current_row db 1

.code
.startup
  ; Set display mode
  mov ah, 00h
  mov al, 03h
  int 10h

  ; Set cursor location to top
  mov ah, 02h
  mov dl, 0
  mov dh, 0
  mov bh, 0
  int 10h

  ; Print 80 'A's
  mov ah, 09h
  mov al, 'A' 
  mov bh, 00h
  mov bl, 00001111b
  mov cx, 80
  int 10h

  ; Set cursor location to bottom
  mov ah, 02h
  mov dl, 0
  mov dh, 24
  mov bh, 0
  int 10h

  ; Print 80 'A's
  mov ah, 09h
  mov al, 'A' 
  mov bh, 00h
  mov bl, 00001111b
  mov cx, 80
  int 10h

  ; Set cursor location to top
  mov ah, 02h
  mov dl, 0
  mov dh, 0
  mov bh, 0
  int 10h

  lea si, current_row
__LEFT:
  mov al, [si]
  cmp al, 24
  jz __RIGHT_PRE

  ; Set cursor location to top
  mov ah, 02h
  mov dl, 0
  mov dh, [si]
  mov bh, 0
  int 10h

  ; Print 'A'
  mov ah, 09h
  mov al, 'A' 
  mov bh, 00h
  mov bl, 00001111b
  mov cx, 1
  int 10h

  mov al, [si]
  inc al
  mov [si], al
  jmp __LEFT

__RIGHT_PRE:
  mov al, [si]
  mov al, 1
  mov [si], al

__RIGHT:
  mov al, [si]
  cmp al, 24
  jz __FINISH

  ; Set cursor location to top
  mov ah, 02h
  mov dl, 79
  mov dh, [si]
  mov bh, 0
  int 10h

  ; Print 'A'
  mov ah, 09h
  mov al, 'A' 
  mov bh, 00h
  mov bl, 00001111b
  mov cx, 1
  int 10h

  mov al, [si]
  inc al
  mov [si], al
  jmp __RIGHT

__FINISH:
  mov ah, 07h
__BLOCK:
  int 21h
  cmp al, 'a'
  jnz __BLOCK

.exit
end

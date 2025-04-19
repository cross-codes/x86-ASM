.model tiny
.data
  current_row db 10
  current_col db 40

.code
.startup
  ; Set display mode
  mov ah, 00h
  mov al, 03h
  int 10h

  lea si, current_row
  lea di, current_col
__PRINT:
  mov al, BYTE PTR[si]
  cmp al, 25
  jz __STOP_PRINT

  ; Set cursor to center
  mov ah, 02h
  mov dh, [si]
  mov dl, [di]
  mov bh, 00
  int 10h

  ; Print character
  mov ah, 09h
  mov al, 'A'
  mov bh, 00h
  mov bl, 10001100b
  mov cx, 1
  int 10h

  mov al, [si];
  inc al
  mov [si], al
  mov al, [di]
  inc al
  mov [di], al
  jmp __PRINT

__STOP_PRINT:
  mov ah, 07h
__BLOCK:
  int 21h
  cmp al, 'a'
  jnz __BLOCK

.exit
end

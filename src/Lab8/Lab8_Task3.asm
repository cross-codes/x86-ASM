.model tiny
.data
  set           db 0
  left_col_pos  db 0
  right_col_pos db 40
  current_row   db 0

.code
.startup
  ; Set display mode
  mov ah, 00h
  mov al, 03h
  int 10h

  mov dh, 00h
__COLOR_LEFT:
  ; Move cursor
  mov ah, 02h
  mov dl, 00h
  mov bh, 00h
  int 10h

  ; Write whitespace
  mov ah, 09h
  mov al, ' '
  mov bh, 00h
  mov bl, 00011110b
  mov cx, 40
  int 10h
  inc dh
  cmp dh, 19h
  jnz __COLOR_LEFT

  mov dh, 00h
  mov dl, 40
__COLOR_RIGHT:
  ; Move cursor
  mov ah, 02h
  mov bh, 00h
  int 10h

  ; Write whitespace
  mov ah, 09h
  mov al, ' '
  mov bh, 00h
  mov bl, 01111010b
  mov cx, 40
  int 10h
  inc dh
  cmp dh, 19h
  jnz __COLOR_RIGHT

  ; Continuously accept input
__RECEIVE:
  lea si, left_col_pos
  lea di, current_row
  mov al, [si]
  cmp al, 39
  jnz __SAME_LINE

  ; Handle line updates
  mov al, [di]
  inc al
  mov [di], al

  mov al, [si]
  mov al, 0
  mov [si], al

  lea si, right_col_pos
  mov al, [si]
  mov al, 40
  mov [si], al

  lea si, left_col_pos
__SAME_LINE:
  ; Set cursor for left column
  mov ah, 02h
  mov dh, [di]
  mov dl, [si]
  mov bh, 00h
  int 10h

  ; Read character
  mov ah, 01h
  int 21h
  ; Is this an exclamation
  cmp al, '!'
  jnz __NEXT_TEST
  ; If it is, state machine moves forward
  lea si, set
  mov ah, 1
  mov [si], ah
  ; Display this exclamation
  jmp __DISPLAY

__NEXT_TEST:
  ; If it is not, is it a '#'?
  cmp al, '#'
  jnz __DISPLAY_PRE
  ; Check if the state machine was already forward (i.e previous was !)
  lea si, set
  mov ah, 1
  cmp [si], ah
  ; Exit if yes
  jz __EXIT

__DISPLAY_PRE:
  ; If not, this is a '#' not preceded by a '!'. Reset state machine
  lea si, set
  mov ah, 0
  mov [si], ah

__DISPLAY:
  lea si, left_col_pos
  lea di, current_row
  ; Set cursor for left column
  mov ah, 02h
  mov dh, [di]
  mov dl, [si]
  mov bh, 00h
  int 10h

  ; Write
  mov ah, 09h
  mov bh, 00h
  mov bl, 00011110b
  mov cx, 1
  int 10h

  ; Upgrade left column position
  mov cl, [si]
  inc cl
  mov [si], cl

  lea si, right_col_pos
  ; Set cursor for right column
  mov ah, 02h
  mov dh, [di]
  mov dl, [si]
  mov bh, 00h
  int 10h

  ; Write
  mov ah, 09h
  mov bh, 00h
  mov bl, 01111010b
  mov cx, 1
  int 10h

  ; Update right column position
  mov cl, [si]
  inc cl
  mov [si], cl

  jmp __RECEIVE

__EXIT:

.exit
end

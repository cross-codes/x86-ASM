.model tiny
.data
  prompt_msg db "Enter the hexadecimal no$"
  res_msg    db "The number of ones in the digit : $"
  res        db ?

.code
.startup
  ; Display prompt message
  lea dx, prompt_msg
  mov ah, 09h
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Read single digit -> store in bl
  mov ah, 01h
  int 21h
  mov bl, al
  sub bl, '0'

  ; Set up a mask
  mov al, 1
  mov cx, 4
  lea di, res
  mov dl, 0
  mov BYTE PTR[di], dl
__MASK:
  mov dl, bl
  AND dl, al
  cmp dl, 0
  je __NEXT_MASK

  inc BYTE PTR[di]

__NEXT_MASK:
  shl al, 1
  dec cx
  jnz __MASK

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Display result message
  lea dx, res_msg
  mov ah, 09h
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Print result
  mov al, '0'
  add [di], al
  mov dl, [di]
  mov ah, 02h
  int 21h

.exit
end

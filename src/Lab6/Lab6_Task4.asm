.model tiny
.data
  fname      db "task1.txt", 0
  handle     dw ?

  result     db 200 dup(24h)

.code
.startup
  ; Get file handle for existing file
  mov ah, 3dh
  mov al, 0
  lea dx, fname
  int 21h

  mov handle, ax

  ; Push back character by character
  mov ah, 3fh
  mov bx, handle
  mov cx, 1
  lea dx, result

__PUSH_BACK:
  mov ah, 3fh
  int 21h
  cmp ax, 0
  jz __DISPLAY
  inc dx
  jmp __PUSH_BACK

__DISPLAY:
  ; Display file contents
  lea dx, result
  mov ah, 09h
  int 21h

  ; Close file handle
  mov ah, 3eh
  mov bx, handle
  int 21h

.exit
end

.model tiny
.data
  fname      db "task1.txt", 0
  handle     dw ?

  bytes      equ 45
  result     db 200 dup(24h)

.code
.startup
  ; Get file handle for existing file
  mov ah, 3dh
  mov al, 0
  lea dx, fname
  int 21h

  mov handle, ax

  ; Transfer contents
  mov ah, 3fh
  mov bx, handle
  mov cx, bytes
  lea dx, result
  int 21h

  ; Print contents
  lea dx, result
  mov ah, 09h
  int 21h

  ; Close file handle
  mov ah, 3eh
  mov bx, handle
  int 21h

.exit
end

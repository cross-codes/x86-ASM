.model tiny
.data
  fname      db "task1.txt", 0
  handle     dw ?

  hostel     db "Budh Bhawan"
  hostel_len equ 11

  NL         db 0ah
  NL_len     equ 1

  room       db "1163"
  room_len   equ 4

.code
.startup
  ; Get file handle for existing file
  mov ah, 3dh
  mov al, 2
  lea dx, fname
  int 21h

  mov handle, ax

  ; Move file pointer to the end
  mov ah, 42h
  mov al, 2
  mov bx, handle
  mov dx, 00h
  mov cx, 00h
  int 21h

  ; Write '\n' onto file handle
  mov ah, 40h
  mov bx, handle
  mov cx, NL_len
  lea dx, NL
  int 21h

  ; Write hostel onto file handle
  mov ah, 40h
  mov bx, handle
  mov cx, hostel_len
  lea dx, hostel
  int 21h

  ; Write '\n' onto file handle
  mov ah, 40h
  mov bx, handle
  mov cx, NL_len
  lea dx, NL
  int 21h

  ; Write room onto file handle
  mov ah, 40h
  mov bx, handle
  mov cx, room_len
  lea dx, room
  int 21h


  ; Close file handle
  mov ah, 3eh
  mov bx, handle
  int 21h

.exit
end

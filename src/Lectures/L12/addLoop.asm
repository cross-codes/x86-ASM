.model tiny
.data
.code
.startup
  mov ax, 6000h
  mov ds, ax
  mov [2000h], 3fh
  mov [2001h], 0feh
  mov [2002h], 0fdh
  mov [2003h], 02h

.exit
end

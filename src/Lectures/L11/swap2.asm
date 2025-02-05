.model tiny
.data
.code
.startup
  mov di, 2000h
  mov si, 10h
  mov al, ds:[bx + di]
  mov di, 20h
  mov ds:[bx + di], al

.exit
end

.model tiny
.data
.code
.startup
  mov ax, 2000h
  mov ds, ax

  mov si, 4000h
  mov di, 5000h

  mov bx, ds:[si]
  mov dx, ds:[di]

  mov ds:[si], dx
  mov ds:[di], bx

.exit
end

.model tiny

.data
  data1 db 23
  data2 dw 9999h
  data3 dw 9999
  array dw 01, 02, 03, 04, 05, 06, 07, 08

.code
.startup
  mov bx, data2
  mov cx, data3
  mov data1, bl
  mov dl, data1
  mov di, 0002h
  mov ax, array[di]

.exit
end

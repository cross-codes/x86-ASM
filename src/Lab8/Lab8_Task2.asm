.model tiny
.data

.code
.startup
  ; Set display mode
  mov ah, 00h
  mov al, 12h
  int 10h

  ; Fill upper side
  mov cx, 79
  mov dx, 70
__UPPER:
  inc cx
  cmp cx, 181
  jz __RIGHT_PRE
  mov ah, 0ch
  mov al, 00001100b
  int 10h
  jmp __UPPER

__RIGHT_PRE:
  mov cx, 180
  mov dx, 69

__RIGHT:
  inc dx
  cmp dx, 151
  jz __BOTTOM_PRE
  mov ah, 0ch
  mov al, 00001100b
  int 10h
  jmp __RIGHT

__BOTTOM_PRE:
  mov cx, 181
  mov dx, 150

__BOTTOM:
  dec cx
  cmp cx, 79
  jz __LEFT_PRE
  mov ah, 0ch
  mov al, 00001100b
  int 10h
  jmp __BOTTOM

__LEFT_PRE:
  mov cx, 80
  mov dx, 151

__LEFT:
  dec dx
  cmp dx, 69
  jz __COMPLETE
  mov ah, 0ch
  mov al, 00001100b
  int 10h
  jmp __LEFT

__COMPLETE:
  ; Blocking function
  mov ah, 07h
__BLOCK:
  int 21h
  cmp al, 'a'
  jnz __BLOCK

.exit
end

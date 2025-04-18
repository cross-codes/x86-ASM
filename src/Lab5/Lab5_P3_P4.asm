.model tiny
.data
  dat1    db "hello12345world67890"
  len1    equ 20

  prompt  db "Enter the string to be compared$"
  success db "Matching string found$"
  fail    db "Matching string not found$"

  max_len db 5
  str_len db ?
  input   db 6 dup(24h)

.code
.startup
  ; Display prompt
  lea dx, prompt
  mov ah, 09h
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Read input
  lea dx, max_len
  mov ah, 0ah
  int 21h

  ; Compare continuous segments in the original
  mov cx, len1
  sub cl, str_len
  inc cl
  mov bx, 0

__COMPARE:
  lea si, dat1
  add si, bx
  lea di, input
  mov dl, str_len
  mov dh, 00h

__REPEAT:
  mov al, BYTE PTR[si]
  cmp BYTE PTR[di], al
  jz __NEXT_ITERATION
  jmp __INCREMENT_IDX

__NEXT_ITERATION:
  inc di
  inc si
  dec dx
  jnz __REPEAT
  jmp __SUCCESS

__INCREMENT_IDX:
  inc bx
  dec cx
  jnz __COMPARE
  jmp __FAIL

__SUCCESS:
  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Print success prompt
  lea dx, success
  mov ah, 09h
  int 21h
  jmp __TERMINATE

__FAIL:
  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Print failure prompt
  lea dx, fail
  mov ah, 09h
  int 21h

__TERMINATE:

.exit
end

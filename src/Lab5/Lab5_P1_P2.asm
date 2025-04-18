.model tiny
.data
  challenge  db "Enter a 5-digit number$"
  odd_msg    db "Odd and $"
  even_msg   db "Even and $"
  negative   db "negative$"
  positive   db "positive$"
  repeat_msg db "Do you want to enter another number? (Y/N)$"
  exit_msg   db "Exiting...$"

  max_digits db 6
  digits     db ?
  number     db 7 dup(24h)

.code
.startup
__CHALLENGE:
  ; Display prompt
  lea dx, challenge
  mov ah, 09h
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Read input
  lea dx, max_digits
  mov ah, 0ah
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Convert to int
  mov cl, digits
  mov ch, 00h
  lea si, number

__TRANSFORM:
  mov al, BYTE PTR[si]
  sub al, '0'
  mov BYTE PTR[si], al
  inc si
  dec cx
  jnz __TRANSFORM

  ; Check parity
  lea si, number
  mov cl, digits
  mov ch, 00h
  add si, cx
  dec si
  mov al, BYTE PTR[si]
  AND al, 01
  cmp al, 01
  jz __ODD
  jmp __EVEN

__ODD:
  ; Display odd prompt
  lea dx, odd_msg
  mov ah, 09h
  int 21h
  jmp __SIGN

__EVEN:
  ; Display even prompt
  lea dx, even_msg
  mov ah, 09h
  int 21h

__SIGN:
  ; Check sign
  lea si, number
  mov al, [si]
  cmp al, 08
  jge __NEGATIVE
  jmp __POSITIVE

__NEGATIVE:
  ; Display negative prompt
  lea dx, negative
  mov ah, 09h
  int 21h
  jmp __QUERY

__POSITIVE:
  ; Display positive prompt
  lea dx, positive
  mov ah, 09h
  int 21h

__QUERY:
  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Display repeat message
  lea dx, repeat_msg
  mov ah, 09h
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Read character with echo
  mov ah, 01h
  int 21h

  cmp al, 'Y'
  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h
  jz __CHALLENGE

  lea dx, exit_msg
  mov ah, 09h
  int 21h

.exit
end

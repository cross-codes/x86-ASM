.model tiny
.data
  string_prompt db "Enter a string with maximum 20 characters$"
  result_prompt db "The encrypted string is $"

  max_len       db 21
  len           db ?
  string1       db 22 dup(24h)

  encrypted     db 22 dup(24h)
  shifter       db 12

.code
.startup
  ; Display prompt
  lea dx, string_prompt
  mov ah, 09h
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Read input string
  lea dx, max_len
  mov ah, 0ah
  int 21h

  ; Reverse input into encrypted
  lea si, string1
  lea di, encrypted

  mov cl, len
  mov ch, 00h
  add si, cx
  dec si

__TRANSFER:
  mov al, BYTE PTR[si]
  mov BYTE PTR[di], al
  inc di
  dec si
  dec cl
  jnz __TRANSFER

  ; Flip and rotate each byte by an amount
  lea si, encrypted
  mov bl, len
  mov bh, 00h

  mov cl, shifter
  mov ch, 00h

__TRANSFORM:
  mov al, BYTE PTR[si]
  NOT al
  ROR al, cl
  mov BYTE PTR[si], al
  inc si
  dec bx
  jnz __TRANSFORM

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Display result prompt
  lea dx, result_prompt
  mov ah, 09h
  int 21h

  ; Display encrypted string
  lea dx, encrypted
  mov ah, 09h
  int 21h

.exit
end

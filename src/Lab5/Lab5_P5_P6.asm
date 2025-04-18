.model tiny
.data
  challenge_prompt db "Enter 10 Hexadecimal numbers$"
  even_trigger     db "The even numbers are: $"
  odd_trigger      db "The odd numbers are: $"

  odd_numbers      db 11 dup(24h)
  even_numbers     db 11 dup(24h)

  max_num          db 11
  num_cnt          db ?
  nums             db 12 dup(24h)

.code
.startup
  ; Display entry prompt
  lea dx, challenge_prompt
  mov ah, 09h
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Read input
  lea dx, max_num
  mov ah, 0ah
  int 21h

  ; To maintain parity, no need to change numbers, but subtract letters by 1
  lea si, nums
  mov cl, num_cnt
  mov ch, 00

  lea bx, odd_numbers
  lea di, even_numbers

__APPEND:
  mov al, BYTE PTR[si]
  cmp al, 41
  jl __TEST
  dec al

__TEST:
  AND al, 1
  cmp al, 00h
  jz __EVEN

  mov al, BYTE PTR[si]
  mov BYTE PTR[di], al
  inc di
  jmp __NEXT

__EVEN:
  mov al, BYTE PTR[si]
  mov BYTE PTR[bx], al
  inc bx

__NEXT:
  inc si
  dec cx
  jnz __APPEND

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Display even numbers
  lea dx, even_trigger
  mov ah, 09h
  int 21h

  lea dx, even_numbers
  mov ah, 09h
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Display odd numbers
  lea dx, odd_trigger
  mov ah, 09h
  int 21h

  lea dx, odd_numbers
  mov ah, 09h
  int 21h

.exit
end

.model tiny
.data
  msg_prompt       db "Enter the number of characters$"
  word_prompt      db "Enter the word$"
  palindrome_msg   db "Entered word is a palindrome$"
  palindrome_f_msg db "Entered word is not a palindrome$"
  repeat_msg       db "Do you want to enter another word (Y/N)?$"
  exit_msg         db "Exiting...$"

  max_num          db 7
  num_cnt          db ?
  input            db 8 dup(24h)

.code
.startup
__CHALLENGE:
  ; Display message prompt
  lea dx, msg_prompt
  mov ah, 09h
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Read word count (discard)
  mov ah, 01h
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Display word prompt
  lea dx, word_prompt
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

  ; Obtain maximum forward and backward distance and load two pointers
  mov cl, num_cnt
  mov ch, 00h

  lea si, input
  lea di, input
  add di, cx
  dec di

  shr cx, 1

  ; Iterate
__COMPARE:
  mov al, [si]
  mov bl, [di]
  cmp al, bl
  jz __NEXT
  jmp __BAD

__NEXT:
  inc si
  dec di
  dec cx
  jnz __COMPARE
  jmp __GOOD

__BAD:
  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Display message
  lea dx, palindrome_f_msg
  mov ah, 09h
  int 21h

  jmp __REPEAT

__GOOD:
  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Display message
  lea dx, palindrome_msg
  mov ah, 09h
  int 21h

  ; Test if user wants to go again
__REPEAT:
  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Print repeat message
  lea dx, repeat_msg
  mov ah, 09h
  int 21h

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Read option
  mov ah, 01h
  int 21h

  cmp al, 'Y'
  jz __REPEAT_CHALLENGE

  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h

  ; Print exit message
  lea dx, exit_msg
  mov ah, 09h
  int 21h
  jmp __TERMINATE

__REPEAT_CHALLENGE:
  ; Print newline
  mov dl, 0ah
  mov ah, 02h
  int 21h
  jmp __CHALLENGE

__TERMINATE:

.exit
end

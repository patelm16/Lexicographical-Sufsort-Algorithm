%include "asm_io.inc"

section .data
 
e: db 'hello', 0

section .bss

N: resb 31
r: resd 1

section .text
global asm_main

asm_main:
   enter 0, 0
   pusha
   mov eax, 0
   mov [N], dword 30
   mov [r], dword 2
   mov eax, [N]
   sub eax, [r]
   mov eax, dword [e]
   call  print_string
   popa
   leave
   ret  

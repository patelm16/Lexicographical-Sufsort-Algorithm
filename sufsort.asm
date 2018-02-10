%include "asm_io.inc"

section .data

err1: db "ERROR: Program expects 2 arguments ex. 'sufsort aabaabba'", 10,0
err2: db "String should be of length 1 to 30", 10,0
err3: db "String should consist of only characters '0', '1', or '2'", 10,0


section .bss

temp: resd 1
N: resd 1
X resb 30

section .text
	global asm_main

asm_main:
	enter 0,0
	pusha

	cmp dword [ebp+8], dword 2
	jne error1

	mov eax, dword [ebp+12]
	add eax, 4
	mov ebx, dword [eax]

	mov ecx, dword 0
	jmp endString
	jmp asm_main_end

error1:
	mov eax, err1
	call print_string
	jmp asm_main_end

error2:
	mov eax, err2
	call print_string
	jmp asm_main_end

error3: 
	mov eax, err3
	call print_string
	jmp asm_main_end

endString:
	cmp byte [ebx], 0
	je lengthCheck
	jmp characterCheck

characterCheck:
	cmp byte [ebx], '0'
	je incrementCounter
	cmp byte [ebx], '1'
	je incrementCounter
	cmp byte [ebx], '2'
	je incrementCounter
	jmp error3

incrementCounter:
	inc ecx
	inc ebx
	jmp endString

lengthCheck:
	cmp ecx, dword 30
	jg error2
	mov [N], ecx
	mov ecx, dword 0
	mov eax, dword [ebp+12]
	add eax, 4
	mov ebx, dword [eax]
	jmp createArray

createArray:
	cmp byte [ebx], 0
	je displayString
	mov al, byte [ebx]
	mov [X+ecx], al
	inc ebx
	inc ecx
	jmp createArray

displayString:
	mov eax, X
	call print_string
	jmp asm_main_end		

asm_main_end:
	call print_nl
	popa
	leave
	ret


;completed steps 1-7

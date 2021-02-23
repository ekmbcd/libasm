; void ft_list_push_front(t_list **begin_list, void *data);
;								rdi				  rsi

section .text
		global _ft_list_push_front
		extern _malloc
		extern ___error

_ft_list_push_front:
		push	rdi					; put begin_list on stack
		push	rsi
		mov		rdi, 16				; rdi = 16
		xor		rax, rax
		call	_malloc				; malloc(16)
		cmp		rax, 0
		je		malloc_err
		pop		rsi
		pop		rdi
		cmp		rax, 0				; malloc fail
		je		return
		mov		[rax], rsi			; put data in node
		mov		r9, [rdi]			; save *begin_list in r9
		mov		[rax + 8], r9		; set new->next to r9
		mov		[rdi], rax			; new node at beginning

return:
		ret

malloc_err:
		call ___error		; error puts the address of errno in rax
		mov r10, 12			; 12 = ENOMEM
		mov [rax], r10
		mov rax, 0
		ret

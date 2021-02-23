; void 		ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void*));
;	rdi = **begin			r9
;	rsi = *data_ref			r10
;	rdx = *cmp()			r11
;	rcx = *free_fct()		r12
;	r13  = current
;	r14  = previus

section .text
		global _ft_list_remove_if
		extern _free

_ft_list_remove_if:
		mov		r9, rdi				; r9 = **begin
		mov		r10, rsi			; r10 = *data_ref
		mov		r11, rdx			; r11 = *cmp()
		mov		r12, rcx			; r12 = *free_fct()
		mov		r13, [rdi]			; current = *begin
		xor		r14, r14			; previous = 0

while:
		cmp		r13, 0				; while(current)
		je		return
		push	r9					; push variables
		push	r10
		push	r11
		push	r12
		push	r13
		push	r14
		mov		rdi, [r13]			; rdi = current->data
		mov		rsi, r10			; rsi = data_ref
		call	r11					; cmp()
		pop		r14					; pop variables
		pop		r13
		pop		r12
		pop		r11
		pop		r10
		pop		r9
		cmp		rax, 0
		je		delete_node			; delete node
		mov		r14, r13			; previous = current
		mov		r13, [r13 + 8]		; current = current->next
		jmp		while

delete_node:

		mov		rdi, [r13 + 8]		; rdi = current->next
		cmp		r14, 0				; if (previous == 0)
		je		first_node
		mov		[r14 + 8], rdi		; previous->next = current->next;
		jmp		free_node

first_node:
		mov		[r9], rdi			; *begin_list = current->next;
		jmp		free_node

free_node:
		push	r9					; push variables
		push	r10
		push	r11
		push	r12
		push	r14
		push	r13
		mov		rdi, [r13]			; rdi = current->data
		call	r12					; free_fct()
		pop		r13					; pop current
		mov		rdi, r13			; rdi = current
		mov		r13, [r13 + 8]		; current = current->next
		push	r13
		push	rsp					; align the stack :`)
		call	_free				; free(current)
		pop		rsp
		pop		r13
		pop		r14					; pop variables
		pop		r12
		pop		r11
		pop		r10
		pop		r9

		jmp		while

return:
		ret

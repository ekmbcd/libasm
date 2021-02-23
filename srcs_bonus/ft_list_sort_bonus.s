; void 		ft_list_sort(t_list **begin_list, int (*cmp)());
;	rdi = **begin_list
;	rsi = *cmp
;	rcx = has_changed

section .text
		global _ft_list_sort

_ft_list_sort:
		mov		r9, [rdi]			; ptr = *begin
		mov		r12, rsi			; r12 = *cmp
		mov		r11, rdi			; r11 = **begin

big_while:
;		xor		rcx, rcx
		cmp		r9, 0				; ptr == 0
		je		return
		mov		r10, [r11]			; ptr2 = *begin

small_while:
		mov		rcx, [r10 + 8]		; rcx = ptr2->next
		cmp		rcx, 0				; if(ptr2->next)
		je		end_big
		xor		rsi, rsi			; clear rsi
		xor		rdi, rdi			; clear rdi
		xor		r13, r13			; clear r13
		mov		rdi, [r10]			; rdi = ptr2->data
		mov		r13, [r10 + 8]		; r13 = ptr2->next
		mov		rsi, [r13]			; rsi = ptr2->next->data
		call	r12					; cmp(rdi, rsi)
		cmp		rax, 0				; cmp(rdi, rsi) > 0
		jg		switcheroo

end_small:
		mov		r10, [r10 + 8]		; ptr2 = ptr2->next
		jmp		small_while

end_big:
		mov 	r9, [r9 + 8]
		jmp		big_while			; ptr = ptr->next;

switcheroo:
		mov		[r10], rsi			; ptr2->data = ptr2->next->data;
		mov		[r13], rdi			; ptr2->next->data = ptr2->data;
		jmp		end_small

return:
		ret

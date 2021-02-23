; int 		ft_list_size(t_list *begin_list);
;								rdi

section .text
		global _ft_list_size

_ft_list_size:
		xor		rax, rax			; ret = 0

while:
		cmp		rdi, 0				; list = 0
		je		return
		mov		rdi, [rdi + 8]		; list = list->next
		inc		rax					; ret++
		jmp		while

return:
		ret

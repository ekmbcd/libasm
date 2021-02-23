;	int		ft_strcmp(const char *s1, const char *s2);
;							rdi				rsi

section .text
    	global _ft_strcmp

_ft_strcmp:
		mov	rcx, -1					; rcx = -1
		mov rax, 0

while:
		inc	rcx						; rcx++
		mov	r10b, BYTE [rdi + rcx]	; r10b = s1[i]
		mov	r11b, BYTE [rsi + rcx]	; r10b = s2i]
		cmp	r10b, r11b				; s1[i] == s2[i]
		jne return
		cmp r10b, 0					; s1[i] = s2[i] = 0
		je	return
		jmp	while

return:
		mov al, r10b
		mov bl, r11b
		sub rax, rbx				; s1[i] - s2[i]
		ret

; char *		ft_strdup(const char *s1);

section .text
    	global _ft_strdup
		extern ___error
		extern _ft_strlen
		extern _ft_strcpy
		extern _malloc

_ft_strdup:
		call	_ft_strlen
		inc rax
		push rdi				; put str on the stack
		mov rdi, rax			; rdi = len
		inc rdi
		call	_malloc			; rax = malloc
		cmp rax, 0
		je	malloc_err
		pop r11					; get str back from the stack
		mov rdi, rax			; rdi = dest
		mov rsi, r11			; rsi = src
		call _ft_strcpy
		ret

malloc_err:
		call ___error			; error puts the address of errno in rax
		mov r10, 12				; 12 = ENOMEM
		mov [rax], r10
		mov rax, 0
		ret

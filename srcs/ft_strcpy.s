;	char		*ft_strcpy(char * dst, const char * src)
;	{
;		int i = -1;
;		if(dst == 0)
;			return (0);
;		while(src[i++])
;			dst[i] = src[i];
;		dst[i] = 0;
;		return (dst);
;	}

section .text
    	global _ft_strcpy

_ft_strcpy:
		mov	rcx, -1					; rcx = -1
		cmp	rsi, 0					; if (dst == 0)
		je	error

while:
		inc	rcx						; rcx++
		mov	r10b, BYTE [rsi + rcx]	; r10b = str[i]
		cmp	r10b, 0					; if (src[i] == 0)
		je	terminate
		mov BYTE [rdi + rcx], r10b	; dst[i] = r10b
		jmp	while

terminate:
		mov BYTE [rdi + rcx], 0		; dst[i] = 0
		mov	rax, rdi
		ret							; return

error:
		mov rax, 0
		ret

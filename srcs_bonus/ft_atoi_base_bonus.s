; int		ft_atoi_base(char *str, char *base)
;							rdi			rsi

;	res 			=	r10
;	i 				=	rcx
;	j				=	r8
;	sign			=	r11
;	1st argument	=	rdi
;	2nd argument	=	rsi
;	return 			=	rax
;	temp char		=	r9
;	pointer			=	r12
;	temp char 2		=	r13
;	len				=	r14

section .text
    	global _ft_atoi_base
		extern _ft_strlen

_ft_atoi_base:
		jmp		check_base

check_base:
		push	rdi
		mov		rdi, rsi					; rsi = base
		call	_ft_strlen					; rax = len
		pop		rdi
		cmp		rax, 2						; exit if len < 2
		jl		error
		mov		r14, rax					; save len in r14
		mov 	rcx, -1						; j = -1

loop_base:
		inc		rcx							; j++
		cmp		rcx, rax					; while j < len
		je		ignore_start				; done loop
		mov		r9b, BYTE[rsi + rcx]		; r9b = base[j]
		cmp		r9b, 43						; base[j] = '+'
		je		error
		cmp		r9b, 45						; base[j] = '-'
		je		error
		mov		r12, rsi					; r12 = base
		add		r12, rcx					; r12 = base + j

loop_base_2:
		inc		r12							; pointer++
		mov		r13b, [r12]
		cmp		r13b, 0						; while *pointer != 0
		je		loop_base
		cmp		r13b, r9b					; if *pointer == base[j]
		je		error						; duplicate char
		jmp		loop_base_2

ignore_start:
		mov		r11, 1						; sign = 1
		mov 	rcx, -1						; i = -1

ignore:
		inc 	rcx							; i++
		cmp		BYTE[rdi + rcx], 32			; ' '
		je		ignore
		cmp		BYTE[rdi + rcx], 9
		je		ignore
		cmp		BYTE[rdi + rcx], 10
		je		ignore
		cmp		BYTE[rdi + rcx], 11
		je		ignore
		cmp		BYTE[rdi + rcx], 12
		je		ignore
		cmp		BYTE[rdi + rcx], 13
		je		ignore
		dec		rcx

ignore_sign:
		inc		rcx
		cmp		BYTE[rdi + rcx], 45			; '-'
		je		change_sign
		cmp		BYTE[rdi + rcx], 43			; '+'
		je		ignore_sign

decrement_i:
		dec 	rcx							; decrement only once
		mov		rax, 0						; set return to 0

check_char:
		inc		rcx							; i++
		cmp		BYTE[rdi + rcx], 0			; str[i] = 0
		je		done
		mov		r9, -1						; j = -1
		mov		r13b, BYTE[rdi + rcx]		; r13b = str[i]

find_in_base:
		inc		r9							; j++
		cmp		BYTE[rsi + r9], 0			; base[j] = 0
		je		error						; wrong char in str
		cmp		BYTE[rsi + r9], r13b		; base[j] == str[i]
		je		convert						; good char
		jmp		find_in_base

convert:
		mul		r14							; ret *= len
		add		rax, r9						; ret += j
		jmp		check_char					; go back to the loop

done:
		imul	r11							; ret *= sign
		ret

change_sign:
		cmp		r11, 1						; if sign positive
		je		negative_sign
		mov		r11, 1						; if sign negative
		jmp		ignore_sign

negative_sign:
		mov r11, -1
		jmp ignore_sign

error:
		mov rax, 0							; return 0 if error
		ret

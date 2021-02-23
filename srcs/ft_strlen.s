; int ft_strlen(char *str)
; {
; 	int i = 0;
;	if (!str)
;		return(0);
;	while(str[i])
;		i++;
;	return(i);
; }
;	rax = ret
;	rdi = str


section .text
    	global _ft_strlen

_ft_strlen:
		mov rax, 0					;i = 0;
;		cmp rdi, 0
;		je	exit

loop:
		cmp BYTE [rdi + rax], 0		;str[i] == 0
		je	exit					;if 0 exit loop
		inc rax						;i++
		jmp	loop					;back to loop

exit:
		ret							;return(i)

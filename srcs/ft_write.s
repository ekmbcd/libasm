;	ssize_t	ft_write(int fildes, const void *buf, size_t nbyte);
; 	ft_write (rdi, rsi, rdx)

section .text
    	global _ft_write
		extern ___error

_ft_write:
		mov	rax, 0x2000004
		syscall
		jc error
		ret

error:
		push rax
		call ___error		; error puts the address of errno in rax
		pop r10
		mov [rax], r10
		mov rax, -1
		ret

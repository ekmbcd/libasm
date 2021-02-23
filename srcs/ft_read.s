;	ssize_t		ft_read(int fildes, void *buf, size_t nbyte);
; 	ft_read (rdi, rsi, rdx)

section .text
    	global _ft_read
		extern ___error

_ft_read:
		mov	rax, 0x2000003
		syscall
		jc error
		ret

error:
		push rax
		call ___error
		pop r10
		mov [rax], r10
		mov rax, -1
		ret

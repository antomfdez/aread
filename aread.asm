SECTION .data

SECTION .bss

ByteBuff resb 256

SECTION .text

global _start
_start:
	nop			
	cmp qword [rsp], 2	
	jl Exit		
			
	;opening the file
	mov rax, 2				
	mov rdi, [rsp+16]	;placing argv[1] in rdi for syscalls
	mov rsi, 0		;setting flags to 0, read only
	mov rdx, 0		
	syscall			
	cmp rax, 0		;check for errors on opening file
	jl Error		
	mov rbx, rax		

read:
	mov rax, 0		
	mov rdi, rbx	
	mov rsi, ByteBuff	
	mov rdx, 256		
	syscall			
	cmp rax, 0		
	jl Error		
	jne print	
				
	;close file and jump to exit
	mov rax, 3		
	mov rdi, rbx		
	syscall			
	cmp rax, 0		
	jl Error		
	jmp NoError		

print:	
	mov rdx, rax		
	mov rax, 1		
	mov rdi, 1		
	mov rsi, ByteBuff	
	syscall			
	cmp rax, 0		
	jl Error	
	jmp read		
Error:
	mov rdi, rax		
	jmp Exit		
NoError:
	mov rdi, 0		
Exit:
	mov rax, 60		;specify exit syscall
	syscall			

# x86-64 Assembly Implementation for CS201 HW3
# Function: sumOfPowers(int n)
# Calculates: 1^2 + 2^2 + 3^2 + ... + n^2
# Parameter: n in RDI
# Returns: sum in RAX

.section .note.GNU-stack,"",@progbits
.text
.globl sumOfPowers

sumOfPowers:
    pushq   %rbp              # Save frame pointer
    movq    %rsp, %rbp        # Set up frame pointer
    
    # Initialize
    movq    $0, %rax          # sum = 0 (return value)
    movq    $1, %rcx          # i = 1 (loop counter)
    
    # Check if n <= 0
    cmpq    $0, %rdi
    jle     sumOfPowers_done
    
sumOfPowers_loop:
    # Calculate i^2
    movq    %rcx, %rdx        # Copy i to RDX
    imulq   %rdx, %rdx        # i^2 = i * i
    
    # Add to sum
    addq    %rdx, %rax        # sum += i^2
    
    # Increment i
    incq    %rcx              # i++
    
    # Check if i <= n
    cmpq    %rdi, %rcx
    jle     sumOfPowers_loop
    
sumOfPowers_done:
    popq    %rbp              # Restore frame pointer
    ret


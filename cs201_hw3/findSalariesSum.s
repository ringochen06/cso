# x86-64 Assembly Implementation for CS201 HW3
# Function: findSalariesSum(EMPLOYEE e[], int size)
# Finds the sum of salaries in a given array of employees
# Parameters: e[] in RDI, size in RSI
# Returns: sum in RAX
# EMPLOYEE struct: {char name[8]; int salary;}
# name is at offset 0, salary is at offset 8
# Each EMPLOYEE is 12 bytes (8 bytes for name + 4 bytes for salary)

.section .note.GNU-stack,"",@progbits
.text
.globl findSalariesSum

findSalariesSum:
    pushq   %rbp              # Save frame pointer
    movq    %rsp, %rbp        # Set up frame pointer
    
    # Initialize
    movq    $0, %rax          # sum = 0
    movq    $0, %rcx          # i = 0 (loop counter)
    
    # Check if size <= 0
    cmpq    $0, %rsi
    jle     findSalariesSum_done
    
findSalariesSum_loop:
    # Calculate address of e[i].salary
    # e[i] is at base + i * 12
    movq    %rcx, %rdx        # Copy i
    imulq   $12, %rdx         # i * 12 (size of EMPLOYEE)
    addq    %rdi, %rdx        # RDX = address of e[i]
    addq    $8, %rdx          # RDX = address of e[i].salary (offset 8)
    
    # Load salary
    movl    (%rdx), %r8d      # R8D = e[i].salary
    
    # Add to sum (sign-extend to 64-bit)
    movslq  %r8d, %r8         # Sign-extend to 64-bit
    addq    %r8, %rax         # sum += e[i].salary
    
    # Increment i
    incq    %rcx              # i++
    
    # Check if i < size
    cmpq    %rsi, %rcx
    jl      findSalariesSum_loop
    
findSalariesSum_done:
    popq    %rbp              # Restore frame pointer
    ret


# x86-64 Assembly Implementation for CS201 HW3
# Function: findPaymentsSum(CUSTOMER* c, int num_of_payments)
# Finds the sum of all payments made by a given customer
# Parameters: c in RDI, num_of_payments in RSI
# Returns: sum in RAX
# payments array starts at offset 8 (4 bytes for id + 4 bytes for age)

.section .note.GNU-stack,"",@progbits
.text
.globl findPaymentsSum

findPaymentsSum:
    pushq   %rbp              # Save frame pointer
    movq    %rsp, %rbp        # Set up frame pointer
    
    # Initialize
    movq    $0, %rax          # sum = 0
    movq    $0, %rcx          # i = 0 (loop counter)
    
    # Check if num_of_payments <= 0
    cmpq    $0, %rsi
    jle     findPaymentsSum_done
    
    # payments array starts at offset 8
    leaq    8(%rdi), %rdx     # RDX = address of payments[0]
    
findPaymentsSum_loop:
    # Load payments[i] (each int is 4 bytes)
    movl    (%rdx,%rcx,4), %r8d  # R8D = payments[i]
    
    # Add to sum (sign-extend to 64-bit)
    movslq  %r8d, %r8         # Sign-extend to 64-bit
    addq    %r8, %rax         # sum += payments[i]
    
    # Increment i
    incq    %rcx              # i++
    
    # Check if i < num_of_payments
    cmpq    %rsi, %rcx
    jl      findPaymentsSum_loop
    
findPaymentsSum_done:
    popq    %rbp              # Restore frame pointer
    ret


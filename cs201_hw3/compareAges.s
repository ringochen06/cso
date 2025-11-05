# x86-64 Assembly Implementation for CS201 HW3
# Function: compareAges(CUSTOMER* a, CUSTOMER* b)
# Tests if a->age == b->age
# Parameters: a in RDI, b in RSI
# Returns: 1 if equal, 0 otherwise in RAX
# CUSTOMER struct: {int id; int age; int payments[5];}
# age is at offset 4 (4 bytes for id)

.section .note.GNU-stack,"",@progbits
.text
.globl compareAges

compareAges:
    pushq   %rbp              # Save frame pointer
    movq    %rsp, %rbp        # Set up frame pointer
    
    # Load a->age (offset 4)
    movl    4(%rdi), %eax     # EAX = a->age
    
    # Compare with b->age (offset 4)
    cmpl    4(%rsi), %eax     # Compare a->age with b->age
    
    # Set return value based on comparison
    sete    %al               # Set AL to 1 if equal, 0 otherwise
    movzbl  %al, %eax         # Zero-extend to 32-bit (clears upper 32 bits of RAX)
    
    popq    %rbp              # Restore frame pointer
    ret


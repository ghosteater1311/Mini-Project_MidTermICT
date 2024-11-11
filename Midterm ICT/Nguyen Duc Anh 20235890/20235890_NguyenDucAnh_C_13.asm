.data
	A: .space 32	# String A	
	B: .space 32	# String B	
.text
start:
    # Get input string A from keyboard
	li a7, 8 		
	la a0, A		
	li a1, 32		
	ecall

    # Get input string B from keyboard			
	li a7, 8 		
	la a0, B		
	li a1, 32		
	ecall			

    # Set up pointers for iterating through A and B
    la t0, A              # t0 points to start of string A
    la t1, B              # t1 points to start of string B

    loop_A:
        lb t2, 0(t0)            # Load a byte from string A into t2
        beq t2, zero, end       # If it's null (end of string A), we're done

        # Check if t2 is a lowercase letter (between 'a' and 'z')
        li t5, 'a'              # Load 'a' into t5
        slt t6, t2, t5          # if t2 < 'a', t6 = 1 or 0
        bne t6, zero, next_A    # If t2 < 'a', skip to next_A

        li t5, 'z'              # Load 'z' into t5
        slt t6, t5, t2          # if 'z' < t2, t6 = 1 or 0
        bne t6, zero, next_A    # If 'z' < t2, skip to next_A

        # Check if character in A appears in B
        la t1, B                # Reset t1 to the start of string B
        addi t3, zero, 0        # Clear flag (t3 = 0) to indicate not found in B
    
    loop_B:
        lb t4, 0(t1)              # Load a byte from string B into t4
        beq t4, zero, check_print # If end of B, check flag
        beq t2, t4, found_B       # If char in A matches B, set found flag
        addi t1, t1, 1            # Move to next character in B
        j loop_B                  # Repeat loop for B

    found_B:
        li t3, 1              # Set flag indicating character was found in B

    check_print:
        beq t3, zero, print_char # If not found in B, print char in A
        j next_A              # Otherwise, move to next char in A

    print_char:
        mv a0, t2             # Character to print
        li a7, 11             # Syscall code for putchar
        ecall                 # System Call

    next_A:
        addi t0, t0, 1        # Move to next character in A
        j loop_A              # Repeat loop for A

end:
    li a7, 10             # Syscall code for exit
    ecall                 # Exit the program
    
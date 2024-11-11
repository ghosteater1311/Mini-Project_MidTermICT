    .data
stringA: .ascii "aAbBcCdDeEfFgG\0"       # Example string A
stringB: .ascii "acf\0"           # Example string B

    .text
    .globl _start
_start:
    # Load the base addresses of stringA and stringB
    la t0, stringA        # t0 points to stringA
    la t1, stringB        # t1 points to stringB

loop_A:
    lb t2, 0(t0)          # Load a byte from stringA into t2
    beq t2, zero, end     # If it's null (end of string), we're done
    blt t2, 'a', next_A   # If not a lowercase letter, skip
    bgt t2, 'z', next_A   # If not a lowercase letter, skip

    # Check if character in A appears in B
    la t1, stringB        # Reset t1 to the start of stringB
    mv t3, zero           # Flag to indicate if found in B
loop_B:
    lb t4, 0(t1)          # Load a byte from stringB into t4
    beq t4, zero, check_print # End of B; check if found
    beq t2, t4, found_B   # If char in A matches B, set flag
    addi t1, t1, 1        # Move to next character in B
    j loop_B              # Repeat loop for B

found_B:
    li t3, 1              # Set found flag
check_print:
    beq t3, zero, print_A # If not found in B, print char in A
    j next_A              # Otherwise, move to next char in A

print_A:
    # Print character in A (system call for character output)
    mv a0, t2             # Character to print
    li a7, 11             # Syscall code for putchar
    ecall                 # Make the syscall

next_A:
    addi t0, t0, 1        # Move to the next character in A
    j loop_A              # Repeat loop for A

end:
    li a7, 10             # Syscall code for exit
    ecall                 # Exit the program

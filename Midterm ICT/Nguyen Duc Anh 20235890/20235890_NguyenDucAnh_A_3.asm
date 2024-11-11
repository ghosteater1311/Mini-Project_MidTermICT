.data
    Input_M:    .asciz "Input M: "
    Input_N:    .asciz "Input N: "
    prime_msg:   .asciz "Prime Num: "
    newline:     .asciz "\n"

.text
start:
    # Print Input messenger for M
    la a0, Input_M     
    li a7, 4           
    ecall

    # Input M
    li a7, 5           
    ecall
    addi s0, a0, 0          

    # Print Input messenger for N
    la a0, Input_N
    li a7, 4           
    ecall

    # Input N
    li a7, 5           
    ecall
    addi s1, a0, 0

# *********************************************************************************************************
# Prime Number Checking Algorithms:
# Base Case: if t0 (M) = 2 -> print M
# Even numbers > 2 basically is not the prime number -> ignore
# 1 is the odd number but not the prime number
# To check other numbers: Start from the divisor 3 and only check odd divisors up to sqrt(t0),
# Because any composite number greater than 2 must have at least one factor less than or equal to sqrt(t0).
# Increse the divisor by 2 to skip even numbers.
# *********************************************************************************************************
    
    init_index:
        addi t0, s0, 0  # t0 = M (starting from M)

    check_prime:
        bgt t0, s1, end # Check if t0 > N -> jump to end

        # Case: Check if t0 == 2
        li t2, 2
        beq t0, t2, print_prime

        # Check if t0 < 2 or t0 is even (t0 % 2 == 0)
        li t3, 2
        blt t0, t3, next_num   # If t0 < 2, jump to next number
        rem t4, t0, t3         # t4 = t0 % t3 (M % 2)
        beq t4, zero, next_num # If t0 is even, jump to next number

        # Set divisor to 3 and Bool value to check prime to 1 (true)
        li t1, 3           # Divisor starts at 3
        li t2, 1           # Prime Check value (1 (true) means prime, 0 (false) means not prime)

    is_prime_loop:
        # Break loop if divisor (t1) * divisor (t1) > current number (t0)
        mul t3, t1, t1
        bgt t3, t0, print_prime

        # Check if t0 % t1 == 0
        rem t4, t0, t1
        beq t4, zero, not_prime

        # Increment divisor by 2 (only odd divisors)
        addi t1, t1, 2
        j is_prime_loop

    not_prime:
        li t2, 0 # Set Prime check value to 0 (false) means not prime

    print_prime:
        beq t2, zero, next_num # If Prime check is still 1, print the number

        # Print "Prime Num: "
        la a0, prime_msg
        li a7, 4
        ecall

        # Print the prime number (t0)
        mv a0, t0
        li a7, 1           
        ecall

        # Print newline
        la a0, newline
        li a7, 4           
        ecall

    next_num:
        # Increse t0 and check the next number
        addi t0, t0, 1
        j check_prime

end:
    # Exit the program
    li a7, 10          
    ecall

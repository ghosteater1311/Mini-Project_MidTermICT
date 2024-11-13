.data
    array:   .space 200      # Declare space for 50 integers (4 bytes each)
    msg_and: .asciz " and "               
.text
start:
    # Input n (number of elements)
    li a7, 5
    ecall 

    init_method:
    # Initialize loop to input array elements
        addi t1, a0, 0  # Load number of elements (t1 = n)
        la t0, array    # Load base address of array
        li t2, 0        # Initialize index i = 0

    input_array_loop:
        bge t2, t1, max_adjacency_sum # If i >= n, jump to max_adjacency_sum

        # Read the next array element
        li a7, 5            
        ecall               
        sw a0, 0(t0)        # Store a0 into array[i]
        addi t2, t2, 1      # i = i + 1
        addi t0, t0, 4      # Move to the next element (4 bytes)
        j input_array_loop  # Repeat the loop

    max_adjacency_sum:
        la t0, array           # Reset t0 to the base of the array
        lw t3, 0(t0)           # Load arr[0] into t3
        lw t4, 4(t0)           # Load arr[1] into t4
        add t5, t3, t4         # Initialize max_Adjacentcy_Sum (t5) = arr[0] + arr[1]
        addi t2, t1, -1        # Set t2 = n - 1 for loop limit

    # First loop to find the maximum adjacency sum
    find_max_sum:
        addi t2, t2, -1           # Decrese the index
        blt t2, zero, print_pairs # If i < 0, go to second loop to print pairs

        lw t3, 0(t0)           # Load arr[i] (t3)
        lw t4, 4(t0)           # Load arr[i + 1] (t4)
        add t6, t3, t4         # Calculate arr[i] + arr[i + 1]

        # Check if arr[i] + arr[i + 1] > max_Adjacentcy_Sum
        ble t6, t5, next       # If current sum <= max, skip to next
        add t5, t6, zero       # Update max_Adjacentcy_Sum

    next:
        addi t0, t0, 4         # Move to next element
        j find_max_sum         # Repeat the loop

    print_pairs:
        # Reset t0 to the base of the array for second loop
        la t0, array
        addi t2, t1, -1        # Set t2 = n - 1 for loop limit

    print_loop:
        addi t2, t2, -1        # Decrese the index
        blt t2, zero, end      # If i < 0, end program

        lw t3, 0(t0)           # Load arr[i]
        lw t4, 4(t0)           # Load arr[i + 1]
        add t6, t3, t4         # Calculate arr[i] + arr[i + 1]

        # Check if arr[i] + arr[i + 1] == max_Adjacentcy_Sum
        bne t6, t5, skip_print # If not equal, skip to next iteration

        # Print arr[i] 
        addi a0, t3, 0              
        li a7, 1              
        ecall

        # Print " and "
        la a0, msg_and         
        li a7, 4               
        ecall
        
        # Print arr[i + 1]
        addi a0, t4, 0              
        li a7, 1               
        ecall

        # Print newline
        li a7, 11              
        li a0, 10
        ecall

    skip_print:
        addi t0, t0, 4         # Move to next element
        j print_loop           # Repeat the loop

end:
    # End the program
    li a7, 10
    ecall

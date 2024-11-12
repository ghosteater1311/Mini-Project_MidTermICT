.data
    array:   .space 200      # Declare space for 50 integers (4 bytes each)
    msg_and: .asciz " and "               
.text
start:
    # Input n (number of elements)
    li a7, 5
    ecall 

    init:
    # Initialize loop to input array elements
    addi t1, a0, 0  # Load number of elements (t1 = n)
    la t0, array    # Load base address of array
    li t2, 0        # Initialize index i = 0

    input_array_loop:
        bge t2, t1, max_adjacency_sum # If i >= n, go to compute_max_sum

        # Read the next array element
        li a7, 5            
        ecall               
        sw a0, 0(t0)        # Store a0 into array[i]
        addi t2, t2, 1      # i = i + 1
        addi t0, t0, 4      # Move to the next element (4 bytes)
        j input_array_loop  # Repeat the loop

    max_adjacency_sum:

    find_max_pair:

    next_pair:

    print_result:

end:
    # End the program
    li a7, 10
    ecall

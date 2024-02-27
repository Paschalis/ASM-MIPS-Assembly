    .data
# Initialize the array's space
array:          .word 5, 3, 8, 4, 2, 7
array_size:     .word 6
# Constant strings to be output to the terminal
promptInt:      .asciiz "Please input 6 integers: \n"
resultInt:      .asciiz "The sorted array is: \n"
linefeed:       .asciiz "\n"

    .text
main:
    # prompt for an integer (not needed for this exercise)
        # omitted for brevity

    # initialize N = 6*4 and i = 0
        lw      $t0, array_size    # size of the array
        li      $t1, 0              # outer loop iterator
        li      $t2, 4              # offset

outer_loop:
    bge     $t1, $t0, print_array  # If outer loop iterator >= array size, jump to print_array

    li      $t3, 0                 # Set inner loop iterator to 0

inner_loop:
    bge     $t3, $t0, next_outer   # If inner loop iterator >= array size, jump to next_outer

    lw      $t4, array($t3)        # Load current element
    lw      $t5, array($t3+$t2)    # Load next element

    ble     $t4, $t5, no_swap      # If current element <= next element, jump to no_swap

    # Swap current element with next element
    sw      $t5, array($t3)        # Store next element at current position
    sw      $t4, array($t3+$t2)    # Store current element at next position

no_swap:
    addi    $t3, $t3, 1            # Increment inner loop iterator
    j       inner_loop             # Repeat inner loop

next_outer:
    addi    $t1, $t1, 1            # Increment outer loop iterator
    j       outer_loop             # Repeat outer loop

print_array:
    # Print message indicating the sorted array
    li      $v0, 4                 # Code for print_string
    la      $a0, resultInt         # Load address of result message
    syscall                        # Print result message

    # Print the sorted array
    lw      $t1, 0                 # Reset iterator to 0

print_loop:
    bge     $t1, $t0, end_program  # If iterator >= array size, jump to end_program

    lw      $a0, array($t1)        # Load current element
    li      $v0, 1                 # Code for print_int
    syscall                        # Print current element

    # Print a space
    li      $v0, 4                 # Code for print_string
    la      $a0, linefeed          # Load address of linefeed string
    syscall                        # Print linefeed

    addi    $t1, $t1, 1            # Increment iterator
    j       print_loop             # Repeat print loop

end_program:
    # All done, thank you!
    li      $v0, 10                # Code for exit
    syscall                        # Exit program

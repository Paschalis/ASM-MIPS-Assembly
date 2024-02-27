    .data
# Initialize the array's space
array:          .word 5, 3, 8, 4, 2, 7
array_size:     .word 6
# Constant strings to be output to the terminal
promptInt:      .asciiz "Please input 6 integers: \n"
resultInt:      .asciiz "Sorted array: "
linefeed:       .asciiz "\n"

    .text
main:
    # prompt for an integer
        li      $v0, 4              # code for print_string
        la      $a0, promptInt      # point $a0 to prompt string
        syscall                     # print promptInt

    # initialize N = 6*4 and i = 0
        lw      $t0, array_size    # size of the array
        li      $t1, 0              # outer loop iterator
        li      $t2, 4              # offset

    # Loop to get integers from the user and store them in the array
    # (omitted for brevity)

    # Bubble sort algorithm
    # Outer loop for each pass
outer_loop:
    li      $t3, 1                  # Set $t3 to 1 to indicate no swaps yet
    li      $t4, 0                  # Inner loop iterator
inner_loop:
    bge     $t4, $t0, end_outer     # If inner loop iterator >= array size, exit outer loop
    li      $t5, 0                  # Reset $t5 to 0 for inner loop comparisons
    lw      $t6, array($t4)         # Load current element
    lw      $t7, array($t5)         # Load next element
    bge     $t6, $t7, no_swap       # If current element >= next element, no swap needed
    sw      $t7, array($t4)         # Swap current and next element
    sw      $t6, array($t5)
    li      $t3, 0                  # Set $t3 to 0 to indicate a swap occurred
no_swap:
    addi    $t4, $t4, 1             # Increment inner loop iterator
    addi    $t5, $t5, 1             # Increment inner loop iterator
    j       inner_loop              # Repeat inner loop

end_outer:
    # print out text for the result
        li      $v0, 4              # code for print_string
        la      $a0, resultInt      # point $a0 to result string
        syscall                     # print the result string

    # Print the sorted array
    li      $t8, 0                  # Reset loop iterator
print_loop:
    bge     $t8, $t0, end_print    # If iterator >= array size, exit loop
    lw      $a0, array($t8)         # Load element to print
    li      $v0, 1                  # Code for print_int
    syscall
    li      $v0, 4                  # Code for print_string
    la      $a0, linefeed           # Load linefeed string
    syscall                         # Print linefeed
    addi    $t8, $t8, 1             # Increment loop iterator
    j       print_loop              # Repeat loop

end_print:
    # All done, thank you!
        li      $v0, 10             # code for exit
        syscall                     # exit program

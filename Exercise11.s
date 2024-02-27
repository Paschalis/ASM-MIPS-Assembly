    .data
# Initialize the array's space
array:          .word 5, 3, 8, 4, 2, 7
array_size:     .word 6
# Constant strings to be output to the terminal
promptInt:      .asciiz "Please input 6 integers: \n"
sortedMsg:      .asciiz "The sorted array is: "
linefeed:       .asciiz "\n"

    .text
main:
    # prompt for an integer
        li      $v0, 4              # code for print_string
        la      $a0, promptInt      # point $a0 to prompt string
        syscall                     # print promptInt

    # initialize N = 6*4 and i = 0
        lw      $t0, array_size    # size of the array
        li      $t1, 0              # iterator (outer loop)
        li      $t2, 4              # offset

    # Loop to get integers from the user and store them in the array
    # (omitted for brevity)

    # Bubble sort algorithm
    li      $t4, 1                  # Set flag to 1 to enter first pass
outer_loop:
    beq     $t4, $zero, sorted      # If flag is 0, array is sorted, exit loop
    li      $t4, 0                  # Reset flag to 0

    li      $t1, 0                  # Reset iterator for inner loop
inner_loop:
    bge     $t1, $t0, outer_loop   # If iterator >= array size, exit inner loop
    lw      $t5, array($t1)         # Load current element into $t5
    lw      $t6, array($t1+$t2)     # Load next element into $t6
    ble     $t5, $t6, no_swap       # If current element <= next element, no swap needed

    # Swap elements
    sw      $t6, array($t1)         # Store next element in current position
    sw      $t5, array($t1+$t2)     # Store current element in next position
    li      $t4, 1                  # Set flag to 1 to indicate a swap occurred

no_swap:
    addi    $t1, $t1, 1             # Increment iterator
    j       inner_loop              # Repeat inner loop

sorted:
    # Print out text for the result
    li      $v0, 4                  # Code for print_string
    la      $a0, sortedMsg          # Load address of sorted message
    syscall                         # Print sorted message

    # Print the sorted array
    li      $t1, 0                  # Reset iterator for printing
print_loop:
    bge     $t1, $t0, end_print    # If iterator >= array size, exit print loop
    lw      $a0, array($t1)         # Load current element to print
    li      $v0, 1                  # Code for print_int
    syscall                         # Print current element
    li      $v0, 4                  # Code for print_string
    la      $a0, linefeed           # Load address of linefeed string
    syscall                         # Print linefeed
    addi    $t1, $t1, 1             # Increment iterator
    j       print_loop              # Repeat print loop

end_print:
    # All done, thank you!
    li      $v0, 10                 # Code for exit
    syscall                         # Exit program

    .data
# Initialize the array's space
array:          .word 5, 3, 8, 4, 2, 7
array_size:     .word 6
# Constant strings to be output to the terminal
promptInt:      .asciiz "Please input 6 integers: \n"
resultInt:      .asciiz "The maximum element is: "
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

    # Set $t3 to store the maximum element found so far
    lw      $t3, array              # Load the first element into $t3

    # Loop to find the maximum element in the array
find_max:
    bge     $t1, $t0, end_search    # If iterator >= array size, exit loop
    lw      $t4, array($t1)         # Load current element into $t4
    bgt     $t4, $t3, update_max    # If current element > maximum found so far, update maximum
    addi    $t1, $t1, 1             # Increment iterator
    j       find_max                # Repeat loop

update_max:
    move    $t3, $t4                # Update maximum element
    addi    $t1, $t1, 1             # Increment iterator
    j       find_max                # Continue searching

end_search:
    # Print out text for the result
    li      $v0, 4                  # Code for print_string
    la      $a0, resultInt          # Load address of result string
    syscall                         # Print result string

    # Print the maximum element found
    li      $v0, 1                  # Code for print_int
    move    $a0, $t3                # Load maximum element to print
    syscall

    # Print a line feed
    li      $v0, 4                  # Code for print_string
    la      $a0, linefeed           # Load address of linefeed string
    syscall                         # Print linefeed

    # All done, thank you!
    li      $v0, 10                 # Code for exit
    syscall                         # Exit program

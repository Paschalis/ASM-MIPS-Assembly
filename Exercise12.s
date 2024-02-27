    .data
# Initialize the array's space
array:          .word 5, 3, 8, 4, 2, 7
array_size:     .word 6
target:         .word 4
# Constant strings to be output to the terminal
promptInt:      .asciiz "Please input 6 integers: \n"
notFoundMsg:    .asciiz "Target integer not found in the array.\n"
foundMsg:       .asciiz "Target integer found at index: "
linefeed:       .asciiz "\n"

    .text
main:
    # prompt for an integer (not needed for this exercise)
        # omitted for brevity

    # initialize N = 6*4 and i = 0
        lw      $t0, array_size    # size of the array
        li      $t1, 0              # iterator
        li      $t2, 4              # offset

    # Load the target integer
        lw      $t3, target         # Load target integer into $t3

search_loop:
    bge     $t1, $t0, not_found   # If iterator >= array size, target not found

    lw      $t4, array($t1)       # Load current element into $t4

    # Compare current element with target integer
    beq     $t4, $t3, found       # If current element == target, jump to found label

    addi    $t1, $t1, 1           # Increment iterator
    j       search_loop            # Repeat search loop

found:
    # Print message indicating target integer is found
    li      $v0, 4                 # Code for print_string
    la      $a0, foundMsg          # Load address of found message
    syscall                        # Print found message

    # Calculate and print index where target integer is found
    sub     $t1, $t1, 1            # Decrement iterator to get the index
    li      $v0, 1                 # Code for print_int
    move    $a0, $t1               # Load index into $a0
    syscall                        # Print index

    j       end_program             # Jump to end_program label

not_found:
    # Print message indicating target integer is not found
    li      $v0, 4                 # Code for print_string
    la      $a0, notFoundMsg       # Load address of not found message
    syscall                        # Print not found message

end_program:
    # All done, thank you!
    li      $v0, 10                # Code for exit
    syscall                        # Exit program

    .data
# Initialize the array's space
array:          .space 24
array_size:     .word 6
# Constant strings to be output to the terminal
promptInt:      .asciiz "Please give 6 integers: \n"
resultInt:      .asciiz "The result is: \n"
linefeed:       .asciiz "\n"

    .text
main:
    # prompt for an integer
        li      $v0, 4              # code for print_string
        la      $a0, promptInt      # point $a0 to prompt string
        syscall                     # print promptInt

    # initialize N = 6*4 and i = 0
        lw      $t0, array_size    # size of the array
        li      $t1, 0              # iterator
        li      $t2, 4              # offset

    # Loop to get integers from the user and store them in the array
while:
    # while statement
        bge     $t1, $t0, end_while    # if i >= 6, end loop

        # $t3 = iterator * offset
        mul     $t3, $t1, $t2

        # get an integer from the user
        li      $v0, 5              # code for read_int
        syscall                     # get int from user --> returned in $v0
        move    $t4, $v0            # move the resulting int to $t4
        sw      $t4, array($t3)     # store the integer in the array

        # increment iterator
        addi    $t1, $t1, 1

        # repeat the loop
        j       while

end_while:

    # Calculate the sum of the elements in the array
    li      $t1, 0                  # Initialize sum to 0
    li      $t3, 0                  # Reuse $t3 as loop iterator
    li      $t0, 24                 # Total bytes allocated for the array
    li      $t2, 4                  # Word size
sum_loop:
    bge     $t3, $t0, print_result  # If iterator >= total bytes, exit loop
    lw      $t4, array($t3)         # Load the current element from the array
    add     $t1, $t1, $t4           # Add the current element to the sum
    addi    $t3, $t3, $t2           # Move to the next element
    j       sum_loop

print_result:
    # print out text for the result
        li      $v0, 4              # code for print_string
        la      $a0, resultInt      # point $a0 to result string
        syscall                     # print the result string

    # print out the sum
        li      $v0, 1              # code for print_int
        move    $a0, $t1            # put result in $a0
        syscall                     # print out the result

    # print a line feed
        li      $v0, 4              # code for print_string
        la      $a0, linefeed       # point $a0 to linefeed string
        syscall                     # print linefeed

    # All done, thank you!
        li      $v0, 10             # code for exit
        syscall                     # exit program

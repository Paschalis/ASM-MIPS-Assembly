    .data
# Initialize the array's space
array:          .word 0,0,0,0,0,0,0,0
array_size:     .word 4
# Constant strings to be output to the terminal
promptInt:      .asciiz "Please give the decimal number: \n"
resultInt:      .asciiz "The binary number is: \n"
linefeed:       .asciiz "\n"

    .text
main:
    # prompt for an integer
        li      $v0, 4              # code for print_string
        la      $a0, promptInt      # point $a0 to prompt string
        syscall                     # print promptInt
    # get an integer from the user
        li      $v0, 5              # code for read_int
        syscall                     # get int from user --> returned in $v0
        move    $t4, $v0            # move the resulting int to $t4 (dividend)
    # initialize N = 8 and i = 0
        lw      $t0, array_size     # size of the array
        li      $t1, 0              # iterator
        li      $t2, 4              # offset
        li      $t5, 2              # $t5 (divisor) = 2

    # loop to convert decimal to binary
while:
    # while statement
        bge     $t1, $t0, end_while # if i >= 8, end loop

        # $t3 = iterator * offset
        mul     $t3, $t1, $t2

        # $t6 = dividend % 2 (remainder)
        rem     $t6, $t4, $t5

        # store the remainder (0 or 1) in the array
        sw      $t6, array($t3)

        # $t4 = $t4 / 2 (integer division)
        div     $t4, $t4, $t5

        # increment iterator
        addi    $t1, $t1, 1

        # repeat the loop
        j       while

end_while:
    # print out text for the result
        li      $v0, 4              # code for print_string
        la      $a0, resultInt      # point $a0 to result string
        syscall                     # print the result string

    # print out the binary number
    # initialize iterator and load array address
        li      $t1, 7              # starting from the last element of the array
        la      $t7, array

print_binary:
    # print the binary digits stored in the array
        lw      $a0, 0($t7)         # load digit to print
        li      $v0, 1              # code for print_int
        syscall                     # print the digit

        # print a space between digits
        li      $v0, 4              # code for print_string
        la      $a0, space          # point $a0 to space string
        syscall                     # print space

        # decrement iterator
        subi    $t1, $t1, 1

        # check if all digits have been printed
        bgez    $t1, print_binary   # repeat if not all digits printed

    # print a line feed
        li      $v0, 4              # code for print_string
        la      $a0, linefeed       # point $a0 to linefeed string
        syscall                     # print linefeed

    # All done, thank you!
        li      $v0, 10             # code for exit
        syscall                     # exit program

    .data
# Initialize the array's space
array:          .space 24
array_size:     .word 6        # Specify the size of the array

# Constant strings to be output to the terminal
promptInt:      .asciiz "Please input 6 integers: \n"
resultInt:      .asciiz "The result is: \n"
linefeed:       .asciiz "\n"

    .text
main:
    # prompt for integers
        li      $v0, 4              # code for print_string
        la      $a0, promptInt      # point $a0 to prompt string
        syscall                     # print promptInt

    # initialize N = 6 and i = 0
        lw      $t0, array_size     # load the size of the array
        li      $t1, 0              # iterator
        li      $t2, 4              # offset for each integer

while:
    # while statement: iterate until i > N
        bge     $t1, $t0, end_while

    # calculate memory address for the next element
        mul     $t3, $t1, $t2       # $t3 = iterator * offset

    # get an integer from the user
        li      $v0, 5              # code for read_int
        syscall                     # get int from user --> returned in $v0
        move    $t4, $v0            # move the resulting int to $t4

    # store the integer in the array
        sw      $t4, array($t3)     # store the integer in the array

        addi    $t1, $t1, 1         # increment iterator
        j       while

end_while:
    # print out text for the result
        li      $v0, 4              # code for print_string
        la      $a0, resultInt      # point $a0 to result string
        syscall                     # print the result string

    # initialize i = 0 for printing loop
        li      $t1, 0              # iterator for printing loop

print:
    # print elements of the array
        bge     $t1, $t0, end_print # if i >= N, exit the loop

        mul     $t3, $t1, $t2       # $t3 = iterator * offset

    # load the integer from the array
        lw      $a0, array($t3)     # load the integer from the array
        li      $v0, 1              # code for print_int
        syscall                     # print out the integer

    # print out a line feed
        li      $v0, 4              # code for print_string
        la      $a0, linefeed       # point $a0 to linefeed string
        syscall                     # print linefeed

        addi    $t1, $t1, 1         # increment iterator
        j       print

end_print:
    # All done, thank you!
        li      $v0, 10             # code for exit
        syscall                     # exit program

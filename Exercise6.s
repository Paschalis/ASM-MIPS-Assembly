    .data
# Initialize the array's space
array:          .space 20
array_size:     .word 5        # Specify the size of the array
max_value:      .word 0        # Initialize max_value to 0

# Constant strings to be output to the terminal
promptInt:      .asciiz "Please input 5 integers: \n"
resultInt:      .asciiz "The max is: \n"
linefeed:       .asciiz "\n"

    .text
main:
    # prompt for integers
        li      $v0, 4              # code for print_string
        la      $a0, promptInt      # point $a0 to prompt string
        syscall                     # print promptInt

    # initialize N = 5 and i = 0
        lw      $t0, array_size     # load the size of the array
        li      $t1, 0              # iterator
        li      $t2, 4              # offset for each integer

    # initialize max_value to the first element of the array
        lw      $t5, array          # load the first element into $t5

while:
    # while statement: iterate until i > N
        bge     $t1, $t0, end_while

    # calculate memory address for the next element
        mul     $t3, $t1, $t2       # $t3 = iterator * offset

    # get an integer from the user
        li      $v0, 5              # code for read_int
        syscall                     # get int from user --> returned in $v0
        sw      $v0, array($t3)     # store the integer in the array

    # compare the current element with max_value
        lw      $t6, array($t3)     # load the current element into $t6
        bgt     $t6, $t5, update_max # if current element > max_value, update max_value

    # increment iterator
        addi    $t1, $t1, 1         # increment iterator
        j       while

update_max:
    # update max_value with the current element
        move    $t5, $t6            # update max_value with the current element

    # increment iterator
        addi    $t1, $t1, 1         # increment iterator
        j       while

end_while:
    # print out text for the result
        li      $v0, 4              # code for print_string
        la      $a0, resultInt      # point $a0 to result string
        syscall                     # print the result string

    # print out the maximum value
        lw      $a0, max_value      # load max_value into $a0
        li      $v0, 1              # code for print_int
        syscall                     # print out the maximum value

    # All done, thank you!
        li      $v0, 10             # code for exit
        syscall                     # exit program

    .data
# Constant strings to be output to the terminal
promptInt:      .asciiz "\nPlease input two integers: \n"
resultInt:      .asciiz "The sum is: "
space:          .asciiz " "

    .text
main:

do:
    # prompt for an integer
        li      $v0, 4              # code for print_string
        la      $a0, promptInt      # point $a0 to prompt string
        syscall                     # print promptInt
    # get the first integer from the user
        li      $v0, 5              # code for read_int
        syscall                     # get int from user --> returned in $v0
        move    $t0, $v0            # move the resulting int to $t0
    # get the second integer from the user
        li      $v0, 5              # code for read_int
        syscall                     # get int from user --> returned in $v0
        move    $t1, $v0            # move the resulting int to $t1
    # calculate the sum of the two integers
        add     $t2, $t0, $t1       # sum = first integer + second integer
    # print out text for the result
        li      $v0, 4              # code for print_string
        la      $a0, resultInt      # point $a0 to result string
        syscall                     # print the result string
    # print out the sum
        li      $v0, 1              # code for print_int
        move    $a0, $t2            # put the sum in $a0
        syscall                     # print out the sum
    # print a space for better readability
        li      $v0, 4              # code for print_string
        la      $a0, space          # point $a0 to space string
        syscall                     # print space
# if the first number is not zero, loop again
    bnez    $t0, do                # if the first number != 0, then repeat the process

# All done, thank you!
    li      $v0, 10                 # code for exit
    syscall                         # exit program

.data
# Constant strings to be output to the terminal
promptInt:      .asciiz "Please input three integers: \n"
resultInt:      .asciiz "The result is: \n"
linefeed:       .asciiz "\n"

.text
main:
    # prompt for input of three integers
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

    # get the third integer from the user
    li      $v0, 5              # code for read_int
    syscall                     # get int from user --> returned in $v0
    move    $t2, $v0            # move the resulting int to $t2

    # Sort the integers in ascending order
    # if(1st integer > 2nd integer) swap
    blt     $t0, $t1, endif1    # if $t0 < $t1 then
    move    $t3, $t0             # swap
    move    $t0, $t1
    move    $t1, $t3
endif1:
    # if(2nd integer > 3rd integer) swap
    blt     $t1, $t2, endif2    # if $t1 < $t2 then
    move    $t3, $t1             # swap
    move    $t1, $t2
    move    $t2, $t3
endif2:
    # if(1st integer > 2nd integer) swap
    blt     $t0, $t1, end       # if $t0 < $t1 then
    move    $t3, $t0             # swap
    move    $t0, $t1
    move    $t1, $t3
end:

    # print out text for the result
    li      $v0, 4              # code for print_string
    la      $a0, resultInt      # point $a0 to result string
    syscall                     # print the result string

    # print out the first sorted integer
    li      $v0, 1              # code for print_int
    move    $a0, $t0            # put result in $a0
    syscall                     # print out the result

    # print out a line feed
    li      $v0, 4              # code for print_string
    la      $a0, linefeed       # point $a0 to linefeed string
    syscall                     # print linefeed

    # print out the second sorted integer
    li      $v0, 1              # code for print_int
    move    $a0, $t1            # put result in $a0
    syscall                     # print out the result

    # print out a line feed
    li      $v0, 4              # code for print_string
    la      $a0, linefeed       # point $a0 to linefeed string
    syscall                     # print linefeed

    # print out the third sorted integer
    li      $v0, 1              # code for print_int
    move    $a0, $t2            # put result in $a0
    syscall                     # print out the result

    # All done, thank you!
    li      $v0, 10             # code for exit
    syscall                     # exit program

    .data
# Constant strings to be output to the terminal
promptInt:      .asciiz "Please input two integers: \n"
resultInt:      .asciiz "The result is: "
space:       .asciiz " "

    .text
main:
    # prompt for an integer
    	  li      $v0, 4              # code for print_string
        la      $a0, promptInt      # point $a0 to prompt string
        syscall                     # print promptInt
    # get an integer from the user
        li      $v0, 5              # code for read_int
        syscall                     # get int from user --> returned in $v0
        move    $t0, $v0            # move the resulting int to $t0
    # get an integer from the user
        li      $v0, 5              # code for read_int
        syscall                     # get int from user --> returned in $v0
        move    $t1, $v0            # move the resulting int to $t1
    # print out text for the result
        li      $v0, 4              # code for print_string
        la      $a0, resultInt      # point $a0 to result string
        syscall                     # print the result string
    # print out the result
        li      $v0, 1              # code for print_int
        move    $a0, $t1            # put result in $a0
        syscall                     # print out the result
    # print out a line feed
        li      $v0, 4              # code for print_string
        la      $a0, space	        # point $a0 to linefeed string
        syscall                     # print space between two numbers
    # print out the result
        li      $v0, 1              # code for print_int
        move    $a0, $t0            # put result in $a0
        syscall                     # print out the result
    # All done, thank you!
        li      $v0, 10             # code for exit
        syscall                     # exit program

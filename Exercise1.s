    .data
# Constant strings to be output to the terminal
promptInt:      .asciiz "Please input an integer: "
resultInt:      .asciiz "Next integer is: "
linefeed:       .asciiz "\n"
enterkey:       .asciiz "Press any key to end program."

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

    # compute the next integer
            addi    $t0, $t0, 1         # t0 <-- t0+ 1

    # print out text for the result
            li      $v0, 4              # code for print_string
            la      $a0, resultInt      # point $a0 to result string
            syscall                     # print the result string

    # print out the result
            li      $v0, 1              # code for print_int
            move    $a0, $t0            # put result in $a0
            syscall                     # print out the result

    # print out a line feed
            li      $v0, 4              # code for print_string
            la      $a0, linefeed       # point $a0 to linefeed string
            syscall                     # print linefeed

    # wait for the enter key to be pressed to end program
            li      $v0, 4              # code for print_string
            la      $a0, enterkey       # point $a0 to enterKey string
            syscall                     # print enterKey

    # wait  for input  by  getting  an  integer  from  the  user  (integer  isignored)
            li      $v0, 5              # code for read_int
            syscall                     # get int from user --> returned in $v0

    # All done, thank you!
            li      $v0, 10             # code for exit
            syscall                     # exit program

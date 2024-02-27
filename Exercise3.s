    .data
# Constant strings to be output to the terminal
promptInt:      .asciiz "Please give the N number: \n"
result1:  	    .asciiz "^2 + "
result2:  	    .asciiz "^2 = "
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
    move    $t0, $v0            # move the resulting int to $t0

    # value of sum is in $t2 and value of i is in $t1
    li      $t1, 0              # i = 0
    li		$t2, 0 		        # sum = 0

for:
    bgt     $t1, $t0, end_for   # if i > N then end_for

    mul 	$t3, $t1, $t1        # i^2 = i*i
    add		$t2, $t2, $t3       # sum = sum + i^2
    addi	$t1, $t1, 1         # i++
    j		for				    # jump to for

end_for:
    # print out text for the result
    li      $v0, 4              # code for print_string
    la      $a0, result1        # point $a0 to result string
    syscall                     # print the result string

    # print out the result
    li      $v0, 1              # code for print_int
    move    $a0, $t2            # put result in $a0
    syscall                     # print out the result

    # print out text for the result
    li      $v0, 4              # code for print_string
    la      $a0, result2        # point $a0 to result string
    syscall                     # print the result string

    # print out the result
    li      $v0, 1              # code for print_int
    move    $a0, $t2            # put result in $a0
    syscall                     # print out the result

    # print out a line feed
    li      $v0, 4              # code for print_string
    la      $a0, linefeed       # point $a0 to linefeed string
    syscall                     # print linefeed

    # All done, thank you!
    li      $v0, 10             # code for exit
    syscall                     # exit program

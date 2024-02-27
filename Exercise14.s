    .data
# Initialize the array's space
array:          .word 5, 3, 8, 4, 2, 7
array_size:     .word 6
search_value:   .word 4  # Value to search for
# Constant strings to be output to the terminal
promptInt:      .asciiz "Please input an integer to search for: \n"
resultInt:      .asciiz "The index of the element is: "
not_found:      .asciiz "Element not found.\n"

    .text
main:
    # prompt for an integer
        li      $v0, 4              # code for print_string
        la      $a0, promptInt      # point $a0 to prompt string
        syscall                     # print promptInt

    # get the integer to search for from the user
        li      $v0, 5              # code for read_int
        syscall                     # get int from user --> returned in $v0
        move    $t6, $v0            # move the search value to $t6

    # initialize N = 6*4 and i = 0
        lw      $t0, array_size     # size of the array
        li      $t1, 0              # iterator
        li      $t2, 4              # offset

    # Initialize $t3 to store the index of the found element
        li      $t3, -1             # initialize index to -1 (not found)

search_loop:
    # check if iterator is greater than or equal to array size
        bge     $t1, $t0, print_result   # if true, jump to print_result

    # load current element from the array
        lw      $t4, array($t1)

    # compare current element with the search value
        beq     $t4, $t6, element_found # if true, jump to element_found

    # if not found, increment iterator and jump back to search_loop
        addi    $t1, $t1, 1
        j       search_loop

element_found:
    # store the index of the found element
        move    $t3, $t1

print_result:
    # print result
        li      $v0, 4              # code for print_string
        la      $a0, resultInt      # point $a0 to result string
        syscall                     # print resultInt

    # print the index of the found element
        li      $v0, 1              # code for print_int
        move    $a0, $t3            # put index in $a0
        syscall                     # print index

    # print a linefeed
        li      $v0, 4              # code for print_string
        la      $a0, linefeed       # point $a0 to linefeed string
        syscall                     # print linefeed

    # if element not found, print "Element not found."
        beq     $t3, -1, print_not_found  # if index == -1, jump to print_not_found

    # All done, thank you!
        li      $v0, 10             # code for exit
        syscall                     # exit program

print_not_found:
    # print "Element not found."
        li      $v0, 4              # code for print_string
        la      $a0, not_found      # point $a0 to not_found string
        syscall                     # print not_found

    # All done, thank you!
        li      $v0, 10             # code for exit
        syscall                     # exit program

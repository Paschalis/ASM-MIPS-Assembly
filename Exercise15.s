    .data
# Initialize the array's space
array:          .word 5, 3, 8, 4, 2, 7
array_size:     .word 6
# Constant strings to be output to the terminal
promptInt:      .asciiz "Unsorted array: "
resultInt:      .asciiz "\nSorted array: "
linefeed:       .asciiz "\n"

    .text
main:
    # prompt for unsorted array
        li      $v0, 4              # code for print_string
        la      $a0, promptInt      # point $a0 to prompt string
        syscall                     # print promptInt

    # print unsorted array
        li      $v0, 4              # code for print_string
        la      $a0, array          # point $a0 to the start of the array
        lw      $a1, array_size     # load array size
        mul     $a1, $a1, 4         # multiply array size by 4 to get total bytes
        syscall                     # print array

    # initialize N = 6*4 and i = 0
        lw      $t0, array_size     # size of the array
        li      $t1, 0              # iterator
        li      $t2, 4              # offset

bubble_sort_loop:
    # outer loop: iterate through array elements
        li      $t1, 0              # reset iterator to 0 at the beginning of each iteration

    outer_loop:
        # load current element from the array
            lw      $t3, array($t1)

        # load next element from the array
            lw      $t4, array($t1)
            add     $t4, $t4, $t2    # move to the next element

        # compare current element with next element
            bge     $t4, $t0, end_outer_loop  # if next element is out of bounds, jump to end_outer_loop

        # load the value of the next element from the array
            lw      $t4, array($t4)

        # if current element is greater than next element, swap them
            ble     $t3, $t4, not_swap
            sw      $t4, array($t1)
            sw      $t3, array($t1)
        not_swap:

        # increment iterator
            addi    $t1, $t1, 1
        # jump back to outer_loop
            j       outer_loop

    # decrement N
        subi    $t0, $t0, 1
    # if N > 0, jump back to bubble_sort_loop
        bgtz    $t0, bubble_sort_loop

end_outer_loop:
    # print sorted array
        li      $v0, 4              # code for print_string
        la      $a0, resultInt      # point $a0 to result string
        syscall                     # print resultInt

        li      $v0, 4              # code for print_string
        la      $a0, array          # point $a0 to the start of the array
        lw      $a1, array_size     # load array size
        mul     $a1, $a1, 4         # multiply array size by 4 to get total bytes
        syscall                     # print sorted array

    # print a linefeed
        li      $v0, 4              # code for print_string
        la      $a0, linefeed       # point $a0 to linefeed string
        syscall                     # print linefeed

    # All done, thank you!
        li      $v0, 10             # code for exit
        syscall                     # exit program

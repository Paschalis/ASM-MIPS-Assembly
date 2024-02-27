    .data
result: .word 0            # Variable to store the result

    .text
main:
    li      $t0, 1          # Initialize i = 1
    li      $t1, 0          # Initialize sum = 0

loop:
    bgt     $t0, 10, end    # Exit loop if i > 10

    # Calculate i^3 and add to sum
    mul     $t2, $t0, $t0   # Calculate i^2
    mul     $t2, $t2, $t0   # Calculate i^3
    add     $t1, $t1, $t2   # Add i^3 to sum

    addi    $t0, $t0, 1     # Increment i
    j       loop

end:
    # Store the result
    sw      $t1, result

    # Exit program
    li      $v0, 10         # Exit syscall
    syscall

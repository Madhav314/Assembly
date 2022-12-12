main:

    ADDI X0, X0, #9     // start at n = 9
    SUBI X0, X0, #1     // n - 1
    ADD X15, XZR, X0    // length of array
    ADDI X7, XZR, #1    // constant: X7 = 1
    ADD X13, XZR, X15   // length - 1


Fill: // fills an array of length n with decreasing values from n - 1 to  zero

    STUR X0, [X1, #0] // Array starts at X1
    SUBS X0, X0, X7
    ADDI X1, X1, #8
    B.GT Fill
    ADDI X1, XZR, #0
    ADD X0, XZR, X15 // index at array length
    ADD X0, X0, X7
    B bubble_sort


bs_swap_pass: // inner loop

    SUBS X15, X15, X7 // length - 1 >=  0
    B.LT bubble_sort // go to outer loop

    LDUR X9, [X1, #0]   // X9 = A[j]

    ADDI X1, X1, #8     // j + 1
    
    LDUR X12, [X1, #0]  // X12 = A[j+1]

    SUBS XZR, X12, X9   // if(A[j+1] < A[j])
    B.GT bs_swap_pass


swap: // swaps two numbers in array

    SUBI X1, X1, #8

    STUR X9, [X1, #8] // A[j+1] = A[j]

    STUR X12, [X1, #0] // A[j] = A[j+1]

    ADDI X1, X1, #8
    
    B bs_swap_pass

bubble_sort: // outer loop

    ADDI X1, XZR, #0
    ADD X15, XZR, X13 // X15 = length

    SUBS x0, X0, X7 // length - 1 >= 0
    B.GT bs_swap_pass


end:

    DUMP
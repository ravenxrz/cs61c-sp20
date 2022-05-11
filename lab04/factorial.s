.globl factorial

.data
n: .word 8

.text
main:
    la t0, n        
    lw a0, 0(t0)
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:    #use recursion 
    add t0, a0, x0  # t0 = param n
    addi t1, x0, 1  # t1 == 1
    bne t0, t1, other
    ret             # a0 is 1 now, so just return it. return 1 if n == 1
other:
    addi sp, sp, -8
    sw ra, 4(sp)    # save ra address 
    sw t0, 0(sp)
    addi a0, a0,-1  # construct n-1
    jal factorial   
    lw t0, 0(sp)    # restore t0, which is n
    lw ra, 4(sp)
    mul a0, t0, a0  # calc the final ans
    addi sp, sp, 8
    ret

  

    

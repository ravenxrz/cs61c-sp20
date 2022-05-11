.data
source:
    .word   3
    .word   1
    .word   4
    .word   1
    .word   5
    .word   9
    .word   0
dest:
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0

.text
main:
    addi t0, x0, 0  # t0 = 0
    addi s0, x0, 0  # s0 = 0
    la s1, source   # s1 = source address
    la s2, dest     # s2 = dest address
loop:
    slli s3, t0, 2  # s3 = t0 << 2  -> +4 字节
    add t1, s1, s3  # t1 = s1 + s3  : t1是source array element的指针
    lw t2, 0(t1)    # t2 = source[k]
    beq t2, x0, exit
    add a0, x0, t2  # a0 = t2
    addi sp, sp, -8
    sw t0, 0(sp)    # save t0
    sw t2, 4(sp)    # save t2, why we need to store t2?
    jal square
    lw t0, 0(sp)    # resotre t0
    lw t2, 4(sp)    # restore t2
    addi sp, sp, 8  # restore sp
    add t2, x0, a0  # t2 = a0 -> a0 <=> desk[k]
    add t3, s2, s3  # t3 指向当前引用的desk[k]地址
    sw t2, 0(t3)    # desk[k] = t2
    add s0, s0, t2  # s0 <==> sum
    addi t0, t0, 1  # k++
    jal x0, loop
square:
    add t0, a0, x0
    add t1, a0, x0
    addi t0, t0, 1
    addi t2, x0, -1
    mul t1, t1, t2
    mul a0, t0, t1
    jr ra
exit:
    add a0, x0, s0
    add a1, x0, x0
    ecall # Terminate ecall

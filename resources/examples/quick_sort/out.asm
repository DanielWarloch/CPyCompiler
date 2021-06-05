li $t0,8
sw $t0,n
li $t0,4
sw $t0,s
.data
lbl8: .asciiz "Numbers found "
lbl9: .asciiz " + "
lbl10: .asciiz " = "
lbl15: .asciiz " "
lbl17: .asciiz "\n"
lbl18: .asciiz "Array: "
lbl19: .asciiz "Sorted array: "
arr: .word 10, 10, 8, 9, 1, 2, 3, 0
n: .word 0
s: .word 0
.text

main:
addi $sp, $sp, -4
sw $ra, 0($sp)
la $a0, lbl18
li $v0, 4
syscall
jal printArray
lw $t0,n
subi $t0, $t0, 1
li $a0 0
add $a1 $zero, $t0
jal quickSort
la $a0, lbl19
li $v0, 4
syscall
jal printArray
jal findTheSum
li $v0, 0
lw $ra, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4
li $v0 10 #program finished call terminate
syscall

swap:
addi $sp, $sp, -16
sw $ra, 0($sp)
sw $zero, 4($sp)
sw $zero, 8($sp)
sw $a0, 4($sp)
sw $a1, 8($sp)
lw $t0, 4($sp)
lw $t0, ($t0)
sw $t0, 12($sp)
lw $t0, 8($sp)
lw $t0, ($t0)
lw $t1, 4($sp)
sw $t0, ($t1)
lw $t0, 12($sp)
lw $t1, 8($sp)
sw $t0, ($t1)
lw $ra, 0($sp)
addi $sp, $sp, 16
jr $ra

partition:
addi $sp, $sp, -24
sw $ra, 0($sp)
sw $zero, 4($sp)
sw $zero, 8($sp)
sw $a0, 4($sp)
sw $a1, 8($sp)
la $t0, arr
lw $t1, 8($sp)
add $t1, $t1, $t1
add $t1, $t1, $t1
add $t1, $t0, $t1
lw $t1, ($t1)
sw $t1, 12($sp)
lw $t0, 4($sp)
subi $t0, $t0, 1
sw $t0, 16($sp)
li $t0,0
sw $t0, 20($sp)
lw $t0, 4($sp)
sw $t0, 20($sp)
lbl3:
lw $t0, 20($sp)
lw $t1, 8($sp)
subi $t1, $t1, 1
bgt $t0, $t1, lbl1
la $t0, arr
lw $t1, 20($sp)
add $t1, $t1, $t1
add $t1, $t1, $t1
add $t1, $t0, $t1
lw $t1, ($t1)
lw $t0, 12($sp)
bgt $t1, $t0, lbl2
lw $t0, 16($sp)
addi $t0, $t0, 1
sw $t0, 16($sp)
la $t0, arr
lw $t1, 16($sp)
add $t1, $t1, $t1
add $t1, $t1, $t1
add $t1, $t0, $t1
la $t0, arr
lw $t2, 20($sp)
add $t2, $t2, $t2
add $t2, $t2, $t2
add $t2, $t0, $t2
add $a0 $zero, $t1
add $a1 $zero, $t2
jal swap
lbl2:
lw $t0, 20($sp)
addi $t0, $t0, 1
sw $t0, 20($sp)
j lbl3
lbl1:
la $t0, arr
lw $t1, 16($sp)
addi $t1, $t1, 1
add $t1, $t1, $t1
add $t1, $t1, $t1
add $t1, $t0, $t1
la $t0, arr
lw $t2, 8($sp)
add $t2, $t2, $t2
add $t2, $t2, $t2
add $t2, $t0, $t2
add $a0 $zero, $t1
add $a1 $zero, $t2
jal swap
lw $t0, 16($sp)
addi $t0, $t0, 1
add $v0, $zero, $t0
lw $ra, 0($sp)
addi $sp, $sp, 24
jr $ra
lw $ra, 0($sp)
addi $sp, $sp, 24
jr $ra

quickSort:
addi $sp, $sp, -16
sw $ra, 0($sp)
sw $zero, 4($sp)
sw $zero, 8($sp)
sw $a0, 4($sp)
sw $a1, 8($sp)
lw $t0, 4($sp)
lw $t1, 8($sp)
bge $t0, $t1, lbl4
li $t0,0
sw $t0, 12($sp)
lw $t0, 4($sp)
lw $t1, 8($sp)
add $a0 $zero, $t0
add $a1 $zero, $t1
jal partition
sw $v0, 12($sp)
lw $t0, 4($sp)
lw $t1, 12($sp)
subi $t1, $t1, 1
add $a0 $zero, $t0
add $a1 $zero, $t1
jal quickSort
lw $t0, 12($sp)
addi $t0, $t0, 1
lw $t1, 8($sp)
add $a0 $zero, $t0
add $a1 $zero, $t1
jal quickSort
lbl4:
lw $ra, 0($sp)
addi $sp, $sp, 16
jr $ra

findTheSum:
addi $sp, $sp, -12
sw $ra, 0($sp)
li $t0,0
sw $t0, 4($sp)
lw $t0,n
subi $t0, $t0, 1
sw $t0, 8($sp)
lbl13:
lw $t0, 4($sp)
lw $t1, 8($sp)
bge $t0, $t1, lbl5
la $t0, arr
lw $t1, 4($sp)
add $t1, $t1, $t1
add $t1, $t1, $t1
add $t1, $t0, $t1
lw $t1, ($t1)
la $t0, arr
lw $t2, 8($sp)
add $t2, $t2, $t2
add $t2, $t2, $t2
add $t2, $t0, $t2
lw $t2, ($t2)
add $t0, $t1, $t2
lw $t1,s
bne $t0, $t1, lbl7
la $a0, lbl8
li $v0, 4
syscall
la $t0, arr
lw $t1, 4($sp)
add $t1, $t1, $t1
add $t1, $t1, $t1
add $t1, $t0, $t1
lw $t1, ($t1)
add $a0 $zero, $t1
jal print_int
la $a0, lbl9
li $v0, 4
syscall
la $t0, arr
lw $t1, 8($sp)
add $t1, $t1, $t1
add $t1, $t1, $t1
add $t1, $t0, $t1
lw $t1, ($t1)
add $a0 $zero, $t1
jal print_int
la $a0, lbl10
li $v0, 4
syscall
lw $t0,s
add $a0 $zero, $t0
jal print_int
lw $t0,n
sw $t0, 4($sp)
j lbl6
lbl7:
la $t0, arr
lw $t1, 4($sp)
add $t1, $t1, $t1
add $t1, $t1, $t1
add $t1, $t0, $t1
lw $t1, ($t1)
la $t0, arr
lw $t2, 8($sp)
add $t2, $t2, $t2
add $t2, $t2, $t2
add $t2, $t0, $t2
lw $t2, ($t2)
add $t0, $t1, $t2
lw $t1,s
bge $t0, $t1, lbl12
lw $t0, 4($sp)
lw $t1, 4($sp)
addi $t1, $t1, 1
sw $t1, 4($sp)
j lbl11
lbl12:
lw $t0, 8($sp)
lw $t1, 8($sp)
subi $t1, $t1, 1
sw $t1, 8($sp)
lbl11:
lbl6:
j lbl13
lbl5:
lw $ra, 0($sp)
addi $sp, $sp, 12
jr $ra

printArray:
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $zero, 4($sp)
li $t0,0
sw $t0, 4($sp)
lbl16:
lw $t0, 4($sp)
lw $t1,n
bge $t0, $t1, lbl14
la $t0, arr
lw $t1, 4($sp)
add $t1, $t1, $t1
add $t1, $t1, $t1
add $t1, $t0, $t1
lw $t1, ($t1)
add $a0 $zero, $t1
jal print_int
la $a0, lbl15
li $v0, 4
syscall
lw $t0, 4($sp)
addi $t0, $t0, 1
sw $t0, 4($sp)
j lbl16
lbl14:
la $a0, lbl17
li $v0, 4
syscall
lw $ra, 0($sp)
addi $sp, $sp, 8
jr $ra

print_int:
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $zero, 4($sp)
sw $a0, 4($sp)
li $v0 1
syscall
lw $ra, 0($sp)
addi $sp, $sp, 8
jr $ra


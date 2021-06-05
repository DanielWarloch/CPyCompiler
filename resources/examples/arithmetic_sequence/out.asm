.data
lbl3: .asciiz "Sum = "
lbl4: .asciiz "\n"
.text

main:
addi $sp, $sp, -12
sw $ra, 0($sp)
li $t0,1
sw $t0, 4($sp)
sw $zero, 8($sp)
li $t0,2
sw $t0, 8($sp)
lbl6:
lw $t0, 8($sp)
li $t1,25
bgt $t0, $t1, lbl1
lbl5:
lw $t0, 4($sp)
lw $t1, 8($sp)
bge $t0, $t1, lbl2
la $a0, lbl3
li $v0, 4
syscall
lw $t0, 8($sp)
subi $t0, $t0, 1
lw $t1, 4($sp)
mul $t2, $t0, $t1
addi $t2, $t2, 2
li $t1,2
div $t0, $t2, $t1
lw $t1, 8($sp)
mul $t2, $t0, $t1
add $a0 $zero, $t2
jal print_int
la $a0, lbl4
li $v0, 4
syscall
lw $t0, 4($sp)
addi $t0, $t0, 1
sw $t0, 4($sp)
lw $t0, 4($sp)
j lbl5
lbl2:
lw $t0, 8($sp)
addi $t0, $t0, 1
sw $t0, 8($sp)
lw $t0, 8($sp)
j lbl6
lbl1:
lw $ra, 0($sp)
addi $sp, $sp, 12
li $v0 10 #program finished call terminate
syscall

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


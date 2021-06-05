.data
lbl3: .asciiz " "
lbl6: .asciiz "* "
lbl8: .asciiz "\n"
.text

main:
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $zero, 4($sp)
li $t0,23
sw $t0, 4($sp)
lw $t0, 4($sp)
add $a0 $zero, $t0
jal tree
li $v0, 0
lw $ra, 0($sp)
addi $sp, $sp, 8
lw $ra, 0($sp)
addi $sp, $sp, 8
li $v0 10 #program finished call terminate
syscall

tree:
addi $sp, $sp, -16
sw $ra, 0($sp)
sw $zero, 4($sp)
sw $a0, 4($sp)
sw $zero, 8($sp)
sw $zero, 12($sp)
lw $t0, 4($sp)
sw $t0, 8($sp)
lbl9:
lw $t0, 8($sp)
li $t1,0
ble $t0, $t1, lbl1
li $t0,0
sw $t0, 12($sp)
lbl4:
lw $t0, 12($sp)
lw $t1, 4($sp)
lw $t2, 8($sp)
sub $t3, $t1, $t2
bge $t0, $t3, lbl2
la $a0, lbl3
li $v0, 4
syscall
lw $t0, 12($sp)
lw $t1, 12($sp)
addi $t1, $t1, 1
sw $t1, 12($sp)
j lbl4
lbl2:
li $t0,0
sw $t0, 12($sp)
lbl7:
lw $t0, 12($sp)
lw $t1, 8($sp)
bge $t0, $t1, lbl5
la $a0, lbl6
li $v0, 4
syscall
lw $t0, 12($sp)
lw $t1, 12($sp)
addi $t1, $t1, 1
sw $t1, 12($sp)
j lbl7
lbl5:
la $a0, lbl8
li $v0, 4
syscall
lw $t0, 8($sp)
subi $t0, $t0, 2
sw $t0, 8($sp)
j lbl9
lbl1:
lw $ra, 0($sp)
addi $sp, $sp, 16
jr $ra


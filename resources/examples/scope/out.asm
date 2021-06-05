li $t0,1
sw $t0,i
.data
lbl1: .asciiz "i = 1\n"
lbl2: .asciiz "\n"
lbl3: .asciiz "b = 3\n"
lbl4: .asciiz "\n"
lbl5: .asciiz "i = 1\n"
lbl6: .asciiz "\n"
lbl7: .asciiz "b = 2\n"
lbl8: .asciiz "\n"
i: .word 0
.text

main:
addi $sp, $sp, -12
sw $ra, 0($sp)
li $t0,1
sw $t0, 4($sp)
li $t0,3
sw $t0, 8($sp)
la $a0, lbl1
li $v0, 4
syscall
lw $t0,i
add $a0 $zero, $t0
jal print_int
la $a0, lbl2
li $v0, 4
syscall
jal check
la $a0, lbl3
li $v0, 4
syscall
lw $t0, 8($sp)
add $a0 $zero, $t0
jal print_int
la $a0, lbl4
li $v0, 4
syscall
jal check2
li $v0, 0
lw $ra, 0($sp)
addi $sp, $sp, 12
lw $ra, 0($sp)
addi $sp, $sp, 12
li $v0 10 #program finished call terminate
syscall

check:
addi $sp, $sp, -4
sw $ra, 0($sp)
la $a0, lbl5
li $v0, 4
syscall
lw $t0,i
add $a0 $zero, $t0
jal print_int
la $a0, lbl6
li $v0, 4
syscall
lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra

check2:
addi $sp, $sp, -8
sw $ra, 0($sp)
li $t0,2
sw $t0, 4($sp)
la $a0, lbl7
li $v0, 4
syscall
lw $t0, 4($sp)
add $a0 $zero, $t0
jal print_int
la $a0, lbl8
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


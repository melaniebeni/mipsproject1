.data
full_word: .word 
char1: .byte 'F'
char2: .byte 'I'
char3: .byte 'N'
char4: .byte 'A'
.text
li, $t3,90 #NOTE 90 is Z in ASCII
la $t0,char1
lw $t1,0($t0)
sll $t2,$t1,8
add $t1,$t2,$t3
la $t4,full_word
sw $t1,0($t4)
la $a0,full_word
li $v0, 4
syscall

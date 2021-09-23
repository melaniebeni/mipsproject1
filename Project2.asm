#Melanie Beni
	.data 
prompt: .asciiz "\n Please Input a value for N = "
result: .asciiz " \n The sum of the integers from 1 to N is "
fptnum: .asciiz "\nA floating point number has been entered and will be truncated to: "
bye:    .asciiz "\n **** Adios Amigo - Have a good day *****"
	.globl main
	.text 
main:
	li 		$v0, 4			#system call code for Print String
	la 		$a0, prompt		#load address of prompt into $a0
	syscall 				#print prompt
	
	li 		$v0, 6			#system call code for read integer
	syscall					#reads the value of N into $v0
	
	blez 		$v0, end		#branch to end if $v0 <= 0
	li 		$t0, 0			#clear register $t0 to 0
	
	mfc1 		$t1, $f0		#move the floating point number into an integer register
	srl 		$t2, $t1, 23
	
	addi 		$s3, $t2, -127		#subract 127 to get exponent 
	
	sll 		$t4, $t1, 9		#shift out exponent and sign bit
	srl 		$t5, $t4, 9		#shift back to original position. This will make all previous bits 0
	add 		$t6, $t5, 8388608	#add the implied bit to bit number 8 (2^23)
	add 		$t7, $s3, 9		#add nine to the exponent 
	sllv 		$s4, $t6, $t7		#when you shift left by 9, if the number NE 0 then there is a fraction.
	
	rol 		$t4, $t6, $t7		#rotate the bits left by $s7 to get the integer portion in the right most bits.
	
	li 		$t5, 31			#shift left by 31
	sub 		$t2, $t5, $s3		#shift value
	sllv 		$t5, $t4, $t2		#zero out the fraction portion 
	srlv 		$s5, $t5, $t2		#reset integer bits, integer is in $s5
	
	move 		$v0, $s5		#move the integer into $v0
	li 		$t0, 0			#zero out $t0
	blez 		$t1, end
	beqz 		$s4, loop		#if it is not a fraction, branch to loop
	bne 		$s4, 0, To		#branch out to To if the value is not equal to 0
To:
	li 		$v0, 4			#system call for print string 
	la 		$a0, fptnum		#address of floating point number is loaded in $a0
	syscall					#print the message
	
	li 		$v0, 1			#system call
	move 		$a0, $s5		#move the value so that it can be printed to $a0
	syscall 				#prints the sum 
	
	move 		$v0, $s5		#put the integer into loop
	b 		loop			#branch to loop
loop:
	add 		$t0, $t0, $v0		#sum of integers in register $t0
	addi 		$v0, $v0,-1		#summing integers in reverse order
	bnez 		$v0, loop		#branch to loop if $v0 is !=0
	
	li 		$v0, 4			#system call code for print string 
	la 		$a0, result		#load address of message into $a0
	syscall					#print the string 
	
	li 		$v0, 1			#system call code for print integer
	move 		$a0, $t0		#move value to be printed to $a0
	syscall					#print sum of integers 
	b 		main			#branch to main 
end:
	li 		$v0, 4			#system call code for print string
	la 		$a0, bye		#load address of msg. into $a0
	syscall					#print the string
	
	li 		$v0, 10			#terminate program run and
	syscall					#return control to system

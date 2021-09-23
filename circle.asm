# UNTITLED PROGRAM

	.data	# Data declaration section
	pi: 	.double 3.14
	radius:	.double 200.5
	largest: .double 200010.0
	.text

main:		# Start of code section
	l.d $f16, radius
	mul.d $f18, $f16, $f16
	l.d $f2, pi
	mul.d $f4, $f2, $f18
	l.d $f0, largest
	c.le.d  $f4, $f0	#if Area <= 10.0
	bc1t ltEQ		#if true goto ltEQ
	sub.d $f6,$f4, $f2      #AREA =AREA - PI
ltEQ: 
	li $v0, 3		#tells syscall print float
	mov.d $f12, $f4		#put float to be printed in f12
	syscall
# END OF PROGRAM

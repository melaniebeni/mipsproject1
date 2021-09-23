.data
fp1: .float 1038.5
shift_int: .word 29
#fp2: .float -0.75

.text   
l.s $f0, fp1
#mfc1 $f0, $t0
#Move the FP number into an integer register, NO CONVERSION
mfc1 $t1, $f0
srl $t2, $t1, 23
#Subtract 127 to get the exponent
add  $s3, $t2, -127 #This is the exponent
#Get the fraction.
sll $t4, $t1, 9 # Shift out exponent and sign bit
srl $t5, $t4, 9 # Shift back to original position. This will make all previous bits 0
add $t6, $t5, 8388608 # add the impied bit to bit number 8 (2^23)
add $t7, $s3, 9 #add 9 to the exponent
sllv $s4, $t6, $t7 # By shifting to the left 9 + exponent. If this number NE 0 then there is a fraction. Shifted out the inetger portion















# Now get the integer
rol $t4, $t6, $t7 # Rotate the bits left by $t7 to get the intger portion in the right most bits
# Shift left 31 -exp to zero out the other bits
li $t5, 31
sub $t2, $t5, $s3 # Shift value
sllv $t5, $t4, $t2 # Zero out the fraction part.
srlv $s5, $t5, $t2 # reset integer bits. Integer is in $s5



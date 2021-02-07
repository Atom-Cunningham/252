#Adam Cunningham
#csc252
#Spring 2019
#assembly assignment 1
#asm1.s

#this is an introduction to MIPS, an assembly language
#the program can perform the following tasks:
#find the median value of three values,
#update the values in memory of the given 3 to their absolute values
#calculate the sum of the 3 updated values
#rotate the updated values in memory, one to two, two to three, three to one
#dump: print the new values of the three given values


.text

.globl studentMain
studentMain:
	# Function prologue -- even main has one
	addiu $sp, $sp, -24   # allocate stack space -- default of 24 here
	sw    $fp, 0($sp)     # save caller's frame pointer
	sw    $ra, 4($sp)     # save return address
	addiu $fp, $sp, 20    # setup main's frame pointer

	#median will find the median value
	#of the three given numbers, one, two, three
MEDIAN:
	la    $t0, median     #$t0 = &median
	lw    $s0, 0($t0)     #$s0 = median
	
	
	beq   $s0, $zero, ABSVAL   #if (median == 1) median, else goto ABSVAL
	
	la    $t0, one        #$t0 = &one
	lw    $s0, 0($t0)     #$s0 = one
	
	la    $t0, two        #$t0 = &two
	lw    $s1, 0($t0)     #$s1 = two
	
	la    $t0, three      #$t0 = &three
	lw    $s2, 0($t0)     #$s2 = three
	
	slt   $s5, $s0, $s1   #if (one < two)   $s5 = 1
	slt   $s6, $s0, $s2   #if (one < three) $s6 = 1
	slt   $s7, $s1, $s2   #if (two < three) $s7 = 1
	
	
	bne   $s0, $s1, TWO_IS_THREE   #if (one == two)   goto TWO_IS_THREE
	bne   $s0, $s2, TWO_IS_THREE   #if (one != three) goto TWO_IS_THREE
	add   $s4, $zero, $s0          #one == two == three, so $s4 = one
	j     PRINT_MEDIAN             #goto print statement
	
TWO_IS_THREE:
	bne   $s1, $s2, UNIQUE_VARS_CASE    #if (two != three) goto unique case
	add   $s4, $zero, $s1               #two == three, so $s4 = two
	j     PRINT_MEDIAN

UNIQUE_VARS_CASE:

	bne   $s5, $s7, NOT_TWO   #if (one < two) != (two < three) goto NOT _TWO
	add   $s4, $zero, $s1     #two is median, $s4 = two goto print
	j     PRINT_MEDIAN
	
NOT_TWO:	
	beq   $s5, $s6, NOT_ONE   #if (one < two) == (one < three) goto NOT_ONE
	add   $s4, $zero, $s0
	j     PRINT_MEDIAN

NOT_ONE:
	#this last check is redundant, by process of elimination
	#we know by now that the median is three
	#this branch should never execute
	#consider jumping to error statement
	beq   $s6, $s7, ABSVAL #if (one < three) == (two < three) goto absval    
	add   $s4, $zero, $s2
	j     PRINT_MEDIAN
	
PRINT_MEDIAN:
	.data
	MSG_COMPS:  .asciiz    "Comparisons: "
	.text
	
	
	addi  $v0, $zero, 4   #set syscall to print_str
	la    $a0, MSG_COMPS  #set sys arg to msg_comps
	syscall
	
	
	addi  $v0, $zero, 1   #set syscall to print_int	
	add   $a0, $zero, $s5 #set sys arg to (two < three)
	syscall
	
			      # print_chr(' ')
	addi	$v0, $zero,11
	addi	$a0, $zero,0x20
	syscall
	
	addi  $v0, $zero, 1   #set syscall to print_int	
	add   $a0, $zero, $s6 #set sys arg to (one < two)
	syscall
	
				      # print_chr(' ')
	addi	$v0, $zero,11
	addi	$a0, $zero,0x20
	syscall
	
	addi  $v0, $zero, 1   #set syscall to print_int	
	add   $a0, $zero, $s7 #set sys arg to (two < three)
	syscall
	
	
			# print_chr('\n')
	addi	$v0, $zero,11
	addi	$a0, $zero,0xa
	syscall
	
	.data
	MSG_MED:  .asciiz     "median: "
	.text

	addi  $v0, $zero, 4   #set syscall to print_str
	la    $a0, MSG_MED    #set sys arg to msg_med
	syscall

	addi  $v0, $zero, 1  #print_int (median)
	add   $a0, $s4, $zero#load argument median
	syscall
	
		# print_chr('\n')
	addi	$v0, $zero,11
	addi	$a0, $zero,0xa
	syscall
	
		# print_chr('\n')
	addi	$v0, $zero,11
	addi	$a0, $zero,0xa
	syscall


ABSVAL:	#convert all variables (one, two, three) into positive ints
	.data
	NEG_ONE:  .asciiz "'one' was negative\n"
	.text
	.data
	NEG_TWO:  .asciiz "'two' was negative\n"
	.text
	.data
	NEG_THREE:.asciiz "'three' was negative\n"
	.text
	#convert all variables (one, two, three) into positive ints
	la    $t0, absVal     #$t0 = &absVal
	lw    $s4, 0($t0)     #$s4 = absVal
	beq   $s4, $zero, SUM     #if (absVal != 1) goto sum
	
		
	la    $t0, one        #$t0 = &one
	lw    $s0, 0($t0)     #$s0 = one
	
	la    $t0, two        #$t0 = &two
	lw    $s1, 0($t0)     #$s1 = two
	
	la    $t0, three      #$t0 = &three
	lw    $s2, 0($t0)     #$s2 = three
	
	slt   $s4, $s0, $zero #if (one < 0)   $s4 = 1 else 0
	slt   $s5, $s1, $zero #if (two < 0)   $s5 = 1 else 0
	slt   $s6, $s2, $zero #if (three < 0) $s6 = 1 else 0
	
	beq   $s4, $zero, ABSTWO  #if (one >= 0)  goto abstwo
	sub   $s0, $zero, $s0 #$s0 = -one (should be pos
	
	addi  $v0, $zero, 4   #set syscall to print_str
	la    $a0, NEG_ONE    #set sys arg to neg_one
	syscall

ABSTWO:
	beq   $s5, $zero, ABSTHREE#if (two >= 0) goto absthree
	sub   $s1, $zero, $s1 #$s1 = -two (should be pos)
	
	addi  $v0, $zero, 4   #set syscall to print_str
	la    $a0, NEG_TWO    #set sys arg to neg_two
	syscall

ABSTHREE:
	beq   $s6, $zero, UPDATE_VALS #if (three >= 0) goto updatevals
	sub   $s2, $zero, $s2     #$s2 = -three (should be pos)
	
	addi  $v0, $zero, 4   #set syscall to print_str
	la    $a0, NEG_THREE  #set sys arg to neg_three
	syscall
	
UPDATE_VALS:
	#restore all given variables (one, two, three)
	#back into the memory, changed or not
	la    $t0, one        #$t0 = &one
	sw    $s0, 0($t0)     #&one = one
	
	la    $t0, two        #$t0 = &two
	sw    $s1, 0($t0)     #&two = $s1
	
	la    $t0, three      #$t0 = &three
	sw    $s2, 0($t0)     #&three = $s2
	
			      # print_chr('\n')
	addi	$v0, $zero,11
	addi	$a0, $zero,0xa
	syscall
		
SUM:
	#reload variables from the memory (one, two, three)
	#sum the variables
        la    $t0, sum        #$t0 = &sum
	lw    $s4, 0($t0)     #$s4 = sum
	
	beq   $s4, $zero, DUMP#if ($s4 == 1) sum, else goto ROTATE
	#sum the three given numbers, one, two, three
	la    $t0, one	      #$t0 = &one
	lw    $s0, 0($t0)     #$s0 = one
	
	la    $t0, two	      #$t0 = &two
	lw    $s1, 0($t0)     #$s1 = two
	add   $s4, $s0, $s1   #$s4 = one + two
	
	la    $t0, three      #$t0 = &three
	lw    $s2, 0($t0)     #$s2 = three
	add   $s4, $s4, $s2   #$s4 = one + two + three
	
	.data
	MSG_SUM:  .asciiz "sum: "
	.text
	addi  $v0, $zero, 4   #set syscall to print_str
	la    $a0, MSG_SUM    #set sys arg to msg_sum
	syscall
	
	addi  $v0, $zero, 1   #print_int(one + two + three)
	add   $a0, $s4, $zero #load argument
	syscall
	
		# print_chr('\n')
	addi	$v0, $zero,11
	addi	$a0, $zero,0xa
	syscall
	syscall
	
ROTATE:
	la    $t0, rotate    #$t0 = &rotate
	lw    $s3, 0($t0)    #$s4 = rotate
	beq   $s3, $zero, DUMP	     #if (rotate != 1) goto dump
	
	add   $s3, $zero, $s0#$s3 = one
	add   $s0, $zero, $s2#$s0 = three
	add   $s2, $zero, $s1#$s2 = two
	add   $s1, $zero, $s3#$s1 = one
	
	la    $t0, one       #$t0 = &one
	sw    $s0, 0($t0)    #one = three
	
	la    $t0, two       #$t0 = &two
	sw    $s1, 0($t0)    #two = one
	
	la    $t0, three     #$t0 = &three
	sw    $s2, 0($t0)    #three = two

DUMP:
	la    $t0, dump       #$t0 = &dump
	lw    $s4, 0($t0)     #$s4 = dump
	beq   $s4, $zero, DONE    #if (dump != 1) goto done
	
	.data
	MSG_ONE:   .asciiz "one: "
	.text
	addi  $v0, $zero, 4   #set syscall to print_str
	la    $a0, MSG_ONE    #set sys arg to msg_one
	syscall
	addi  $v0, $zero, 1   #set syscall to print_int
	add   $a0, $zero, $s0 #set sys arg to one
	syscall
	
			     # print_chr('\n')
	addi	$v0, $zero,11
	addi	$a0, $zero,0xa
	syscall

	.data
	MSG_TWO:   .asciiz "two: "
	.text
	addi  $v0, $zero, 4   #set syscall to print_str
	la    $a0, MSG_TWO    #set sys arg to msg_two
	syscall
	addi  $v0, $zero, 1   #set syscall to print_int
	add   $a0, $zero, $s1 #set sys arg to two
	syscall
	
			      # print_chr('\n')
	addi	$v0, $zero,11
	addi	$a0, $zero,0xa
	syscall	
	
	.data
	MSG_THREE:  .asciiz "three: "
	.text
	addi  $v0, $zero, 4   #set syscall to print_str
	la    $a0, MSG_THREE  #set sys arg to msg_three
	syscall
	addi  $v0, $zero, 1   #set syscall to print_int
	add   $a0, $zero, $s2 #set sys arg to three
	syscall
	
                              # print_chr('\n')
	addi	$v0, $zero,11
	addi	$a0, $zero,0xa
	syscall
	syscall



DONE:   # Epilogue for main -- restore stack & frame pointers and return
	lw    $ra, 4($sp)     # get return address from stack
	lw    $fp, 0($sp)     # restore the caller's frame pointer
	addiu $sp, $sp, 24    # restore the caller's stack pointer
	jr    $ra             # return to caller's code

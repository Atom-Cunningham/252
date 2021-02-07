#Author: Adam Cunningham
#asm2.s
#2/17/19
#this program has several functions
#it reads in instructions from an input file
#it checks global variables to determine which functions to output
#its functions include:

#printing out n numbers of the fibonacci sequence
#printing a square of size i by i, with custom fill char
#checking to see if an array is in ascending or descending order
#counting the number of words in a string
#reversing a string in memory


.globl studentMain


studentMain:
	# Function prologue -- even main has one
	addiu $sp, $sp, -24   # allocate stack space -- default of 24 here
	sw    $fp, 0($sp)     # save caller's frame pointer
	sw    $ra, 4($sp)     # save return address
	addiu $fp, $sp, 20    # setup main's frame pointer


FIB:
        #FIB will print numbers of the fibbinaci sequence
        #starting with 0,1. fib is a passed in value >=0
        #prints out fib many numbers, including the first two
        
	la    $t0, fib               #$t0 = &fib
	lw    $s0, 0($t0)            #$s0 = fib
	
	#we may assume fib is never negative
	slt   $t0, $zero, $s0        #if (0 < fib) $t0 = 1, else $t0 = 0
	beq   $t0, $zero, SQUARE     #if ($t0 == 0) goto next function
	                             #else it is true that fib is non-0
	
	addi  $t1, $zero, 1          #$t1 = 1 (prev)
	addi  $t2, $zero, 1	     #$t2 = 1 (beforeThat)
	addi  $t3, $zero, 2          #$t3 = 2 (n)
	
	slt     $t0, $s0, $t3        #if (fib < n): $t0 = 1
	bne     $t0, $zero, SQUARE   #if (fib < n): do not print first- 
				     #print statements ('  0:1'),('  0:1')
				     #or "Fibonacci Numbers:\n"
	
	.data
	FIB_LABEL:    .asciiz        "Fibonacci Numbers:\n"
	.text
	
	addi    $v0, $zero, 4        #set syscall to print_str
	la      $a0, FIB_LABEL       #set sysarg to ""Fibonacci Numbers:\n"
	syscall
	
	#print('  0: 1')
	addi    $v0, $zero, 11       #set syscall to print_char
	addi    $a0, $zero, 0x20     #set sys argument to ' '
	syscall                      #print_chr(' ')
	syscall                      #print_chr(' ')
	
	addi    $a0, $zero, 0x30     #set sys argument to '0'
	syscall                      #print_chr('0')
	
	addi    $a0, $zero, 0x3a     #set sys argument to ':'
	syscall                      #print_chr(':')
	
	addi    $a0, $zero, 0x20     #set sys argument to ' '
	syscall                      #print_chr(' ')
	
	addi    $a0, $zero, 0x31     #set sys argument to '1'
	syscall                      #print_chr('1')
	
	addi    $a0, $zero, 0xa      #set sys argument to '\n'
	syscall                      #print_chr('\n')
	
	#the following code until FIBLOOP label is
	#heavy repetition of lines 38-55
	#print('  1: 1')
	
	addi    $a0, $zero, 0x20     #set sys argument to ' '
	syscall                      #print_chr(' ')
	syscall                      #print_chr(' ')
	
	addi    $a0, $zero, 0x31     #set sys argument to '1'
	syscall                      #print_chr('0')
	
	addi    $a0, $zero, 0x3a     #set sys argument to ':'
	syscall                      #print_chr(':')
	
	addi    $a0, $zero, 0x20     #set sys argument to ' '
	syscall                      #print_chr(' ')
	
	addi    $a0, $zero, 0x31     #set sys argument to '1'
	syscall                      #print_chr('1')
	

FIBLOOP:
	#FIBLOOP is entered after each iteration of finding
        #the next fibbinaci sequence number, so long as the
        #number of series elements printed so far is less than
        #the given variable (pulled from test files)
        
 
        slt     $t0, $s0, $t3        #if (fib < n): $t0 = 1
	bne     $t0, $zero, FIB_END  #if (fib < n): do not enter while loop
				     #instead goto next function label (square)
        add     $t4, $t1, $t2        #$t4 = $t1+$t2; curr = prev + beforeThat
        
       				     #print printf(" n: curr\n", n, cur)     
	addi	$v0, $zero, 11       #set syscall to print char
		
	addi    $a0, $zero, 0xa      #set sys argument to '\n'
	syscall                      #print_chr('\n')
	
	addi	$a0, $zero, 0x20     #set sys argument to ' ' char
	syscall                      # print_chr(' ')
	syscall		             # print_chr(' ') (again)
	
	addi	$v0, $zero, 1        #set syscall to print int
	add     $a0, $zero, $t3      #set sys argument to $t3; (n)
	syscall                      #print_int $t3; n
	
	addi	$v0, $zero, 11       #set syscall to print char
	addi    $a0, $zero, 0x3a     #set sys argument to ':'
	syscall                      #print_chr (':')
	
	addi    $a0, $zero, 0x20     #set sys argument to ' '
	syscall                      #print_chr (' ')
	
        addi    $v0, $zero, 1        #set syscall to print int
        add     $a0, $zero, $t4      #set sysargs to $t0; curr
        syscall                      #print curr
        
        #
        addi    $t3, $t3, 1          #$t3 += 1; n++
        add     $t2, $t1, $zero      #$t2 = $t1; beforeThat = prev
        add     $t1, $t4, $zero      #$t1 = $t4; prev = curr
        
        j       FIBLOOP
FIB_END:
	addi    $v0, $zero, 11       #set syscall to print char
	addi    $a0, $zero, 0x0a     #set sys arg to '\n'
	syscall                      #print_char('\n')

SQUARE: 
	#check to see if something should be called, then begin with a new line

	#TODO print newline
	#prints a square given the variables from the testfile
	la    $t0, square            #load the address of the global variable 
	                             #square
	lw    $t0, 0($t0)            #load the value of square into $t0
	                             #should be 0 or 1
	beq   $t0, $zero, RUN_CHECK  #if square == 0, goto runCheck label
	
	addi   $v0, $zero, 11         #set syscall to print_char
	addi   $a0, $zero, 0x0a       #set sysarg to '\n'
	syscall                       #print_char('\n')
	
	la    $s0, square_size       #load &square_size var into $s0
	lw    $s0, 0($s0)            #load int square_size into $s0
	
	la    $s1, square_fill       #load &square_fill var into $s1
	lb    $s1, 0($s1)            #load char square_fill into $s1
	
	add   $s2, $zero, $zero      #set $s2 (row counter) to 0
	
SQUARE_LOOP: 

	
	slt   $t0, $s2, $s0          #set $t0 to (row < square_size)
	addi  $t1, $zero, 1
	bne   $t0, $t1, END_SQUARE  #if (n>= square_size) goto end_square

TOP:
        #sets up first row
	bne   $s2, $zero, BOTTOM     #if (row != 0) goto middle
	
	addi  $t0, $zero, 0x2b       #$t0 = '+'; lr variable = '+'
	addi  $t1, $zero, 0x2d       #$t1 = '-'; mid variable = '-'

	j     PRINT_ROW
	
BOTTOM:                              #sets up last row
        addi  $t0, $zero, 1          #$t0 = 1
        sub   $t0, $s0, $t0          #$t0 = square_size - 1
        bne   $t0, $s2, MIDDLE       #if (n == row_size -1) goto middle
                                     
                                     
	addi  $t0, $zero, 0x2b       #$t0 = '+'; lr variable = '+'
	addi  $t1, $zero, 0x2d       #$t1 = '-'; mid variable = '-'

	j     PRINT_ROW              #goto print_row label
	
MIDDLE:
        #set variables
        addi  $t0, $zero, 0x7c       #lr = '|'
        add   $t1, $zero, $s1        #$t1 = $s1 = square_fill

PRINT_ROW:
       #print the row of the box as--
       #print out the left character, the middle character
       #print out the right character

       addi   $v0, $zero, 11         #set syscall to print_char
       add    $a0, $zero, $t0        #set sys argument to lr
       syscall                       #print_char(lr)
       
       addi   $t2, $zero, 1      #t2 = 0 = i
       addi   $t3, $zero, 1      #t3 = 1
       sub    $t3, $s0, $t3      #t3 = square_size -1
PRINT_FILL:
       beq    $t2, $t3, PRINT_REST   #if (i==rowsize-1) goto print_rest
       add    $a0, $zero, $t1        #set sys argument to mid char
       syscall                       #print_char(mid)
       
       addi   $t2, $t2, 1            #i++
       j      PRINT_FILL             #goto top of loop

PRINT_REST:
       add    $a0, $zero, $t0        #set sys argument to lr
       syscall                       #print_char(lr)
       
       addi   $a0, $zero, 0x0a       #set sys argument to '\n'
       syscall                       #print_char('\n')
      
       #jump to start
       addi   $s2, $s2, 1            #row++
       j      SQUARE_LOOP            #goto square loop
	  
END_SQUARE:
       addi   $a0, $zero, 0x0a       #set sysarg to '\n'
       syscall                       #print_char('\n')
       
       
       
       
       
       
RUN_CHECK:
	#checks an array of integers for ascending/descending order
	
	la     $t0, runCheck          #get the runcheck command
	lw     $t0, 0($t0)            #load the runcheck command
	beq    $t0, $zero, COUNTWORDS #if (runcheck == 0) goto countwords

	la     $t0, intArray_len      #get an address for array length
	lw     $s0, 0($t0)            #load array length
	
	la     $s4, intArray          #load int array
	
	addi   $s1, $zero, 1          #$s1 = 1 = ascending
	addi   $s2, $zero, 1          #$s2 = 1 = descending
	
	beq    $s0, $zero, PRINT_CHECK_ASC
				     #if (arraylen == 0) goto prints
	beq    $s0, $s1, PRINT_CHECK_ASC
	                             #if (arraylen == 1) goto prints			     
	
	#for i = 0; i<len; i++
	#check if two list items are equal, greater than or less than each other
	#keep track of result in $s1, $s2, as ascending, descending
	add    $s3, $zero, $zero      #$s3 = 0 = i
	sub    $s0, $s0, $s1          #len = len-1

RUN_LOOP:
	slt    $t2, $s3, $s0          #$t2 = (i < len)
	beq    $t2, $zero, PRINT_CHECK_ASC
	                             #if (i < len) goto prints
	lw     $t0, 0($s4)
	lw     $t1, 4($s4)
	
	
EQ_CHECK:
	bne    $t0, $t1, ASC_CHECK  #if (intArray[i] != intArray[i+1]
				    #continue with the checks
	j      CHECK_LOOP_END       #else skip checks
	      
ASC_CHECK:
        
        slt    $t2, $t0, $t1        #$t0 = array[i] < array[i+1]
                	            #if (array[i] < array[i+1])
        bne    $t2, $zero, DEC_CHECK           #goto next check
	add    $s1, $zero, $zero    #else ascending = 0
        
        
DEC_CHECK:
       
        slt    $t2, $t1, $t0        #$t0 = array[i] > array[i+1]
                	            #if (array[i] > array[i+1])
                                    #goto end of loop step
        bne    $t2, $zero, CHECK_LOOP_END
	add    $s2, $zero, $zero    #else descending = 0
        
        
CHECK_LOOP_END:
	addi  $s3, $s3, 1           #i++
	addi  $s4, $s4, 4           #move to next array item
        j     RUN_LOOP              #goto top of loop

PRINT_CHECK_ASC:

	                               #if (ascending == 0) goto next print
	beq    $s1, $zero, PRINT_CHECK_DEC 
	
	.data
	ASCENDING:    .asciiz          "Run Check: ASCENDING\n"
	.text
        addi   $v0, $zero, 4           #set syscall to print_str
        la     $a0, ASCENDING          #set sys arg to 'Run Check: ASCENDING'
        syscall
        
PRINT_CHECK_DEC:
	                               #if (descending == 0) goto next print
	beq    $s2, $zero, PRINT_CHECK_NEITHER 
	
	.data
	DESCENDING:    .asciiz        "Run Check: DESCENDING\n"
	.text
        addi   $v0, $zero, 4          #set syscall to print_str
        la     $a0, DESCENDING        #set sys arg to 'Run Check: DESCENDING'
        syscall

PRINT_CHECK_NEITHER:

	beq    $s1, $zero, NEWLINE    #if (ascending == 0) goto end function
	beq    $s2, $zero, NEWLINE    #if (descending == 0) goto end function
	
	.data
	NEITHER:    .asciiz           "Run Check: NEITHER\n"
	.text
        addi   $v0, $zero, 4          #set syscall to print_str
        la     $a0, NEITHER           #set sys arg to 'Run Check: NEITHER\n'
        syscall
        
NEWLINE:
	addi   $v0, $zero, 11         #set syscall to print_char
	addi   $a0, $zero, 0x0a       #set sys args to '\n'
	syscall
	
COUNTWORDS:
	#countwords checks the number of words in a string
	#a word by this function is any non-space or null character
	#followed by a space or null character
	#countwords prints the count after completion
	
	la    $t0, countWords   #get the address of the countwords command
	lw    $t0, 0($t0)       #load the value of the countwords command
	                        #if (countwords == 0) goto revstring
	beq   $t0, $zero, REVSTRING
	
	add   $s3, $zero, $zero #$s3 = 0 = wordCount
	la    $s0, str          #get the address of the string

COUNT_LOOP:
	lb    $s1, 0($s0)       #load the current character of the string
	                        #if the current char is null, goto print
	addi  $t6, $zero, 0x00
	beq   $s1, $t6, PRINT_COUNT
	
	                        #if current character is a space
			        # goto end of loop
	addi  $t6, $zero, 0x20
	beq   $s1, $t6, COUNT_LOOP_END
	
	lb    $s2, 1($s0)       #$s2 = value of the next char
			        #if next character is a space
			        # goto increment
	addi  $t6, $zero, 0x20
	beq   $s2, $t6, COUNTWORD
	                        #or if next character is null
	                        #goto increment	
	addi  $t6, $zero, 0x00
	beq   $s2, $t6, COUNTWORD
	
	
	j     COUNT_LOOP_END    #if (str[i] is a letter)
		                #and (str[i+1] is not a space or null
		                #goto the end of the loop
	     


COUNTWORD:
	addi   $s3, $s3, 1     #increment the wordcount

COUNT_LOOP_END:
	
	addi   $s0, $s0, 1    #increment the address
	j  COUNT_LOOP
	
PRINT_COUNT:
	#print the result of the count
        addi    $v0, $zero, 1          #set syscall to print_int
        add     $a0, $zero, $s3        #set sys argument to wordcount
        syscall			       #print wordcount
	
	addi    $v0, $zero, 11         #set syscall to print char
	addi    $a0, $zero, 0x0a       #set sys arguent to '\n'
	syscall     		       #print_char('\n')
	syscall     		       #print_char('\n')
	

REVSTRING:

	#revstring reverses all the characters in a string in the memory
	la      $t0, revString	       #load &revString into $t0
	lw      $t0, 0($t0)	       #$t0 = *revString
	beq     $t0, $zero, DONE       #if (revString == 0) end the program
	
	add     $t0, $zero, $zero      #$t0 = 0 = head
	add     $t1, $zero, $zero      #$t1 = 0 = tail
	
	la      $s1, str               #$s0 = &string

FIND_TAIL:
	lb      $s2, 0($s1)            #load the curr character
				       #$s1 = string[i]
			               #if (char == \0) goto donefindtail
	addi    $t6, $zero, 0x00
	beq     $s2, $t6, DONE_FIND_TAIL 
	
	addi    $t1, $t1, 1	       #count the curr character
	addi	$s1, $s1, 1            #increment the address
	j       FIND_TAIL              #goto top of loop

DONE_FIND_TAIL:
	addi $t7, $zero, 1 #$t3 = 1
	sub $t1, $t1, $t7 #tail = tail -1
SWAP:


	
	slt     $t4, $t0, $t1          #$t4 = head < tail
	beq     $t4, $zero, END_SWAP   #if (tail >= head) goto end of function
	
	la     $s3, str		      #get the address of $s3

	add    $s0, $t0, $s3	      #get the address offset by the head
	lb     $t2, 0($s0)            #$t2 = string[head]
	add    $s1, $s3, $t1          #get the address offset by tail
	lb     $t3, 0($s1)            #get the byte

	sb     $t3, 0($s0)	      #newString[head] = string[tail]
	sb     $t2, 0($s1)	      #newString[tail] = string[head]
	
	
	sub $t1, $t1, $t7 #tail = tail -1
	addi    $t0, $t0, 1            #head++
	j       SWAP                   #goto top of function

END_SWAP:

.data
.globl swapped
swapped:
	.asciiz  "String successfully swapped!\n\n"


.text
	addi    $v0, $zero, 4          #set syscall to string
	la      $a0, swapped           #set sysarg to swap comment
	syscall
	
DONE:   
	# Epilogue for main -- restore stack & frame pointers and return
	lw    $ra, 4($sp)     # get return address from stack
	lw    $fp, 0($sp)     # restore the caller's frame pointer
	addiu $sp, $sp, 24    # restore the caller's stack pointer
	jr    $ra             # return to caller's code

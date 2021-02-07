# demo.s
#
# This file is the scaffolding for early Software projects.  In those, you
# will put all of your code inside a function named studentMain(); the
# testcase will include a main() function.
#
# When the testcase runs, MARS will jump to main() in the testcase - and
# then, after things have been set up properly, the testcase will call your
# studentMain() code below.


.text

.globl studentMain
studentMain:
	# Function prologue -- even main has one
	addiu $sp, $sp, -24   # allocate stack space -- default of 24 here
	sw    $fp, 0($sp)     # save caller's frame pointer
	sw    $ra, 4($sp)     # save return address
	addiu $fp, $sp, 20    # setup main's frame pointer


	
	TODO: Put your code here!
	 


DONE:   # Epilogue for main -- restore stack & frame pointers and return
	lw    $ra, 4($sp)     # get return address from stack
	lw    $fp, 0($sp)     # restore the caller's frame pointer
	addiu $sp, $sp, 24    # restore the caller's stack pointer
	jr    $ra             # return to caller's code

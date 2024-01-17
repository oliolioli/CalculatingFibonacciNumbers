# some data for nice output after calculation
.data
	str0:
	.string "Please input your desired first x fibonacci numbers to calculate (max: 30): \n"

	str1:
	.string "Fibonacci "
	
	str2:
	.string " = "

# the program itself to calculate Fibonacci numbers
.text

	li a0, 1
	la a1, str0
	li a2, 78
	li a7, 64
	ecall


	addi a7, zero, 5			# Reads a double from input console
	ecall					# Syscall

	#addi a0, zero, 12			# store n=10 into a0 -- a0 ist unsere Laufvariable, t1 unsere zweite Laufvariable
	mv a1, a0				# unsere zweite Laufvariable (wir wollen nur bis Stufe n rekursiv ausrechnen)
	
	addi s0, zero, 0			# fib(0) = 0
	addi s1, zero, 1			# fib(1) = 1
	
	
	addi t0, zero, 1
	
	# We try to calculate fibonacci numbers
	fibonacci:
		bgt a0, t0, else		# if ( n > 1 ), n is still too big: we jump to label "else"
		
		add s2, s1, s0			# Add temporary results and put them into s2	(s2 will carry our fibonacci result at a certain level (level = t0) 
		
		mv s0, s1			# Now move the last two results "backwards" s1 -> s0 and s2 -> s1
		mv s1, s2
		
		addi t0, t0, 1			# Increase index variable (to climb back the whole tree from leaf)
		
		beq t0, a1, end
		jr ra				# return to return address
	
	# As long we are at the end of the tree (=leaf), we iterate further down
	else:					
		addi a0, a0, -1			# thus decrease a0
		jal fibonacci			# and (recursive) jump and link "fibonacci" again
		
		j fibonacci			# return
	
	
	# Finished calculating fibonacci number and now printing some nice readable results	
	end:			
	
		li a0, 1   	# li means to Load Immediate and we want to load the value 1 into register a0
		la a1, str1 	# la is similar to li, but works for loading addresses
		li a2, 11  	# like the first line, but with length of string. This is the final argument to the system call
		li a7, 64  	# a7 is what determines which system call we are calling and we what to call write (64)
		ecall      	# actually issue sys call
		
		mv a0, t0
		addi a7, zero, 1
		ecall
		
		li a0, 1
		la a1, str2
		li a2, 4
		li a7, 64
		ecall
		
		mv a0, s2
		addi a7, zero, 1
		ecall		
		
		addi a7, zero, 93
		addi a0, zero, 0
		ecall
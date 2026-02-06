# Eren Durham - Computer Architecture
# Phase 1 of Semester project
# Problem 1: Multiplication

# Using bit shifting to multiply two numbers
# Logic:
	# while b > 0
		# if b & 1 == 1
			# result += a
		# sll a 1
		# srl b 1

.data
a: .word 22
b: .word 59
c: .word 0

.text
.globl main

main:
    # Load in variables ----------------
    lui  t0, %hi(a)
    addi t0, t0, %lo(a)
    lw t1, 0(t0)     # a = t1
    
    lui  t0, %hi(b)
    addi t0, t0, %lo(b)
    lw t2, 0(t0)     # b = t2
    
    lui  t0, %hi(c)
    addi t0, t0, %lo(c)
    lw t3, 0(t0)     # c = t3
    
    # Main logic       ----------------
start:
    beq t2, x0, done      # while b > 0
    
    andi t4, t2, 1        # check if b right most bit is = 1, so AND it
    addi t0, x0, 1              # load immediate to compare for loop
    bne t4, t0, continue  # is b=1 after the AND? If no, then move on
    
    add t3, t3, t1        # add a to the result
    
continue:
    slli t1, t1, 1        # shift a to the left
    srli t2, t2, 1        # shift b to the right

    # saves c for end
    lui  t0, %hi(c)
    addi t0, t0, %lo(c)
    sw t3, 0(t0)
 
    jal x0, start              # loop back to start of the logic

done:
    lui  t5, %hi(c) 
    addi t5, t5, %lo(c) 
    lw   a0, 0(t5)

    addi a7, x0, 1
    ecall

    # exit program
    addi a7, x0, 10
    ecall

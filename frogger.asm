# Demo for painting
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
.data
	displayAddress: .word 0x10008000
	#--------------- frog --------------------#
	frog_x_start: .word 0x000E
	frog_y_start: .word 0x001C
	frog_x: .word 0x000E
	frog_y: .word 0x001C
	normal_frog_color: .word 0x8b8970
	dead_frog_color: .word 0xe066ff 
	
	
	first_vehicle_row: .space 512
	second_vehicle_row: .space 512
	first_log_row: .space 512
	second_log_row: .space 512
	
	lives: .word 0x0003
	#-------------- Different Speed Feature ------------#	
	first_vehicle_row_movement_counter: .word 0x0000
	second_vehicle_row_movement_counter: .word 0x0000
	first_log_row_movement_counter: .word 0x0000
	second_log_row_movement_counter: .word 0x0000
	
	seventy_five: .word 0x4B
	sixty: .word 0x3C
	forty_five: .word 0x2D
	thirty: .word 0x1E
	
	#--------------- Color Constant --------------------#
	vehicle_color: .word 0xff0000
	water_color: .word 0x436EEE
	log_color: .word 0xcd8500
	
	#--------------- Collison bit --------------------#
	no_collision: .word 0x000001
	
	#----------------Score Variable -------------------#
	score: .word 0x000000
.text

#################################################################################################################
#----------------------------------------store first vehical row memory-----------------------------------------#
START:	
	li $t0, 0
	sw $t0, score
	
	li $v0, 1
	lw $a0, score
	syscall
	
fill_first_vehicle_row:
	lw   $t0, displayAddress # $t0 stores the base address for display
	lw   $t1, vehicle_color # $t1 stores the red colour code
	li   $t2, 0x000000 # $t2 stores the black colour code
	
	la  $t3, first_vehicle_row
	add $t9, $zero, $t3 
	 
	add  $t7, $zero, $zero
	addi $t8, $zero, 4
	
fill_first_vehicle_row_loop:
	beq $t7, $t8, fill_first_vehicle_row_end
	add $a0, $zero, $t9
	add $a1, $zero, $t1
	jal store_8_pixels_colors
	
	addi $t9, $t9, 32
	add $a0, $zero, $t9
	add $a1, $zero, $t2
	jal store_8_pixels_colors
	
	addi $t9, $t9, 32
	add $a0, $zero, $t9
	add $a1, $zero, $t1
	jal store_8_pixels_colors
	
	addi $t9, $t9, 32
	add $a0, $zero, $t9
	add $a1, $zero, $t2
	jal store_8_pixels_colors
	
	addi $t9, $t9, 32
	addi $t7, $t7, 1
	j fill_first_vehicle_row_loop
		
fill_first_vehicle_row_end:

#################################################################################################################
#----------------------------------------store second vehical row memory----------------------------------------#

fill_second_vehicle_row: 	
	lw   $t0, displayAddress # $t0 stores the base address in Bitmap
	li   $t1, 0x000000 # $t1 stores the black colour code
	lw   $t2, vehicle_color # $t2 stores the red colour code
	
	la  $t3, second_vehicle_row
	add $t9, $zero, $t3 
	 
	add  $t7, $zero, $zero
	addi $t8, $zero, 4
	
fill_second_vehicle_row_loop:
	beq $t7, $t8, fill_second_vehicle_row_end
	add $a0, $zero, $t9
	add $a1, $zero, $t1
	jal store_8_pixels_colors
	
	addi $t9, $t9, 32
	add $a0, $zero, $t9
	add $a1, $zero, $t2
	jal store_8_pixels_colors
	
	addi $t9, $t9, 32
	add $a0, $zero, $t9
	add $a1, $zero, $t1
	jal store_8_pixels_colors
	
	addi $t9, $t9, 32
	add $a0, $zero, $t9
	add $a1, $zero, $t2
	jal store_8_pixels_colors
	
	addi $t9, $t9, 32
	addi $t7, $t7, 1
	j fill_second_vehicle_row_loop	
	
fill_second_vehicle_row_end:

	
#################################################################################################################
#---------------------------------------------store first log row memory----------------------------------------#

fill_first_log_row: 	
	lw   $t0, displayAddress # $t0 stores the base address for display
	lw   $t1, log_color # $t1 stores the brown colour code
	lw   $t2, water_color # $t2 stores the blue colour code
	
	la  $t3, first_log_row
	add $t9, $zero, $t3 
	 
	add  $t7, $zero, $zero
	addi $t8, $zero, 4
	
fill_first_log_row_loop:
	beq $t7, $t8, fill_first_log_row_end
	add $a0, $zero, $t9
	add $a1, $zero, $t1
	jal store_8_pixels_colors
	
	addi $t9, $t9, 32
	add $a0, $zero, $t9
	add $a1, $zero, $t2
	jal store_8_pixels_colors
	
	addi $t9, $t9, 32
	add $a0, $zero, $t9
	add $a1, $zero, $t1
	jal store_8_pixels_colors
	
	addi $t9, $t9, 32
	add $a0, $zero, $t9
	add $a1, $zero, $t2
	jal store_8_pixels_colors
	
	addi $t9, $t9, 32
	addi $t7, $t7, 1
	j fill_first_log_row_loop
		
fill_first_log_row_end:


	
################################################################################################################
#---------------------------------------------store second log row memory---------------------------------------#

fill_second_log_row: 	
	lw   $t0, displayAddress # $t0 stores the base address for display
	lw   $t1, water_color # $t1 stores the blue colour code
	lw   $t2, log_color # $t2 stores the brown colour code
	
	
	la  $t3, second_log_row
	add $t9, $zero, $t3 
	 
	add  $t7, $zero, $zero
	addi $t8, $zero, 4
	
fill_second_log_row_loop:
	beq $t7, $t8, fill_second_log_row_end
	add $a0, $zero, $t9
	add $a1, $zero, $t1
	jal store_8_pixels_colors
	
	addi $t9, $t9, 32
	add $a0, $zero, $t9
	add $a1, $zero, $t2
	jal store_8_pixels_colors
	
	addi $t9, $t9, 32
	add $a0, $zero, $t9
	add $a1, $zero, $t1
	jal store_8_pixels_colors
	
	addi $t9, $t9, 32
	add $a0, $zero, $t9
	add $a1, $zero, $t2
	jal store_8_pixels_colors
	
	addi $t9, $t9, 32
	addi $t7, $t7, 1
	j fill_second_log_row_loop	
fill_second_log_row_end:





####################################################################################################
############################################# MAiNLOOP #############################################
####################################################################################################
MAINLOOP:	
######################################## KeyStroke Detection #######################################
keystroke_detection:
	lw $t8, 0xffff0000
	bne $t8, 1, draw_3_areas
	
	
	lw $t2, 0xffff0004
	beq $t2, 0x61, respond_to_A
	beq $t2, 0x77, respond_to_W 
	beq $t2, 0x73, respond_to_S 
	beq $t2, 0x64, respond_to_D 
	
	j draw_3_areas
	
respond_to_A:
	lw $t3, frog_x
	addi $t3, $t3, -1
	sw $t3, frog_x
	
	add $t3, $zero, $zero
	j draw_3_areas
	
respond_to_W:
	lw $t1, frog_y
	addi $t1, $t1, -1
	sw $t1, frog_y
	
	add $t1, $zero, $zero
	j draw_3_areas

respond_to_S:
	lw $t1, frog_y
	addi $t1, $t1, 1
	sw $t1, frog_y
	
	add $t1, $zero, $zero
	j draw_3_areas

respond_to_D:
	lw $t3, frog_x
	addi $t3, $t3 1
	sw $t3, frog_x
	
	add $t3, $zero, $zero
	j draw_3_areas
	

########################################## draw 3 safe areas #######################################
	
draw_3_areas:
	lw $t0, displayAddress 	# $t0 stores the base address for display
	li $t1, 0xff0000 	# $t1 stores the red colour code
	li $t2, 0x00ff00 	# $t2 stores the green colour code
	li $t3, 0x0000ff 	# $t3 stores the blue colour code
	
	addi $a0, $zero, 0 
	addi $a1, $zero, 256
	li $a2, 0x00ff00 	# $a2 stores the green colour code   
	jal  draw_rect
	
	addi $a0, $zero, 512
	addi $a1, $zero, 128 
	li $a2, 0xeec900 	# $a2 stores the yellow colour code    
	jal  draw_rect
	
	addi $a0, $zero, 896
	addi $a1, $zero, 128
	li $a2, 0x00ff00 	# $a2 stores the green colour code   
	jal  draw_rect
	
	
########################################## draw lives ########################################

draw_lives:
	lw    $t0, displayAddress # $t0 stores the base address for display
	
	lw $t1, lives
	li $t2, 0x0001
	li $t3, 0x0002
	
	beq $t1, $t2, draw_one_live     # if $t1 = 1
	beq $t1, $t3, draw_two_lives    # if $t1 = 2
	
	addi $a0, $zero, 37
	addi $a1, $zero, 1
	li   $a2, 0xff4500
	jal draw_rect
	
draw_two_lives:
	addi $a0, $zero, 35
	addi $a1, $zero, 1
	li   $a2, 0xff4500
	jal draw_rect
	
draw_one_live:	
	addi $a0, $zero, 33
	addi $a1, $zero, 1
	li   $a2, 0xff4500
	jal draw_rect


################################################################################################################
#------------------------------------------------draw rows-----------------------------------------------------#

draw_rows:	
	################################## draw vehicle rows ######################################
	add $a0, $zero, 640
	la  $a1, first_vehicle_row
	jal draw_a_row
	
	add $a0, $zero, 768
	la  $a1, second_vehicle_row
	jal draw_a_row

	################################## draw log rows ##################################
	add $a0, $zero, 256
	la  $a1, first_log_row
	jal draw_a_row 
	
	add $a0, $zero, 384
	la  $a1, second_log_row
	jal draw_a_row		
	

################################################################################################################
#------------------------------------------update rows memory--------------------------------------------------#

	#--------------------------- check whether update row memory ---------------------------
check_update_rows:
check_update_first_vehicle_row:
	lw $t0, sixty     # t0 = 60
	lw $t1, first_vehicle_row_movement_counter
	beq $t1, $t0, update_first_vehicle_row   # check if fvrmc = 60
	# if not update memory, we increment the movement counter
	lw $t0, first_vehicle_row_movement_counter
	addi $t0, $t0, 1
	sw $t0, first_vehicle_row_movement_counter	

check_update_first_log_row:
	lw $t0, thirty     # t0 = 30
	lw $t1, first_log_row_movement_counter
	beq $t1, $t0, update_first_log_row   # check if flrmc = 30
	# if not update memory, we increment the movement counter
	lw $t0, first_log_row_movement_counter
	addi $t0, $t0, 1
	sw $t0, first_log_row_movement_counter

check_update_second_vehicle_row:
	lw $t0, seventy_five    # t0 = 75
	lw $t1, second_vehicle_row_movement_counter
	beq $t1, $t0, update_second_vehicle_row   # check if flrmc = 30
	# if not update memory, we increment the movement counter
	lw $t0, second_vehicle_row_movement_counter
	addi $t0, $t0, 1
	sw $t0, second_vehicle_row_movement_counter

check_update_second_log_row:
	lw $t0, forty_five    # t0 = 45
	lw $t1, second_log_row_movement_counter
	beq $t1, $t0, update_second_log_row   # check if flrmc = 30
	# if not update memory, we increment the movement counter
	lw $t0, second_log_row_movement_counter
	addi $t0, $t0, 1
	sw $t0, second_log_row_movement_counter
	
	j detect_collision
	
	#--------------------------- update first vehicle row (--->) ---------------------------
update_first_vehicle_row:
	la $t0, first_vehicle_row
	addi $a3, $t0, 0
	jal move_a_row_right
	la $t0, first_vehicle_row
	addi $a3, $t0, 128
	jal move_a_row_right
	la $t0, first_vehicle_row
	addi $a3, $t0, 256
	jal move_a_row_right
	la $t0, first_vehicle_row
	addi $a3, $t0, 384
	jal move_a_row_right
	sw $zero, first_vehicle_row_movement_counter # set first_vehicle_row_movement_counter = 0
	j check_update_rows	
	#--------------------------- update first log row (--->) ---------------------------
update_first_log_row:
	la $t0, first_log_row
	addi $a3, $t0, 0
	jal move_a_row_right
	la $t0, first_log_row
	addi $a3, $t0, 128
	jal move_a_row_right
	la $t0, first_log_row
	addi $a3, $t0, 256
	jal move_a_row_right
	la $t0, first_log_row
	addi $a3, $t0, 384
	jal move_a_row_right
	sw $zero, first_log_row_movement_counter # set first_log_row_movement_counter = 0
	j check_update_rows	
	#--------------------------- update second vehicle row (<---) ---------------------------
update_second_vehicle_row:
	la $t0, second_vehicle_row
	addi $a3, $t0, 0
	jal move_a_row_left
	la $t0, second_vehicle_row
	addi $a3, $t0, 128
	jal move_a_row_left
	la $t0, second_vehicle_row
	addi $a3, $t0, 256
	jal move_a_row_left
	la $t0, second_vehicle_row
	addi $a3, $t0, 384
	jal move_a_row_left
	sw $zero, second_vehicle_row_movement_counter # set second_vechile_row_movement_counter = 0
	j check_update_rows
	#--------------------------- update second log row (<---) ---------------------------
update_second_log_row:
	la $t0, second_log_row
	addi $a3, $t0, 0
	jal move_a_row_left
	la $t0, second_log_row
	addi $a3, $t0, 128
	jal move_a_row_left
	la $t0, second_log_row
	addi $a3, $t0, 256
	jal move_a_row_left
	la $t0, second_log_row
	addi $a3, $t0, 384
	jal move_a_row_left
	sw $zero, second_log_row_movement_counter # set second_log_row_movement_counter = 0
	j check_update_rows

update_rows_memory_end:

	
################################################################################################################
#---------------------------------------------detect-collision-------------------------------------------------#
detect_collision:
	lw    $a1, vehicle_color
	lw    $a2, water_color
	
	lw    $t0, displayAddress # $t0 stores the base address for display
	lw    $t2, frog_x	  # $t2 stores x value of frog in 32*32 table
	lw    $t3, frog_y	  # $t3 stores y value of frog in 32*32 table
	
	sll   $t4, $t3, 5  	 
	# left-top-corner
	add   $t4, $t4, $t2       # t4 = frog_y * 32 + 14 (current address in 32*32)
	sll   $t5, $t4, 2         # t5 is the offset in mips = 4 * t4
	add   $t6, $t5, $t0  	  # t6 is the address in mips
	lw    $t1, 0($t6)
	add   $a0, $t1, $zero        	# set-up color left-corner-pos of frog
	jal   reset_collision_detection
	
	# right-top-corner
	addi  $t7, $t4, 3
	sll   $t5, $t7, 2 
	add   $t6, $t5, $t0 
	lw    $t1, 0($t6)
	add   $a0, $t1, $zero          # set-up color
	jal   reset_collision_detection
		  
	# left-down-corner
	addi  $t7, $t4, 96  
	sll   $t5, $t7, 2 
	add   $t6, $t5, $t0
	lw    $t1, 0($t6)
	add   $a0, $t1, $zero          # set-up color
	jal   reset_collision_detection
		  
	# right-down-corner
	addi  $t7, $t4, 99   
	sll   $t5, $t7, 2 
	add   $t6, $t5, $t0 
	lw    $t1, 0($t6)
	add   $a0, $t1, $zero           # set-up color
	jal   reset_collision_detection
	
################################################################################################################
#---------------------------------------------draw frog--------------------------------------------------------#
	# go to normal draw if no collsion is true, i.e.m = 1
	lw $t1, no_collision
	addi $t2, $zero, 1
	beq $t1, $t2, normal_frog_draw
	
reset_frog_draw:
	lw $a1, dead_frog_color
	jal draw_frog
	
	li $v0, 32
	li $a0, 1000
	syscall
	
	j frog_end
	
normal_frog_draw:
	lw $a1, normal_frog_color
	jal draw_frog
	

frog_end:




################################################################################################################
#-------------------------deal-with-collision (restart game) and decrement a live---------------------------------------#
deal_with_collision:
	lw  $t1, no_collision
	add $t2, $zero, $zero
	bne $t1, $t2 deal_with_collision_end   # jump over the body to the end if no collision
	
	# sound effect
	li $v0, 33
	li $a0, 40
	li $a1, 300
	li $a2, 1
	li $a3, 100
	syscall 
	
	jal reset_frog
	
decrement_live:
	lw $t3, lives
	addi $t3, $t3, -1
	sw $t3, lives
	
	# set back to no collison
	addi $t5, $zero, 1
	sw $t5, no_collision
	
	beq $t3, $zero, detect_retry
deal_with_collision_end:	


################################################################################################################
#---------------------------------------draw goal region (and reset frog)--------------------------------------------#
	lw $t1, frog_y
	addi $t2, $zero, 4
	bne $t1, $t2, draw_goal_region_end
	
draw_goal_region:
	li $v0, 32       # sleep for a second
	li $a0, 500
	syscall
	
	lw $t0, displayAddress 	# $t0 stores the base address for display
	addi $a0, $zero, 0
	addi $a1, $zero, 256
	li $a2, 0xffa500 	# $a2 stores the yellow colour code    
	jal  draw_rect
	
	# sound effect
	li $v0, 33
	li $a0, 80
	li $a1, 300
	li $a2, 60
	li $a3, 100
	syscall 
	
	# add 100 to score, and print out the score
	lw $s1, score
	addi $s1, $s1, 100
	sw $s1, score
	
	li $v0, 1
	lw $a0, score
	syscall
	
	li $v0, 32       # sleep for a second
	li $a0, 1000
	syscall
	
	jal reset_frog
	
	
	
draw_goal_region_end:

################################## sleep ##################################

sleep:	li $v0, 32
	li $a0, 16
	syscall
	j MAINLOOP
		
####################################################################################################
####################################################################################################
####################################################################################################

################################## detect-retry ##################################
detect_retry:
	# sound effect
	li $v0, 33
	li $a0, 60
	li $a1, 1500
	li $a2, 1
	li $a3, 100
	syscall 
	
re_detect:
	lw $t0, displayAddress 	# $t0 stores the base address for display
	
	addi $a0, $zero, 0 
	addi $a1, $zero, 1024
	li $a2, 0x828282	# $a2 stores the bloody red colour code   
	jal  draw_rect
	
	# keystroke_detection
	lw $t8, 0xffff0000
	bne $t8, 1, re_detect
	
	
	lw $t2, 0xffff0004
	beq $t2, 0x72, respond_to_r
	j re_detect
	
respond_to_r:
	addi $t3, $zero, 3
	sw $t3, lives
	j START
	


##################################################################################################
###################################----FUNCTIONS----##############################################
##################################################################################################

#----------------------------------------------------------------------------------------------------
# function: draw_rect
# arguments: $a0 = starting location in 32*32 table, 
#	     $a1 = number of pixel to draw in 32*32 case
# 	     $a2 = color
# $t4 = i = current # of pixels drawn 
# $t8 = starting location in address (mips) = t0 + a0 * 4
# $t6 = offset value (i * 4),
# $t7 = t4 + t6 = current location to draw on mips 
draw_rect:	
	add   $t4, $zero, $zero   # set i = 0
	sll   $t8, $a0, 2         # t8 = a0 * 4
	add   $t8, $t0, $t8       # t8 = t8 + t0, starting postion in mips
draw_rect_loop:	
	beq   $t4, $a1, draw_rect_end    # stops when i = $a1 
	sll   $t6, $t4, 2         # set $t6 to be offset in pixel value
	add   $t7, $t8, $t6       # set $t7 to be location to draw
	sw    $a2, 0($t7)         # draw color (a2) on address $t7
	addi  $t4, $t4, 1         # i = i + 1
	j draw_rect_loop
draw_rect_end:
	jr $ra

#---------------------------------drawing from memeory----------------------------------------------------------
# function: draw_a_row
# arguments: $a_0: starting index to draw on Bitmap Display
# 	     $a_1: starting index of memory array where we store the color
draw_a_row:	
	add $t1, $zero, $a0
	sll $t1, $t1, 2
	add $t2, $zero, $zero # i
	addi $t3, $zero, 128
	add $t4, $t0, $t1	
draw_a_row_loop: 
	# Calculate address in mips
	beq $t2, $t3, draw_a_row_end
	sll $t5, $t2, 2 	   # t5 = i * 4
	add $t6, $t5, $t4          # address in mips to color
	# Load value from corresponding address in array
	lw   $t8, 0($a1)           # t8 = color to draw
	sw   $t8, 0($t6) 
	 	
	addi $a1, $a1, 4  
	addi $t2, $t2, 1	
	j draw_a_row_loop	
draw_a_row_end:
	jr $ra

#-------------------------------------store_8_pixels_colors----------------------------------------

# function: store_8_pixels_colors
# arguments: $a_0: address of memery to store in
# 	     $a_1: color to fill in
store_8_pixels_colors: 
	add  $t4, $zero, $zero   # i - loop counter, i = 0
	addi $t5, $zero, 8       # t5 = 8
store_8_pixels_colors_loop:      
	beq $t4, $t5, store_8_pixels_colors_end  # loop ends after 8 iterations
	sll $t6, $t4, 2 		# $t6 = offset (i * 4)
	add $t6, $a0, $t6 		# current address of memery to store in
	sw  $a1, 0($t6) 		# store color into address 	  
	addi $t4, $t4, 1    		# i = i + 1
	j store_8_pixels_colors_loop	
store_8_pixels_colors_end:
	jr $ra


#-----------------------------------------move_right----------------------------------------------
# function: move_right 
# move a row of 32 slots to right by 1 slot
# arguments：$a3 = strating location of the row in 32*32 maps
move_a_row_right:
	add $t0, $zero, $a3       # t0 = starting point of the array, address of A[0]
	addi $t1, $t0, 124        # t1 = t0 + 124, address of A[31]
	lw $t2, 0($t1)       	    # t2 = color in the 32nd slot of the array
	
	addi $t1, $zero, 0           # i = loop counter
	addi $t6, $zero, 32          # t2 = number of loop iterations	
move_a_row_right_loop:   	  # Loop Invariant: t2 = current color to store
	beq $t1, $t6, move_a_row_right_end
	sll $t3, $t1, 2             # t3 = offset from starting point
	add $t4, $t0, $t3           # t4 = current array address to draw = t3 + t0
	lw $t5, 0($t4)              # t5 = color pixel in A[i]
	
	sw $t2, 0($t4)              # store color pixel t5 into t4 (array address)
	add $t2, $t5, $zero         # t2 = t5 = A[i] color pixel
	
	addi $t1, $t1, 1            # i = i + 1
	j move_a_row_right_loop	
move_a_row_right_end:	
	sw $t2, 0($t0)	            # A[0] store a color pixel t2
	jr $ra

#-----------------------------------------move_left----------------------------------------------
# function: move_left 
# move a row of 32 slots to right by 1 slot
# arguments：$a3 = strating location of the row in 32*32 maps

move_a_row_left:
	add $t0, $zero, $a3 	# t0 = starting point of the array, address of A[0]
 	addi $t1, $t0, 0 	# t1 = t0, address of A[0]
 	lw $t2, 0($t1) 		# t2 = color in the 1st slot of the array
 
 	addi $t1, $zero, 31 	# i = loop counter
 	addi $t6, $zero, -1 
move_a_row_left_loop:   # Loop Invariant: t2 = current color to store
 	beq $t1, $t6, move_a_row_left_end
 	sll $t3, $t1, 2 	# t3 = offset from starting point
 	add $t4, $t0, $t3 	# t4 = current array address to draw = t3 + t0
 	lw $t5, 0($t4) 		# t5 = color pixel in A[i]
 
 	sw $t2, 0($t4) 		# store color pixel t5 into t4 (array address)
 	add $t2, $t5, $zero 	# t2 = t5 = A[i] color pixel
 
 	addi $t1, $t1, -1  	# i = i - 1
 	j move_a_row_left_loop
move_a_row_left_end: 
 	addi $t0, $t0, 124  
 	sw $t2, 0($t0) 		# A[31] store a color pixel t2
 	jr $ra

#-----------------------------------------reset_collision_detection----------------------------------------------
# function: reset_collision_detection 
# arguments：$a0 = color of checking point
# 	     $a1 = color of vehicle
#   	     $a2 = color of log
reset_collision_detection:
	beq   $a0, $a1, reset_collision_detection_body
	bne   $a0, $a2, reset_collision_detection_end
reset_collision_detection_body:
	sw    $zero, no_collision   # if collisison happends, store false (0) to no_collision
reset_collision_detection_end:
	jr    $ra
	
#-----------------------------------------draw_frog ----------------------------------------------
# function: draw_frog 
# arguments：$a0 = color of frog
draw_frog:
	lw    $t0, displayAddress # $t0 stores the base address for display
	lw    $t2, frog_x	  # $t2 stores x value of frog in 32*32 table
	lw    $t3, frog_y	  # $t3 stores y value of frog in 32*32 table
	
	# t4 = address of left-top corner of frog in 32*32
	# t5 = offset (4 * current address in 32*32)
	# t6 = address in mips = t5 + t0 
		
	# left-top coner
	sll   $t4, $t3, 5   
	add   $t4, $t4, $t2       # t4 = frog_y * 32 + 14 (current address in 32*32)
	sll   $t5, $t4, 2         # t5 is the offset in mips = 4 * t4
	add   $t6, $t5, $t0  	  # t6 is the address in mips
	sw    $a1, 0($t6) 	  
	
	# right-top coner
	addi  $t7, $t4, 3
	sll   $t5, $t7, 2 
	add   $t6, $t5, $t0  	  
	sw    $a1, 0($t6) 	
	# second row of frog
	addi  $t7, $t4, 32
	sll   $t5, $t7, 2 
	add   $t6, $t5, $t0  	  
	sw    $a1, 0($t6) 	
	addi  $t7, $t4, 33
	sll   $t5, $t7, 2 
	add   $t6, $t5, $t0  	  
	sw    $a1, 0($t6) 	
	addi  $t7, $t4, 34
	sll   $t5, $t7, 2 
	add   $t6, $t5, $t0  	  
	sw    $a1, 0($t6) 
	addi  $t7, $t4, 35
	sll   $t5, $t7, 2 
	add   $t6, $t5, $t0  	  
	sw    $a1, 0($t6) 	
	# third row of frog
	addi  $t7, $t4, 65
	sll   $t5, $t7, 2 
	add   $t6, $t5, $t0  	  
	sw    $a1, 0($t6)	
	addi  $t7, $t4, 66
	sll   $t5, $t7, 2 
	add   $t6, $t5, $t0  	  
	sw    $a1, 0($t6)
	# forth row of frog  
	addi  $t7, $t4, 96   # left-down-corner
	sll   $t5, $t7, 2 
	add   $t6, $t5, $t0  	  
	sw    $a1, 0($t6) 
	
	addi  $t7, $t4, 97
	sll   $t5, $t7, 2 
	add   $t6, $t5, $t0  	  
	sw    $a1, 0($t6) 
	addi  $t7, $t4, 98
	sll   $t5, $t7, 2 
	add   $t6, $t5, $t0  	  
	sw    $a1, 0($t6)   
	   	
	addi  $t7, $t4, 99   # right-down-corner
	sll   $t5, $t7, 2 
	add   $t6, $t5, $t0  	  
	sw    $a1, 0($t6) 
	
	jr $ra

#----------------------------------------reset_frog----------------------------------------#
# fucntion: reset_frog
reset_frog:
	lw $t3, frog_x_start
	lw $t4, frog_y_start
	sw $t3, frog_x
	sw $t4, frog_y
	jr $ra

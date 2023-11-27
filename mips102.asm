.data
    main_welcome_msg: .asciiz "Machobane Farming Simulation\n\n"
    menu_msg: .asciiz "Select option from the menu:\n1. Winter Crop Management\n2. Summer Crop Management\n3. Prepare soil\n4. Calculate Yield\n5. Quit\n"
    newline: .asciiz "\n"
    schedule_msg: .asciiz "The Planted crops are scheduled to be harvested between January and March\n"
    message: .asciiz "The Planted crops are scheduled to be harvested between January and March\n"
    message_summer: .asciiz "The Planted crops are scheduled to be harvested between November and December\n"
    prompt_wheat: .asciiz "Enter the number of wheat crops: "
    prompt_peas: .asciiz "Enter the number of peas crops: "
    prompt_potatoes: .asciiz "Enter the number of potatoes crops: "
    prompt_maize: .asciiz "Enter the number of maize crops: "
    prompt_beans: .asciiz "Enter the number of beans crops: "
    prompt_pumpkin: .asciiz "Enter the number of pumpkin crops: "
    prompt_sorghum: .asciiz "Enter the number of sorghum crops: "
    prompt_watermelon: .asciiz "Enter the number of watermelon crops: "
    prompt_groundnut: .asciiz "Enter the number of groundnut crops: "
    soil_fert_msg: .asciiz "Enter the soil fertility factor read by the soil NPK sensor:\n"
    moisture_msg: .asciiz "\nEnter level of soil moisture between 1 and 10:\n"
    harvest_msg: .asciiz "Harvested\n"
    soil_fert: .word 0
    soil_moist: .word 0
    soil_qual: .word 0
    total_crop: .word 0
    soil_qual_msg: .asciiz "The soil quality of the plot is: "
    low_msg: .asciiz "Soil fertility is low."
    mod_msg: .asciiz "Soil fertility is moderate."
    high_msg: .asciiz "Soil fertility is high."
    moist_low: .asciiz "Soil moisture is low\n"
    moist_high: .asciiz "Soil moisture is adequate\n"
    yield_msg: .asciiz "Enter the yield factor:\n"
   
   #We define the variables used in the main
    soil_condition: .word 0
    wheat: .word 5
    peas: .word 0
    potatoes: .word 0
    maize: .word 0
    beans: .word 0
    pumpkin: .word 0
    sorghum: .word 0
    watermelon: .word 0
    groundnut: .word 0
    option: .word 0

    #These are the menu options
    WINTER_OPTION: .word 1
    SUMMER_OPTION: .word 2
    SOIL_OPTION: .word 3
    YIELD_OPTION: .word 4
    QUIT_OPTION: .word 5

.text
.globl SummerCropManagement
.globl WinterCropManagement
.globl soil_prep_condition
.globl yield_calc
.globl main

main:
 
    subu $sp, $sp, 4 #move the stack pointer down to make space for the main welcome message in the stack
    li $v0, 4
    la $a0, main_welcome_msg
    syscall

main_loop: #	the purpose of this loop is to display the menu by way of a do while loop 
    li $v0, 4
    la $a0, menu_msg
    syscall
    
    #We are the user to choose an option displayed on the menu to enter into a certain function
    li $v0, 5
    syscall
    sw $v0, option

    # having obtained the option from the user, we use the switch-case method to go to the option chosen
    
    lw $t0, option
    beq $t0, $zero, main_loop  # Loop if option is 0

   # Handle each option
    lw $t0, option

    # if the option is 1
    lw $t1, WINTER_OPTION
    beq $t0, $t1, handle_winter

    # if the option is 2
    lw $t1, SUMMER_OPTION
    beq $t0, $t1, handle_summer

    # if the option is 3
    lw $t1, SOIL_OPTION
    beq $t0, $t1, handle_soil

    # if the option is 4
    lw $t1, YIELD_OPTION
    beq $t0, $t1, handle_yield

    # if the option is 5
    lw $t1, QUIT_OPTION
    beq $t0, $t1, exit_program

    # If none of the options matched, go back to main loop
    j main_loop


handle_winter:
# we now ask the user to give the number of wheat, pea and potato seeds to plant individually
#we do this here instead of inside the winter function because we want to have the variables in the global scope
        li $v0, 4
        la $a0, prompt_wheat
        syscall
        li $v0, 5
        syscall
        move $s0, $v0   # Save wheat quantity in $s0

        li $v0, 4
        la $a0, prompt_peas
        syscall
        li $v0, 5
        syscall
        move $s1, $v0   # Save peas quantity in $s1

        li $v0, 4
        la $a0, prompt_potatoes
        syscall
        li $v0, 5
        syscall
        move $s2, $v0   # Save potatoes quantity in $s2
    jal WinterCropManagement
    j main_loop #gives the function the ability to call the menu again after executing the code in the function

handle_summer:
#when we get here, we again ask the user to give the number of seeds to plant and we do so here to have then in the global scope

	li $v0, 4
        la $a0, prompt_maize
        syscall
        li $v0, 5
        syscall
        move $s3, $v0   # Save wheat quantity in $s0

        li $v0, 4
        la $a0, prompt_beans
        syscall
        li $v0, 5
        syscall
        move $s4, $v0   # Save peas quantity in $s1

        li $v0, 4
        la $a0, prompt_pumpkin
        syscall
        li $v0, 5
        syscall
        move $s5, $v0   # Save potatoes quantity in $s2
        
        
        li $v0, 4
        la $a0, prompt_sorghum
        syscall
        li $v0, 5
        syscall
        move $s6, $v0   # Save wheat quantity in $s0

        li $v0, 4
        la $a0, prompt_watermelon
        syscall
        li $v0, 5
        syscall
        move $s7, $v0   # Save peas quantity in $s1

        li $v0, 4
        la $a0, prompt_groundnut
        syscall
        li $v0, 5
        syscall
        move $a3, $v0   # Save potatoes quantity in $s2
    jal SummerCropManagement
    j main_loop

handle_soil:
    # Get soil fertility factor from the user
    li $v0, 4
    la $a0, soil_fert_msg
    syscall
    li $v0, 5
    syscall
    move $a0, $v0  # Move user input to $a0
    jal soil_prep_condition
    j main_loop

handle_yield:
    jal yield_calc
    jr $ra                 # Return
    j main_loop
    
    
yield_calc:
    # before executing the code in any function, we must remember the responsibility of save registers to avoid overwriting any important information
    subu $sp, $sp, 8       # Make space on the stack for local variables
    sw $ra, 0($sp)         # Save return address
    sw $s0, 4($sp)         # Save s0 (yield)
    

 
    lw $a0, total_crop         # Load total_crops
    lw $a1, soil_qual        # Load soil_qual

    # Calculate yield = total_crops * soil_condition
    mul $s0, $a0, $a1

    li $v0, 1              # Print integer syscall code
    move $a0, $s0          # Load yield into $a0
    syscall

    # at the end of each function we must then restore any register that we altered at the beginning of the function
    #this is done to sometimes free registers so the can be used elsewhere outside the scope of the the function
    #we must also restore the stack pointer in the same manner that we moved it down to accomodate our registers to allow other functions to be able to use it
    lw $ra, 0($sp)         # Restore return address
    lw $s0, 4($sp)         # Restore s0
    addu $sp, $sp, 8       # Restore the stack pointer

soil_prep_condition:
    subu $sp, $sp, 12      
    sw $ra, 0($sp)          
    sw $s0, 4($sp)          
    sw $s1, 8($sp)          
    sw $s2, 12($sp)        

    # Read soil fertility factor
    li $v0, 4
    la $a0, soil_fert_msg
    syscall
    li $v0, 5
    syscall
    sw $v0, soil_fert

    # Test soil fertility
    lw $s0, soil_fert
    li $t0, 5
    blt $s0, $t0, low_fertility
    beq $s0, $t0, moderate_fertility
    j high_fertility

low_fertility:
    li $v0, 4
    la $a0, low_msg
    syscall
    j read_moisture

moderate_fertility:
    li $v0, 4
    la $a0, mod_msg
    syscall
    j read_moisture

high_fertility:
    li $v0, 4
    la $a0, high_msg
    syscall
    j read_moisture

read_moisture:
    # Read soil moisture level
    li $v0, 4
    la $a0, moisture_msg
    syscall
    li $v0, 5
    syscall
    sw $v0, soil_moist

    # Test soil moisture
    lw $s1, soil_moist
    li $t1, 5
    blt $s1, $t1, low_moisture
    j high_moisture

low_moisture:
    li $v0, 4
    la $a0, moist_low
    syscall
    j calculate_soil_qual

high_moisture:
    li $v0, 4
    la $a0, moist_high
    syscall
    j calculate_soil_qual

calculate_soil_qual:
    # Calculate soil quality
    lw $s2, soil_qual
    add $s2, $s0, $s1
    srl $s2, $s2, 1  # Divide by 2

    # Print soil quality
    li $v0, 4
    la $a0, soil_qual_msg
    syscall
    li $v0, 1
    move $a0, $s2
    syscall

  
    lw $ra, 0($sp)          
    addu $sp, $sp, 12      
    jr $ra                  


SummerCropManagement:
 
Summer:
   
    sw $ra, 0($sp)          # Save return address
    sw $s3, 4($sp)          
    sw $s4, 8($sp)          
    sw $s5, 12($sp)         
    sw $s6, 16($sp)         
    sw $s7, 20($sp)         
    sw $a3, 24($sp)         

    # Print maize
    li $v0, 11              # Print character syscall code
    li $t0, 'M'             # Character to print
    move $t1, $s3           # Load maize quantity into $t1

    maize_loop:
        bnez $t1, print_maize
        j end_maize_loop
    print_maize:
        syscall
        subu $t1, $t1, 1
        j maize_loop

    end_maize_loop:
    li $v0, 4               # Print newline
    la $a0, newline
    syscall

    # Print beans
    li $v0, 11              # Print character syscall code
    li $t0, 'B'             # Character to print
    move $t1, $s4           # Load beans quantity into $t1

    beans_loop:
        bnez $t1, print_beans
        j end_beans_loop
    print_beans:
        syscall
        subu $t1, $t1, 1
        j beans_loop

    end_beans_loop:
    li $v0, 4               # Print newline
    la $a0, newline
    syscall

    # Print pumpkin
    li $v0, 11              # Print character syscall code
    li $t0, 'P'             # Character to print
    move $t1, $s5           # Load pumpkin quantity into $t1

    pumpkin_loop:
        bnez $t1, print_pumpkin
        j end_pumpkin_loop
    print_pumpkin:
        syscall
        subu $t1, $t1, 1
        j pumpkin_loop

    end_pumpkin_loop:
    li $v0, 4               # Print newline
    la $a0, newline
    syscall

    # Print sorghum
    li $v0, 11              # Print character syscall code
    li $t0, 'S'             # Character to print
    move $t1, $s6           # Load sorghum quantity into $t1

    sorghum_loop:
        bnez $t1, print_sorghum
        j end_sorghum_loop
    print_sorghum:
        syscall
        subu $t1, $t1, 1
        j sorghum_loop

    end_sorghum_loop:
    li $v0, 4               # Print newline
    la $a0, newline
    syscall

    # Print watermelon
    li $v0, 11              # Print character syscall code
    li $t0, 'W'             # Character to print
    move $t1, $s7           # Load watermelon quantity into $t1

    watermelon_loop:
        bnez $t1, print_watermelon
        j end_watermelon_loop
    print_watermelon:
        syscall
        subu $t1, $t1, 1
        j watermelon_loop

    end_watermelon_loop:
    li $v0, 4               # Print newline
    la $a0, newline
    syscall

    # Print groundnut
    li $v0, 11              # Print character syscall code
    li $t0, 'G'             # Character to print
    move $t1, $a3           # Load groundnut quantity into $t1

    groundnut_loop:
        bnez $t1, print_groundnut
        j end_groundnut_loop
    print_groundnut:
        syscall
        subu $t1, $t1, 1
        j groundnut_loop

    end_groundnut_loop:
    li $v0, 4               # Print newline
    la $a0, newline
    syscall

    # Print schedule message
    li $v0, 4
    la $a0, schedule_msg
    syscall

    
    lw $ra, 0($sp)          # Restore return address
    lw $s3, 4($sp)          # Restore $s3 (maize)
    lw $s4, 8($sp)          # Restore $s4 (beans)
    lw $s5, 12($sp)         # Restore $s5 (pumpkin)
    lw $s6, 16($sp)         # Restore $s6 (sorghum)
    lw $s7, 20($sp)         # Restore $s7 (watermelon)
    lw $a3, 24($sp)         # Restore $a3 (groundnut)
    addu $sp, $sp, 28       # Restore the stack pointer
    jr $ra                  # Return

WinterCropManagement:
    
    sw $ra, 0($sp)          # Save return address
    sw $s0, 4($sp)          # Save $s0
    sw $s1, 8($sp)          # Save $s1
    sw $s2, 12($sp)         # Save $s2

    # Print wheat
    li $v0, 11              # Print character syscall code
    li $t0, '*'             # Character to print
    move $t1, $s0           # Load wheat quantity into $t1

    wheat_loop:
        bnez $t1, print_wheat
        j end_wheat_loop
    print_wheat:
        syscall
        subu $t1, $t1, 1
        j wheat_loop

    end_wheat_loop:
    li $v0, 4               # Print newline
    la $a0, newline
    syscall

    # Print peas
    li $v0, 11              # Print character syscall code
    li $t0, '%'             # Character to print
    move $t1, $s1           # Load peas quantity into $t1

    peas_loop:
        bnez $t1, print_peas
        j end_peas_loop
    print_peas:
        syscall
        subu $t1, $t1, 1
        j peas_loop

    end_peas_loop:
    li $v0, 4               # Print newline
    la $a0, newline
    syscall

    # Print potatoes
    li $v0, 11              # Print character syscall code
    li $t0, '@'             # Character to print
    move $t1, $s2           # Load potatoes quantity into $t1

    potatoes_loop:
        bnez $t1, print_potatoes
        j end_potatoes_loop
    print_potatoes:
        syscall
        subu $t1, $t1, 1
        j potatoes_loop

    end_potatoes_loop:
    li $v0, 4               # Print newline
    la $a0, newline
    syscall
    # Print schedule message
    li $v0, 4
    la $a0, schedule_msg
    syscall

    lw $ra, 0($sp)          # Restore return address
    lw $s0, 4($sp)          # Restore $s0
    lw $s1, 8($sp)          # Restore $s1
    lw $s2, 12($sp)         # Restore $s2
    addu $sp, $sp, 16       # Restore the stack pointer
    jr $ra                  # Return
    
exit_program:
   
    li $v0, 10
    syscall

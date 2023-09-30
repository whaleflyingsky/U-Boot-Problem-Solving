# U-Boot-Problem-Solving


### Task Analysis
The objective is to copy data from ROM area, starting from address 0x00 to 0x1000, to the RAM area at address 0x40000000 and then transfer control to RAM. This is a common practice in many embedded systems to enhance performance. However, frequent system freezes occur during the boot-up process, necessitating a 40ms delay before copying data to RAM as a solution. To address this task, I have configured and simulated the code in KEIL.


### Project Setting
1. Install `Keil uVision7`.
2. Use target `ARM7`.
3. Register an `.ini` file in the Debug menu.   



### Exploring Solutions   

**delay**

The processor we are working with has a clock speed of 60MHz. To implement a 40ms delay as required in Task Analysis, we can utilize the inverse relationship between clock frequency and time. With the clock frequency occurring every 1/(60 x 10^6) seconds, there will be 2,400,000 clock cycles within 0.04 seconds (40 ms).

In the Reset_Handler, I split the value 2,400,000 into upper and lower parts to avoid errors when loading it into R4. Then, in the delay_40ms function, I use the SUBS instruction to decrement R4 by 1 and loop until R4 reaches 0. Each loop iteration effectively measures time.

**copy_code**

The task involves copying code blocks from the ROM area to the RAM area to enhance program execution performance. I accomplished this by using the LDMIA instruction to read data from the ROM area starting at address 0x0 and the STMIA instruction to store this data in the RAM area starting at address 0x40000000. I set the copy size using the SUBS instruction and repeated the load and store operations accordingly.

**loop_copy**

Using the LDMIA instruction, I read data from the memory location pointed to by R1 into registers R5 through R12. I then update the value of R1 to point to the next memory location. The STMIA instruction is employed to store the data from registers R5 to R12 at the memory location indicated by R2, and R2 is updated to point to the next memory location. The SUBS instruction is used to subtract 8 from R3 and store the result in R3, setting the status flags accordingly. Finally, based on the previously set status flags, the program either branches to loop_copy or proceeds accordingly.

**branch**

This code involves copying code from ROM to SRAM and then continuing execution in SRAM. The branch_SRAM section jumps to the code at the address obtained by adding an offset of 0x40 (64) to the SRAM_BASE address using the BX command. The NOP instruction serves as padding to maintain code alignment.

After branching to Execute_App_From_SRAM, additional tasks are performed. The MOV R7, #10 instruction loads the value 10 into R7 to facilitate the execution of the code under the Execute_App_From_SRAM label.






	AREA Reset, CODE, READONLY
	ENTRY

SRAM_BASE        EQU 0x40000000
ROM_START        EQU 0x0
WORDS_TO_COPY    EQU 1024

	EXPORT Reset_Handler

Reset_Handler
    
    MOV R4, #0x24B          
    LSL R4, R4, #12         
    ADD R4, R4, #0x580      

delay_40ms
    SUBS R4, R4, #1
    BNE delay_40ms
    
copy_code
    LDR R1, =ROM_START
    LDR R2, =SRAM_BASE
    LDR R3, =WORDS_TO_COPY

loop_copy
    LDMIA R1!, {R5-R12}
    STMIA R2!, {R5-R12}
    SUBS R3, R3, #8
    BGT loop_copy

branch_SRAM   
    LDR R7, =SRAM_BASE     
    ADD R7, R7, #0x40      
    BX R7                  
    NOP
    NOP

	
Execute_App_From_SRAM
    MOV R7, #10

fin_loop
	B	fin_loop


	END    
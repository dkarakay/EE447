SYSCTL_RCGCGPIO  	EQU 0x400FE608
	
SYSCTL_RCGCSSI		EQU	0x400FE61C
SSI0_CR1			EQU	0x40008004
SSI0_CC				EQU	0x40008FC8	
SSI0_CR0			EQU	0x40008000
SSI0_CPSR			EQU	0x40008010
SSI0_SR				EQU	0x4000800C	
SSI0_DR				EQU	0x40008008


GPIO_PORTA_DIR   	EQU 0x40004400	
GPIO_PORTA_AFSEL 	EQU 0x40004420	
GPIO_PORTA_DEN   	EQU 0x4000451C	
GPIO_PORTA_PCTL  	EQU 0x4000452C	
GPIO_PORTA_AMSEL 	EQU 0x40004528	

GPIO_PORTB_DIR 		EQU 0x40005400
GPIO_PORTB_DEN 		EQU 0x4000551C

					AREA   main, CODE, READONLY
					THUMB
							
					EXPORT	lcd_begin_init
						
lcd_begin_init		PROC
					PUSH	{LR}
					
;					SET RCGCSSI for SSI0	
					LDR 	R1,=SYSCTL_RCGCSSI
					LDR 	R0,[R1]                   
					ORR		R0,#0x01
					STR 	R0,[R1]
					
					
;					SET RCGGPIO for PORT A & B
					LDR 	R1, =SYSCTL_RCGCGPIO
					LDR 	R0, [R1]                   
					ORR		R0, #0x03					
					STR 	R0, [R1]                   
			

; 					PORT A
;					DIR ALL
					LDR		R1,=GPIO_PORTA_DIR		
					LDR 	R0, [R1]
					ORR		R0, #0xFF				
					STR		R0,[R1]
					
;					DEN ALL					
					LDR		R1,=GPIO_PORTA_DEN		
					LDR 	R0, [R1]
					ORR		R0, #0xFF
					STR		R0,[R1]
					
;					AFSEL 2-3-4-5 only
					LDR		R1,=GPIO_PORTA_AFSEL	
					LDR 	R0, [R1]
					ORR		R0, #0x3C 				
					STR		R0,[R1]
					
;					PCTL 2-3-4-5 only
					LDR		R1,=GPIO_PORTA_PCTL 	
					MOV32	R0, #0x00222200						
					STR		R0,[R1]
					
					;LDR		R1,=GPIO_PORTA_DEN		
					;LDR 	R0, [R1]
					;ORR		R0, #0x01
					;STR		R0,[R1]	
					
					

; 					PORT B
;					DIR ALL
					LDR		R1,=GPIO_PORTB_DIR		
					LDR 	R0, [R1]
					ORR		R0, #0xFF				
					STR		R0,[R1]
					
;					DEN ALL										
					LDR		R1,=GPIO_PORTB_DEN		
					LDR 	R0, [R1]
					ORR		R0, #0xFF
					STR		R0,[R1]

;					SSI
;					Lock SSI
					LDR		R1,=SSI0_CR1		
					MOV		R0,#0x00					 
					STR		R0,[R1]
					
;					Prescale
					LDR		R1,=SSI0_CPSR	
					MOV		R0,#0x04					
					STR		R0,[R1]	

;					Set Baud rate  
					LDR		R1,=SSI0_CR0	
					LDR		R0,[R1]
					ORR		R0,#0x0120		
					STR		R0,[R1]

;					Set SSI0_CR0
					LDR		R1,=SSI0_CR0			
					LDR		R0,[R1]

;					Clear SPH	
					BIC		R0, #0x20
					
;					Clear SPO
					BIC		R0, #0x10
					
;					8-bit data selection
					ORR		R0, #0x07		
					STR		R0,[R1]
					
;					Unlock SSI
					LDR		R1,=SSI0_CR1	
					LDR		R0,[R1]
					ORR		R0,#0x02				
					STR		R0,[R1]

					BL		wait_for_SR
					
;					Return back to main routine
					POP		{LR}
					BX		LR
	
				
wait_for_SR			LDR		R1,=SSI0_SR
					LDR		R0,[R1]
					ANDS	R0,#16
					BNE		wait_for_SR
					BX		LR
					ENDP
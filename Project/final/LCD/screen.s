SSI0_SR				EQU	0x4000800C	
SSI0_DR				EQU	0x40008008
GPIO_PORTA_DATA		EQU	0x400043FC	
GPIO_PORTB_DATA		EQU	0x400053FC	

					AREA   main, CODE, READONLY
					THUMB
						
					EXTERN  delay
					EXTERN  lcd_send_data
					EXPORT	screen_begin
					EXPORT	screen_clear
						
screen_begin		PROC
					PUSH	{LR}
					
;					RESET PIN B0 -> 0
					LDR		R1,=GPIO_PORTB_DATA	
					LDR		R2,[R1]
					MOV		R0,#0xFE			
					AND		R2,R0
					STR		R2,[R1]	
					
					BL 		delay
					
;					SET RESET PIN B0 -> 1					
					LDR		R1,=GPIO_PORTB_DATA	
					LDR		R2,[R1]
					MOV		R0,#1			
					ORR		R2,R0
					STR		R2,[R1]	
					
;					Command mode 					
					LDR		R1,=GPIO_PORTB_DATA		
					LDR		R0,[R1]
					AND		R0,#0xFD 		
					STR		R0,[R1]

;					H=1 & V=0
					MOV		R4,#0x21			;H=1, V=0
					BL		lcd_send_data
					
;					VOP
					MOV		R4,#0xB5
					BL		lcd_send_data


;					Temperature					
					MOV		R4,#0x05
					BL		lcd_send_data

;					Vop					
					MOV		R4,#0x13			
					BL		lcd_send_data

;					H=0				
					MOV		R4,#0x20			
					BL		lcd_send_data

;					Normal Display
					MOV		R4,#0x0C			
					BL		lcd_send_data

;					X=0
					MOV		R4,#0x80			
					BL		lcd_send_data

;					Y=0					
					MOV		R4,#0x40			
					BL		lcd_send_data


					BL		delay
					BL		delay					

					POP		{LR}
					BX		LR		




wait_for_SR			LDR		R1,=SSI0_SR
					LDR		R0,[R1]
					ANDS	R0,#16
					BNE		wait_for_SR
					BX		LR
					
					
screen_clear		PUSH	{LR}
;					X=0
					MOV		R4,#0x80			
					BL		lcd_send_data

;					Y=0					
					MOV		R4,#0x40			
					BL		lcd_send_data
					
					LDR		R1,=GPIO_PORTB_DATA	
					LDR		R0,[R1]
					ORR		R0,#2
					STR		R0,[R1]
					
;					Clear All Screen
					MOV		R2,#0x00		
					MOV		R4,#0x00		
					
check				BL		wait_for_SR
					LDR		R1,=SSI0_DR
					STRB	R4,[R1]	
					ADD		R2,#1
					CMP		R2,#504
					BEQ		finish
					BNE		check
					
finish				POP		{LR}
					BX		LR
					ENDP
					END
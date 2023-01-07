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

					
					MOV		R4,#0x13			;Bias adjustment
					BL		lcd_send_data

					
					MOV		R4,#0x20			;H=0
					BL		lcd_send_data
					
					MOV		R4,#0x0C			; NORmal display
					BL		lcd_send_data


					
					MOV		R4,#0x80			;Adress of X=0
					BL		lcd_send_data

					
					MOV		R4,#0x40			;Adress of Y=0
					BL		lcd_send_data

					LDR		R1,=GPIO_PORTB_DATA		;Data mode on
					LDR		R0,[R1]
					ORR		R0,#0x2
					STR		R0,[R1]
					
					MOV		R4,#0xFF			;Adress of Y=0
					BL		lcd_send_data
					
					MOV		R4,#0x81			;Adress of Y=0
					BL		lcd_send_data
					
					MOV		R4,#0x81			;Adress of Y=0
					BL		lcd_send_data

					
					
					;BL		wait_for_SR
					POP		{LR}
					BX		LR



					
						
screen_clear		PUSH	{R0-R9,LR}
					MOV		R4,#0x80
					BL		wait_for_SR
					LDR		R1,=SSI0_DR
					STRB	R4,[R1]	
					
					MOV		R4,#0x40
					BL		wait_for_SR
					LDR		R1,=SSI0_DR
					STRB	R4,[R1]	
					
					LDR		R1,=GPIO_PORTB_DATA		;Data mode on
					LDR		R0,[R1]
					ORR		R0,#2
					STR		R0,[R1]
					
					MOV		R2,#0x00		;counter to count all bits
					MOV		R4,#0x00		;Data Register to clear whole screen
					
loop6				BL		wait_for_SR
					LDR		R1,=SSI0_DR
					STRB	R4,[R1]	
					
					ADD		R2,#1
					CMP		R2,#504
					BNE		loop6
					POP		{R0-R9,LR}
					
					BX		LR
					
	

wait_for_SR			LDR		R1,=SSI0_SR
					LDR		R0,[R1]
					ANDS	R0,#16
					BNE		wait_for_SR
					BX		LR
					ENDP
					END
GPIO_PORTA_DATA		EQU	0x400043FC	

					AREA   main, CODE, READONLY
					THUMB
						
					EXPORT	lcd_update_screen
					EXTERN	lcd_send_data
					
lcd_update_screen	PROC
					PUSH	{LR}
					MOV		R5,R0
					
					LDR		R1,=GPIO_PORTA_DATA		;Data mode on
					LDR		R0,[R1]
					ORR		R0,#0x40
					STR		R0,[R1]
					
; ZERO
					MOV		R4,#0xFF			
					BL		lcd_send_data
					
					MOV		R4,#0x81			
					BL		lcd_send_data
					
					MOV		R4,#0x81			
					BL		lcd_send_data
					
					MOV		R4,#0x81			
					BL		lcd_send_data
					
					MOV		R4,#0xFF			
					BL		lcd_send_data
					
					
					MOV		R4,#0x0			
					BL		lcd_send_data
					
					MOV		R4,#0x0			
					BL		lcd_send_data
					
; ONE
					MOV		R4,#0x80			
					BL		lcd_send_data
					
					MOV		R4,#0x80			
					BL		lcd_send_data
					
					MOV		R4,#0xFF			
					BL		lcd_send_data
					
					MOV		R4,#0x80			
					BL		lcd_send_data
					
					MOV		R4,#0x80			
					BL		lcd_send_data
					
					MOV		R4,#0x0			
					BL		lcd_send_data
					
					MOV		R4,#0x0			
					BL		lcd_send_data
					
; TWO
					MOV		R4,#0xF9			
					BL		lcd_send_data
					
					MOV		R4,#0x89			
					BL		lcd_send_data
					
					MOV		R4,#0x89			
					BL		lcd_send_data
					
					MOV		R4,#0x89			
					BL		lcd_send_data
					
					MOV		R4,#0x8F			
					BL		lcd_send_data
					
					MOV		R4,#0x0			
					BL		lcd_send_data
					
					MOV		R4,#0x0			
					BL		lcd_send_data
					
; THREE
					MOV		R4,#0x89			
					BL		lcd_send_data
					
					MOV		R4,#0x89			
					BL		lcd_send_data
					
					MOV		R4,#0x89			
					BL		lcd_send_data
					
					MOV		R4,#0x89			
					BL		lcd_send_data
					
					MOV		R4,#0xFF			
					BL		lcd_send_data
					
					MOV		R4,#0x0			
					BL		lcd_send_data
					
					MOV		R4,#0x0			
					BL		lcd_send_data
					
; FOUR
					MOV		R4,#0xF			
					BL		lcd_send_data
					
					MOV		R4,#0x8			
					BL		lcd_send_data
					
					MOV		R4,#0x8			
					BL		lcd_send_data
					
					MOV		R4,#0x8			
					BL		lcd_send_data
					
					MOV		R4,#0xFF			
					BL		lcd_send_data
					
					
					MOV		R4,#0x0			
					BL		lcd_send_data
					
					MOV		R4,#0x0			
					BL		lcd_send_data
					
; FIVE
					MOV		R4,#0x8F			
					BL		lcd_send_data
					
					MOV		R4,#0x89			
					BL		lcd_send_data
					
					MOV		R4,#0x89			
					BL		lcd_send_data
					
					MOV		R4,#0x89			
					BL		lcd_send_data
					
					MOV		R4,#0xF9			
					BL		lcd_send_data	

					MOV		R4,#0x0			
					BL		lcd_send_data
					
					MOV		R4,#0x0			
					BL		lcd_send_data
					
; SIX
					MOV		R4,#0xFF			
					BL		lcd_send_data
					
					MOV		R4,#0x89			
					BL		lcd_send_data
					
					MOV		R4,#0x89			
					BL		lcd_send_data
					
					MOV		R4,#0x89			
					BL		lcd_send_data
					
					MOV		R4,#0xF9			
					BL		lcd_send_data	
					
					MOV		R4,#0x0			
					BL		lcd_send_data
					
					MOV		R4,#0x0			
					BL		lcd_send_data
					
; SEVEN
					MOV		R4,#0x1			
					BL		lcd_send_data
					
					MOV		R4,#0x1			
					BL		lcd_send_data
					
					MOV		R4,#0x1			
					BL		lcd_send_data
					
					MOV		R4,#0x1			
					BL		lcd_send_data
					
					MOV		R4,#0xFF			
					BL		lcd_send_data

					MOV		R4,#0x0			
					BL		lcd_send_data
					
					MOV		R4,#0x0			
					BL		lcd_send_data
; EIGHT
					MOV		R4,#0xFF			
					BL		lcd_send_data
					
					MOV		R4,#0x89		
					BL		lcd_send_data
					
					MOV		R4,#0x89			
					BL		lcd_send_data
					
					MOV		R4,#0x89			
					BL		lcd_send_data
					
					MOV		R4,#0xFF			
					BL		lcd_send_data
					
					MOV		R4,#0x0			
					BL		lcd_send_data
					
					MOV		R4,#0x0			
					BL		lcd_send_data
					
; NINE
					MOV		R4,#0x8F			
					BL		lcd_send_data
					
					MOV		R4,#0x89		
					BL		lcd_send_data
					
					MOV		R4,#0x89			
					BL		lcd_send_data
					
					MOV		R4,#0x89			
					BL		lcd_send_data
					
					MOV		R4,#0xFF			
					BL		lcd_send_data
					
					POP		{LR}
					BX		LR
					ENDP
					END
					
					AREA   main, CODE, READONLY
					THUMB
						
					EXPORT	lcd_number
					EXTERN	lcd_send_data

;					Pick number with respect to R5
lcd_number			PROC
					PUSH	{R11,LR}
					
					CMP		R5,#0x00
					BEQ.W	zero
					
					CMP		R5,#0x01
					BEQ.W	one
					
					CMP		R5,#0x02
					BEQ.W	two
					
					CMP		R5,#0x03
					BEQ.W	three
					
					CMP		R5,#0x04
					BEQ.W	four
						
					CMP		R5,#0x05
					BEQ.W	five

					CMP		R5,#0x06
					BEQ.W	six
					
					CMP		R5,#0x07
					BEQ.W	seven

					CMP		R5,#0x08
					BEQ.W	eight
					
					CMP		R5,#0x09
					BEQ.W	nine
; ZERO
zero
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
					
					BL		finish
; ONE
one
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
					
					BL		finish

; TWO
two
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
					
					BL		finish

; THREE
three
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

					BL		finish
					
; FOUR
four
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
					
					BL		finish
					
; FIVE
five
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
					
					BL		finish
					
; SIX
six
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
					
					BL		finish
					
; SEVEN
seven
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

					BL		finish
					
; EIGHT
eight
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

					BL		finish
					
; NINE
nine
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
					
					MOV		R4,#0x0			
					BL		lcd_send_data
					
					BL		finish
					
finish				
					POP		{R11,LR}
					BX		LR
					ENDP
					END
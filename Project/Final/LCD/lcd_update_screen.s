GPIO_PORTA_DATA		EQU	0x400043FC	
GPIO_PORTB_DATA		EQU	0x400053FC	

					AREA   main, CODE, READONLY
					THUMB
						
					EXPORT	lcd_update_screen
					EXTERN	lcd_send_data
					EXTERN	lcd_number
					EXTERN	delay
					
lcd_update_screen	PROC
					PUSH	{LR}
					MOV		R7,R0
					MOV		R8,R1
					MOV		R9,R2
					MOV		R10,R3
					

;					Update Cursor
;					R5 For X
;					R6 For Y
					MOV		R5,#0x0
					MOV		R6,#0x0
					MOV		R11,LR
					BL		update_cursor
					MOV		LR,R11


; L
					MOV		R4,#0xFF			
					BL		lcd_send_data
					
					MOV		R4,#0x80		
					BL		lcd_send_data
					
					MOV		R4,#0x80		
					BL		lcd_send_data
					
					MOV		R4,#0x80			
					BL		lcd_send_data
					
					MOV		R4,#0x80			
					BL		lcd_send_data
					
					MOV		R4,#0			
					BL		lcd_send_data
					

;					::
					MOV		R4,#0x14			
					BL		lcd_send_data
					
					MOV		R4,#0x14			
					BL		lcd_send_data

					MOV		R4,#0			
					BL		lcd_send_data
					
					MOV		R4,#0			
					BL		lcd_send_data
					

;					LOW VALUE
					
					MOV		R11, #10
					UDIV	R5, R7,	R11
					
					MOV		R11,LR
					BL		lcd_number
					MOV		LR,R11
					
					MOV		R11, #10
					UDIV	R5, R7,	R11
					MUL		R5, R5, R11
					SUB		R5,	R7, R5

					MOV		R11,LR
					BL		lcd_number
					MOV		LR,R11

;					Update Cursor
;					R5 For X
;					R6 For Y
					MOV		R5,#0x20
					MOV		R6,#0x0
					MOV		R11,LR
					BL		update_cursor
					MOV		LR,R11


; H
					MOV		R4,#0xFF			
					BL		lcd_send_data
					
					MOV		R4,#0x8		
					BL		lcd_send_data
					
					MOV		R4,#0x8		
					BL		lcd_send_data
					
					MOV		R4,#0x8			
					BL		lcd_send_data
					
					MOV		R4,#0xFF			
					BL		lcd_send_data
					
					MOV		R4,#0			
					BL		lcd_send_data	
					
;					::
					MOV		R4,#0x14			
					BL		lcd_send_data
					
					MOV		R4,#0x14			
					BL		lcd_send_data

					MOV		R4,#0			
					BL		lcd_send_data
					
					MOV		R4,#0			
					BL		lcd_send_data
					

;					High value

					MOV		R11, #10
					UDIV	R5, R8,	R11
					
					MOV		R11,LR
					BL		lcd_number
					MOV		LR,R11
					
					MOV		R11, #10
					UDIV	R5, R8,	R11
					MUL		R5, R5, R11
					SUB		R5,	R8, R5

					MOV		R11,LR
					BL		lcd_number
					MOV		LR,R11

;					Update Cursor
;					R5 For X
;					R6 For Y
					MOV		R5,#0x0
					MOV		R6,#0x2
					MOV		R11,LR
					BL		update_cursor
					MOV		LR,R11



; P
					MOV		R4,#0xFF			
					BL		lcd_send_data
					
					MOV		R4,#0x9		
					BL		lcd_send_data
					
					MOV		R4,#0x9		
					BL		lcd_send_data
					
					MOV		R4,#0x9			
					BL		lcd_send_data
					
					MOV		R4,#0xF			
					BL		lcd_send_data
					
					MOV		R4,#0			
					BL		lcd_send_data	
					
;					::
					MOV		R4,#0x14			
					BL		lcd_send_data
					
					MOV		R4,#0x14			
					BL		lcd_send_data

					MOV		R4,#0			
					BL		lcd_send_data
					
					MOV		R4,#0			
					BL		lcd_send_data
					

;					POT value

					MOV		R11, #10
					UDIV	R5, R9,	R11
					
					MOV		R11,LR
					BL		lcd_number
					MOV		LR,R11
					
					MOV		R11, #10
					UDIV	R5, R9,	R11
					MUL		R5, R5, R11
					SUB		R5,	R9, R5

					MOV		R11,LR
					BL		lcd_number
					MOV		LR,R11



;					Update Cursor
;					R5 For X
;					R6 For Y
					MOV		R5,#0x20
					MOV		R6,#0x2
					MOV		R11,LR
					BL		update_cursor
					MOV		LR,R11


; S
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
					
;					::
					MOV		R4,#0x14			
					BL		lcd_send_data
					
					MOV		R4,#0x14			
					BL		lcd_send_data

					MOV		R4,#0			
					BL		lcd_send_data
					
					MOV		R4,#0			
					BL		lcd_send_data
					

;					SENSOR value

					MOV		R11, #10
					UDIV	R5, R10, R11
					
					MOV		R11,LR
					BL		lcd_number
					MOV		LR,R11
					
					MOV		R11, #10
					UDIV	R5, R10, R11
					MUL		R5, R5, R11
					SUB		R5,	R10, R5

					MOV		R11,LR
					BL		lcd_number
					MOV		LR,R11

					POP		{LR}
					BX		LR
					ENDP
			

;					Update Cursor 
;					Command mode 					
update_cursor		PROC
					PUSH	{LR,R11}
					LDR		R1,=GPIO_PORTB_DATA		
					LDR		R0,[R1]
					AND		R0,#0xFD 		
					STR		R0,[R1]


;					X=0
					MOV		R4,#0x80
					ADD		R4,R5					
					BL		lcd_send_data

;					Y=0					
					MOV		R4,#0x40
					ADD		R4,R6
					BL		lcd_send_data

					BL		delay

;					Data Mode					
					LDR		R1,=GPIO_PORTB_DATA		
					LDR		R0,[R1]
					ORR		R0,#0x2
					STR		R0,[R1]
					
					;BL		delay
					POP		{LR,R11}
					BX 		LR

					ENDP
					END
					
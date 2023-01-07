SSI0_SR				EQU	0x4000800C	
SSI0_DR				EQU	0x40008008
	
					AREA   main, CODE, READONLY
					THUMB
						
					EXPORT	lcd_send_data

lcd_send_data		PROC
					PUSH	{LR}
					BL		wait_for_SR
					LDR		R1,=SSI0_DR
					STRB	R4,[R1]
					POP		{LR}
					BX		LR


wait_for_SR			PROC
					LDR		R1,=SSI0_SR
					LDR		R0,[R1]
					ANDS	R0,#0x10
					BNE		wait_for_SR
					BX		LR
					ENDP
					END
					

            AREA        delay, READONLY, CODE
            THUMB
            EXPORT      __delay				; Make available

__delay
loop1m		
			NOP
			NOP
			SUB		R1,R1,#1
			CMP		R1,#0
			BEQ		finish
			B 		loop1m

finish		
			BX LR

            ALIGN
            END

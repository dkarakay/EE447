
            AREA        delay, READONLY, CODE
            THUMB
            EXPORT      __delay				; Make available

__delay
loop1m		
			NOP
			NOP
			SUB		R11,R11,#1
			CMP		R11,#0
			BEQ		finish
			B 		loop1m

finish		
			BX LR

            ALIGN
            END

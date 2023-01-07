		AREA    |.text|, READONLY, CODE, ALIGN=2
					
        THUMB
		

        EXPORT		DELAY100				; make availavle to other programs

DELAY100	MOV32 R0, #200000	;for clock 80 MHz (specified in datasheet)
DELAY_LOOP	NOP
		NOP
		NOP
		SUBS	R0,R0,#1
		NOP
		NOP
		NOP
		BNE DELAY_LOOP
		BX	LR


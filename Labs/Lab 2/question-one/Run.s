            AREA        main, READONLY, CODE
            THUMB
			EXTERN      __delay      ; Make available
            EXPORT    	__main      ; Make available

__main
			MOV32		R1,#225000
			BL			__delay

            ALIGN
            END

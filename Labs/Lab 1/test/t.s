
;SYMBOL		DIRECTIVE	VALUE			COMMENT
FIRST 		EQU 		0x20000400
PRINT 		EQU 		0x2000040A
;***************************************************************
;LABEL		DIRECTIVE	VALUE			COMMENT
            AREA 		main, READONLY, CODE
            THUMB
			DCB 		0X0D
			DCB 		0X04
			EXTERN		OutStr
			EXTERN		CONVRT
            EXPORT 		__main
__main 		
			LDR    		R0,=0x0	;Temp value 1
			LDR			R1,=0x0 ;Temp value 2
			LDR			R2,=0x0 ;Temp value 3
			LDR			R3,=0xA	;Since we are converting hex to decimal. It's based is 10 ( Hexa [A]= Deci [10])
			LDR			R4,=0xA ;Value that will be converted
			;LDR			R5,=FIRST	;Address value that will be written ASCII Value
			;PUSH		{R5} ; Pushing adress value
			LDR			R5,=FIRST
			LDR			R6,=0x0 ;Value that will be converted

			BL 			CONVRT
			
			LDR 		R5,=FIRST
			LDR			R8,=0x0D
			STRB		R8,[R7],#1
			LDR			R8,=0x04
			STRB		R8,[R7]
			LDR 		R0,=FIRST
			BL 			OutStr
done 		B 			done 		    ; end program
			
			ALIGN
            END

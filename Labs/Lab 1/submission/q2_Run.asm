
;SYMBOL		DIRECTIVE	VALUE			COMMENT
NUM 		EQU 		0x20000300		;The address of the number provided
FIRST 		EQU 		0x20000400
PRINT 		EQU 		0x2000040A
;***************************************************************
;LABEL		DIRECTIVE	VALUE			COMMENT
            AREA 		main, READONLY, CODE
            THUMB
			DCB 		0X0D
			DCB 		0X04
			EXTERN		OutStr
			EXTERN		InChar
			EXTERN		CONVRT
            EXPORT 		__main
__main 		
			LDR			R0,=NUM
			LDR			R1,=0xAAAA
			STR			R1,[R0]
			BL 			InChar
			
				
			LDR    		R0,=0x0	
			LDR			R1,=0x0 
			LDR			R2,=0x0 
			LDR			R3,=0xA	;The base that we want to convert the hex number
			LDR			R4,=NUM ;This is the value to be converted
			LDR			R4,[R4]
			
			LDR			R5,=FIRST ;This is the value to be converted
			LDR			R6,=0x0  
			
			BL 			CONVRT
			
			LDR 		R5,=FIRST
			LDR			R8,=0x0D
			STRB		R8,[R7],#1
			LDR			R8,=0x04
			STRB		R8,[R7]
			LDR 		R0,=FIRST
			BL 			OutStr
done 		B 			done 	;This is the end of the program 
			
			ALIGN
            END

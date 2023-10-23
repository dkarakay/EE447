
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
			EXTERN		UPBND
			EXTERN		InChar
            EXPORT 		__main
__main 		
			BL			InChar
			SUB 		R0,0x30
			MOV			R1,R0
			
			BL			InChar
			SUB 		R0,0x30
			MOV			R2,R0
			
			LDR			R3,=0xA
			MUL			R1,R1,R3
			ADD			R0,R1,R2
			
			CMP			R0,#1
			BEQ			ifOne
			SUB 		R0,#2
			
				
			LDR 		R1,=0x2
			LDR 		R2,=0x2
getTwoN		MUL			R2,R2,R1
			SUB			R0,#1
			CMP			R0,#0
			BMI			endOfN
			B 			getTwoN

ifOne	
			LDR			R2,=0x2

endOfN
			
			LDR			R9,=0x1
			LDR			R1,=0x2
			UDIV		R10,R2,R1
			MOV			R11,R2
			
			B 			print
			
			;LDR			R0,=0x55
findValue
			BL			InChar
			CMP			R0,0x43
			;SUBS		R0,#0
			BEQ			done

			BL			UPBND
			B 			print

print
			LDR    		R0,=0x0	
			LDR			R1,=0x0 
			LDR			R2,=0x0 
			LDR			R3,=0xA	;Since we are converting hex to decimal, to be used in R0=(R4//0xA)
			;LDR			R4,=0x7FFFFFF ;The hex number to be converted
			
			MOV			R4,R10
			
			LDR			R5,=FIRST
			LDR			R6,=0x0 ;Counter

			BL 			CONVRT
			
			LDR 		R5,=FIRST
			LDR			R8,=0x0D
			STRB		R8,[R7],#1
			LDR			R8,=0x04
			STRB		R8,[R7]
			LDR 		R0,=FIRST
			BL 			OutStr
			B 			findValue


done 		B 			done 		    ; end program
			
			ALIGN
            END

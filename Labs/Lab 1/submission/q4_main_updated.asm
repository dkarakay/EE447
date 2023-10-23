;SYMBOL		DIRECTIVE	VALUE			COMMENT
FIRST 		EQU 		0x20000400
RECORD 		EQU 		0x20000500
PRINT 		EQU 		0x2000040A
;***************************************************************
;LABEL		DIRECTIVE	VALUE			COMMENT
            AREA 		main, READONLY, CODE
            THUMB
			DCB 		0X0D
			DCB 		0X04
			EXTERN		OutStr
			EXTERN		CONVRT			
			EXTERN		mFibonacci
			EXTERN		InChar
            EXPORT 		__main
__main		PROC 		

			BL			InChar
			SUB 		R0,#0x30
			MOV			R1,R0
			
			BL			InChar
			SUB 		R0,#0x30
			MOV			R2,R0
			
			LDR			R3,=0xA
			MUL			R1,R1,R3
			ADD			R3,R1,R2 ;R3 holds the N information
			

			LDR R1,=0x2



			CMP			R3,#1
			BEQ			ifOne
			CMP			R3,#0
			BEQ			ifZero
			
			B			print1
continue			

			LDR	R4,=RECORD
			LDR R1,=0x1 ;holds the (n-1)th mFibonacci term
			LDR R2,=0x1 ;hold the (n-2)th mFibonacci term
			LDR R5,=0x2 ;hold the number 2
			LDR R6,=0x2
			LDR	R11,=FIRST

			LDR			R0,=0x1
			STR         R0,[R4],#4
			STR 		R0,[R11]
			STR        	R0,[R4],#4
			
			BL 			mFibonacci
				
			LDR 		R5,=FIRST
			B			ende

ifOne	
			LDR			R0,=0x1
			STRB        R0,[R4],#1
			STRB		R6,[R4],#1
			B 			ifZero
			
ifZero	
			LDR			R0,=0x1
			STRB        R0,[R4],#1
			STRB		R6,[R4],#1
			
			LDR 		R5,=FIRST
			B 			ende



print1
			LDR			R7,=0x0 
			LDR			R12,=0xA	;Since we are converting hex to decimal, to be used in R0=(R4//0xA)
			LDR			R11,=FIRST
			
			MOV			R2,R4
			LDR			R4,=0x1
			
			LDR			R6,=0x0 ;Counter
			LDR 		R5,=FIRST

			BL 			CONVRT
			LDR			R8,=0x0D
			STRB		R8,[R7],#1
			LDR			R8,=0x04
			STRB		R8,[R7]
			MOV			R6,R0
			LDR 		R0,=FIRST
			BL 			OutStr
			SUB			R1,#1
			CMP			R1,#0
			BEQ			continue
			B			print1
ende
done 		B 			done 		    
			
			ALIGN
            END

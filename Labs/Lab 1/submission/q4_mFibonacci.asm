FIRST 		EQU 		0x20000400

			AREA 		mFinona, READONLY, CODE
            THUMB
			EXTERN 		OutStr
			EXTERN 		CONVRT
			EXPORT 		mFibonacci
		
mFibonacci	
			PUSH		{LR}
returnFibo
loop1		CMP R3,#2
			BGE Fib
			B exit
		
Fib			LDR R5,=0x2
			MUL R0,R2,R5
			ADD R0,R0,R1
			
			STR R0,[R11]
			STR R0,[R4],#4
			LDR  R5,=0x0
			STRB R5,[R11,#5]
			STRB R5,[R11,#6]
			STRB R5,[R11,#7]
			STRB R5,[R11,#8]
			STRB R5,[R11,#9]
			STRB R5,[R11,#10]
			STRB R5,[R11,#11]
			STRB R5,[R11,#12]
			STRB R5,[R11,#13]
			

			
printq
			LDR			R7,=0x0 
			LDR			R12,=0xA	;Since we are converting hex to decimal, to be used in R0=(R4//0xA)
			LDR			R11,=FIRST
			
			MOV			R2,R4
			LDR			R4,[R11]
			
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
			MOV			R0,R6

			
			MOV			R4,R2

			;STRB R6,[R4],#1
			MOV R2,R1
			MOV	R1,R0
			SUB	R3,R3,#1;
			
		

			
			BL 	returnFibo
			
exit    	POP	{LR}
			BX          LR 			
			ALIGN
			ENDP
			
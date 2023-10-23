FIRST 		EQU 		0x20000400
PRINT 		EQU 		0x2000040A
			AREA 		convrtTest, READONLY, CODE
            THUMB
			EXPORT 		CONVRT				
CONVRT		PROC
loop		
			CMP			R4,#10 ; If the number is less than 10, go to finish
			BMI			finish

			UDIV		R0,R4,R3 ; Find the first decimal digit; R0=(R4//0xA)
			MUL			R1,R0,R3 ; 
			SUB			R2,R4,R1 ;
			STRB		R2,[R5],#1 ; Writing digits to be printed
			MOV			R4,R0 ; Number is updated
			ADD			R6,#1
			B			loop
finish	
			STRB		R4,[R5]
			MOV			R7,R5
			SUB			R5,R6
			MOV 		R8,R5

loop1		LDRB		R1,[R7] ; This loop is writing the same table at the end of it. However, it is in reversed order
			STRB		R1,[R5,#10]
			ADD			R5,R5,#1
			SUB			R7,R7,#1
			CMP			R7,R8
			BGE			loop1
		
			LDR			R7,=FIRST
			LDR 		R8,=0x0;	
			LDR			R5,=PRINT
			
loop2		LDRB		R1,[R5] ; ASCII values are stored in reversed order
			ADD			R1,R1,#48
			MOV			R0,R1
			STRB        R0,[R7]
			ADD 		R5,#1
			ADD 		R7,#1
			ADD			R8,#1
			CMP 		R6,R8
			BGE			loop2
			BX          LR 			
			ALIGN
			ENDP
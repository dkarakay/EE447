FIRST 		EQU 		0x20000400
PRINT 		EQU 		0x2000040A
			AREA 		upbndTest, READONLY, CODE
            THUMB
			EXPORT 		UPBND				
UPBND		PROC
			
			LDR			R8,=0x2
			
			CMP			R0,#85 ; If it is U
			BNE			checkD
			ADD			R9,R10,#1
			ADD			R10,R9,R11
			UDIV		R10,R10,R8
			B			finalize
			
checkD
			CMP			R0,#68 ; If it is D
			SUB			R11,R10,#1
			ADD			R10,R9,R11
			UDIV		R10,R10,R8
			B			finalize


finalize
			BX          LR 			
			ALIGN
			ENDP
			END
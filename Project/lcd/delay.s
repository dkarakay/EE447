			AREA    	main, READONLY, CODE
			THUMB
			EXPORT  	delay

delay		PROC;
			PUSH		{LR}
			MOV32		R1,#225000
loop		
			NOP
			NOP
			SUB			R1,R1,#1
			CMP			R1,#0
			BEQ			finish
			B 			loop
finish
			POP			{LR}
			BX			LR
			ENDP
			END
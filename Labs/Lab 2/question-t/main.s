GPIO_PORTB_DATA 	EQU 0x400053FC ; data address to all pins
GPIO_PORTB_DIR 		EQU 0x40005400
GPIO_PORTB_AFSEL 	EQU 0x40005420
GPIO_PORTB_DEN 		EQU 0x4000551C
GPIO_PORTB_PUR 		EQU 0x40005510
PUB					EQU 0xF0
IOB 				EQU 0x0F
GPIO_PORTE_DATA 	EQU 0x400243FC ; data address to all pins
GPIO_PORTE_DIR 		EQU 0x40024400
GPIO_PORTE_AFSEL 	EQU 0x40024420
GPIO_PORTE_DEN 		EQU 0x4002451C
IOE 				EQU 0x00
SYSCTL_RCGCGPIO 	EQU 0x400FE608
	
			AREA main, READONLY, CODE, ALIGN=2
			THUMB
			EXTERN __delay
			EXTERN OutChar
			EXPORT __main

__main 	LDR R1,=SYSCTL_RCGCGPIO
		LDR R0,[R1]
		ORR R0,R0,#0x12
		STR R0,[R1]
		NOP
		NOP
		NOP 

		LDR R1,=GPIO_PORTB_DIR 
		LDR R0,[R1]
		BIC R0,#0xFF
		ORR R0,#IOB
		STR R0,[R1]
		LDR R1,=GPIO_PORTB_AFSEL
		LDR R0,[R1]
		BIC R0,#0xFF
		STR R0,[R1]
		LDR R1,=GPIO_PORTB_DEN
		LDR R0,[R1]
		ORR R0,#0xFF
		STR R0,[R1] 
		
		LDR R0,=GPIO_PORTB_PUR
		MOV	R1,#PUB
		STR R1,[R0]
		
input
		MOV32 R11,#75000
		LDR R0,=0
		LDR R1,=0
		LDR R2,=0
		LDR R3,=0
		LDR R4,=0
		LDR R5,=0
		LDR R6,=0xF0
		LDR R1,=GPIO_PORTB_DATA
		STR R6,[R1]
		LDR R6,=0

		LDR R1,=GPIO_PORTB_DATA
		LDRB R4,[R1]
		ASR	R3,R4,#4 ; R5 Column
		
		BL __delay
		
		LDR R1,=GPIO_PORTB_DATA
		LDRB R4,[R1]
		ASR	R5,R4,#4 ; R5 Column
		
		CMP R3, R5
		BNE input
		
		CMP R5,#0xF 
		BEQ input
		
loopseven
		LDR R2,=0xF7
		STR	R2,[R1]
		LDR R1,=GPIO_PORTB_DATA
		LDRB R4,[R1]
		CMP R2,R4
		BEQ loopb
		B check

loopb
		LDR R2,=0xFB
		STR	R2,[R1]
		LDR R1,=GPIO_PORTB_DATA
		LDRB R4,[R1]
		CMP R2,R4
		BEQ loopd
		B check
		
loopd
		LDR R2,=0xFD
		STR	R2,[R1]
		LDR R1,=GPIO_PORTB_DATA
		LDRB R4,[R1]
		CMP R2,R4
		BEQ loope
		B check

loope
		LDR R2,=0xFE
		STR	R2,[R1]
		LDR R1,=GPIO_PORTB_DATA
		LDRB R4,[R1]
		B check

check	
		SUB R6, R2,#0xF0 ;row
		MOV32 R11,#75000
		
		LDR R1,=GPIO_PORTB_DATA
		LDRB R8,[R1]
		ASR	R8,R8,#4 ; R5 Column
		
		BL __delay
		
		LDR R1,=GPIO_PORTB_DATA
		LDRB R9,[R1]
		ASR	R9,R9,#4 ; R5 Column
		
		CMP R8,R9
		BNE check
		
		CMP R8,#0xF
		BEQ print
		B check
print
		LDR R9,=0x78
		
checkc	LDR R0,=0x0
		CMP R4,#0xEE
		BEQ output
		
		LDR R0,=0x1
		CMP R4,#0xDE
		BEQ output
		
		LDR R0,=0x2
		CMP R4,#0xBE
		BEQ output
		
		LDR R0,=0x3
		CMP R4,#0x7E
		BEQ output
		
		LDR R0,=0x4
		CMP R4,#0xED
		BEQ output
		
		LDR R0,=0x5
		CMP R4,#0xDD
		BEQ output

		LDR R0,=0x6
		CMP R4,#0xBD
		BEQ output
		
		LDR R0,=0x7
		CMP R4,#0x7D
		BEQ output
		
		LDR R0,=0x8
		CMP R4,#0xEB
		BEQ output
		
		LDR R0,=0x9
		CMP R4,#0xDB
		BEQ output
		
		LDR R0,=0x11
		CMP R4,#0xBB
		BEQ output
		
		LDR R0,=0x12
		CMP R4,#0x7B
		BEQ output
		
		LDR R0,=0x13
		CMP R4,#0xE7
		BEQ output
		
		LDR R0,=0x14
		CMP R4,#0xD7
		BEQ output
		
		LDR R0,=0x15
		CMP R4,#0xB7
		BEQ output
		
		LDR R0,=0x16
		CMP R4,#0x77
		BEQ output
output	
		ADD R0,#0x30
		BL OutChar
		B input
		;STR	R2,[R1]
		
		;LDR R1,=0xF

		ALIGN
		END
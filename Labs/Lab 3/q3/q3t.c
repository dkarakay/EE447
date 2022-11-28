#include "TM4C123GH6PM.h"

int direct = -1;
void init_func(void){
	SYSCTL->RCGCGPIO |= 0x12; //Make both PORT B and PORT E open 
	GPIOE->DIR |= 0x0F; 
	GPIOE->DEN |= 0x0F;
	GPIOE->DATA |= 0x00;
	
	GPIOB->DIR |= 0x0F; 
	GPIOB->DEN |= 0xFF;
	//GPIOB->DATA |= 0xFF;

	
	/*GPIOE->AMSEL &=~0x00;
	GPIOE->PCTL &=~0x00000000;
	GPIOE->DIR |= 0x0F; 
	GPIOE->AFSEL &=~0x00;
	GPIOE->DEN |= 0xFF;
	GPIOE->DATA|= 0xF3;
*/
	SysTick->LOAD = 159999;
	SysTick->CTRL = 7;
	SysTick->VAL = 0;
}

void step_motor_rotate(int dir){
	if(dir == 0){ // CW
		GPIOE->DATA *= 2;
		if(GPIOE->DATA == 8){	
			GPIOE->DATA = 1;
			return;
		}
	}
	else if(dir ==1){ //CCW
		GPIOE->DATA /= 2;
		if(GPIOE->DATA == 1){	
			GPIOE->DATA = 8;
			return;
		}

	}
}

void SysTick_Handler (void){
	step_motor_rotate(direct);
}



int main(void){
	init_func();
	int state = -1;
	while(1){
		while (GPIOB->DATA == 0xE0){
					GPIOE->DATA = 1;
					state = 0;
		}
		while (GPIOB->DATA == 0xD0){
					GPIOE->DATA = 8;
								state = 1;
		}
		
	
		if(state!=-1){
			direct = state;
		}
		
	}
	}

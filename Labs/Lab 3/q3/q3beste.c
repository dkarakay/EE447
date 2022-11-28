#include "TM4C123GH6PM.h"

int direct = -1;
void init_func(void){
	SYSCTL->RCGCGPIO |= 0x12; //Make both PORT B and PORT E open 
	GPIOB->DIR |= 0x0F; 
	GPIOB->DEN |= 0x0F;
	GPIOB->DATA |= 0x00;
	
	GPIOE->AMSEL &=~0x00;
	GPIOE->PCTL &=~0x00000000;
	GPIOE->DIR |= 0x00; 
	GPIOE->AFSEL &=~0x00;
	GPIOE->DEN |= 0xFF;
	GPIOE->DATA|= 0xF3;

	SysTick->LOAD = 159999;
	SysTick->CTRL = 7;
	SysTick->VAL = 0;
}

void step_motor_rotate(int dir){
	if(dir == 0){ // CW
		GPIOB->DATA *= 2;
		if(GPIOB->DATA == 8){	
			GPIOB->DATA = 1;
			return;
		}
	}
	else if(dir ==1){ //CCW
		GPIOB->DATA /= 2;
		if(GPIOB->DATA == 1){	
			GPIOB->DATA = 8;
			return;
		}

	/*}else{
		return;
	*/}
}

void SysTick_Handler (void){
	step_motor_rotate(direct);
}

//static void delayfnc(void){
	//for (int m=0;m<10000;m++){m++;}
//}

int main(void){
	init_func();

		while(GPIOE->DATA == 0xF3){
			GPIOB->DATA = 8;
			direct = 0;
			break;
		}
		while(GPIOE->DATA == 0xF7){
			GPIOB->DATA = 2;
			direct = 1;
		break;
		}
		while(GPIOE->DATA == 0xFB){
			GPIOB->DATA = 1;
			direct = 0;
			break;
		}
		while(GPIOE->DATA == 0xFF){
			direct = -1;
		}
		}
		
		
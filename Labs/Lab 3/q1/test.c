#include "TM4C123GH6PM.h"

int direct = 0;
void init_func(void){
	SYSCTL->RCGCGPIO |= 0x10;
	GPIOE->DIR |= 0x0F;
	GPIOE->DEN |= 0x0F;
	GPIOE->DATA |= 0x01;
	
	SysTick->LOAD = 99999;
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
	int counter = 0;
	while(1){
		if(counter == 1000000){
            GPIOE->DATA = 1;
			direct = 0;
		}
		else if(counter == 2000000){
            GPIOE->DATA = 8;
			direct = 1;
		}else if(counter == 2000001){
			counter = 0;
		}
		counter += 1;
	}
}

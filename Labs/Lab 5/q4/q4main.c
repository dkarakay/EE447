#include "TM4C123GH6PM.h"
#include "stdio.h"

extern void OutStr(char*); 

void init_begin(){
	SYSCTL->RCGCGPIO |= 0x10;
	SYSCTL->RCGCADC |=0x01;
	
	GPIOE->AFSEL |= (1<<3);
	GPIOE->DIR |= 0x08;
	GPIOE->DEN &= ~(0x08);
	GPIOE->AMSEL |= (1<<3);
	
	
	//while(SYSCTL->PRGPIO != 3){}

	ADC0->ACTSS &= ~(1<<3);
  ADC0->EMUX  &= ~(1<<12);
  ADC0->EMUX  &= ~(1<<13);
  ADC0->EMUX  &= ~(1<<14);
  ADC0->EMUX  &= ~(1<<15);
	
	ADC0->SSCTL3 |=(1<<2);
	ADC0->SSCTL3 |=(1<<1);
	
	ADC0->PC |= (1<<0);
	ADC0->ACTSS |= (1<<3);
}

void timer1A_delaySec(){
SYSCTL->RCGCTIMER |=2;
	
	TIMER1->CTL   =0;
	TIMER1->CFG   =0x04;
	TIMER1->TAMR  =0x02;
	TIMER1->TAILR =64000-1;
	TIMER1->TAPR  =250-1;
	TIMER1->ICR   =0x1;
	TIMER1->CTL  |=0x01;
	
	while((TIMER1->RIS & 0x1)==0){}
	TIMER1->ICR = 0x01;
}
int main(){
  volatile float sample = 0;
	char arr[15];
	
	init_begin();
	while(1){
		timer1A_delaySec();	
		ADC0->PSSI |= (1<<3);
			
		// If ADC0->RIS is zero, then sequence is not completed, loop continues.
		if(ADC0->RIS == 0x08){	
			sample = ADC0->SSFIFO3;
      sample -= 2047.5;		
			//ADC0->ISC |=(1<<3);
			sprintf(arr,"%1.2f",sample);
			int count = 0;
			for(int i=0; i<15;i++){
				if(arr[i] == NULL){
					break;
				}
				count +=1;
			}
			arr[count] =  '\r';
			arr[count+1] =  '\4';
			arr[count+2] =  '\n';
			OutStr(arr);
		}
			
	}
}
	
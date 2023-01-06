#include "TM4C123GH6PM.h"
#include "stdio.h"

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

char* convert_float_to_char(float val){
	float f1,f2;
	int i1,i2;
	char* ar;
	f1 = floor(val);
	f2 = val - f1;
	
	i1 = (int) f1;
	i2 = (int) 100*f2;
	
	sprintf(ar,"%d, %d",i1,i2);
	
	return ar;
	
}

int main(){
  volatile float sample = 0;
	char arr[12];
	
	init_begin();
	while(1){
			ADC0->PSSI |= (1<<3);

		// If ADC0->RIS is zero, then sequence is not completed, loop continues.
		if(ADC0->RIS == 0x08){	
			sample = ADC0->SSFIFO3;
      sample -= 2047.5;		
			//ADC0->ISC |=(1<<3);
			sprintf(arr,"%1.2f",sample);
			//arr = convert_float_to_char(sample);
			//memcpy(arr,&sample,sizeof arr);
			//printf("%f",arr);
		}
			
	}
}
	
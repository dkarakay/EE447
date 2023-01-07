#include "TM4C123GH6PM.h"
#include "stdio.h"

extern void OutStr(char*); 

void init_begin(){
	SYSCTL->RCGCGPIO |= 0x30;
	SYSCTL->RCGCADC |=0x01;
	
	GPIOE->AFSEL |= (1<<3);
	GPIOE->DIR |= 0x08;
	GPIOE->DEN &= ~(0x08);
	GPIOE->AMSEL |= (1<<3);
	
	
	GPIOF->DIR			|= (7<<1); //set PF123 as output
  GPIOF->AFSEL		&= (0xFFFFFFFF);  // Regular port function
	GPIOF->PCTL			&= 0xFFFF0000;  // No alternate function
	GPIOF->AMSEL		=0; //Disable analog
	GPIOF->DEN			|=(7<<1); // Enable port digital
		
	
	ADC0->ACTSS &= ~(1<<3);
  ADC0->EMUX  &= ~(15<<12);
	ADC0->SSCTL3 |=(1<<2);
	ADC0->SSCTL3 |=(1<<1);
	ADC0->PC |= (1<<0);
	ADC0->ACTSS |= (1<<3);



	ADC0->ACTSS  &= ~(1<<2);
  ADC0->EMUX   &= ~(15<<9);
  ADC0->SSMUX2 |= (1<<0);
	ADC0->SSCTL2 |=(1<<2);
	ADC0->SSCTL2 |=(1<<1);
	/*ADC0->PC |= (1<<0);
	*/
	ADC0->ACTSS |= (1<<2);
	

}

volatile int get_sensor_data(){
		volatile int sample = -1;
		if(ADC0->RIS == 0x0C){
			ADC0->PSSI |= (1<<3);			
			sample = ADC0->SSFIFO3;
		}
			return sample;
 
}


volatile int get_pot_data(){
		volatile int sample = -1;
		if(ADC0->RIS == 0x0C){
			ADC0->PSSI |= (1<<2);			
			sample = ADC0->SSFIFO2;
		}
			return sample;
 
}
void update_rgb_led(data, lower_limit, higher_limit){
	if(data<lower_limit)GPIOF -> DATA = 2;
	else if(data>higher_limit)GPIOF -> DATA = 4;
	else GPIOF -> DATA = 8;
}

int main(){
	volatile int s,p;
	volatile int sum = 0,sumP=0;
	char arr[20],arr2[20];
	int i=0,j=0;
  //float arrd[55];
	init_begin();
	
	ADC0->PSSI |= (1<<3);
	ADC0->PSSI |= (1<<2);
	
	
	sprintf(arr,"hello /r/4/n");
					
	OutStr(arr);
	
	while(1){
			s = get_sensor_data();
			p = get_pot_data();
		
			if(s != -1){
					sum += s;
					sumP += p;
					i+=1;
		
				if(i==256){
						
						sum /= 256;
						sumP /= 256;
					
					  update_rgb_led(sum,250,1000);
						
						sprintf(arr,"Sensor: %d\r\4\n",sum);
						sprintf(arr2,"Pot: %d\r\4\n",sumP);
					  
						OutStr(arr);
						OutStr(arr2);
						sum = 0;
						sumP = 0;
						i=0;
				}
		}

		// If ADC0->RIS is zero, then sequence is not completed, loop continues.
		
			
	}
}
	
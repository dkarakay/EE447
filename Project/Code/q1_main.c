#include "TM4C123GH6PM.h"
#include "stdio.h"

#define Port_B 0x40005000
#define Port_D 0x40007000
#define Port_E 0x40024000

#define SENSOR_SCALE 41

extern void OutStr(char*);
extern void DELAY100(void);	//delays 100ms
extern void gpio(char port,char pinSelect,char direction,char pull_up,char gpiois,char gpioibe,char gpioiev,char gpioim); //dynamic gpio initializer
extern char keyMatrix(char* scanPort,char bitsInScan,char* readPort,char bitsInRead);	//returns pressed key in key matrix(assuming only a single button in the matrix)
extern void startTimer(int limit);//initiates systic timer
extern void stopTimer();
extern void editTimer();
extern void lcd_begin_init(void);//initializes necessary GPIO pins(B0-B1) and SSI0
extern void screen_begin(void);//initializes  and configures the LCD device
extern void screen_clear(void);//clears the screen
extern void lcd_update_screen(int low, int high, int pot, int sen);	//prints 4 parameters within the interval [0,99] on the LCD

void init_begin(){	//initializes ADC0 and its fifo3 and fifo2, Port_E pins 2-3 for ADC0
	SYSCTL->RCGCGPIO |= 0x30;
	SYSCTL->RCGCADC |=0x01;
	
	GPIOE->AFSEL |= (0x0C);
	GPIOE->DIR &= ~0x0C;
	GPIOE->DEN &= ~(0x0C);
	GPIOE->AMSEL |= (0x0C);
	
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
	ADC0->ACTSS |= (1<<2);
	

}

volatile int get_sensor_data(){		//returns sensor data from ADC0 fifo3
		volatile int sample = -1;
		if(ADC0->RIS == 0x0C){
			ADC0->PSSI |= (1<<3);			
			sample = ADC0->SSFIFO3;
		}
			return sample;
 
}


volatile int get_pot_data(){		//returns pot data from ADC0 fifo2
		volatile int sample = -1;
		if(ADC0->RIS == 0x0C){
			ADC0->PSSI |= (1<<2);			
			sample = ADC0->SSFIFO2;
		}
			return sample;
 
}
void update_rgb_led(int data, int lower_limit, int higher_limit){	//sets RGB led according to limits and sensor data
	if(data<lower_limit){GPIOF -> DATA |= 2;GPIOF -> DATA &= ~0xC;
	}else if(data>higher_limit){GPIOF -> DATA |= 4;GPIOF -> DATA &= ~0xA;
	}else{GPIOF -> DATA |= 8;GPIOF -> DATA &= ~0x6;}
}
void update_pumps(int data, int lower_limit, int higher_limit){		//sets pump switches according to limits and sensor data
	if(data<lower_limit){GPIOB -> DATA |= 4;GPIOB -> DATA &= ~8;}
	else if(data>higher_limit){GPIOB -> DATA |= 8;GPIOB -> DATA &= ~4;}	//port B pin 3 export pump, pin 2 import pump
	else GPIOB -> DATA &= ~0xC;
}
static int sensor_samples[256],pot_samples[256];
int sensor, pot, upper_l = 99, lower_l = 0;
int pot_set=0;	//1 means lower limit by pot, 2 means upper limit by pot, 3 first digit of lower limit by keypad, 4 same as 3 but for upper limit, 5 and 6 wait for button release, 7 sescond digit for lower limit by keypad, 8 same as 7 but for upper limit
int key_matrix=0;
int main(){
	
	lcd_begin_init();
	screen_begin();
	static char arr[40], arr2[40];
	init_begin();
	
	ADC0->PSSI |= (1<<3);
	ADC0->PSSI |= (1<<2);
	
	
	//sprintf(arr,"hello /r/4/n");				
	//OutStr(arr);
	gpio('F',0x0E,0x0E,0x00,0x00,0x00,0xFF,0x00);//port F pins 1,2,3 are used for driving on board RGB led
	gpio('B',0x0C,0x0C,0x00,0x00,0x00,0xFF,0x00);//B[2..3] pump switch output
	gpio('E',0x33,0x00,0x00,0x00,0x00,0xFF,0x00);//port E pins 0,1,4,5 are used for keypad inputs
	gpio('D',0x0F,0x0F,0x00,0x00,0x00,0xFF,0x00);//port D pins 0-3 are used for keypad outputs
	
	startTimer(8000);//set systic timer to 500Hz
	
	while(1){
		DELAY100();
		key_matrix=keyMatrix((char*) (Port_D+(0x0F<<2)),0x0F,(char*) (Port_E+(0x33<<2)) ,0x33);
		switch(key_matrix){		//uses most sigbificant 4 bits of port B to scan buttons    le eski kod keyGet((char*)(Port_B+(0xF0<<2)),0xF0)
			case 11:
			case 12:pot_set = 0;break;
			case 13:pot_set = 1;break;	//buttons 10-16 are used to manage control flow
			case 14:pot_set = 2;break;
			case 15:pot_set = 3;break;
			case 16:pot_set = 4;break;
			default:break;
		}
		switch(pot_set){
			case 1:if(upper_l>(pot*99)/4095)lower_l = (pot*99)/4095;	break;
			case 2:if(lower_l<(pot*99)/4095)upper_l = (pot*99)/4095; break;
			
			case 3:if(0 < key_matrix && key_matrix < 10){pot_set = 5;lower_l = key_matrix*10;}else if(key_matrix == 10){pot_set = 5;lower_l = 0;}break;
			case 4:if(0 < key_matrix && key_matrix < 10){pot_set = 6;upper_l = key_matrix*10;}else if(key_matrix == 10){pot_set = 6;upper_l = 0;}break;
			
			case 5:if(key_matrix==0)pot_set = 7;break;
			case 6:if(key_matrix==0)pot_set = 8;break;

			case 7:if(0 < key_matrix && key_matrix < 10){pot_set = 0;lower_l += key_matrix;}else if(key_matrix == 10){pot_set = 0;}break;
			case 8:if(0 < key_matrix && key_matrix < 10){pot_set = 0;upper_l += key_matrix;}else if(key_matrix == 10){pot_set = 0;}break;
			default:break;
		}
		update_rgb_led((sensor*2*99)/4095,lower_l,upper_l);
		update_pumps((sensor*2*99)/4095,lower_l,upper_l);
		sprintf(arr,"key: %d pot_s: %d\r\4\n",key_matrix,pot_set);OutStr(arr); //debug
		sprintf(arr,"S:%d P:%d LL:%d UL: %d\r\4\n",(sensor*2*99)/4095,(pot*99)/4095,lower_l,upper_l);
		OutStr(arr);
		//screen_clear();
		lcd_update_screen(lower_l,upper_l,(pot*99)/4095,(sensor*2*99)/4095 );
		}
			
	}

void SysTick_Handler(){
	int sensor_sum=0,pot_sum=0;
	static int sample_count = 0;
	if(sample_count<256){
		sensor_samples[sample_count] = get_sensor_data();
		pot_samples[sample_count] = get_pot_data();
		sample_count++;
	}else{
		sample_count = 0;
		for(int i=0;i<256;i++){
			sensor_sum += sensor_samples[i];
			pot_sum += pot_samples[i];
		}
		sensor = sensor_sum >> 8;
		pot = pot_sum >> 8;
	}
}	

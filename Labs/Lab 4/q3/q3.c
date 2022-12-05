#include "TM4C123GH6PM.h"
#include "Pulse_init_orig.h"

int f=0,s=0,t=0;
int pulse=0;
int distance=0;
char msg[32];


void time1_delay(){
	SYSCTL->RCGCTIMER |= 0x02; // turn on bus TIMER1
  TIMER1->CTL			=0; //Disable timer during setup
	TIMER1->CFG			=0x04;  //Set 16 bit mode
	TIMER1->TAMR		=0x02; // set to periodic, count down
	TIMER1->TAILR		=6400-1; //Set interval load as LOW
	TIMER1->TAPR		=249; // Divide the clock by 16 to get 1us
	TIMER1->ICR			=0x1; //Ena
	TIMER1->CTL		 |=0x01; //Ena

	while((TIMER1->RIS&0x1)==0){};
	TIMER1->ICR =0x1;
}


void initRead(){
	SYSCTL->RCGCGPIO |= 0x02; // turn on bus clock for GPIOB
	SYSCTL->RCGCTIMER |= 0x08; // turn on bus TIMER1
	
	
	GPIOB->DIR			|= (1<<3);  //set PB3 as OUTPUT
	GPIOB->DEN			|= (1<<3); // Enable port digital
  GPIOB->AFSEL		&= ~(1<<3);  // Enable AFSEL for PB4
	
	GPIOB->DIR			&= ~(1<<2); //set PB2 as input
	GPIOB->DEN			|= (1<<2); // Enable port digital
  GPIOB->AFSEL		|= (1<<2);  // Enable AFSEL for PB4
	GPIOB->PCTL			&= ~0x00000F00;  // Setting the alternate function to 7th one
	GPIOB->PCTL			|=  0x00000700;  // 
	
	pulse_init();
	time1_delay();
	//GPIOB->PCTL			&= ~0x00000F00;  
	
	TIMER3->CTL			 =0; //Disable timer during setup
	TIMER3->CFG			 =0x04;  //Set 16 bit mode
	TIMER3->TAMR		 =0x17; // set to capture mode, count up
	TIMER3->TAMATCHR = 0xFFFF;
	TIMER3->TAPR		=15; // Divide the clock by 16 to get 1us
	TIMER3->ICR      = 0x1; 	
	TIMER3->CTL 	  |= (1<<3); //Both edges
	TIMER3->CTL 	  |= (1<<2); //Both edges
	//TIMER3->CTL 	   = 12; //Both edges
	TIMER3->CTL	    |= (1<<0); //Enable timer during setup
}

#define		OFFSET		0x10
#define		LENGTH		0x10

extern void OutStr(char*); 

char *int2str(char* ms,int number) {
    int i = 0;
    int div = 1;
    int cmp = number;
		int j=0;
		for(j=0; j<10; j++){
			ms[j]=32;
		}
	
    while (cmp/10 != 0){
        div = div * 10;
				cmp /= 10;
		}
		while (div > 0) {
        ms[i++] = number / div + 48;
        number = number % div;
        div /= 10;
    }
		
		
    ms[i]   = '\r';
    ms[i+1] = '\4';
		ms[i+2] = '\n';
    return ms;
}

int main(){
	initRead();

	TIMER3->CTL |=1;
	while(1){
		
		
		while(TIMER3->RIS != 0x04){}
			
			if(f==0){
				f = TIMER3->TAR;
			}else if(s==0){
				s = TIMER3->TAR;
			}else if(t==0){
				t = TIMER3->TAR;
				
				pulse=(s-f)/16;
				distance=pulse*0.017;
    
				
				OutStr("The first -rising- edge time: \r\4\n");
				OutStr(int2str(msg,f));
				OutStr("The second -falling- edge time: \r\4\n");
				OutStr(int2str(msg,s));
				OutStr("The third -rising- edge time: \r\4\n");
				OutStr(int2str(msg,t));


				OutStr("Pulse Width: \r\4\n");
				OutStr(int2str(msg,pulse));
				OutStr("Distance in cm: \r\4\n");
				OutStr(int2str(msg,distance));


	
			}
				TIMER3->ICR = 0x04;

	}
	return 0;

}
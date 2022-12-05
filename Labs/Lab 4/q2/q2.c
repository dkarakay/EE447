#include "TM4C123GH6PM.h"
#include "Pulse_init_orig.h"

int f=0,s=0,t=0;
int period=0;
int freq=0;
int d_cyc=0;
int pulse=0;
char msg[32];

void initRead(){
	SYSCTL->RCGCGPIO |= 0x02; // turn on bus clock for GPIOB
	SYSCTL->RCGCTIMER |= 0x08; // turn on bus TIMER1
	
	GPIOB->DIR			&= ~(1<<2); //set PB4 as input
	GPIOB->DEN			|= (1<<2); // Enable port digital
  GPIOB->AFSEL		|= (1<<2);  // Enable AFSEL for PB4
	GPIOB->PCTL			&= ~0x00000F00;  // Setting the alternate function to 7th one
	GPIOB->PCTL			|=  0x00000700;  // 
	
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
	pulse_init();
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
				
				period = (t-f) / 16;
				pulse=(s-f)/16;
				d_cyc=100*(s-f)/(t-f);
    
				
				OutStr("The first -rising- edge time: \r\4\n");
				OutStr(int2str(msg,f));
				OutStr("The second -falling- edge time: \r\4\n");
				OutStr(int2str(msg,s));
				OutStr("The third -rising- edge time: \r\4\n");
				OutStr(int2str(msg,t));

				OutStr("Period in usec: \r\4\n");
				OutStr(int2str(msg,period));
		
				OutStr("Pulse Width in usec: \r\4\n");
				OutStr(int2str(msg,pulse));
				OutStr("Duty Cycle in %: \r\4\n");
				OutStr(int2str(msg,d_cyc));
	
			}
				TIMER3->ICR = 0x04;

	}
	return 0;

}
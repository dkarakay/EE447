extern void printFraction(int num,int denum,char pre);
#define RCGCGPIO 0x400FE608
#define GPIOLOCK 0x520
#define GPIOCR 0x524
#define LOCK_KEY 0x4C4F434B
#define GPIODIR 0x400
#define GPIOAFSEL 0x420
#define GPIODEN 0x51C
#define GPIOAMSEL 0x528
#define GPIOPUR 0x510
#define GPIOPDR 0x514
#define GPIOIS 0x404
#define GPIOIBE 0x408
#define GPIOIEV 0x40C
#define GPIOIM 0x410
#define GPIOICR 0x41C
#define GPIOPCTL 0x52C
#define RCGCADC 0x400FE638
#define ADCACTSS 0x0
#define ADCEMUX 0x14
#define ADCPC 0xFC4
#define ADCPSSI 0x028
#define ADCRIS 0x004 
#define ADCISC 0x00C
#define Port_A 0x40004000
#define Port_B 0x40005000
#define Port_C 0x40006000
#define Port_D 0x40007000
#define Port_E 0x40024000
#define Port_F 0x40025000
#define ADC0 0x40038000
#define ADC1 0x40039000
#define ADCSSCTL0 0x44
#define ADCSSCTL1 0x64
#define ADCSSCTL2 0x84
#define ADCSSCTL3 0xA4
volatile char* Port[6]={(char*)Port_A,(char*)Port_B,(char*)Port_C,(char*)Port_D,(char*)Port_E,(char*)Port_F};
volatile char* ADC[2]={(char*)ADC0,(char*)ADC1};
volatile int ADCSSCTL[4]={ADCSSCTL0,ADCSSCTL1,ADCSSCTL2,ADCSSCTL3};
void gpio(char port,char pinSelect,char direction,char pull_up,char gpiois,char gpioibe,char gpioiev,char gpioim){
	*((char*)RCGCGPIO) = *((char*)RCGCGPIO) | (1<<(port-'A'));
	for(int foo=10;foo>0;foo--){
		port=port&0xff;}	//simple delay
	//((volatile int*)Port[port-'A'])[GPIOLOCK]=LOCK_KEY;
	Port[port-'A'][GPIOCR] = Port[port-'A'][GPIOCR]|pinSelect;
	Port[port-'A'][GPIODIR] = (Port[port-'A'][GPIODIR] | (pinSelect & direction)) & ~(pinSelect & ~direction);
	Port[port-'A'][GPIOAFSEL] = Port[port-'A'][GPIOAFSEL] & ~pinSelect;
	Port[port-'A'][GPIODEN] = Port[port-'A'][GPIODEN] | pinSelect;
	Port[port-'A'][GPIOAMSEL] = Port[port-'A'][GPIOAMSEL] & ~pinSelect;
	Port[port-'A'][GPIOPUR] = (Port[port-'A'][GPIOPUR] | (pinSelect & pull_up)) & ~(pinSelect & ~pull_up);
	Port[port-'A'][GPIOPDR] =  (Port[port-'A'][GPIOPDR] | (pinSelect & ~pull_up)) & ~(pinSelect & pull_up);

	Port[port-'A'][GPIOIS] = (Port[port-'A'][GPIOIS] | (pinSelect & gpiois)) & ~(pinSelect & ~gpiois);
	Port[port-'A'][GPIOIBE] = (Port[port-'A'][GPIOIBE] | (pinSelect & gpioibe)) & ~(pinSelect & ~gpioibe);
	Port[port-'A'][GPIOIEV] = (Port[port-'A'][GPIOIEV] | (pinSelect & gpioiev)) & ~(pinSelect & ~gpioiev);
	Port[port-'A'][GPIOIM] = (Port[port-'A'][GPIOIM] | (pinSelect & gpioim)) & ~(pinSelect & ~gpioim);
}


void ADCpin(char port,char pinSelect){
	*((char*)RCGCGPIO) = *((char*)RCGCGPIO) | (1<<(port-'A'));
	for(char i=port;i>0;i--) port=port&0x7f;
	Port[port-'A'][GPIODIR] = Port[port-'A'][GPIODIR] & ~pinSelect;
	Port[port-'A'][GPIOAMSEL] |= pinSelect;
	Port[port-'A'][GPIOAFSEL] |= pinSelect;	
}

#define STCTRL (int*)0xE000E010
#define STRELOAD (int*)0xE000E014
#define STCURRENT (int*)0xE000E018
void startTimer(int limit){
	*(STRELOAD)=limit;
	*(STCURRENT)=0;
	*(STCTRL)=3;
}
void stopTimer(){
	*(STCTRL)=0;
}
void editTimer(int limit){
	*(STRELOAD)=limit;
}

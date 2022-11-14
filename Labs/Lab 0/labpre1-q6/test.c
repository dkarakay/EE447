/*************************************************************** 
* Deniz Beste 
***************************************************************/


extern void OutChar(char); 
extern char InChar(void); 

int main(void){

	while(1){
		char inputchar = InChar();
		if(inputchar != 32){
			OutChar(inputchar);
					}
		else{
			break;
		}
		
	}
}


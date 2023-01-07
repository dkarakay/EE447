//gpio adresses should be given in masked offset
char keyGet(char* readPort,char bitsInRead){
	char pin=0x80;char i;
	for(i=4;i>0;i--){
		while((pin & bitsInRead) == 0) pin=pin >> 1;
		if((*readPort & pin) == 0) break;
		pin=pin >> 1;
	}
	return i;
}

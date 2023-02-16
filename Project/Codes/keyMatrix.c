//gpio adresses should be given in masked offset
char keyMatrix(char* scanPort,char bitsInScan,char* readPort,char bitsInRead){
	char out=0x01;int i,l;
	for(i=0;i<4;i++){
		while((bitsInScan & out) == 0) out=out << 1;
		*scanPort = out;
		for(int k=100;k>0;k--) out=out&bitsInScan; //small delay
		if((*readPort & bitsInRead) != 0) break;
		out=out << 1;
	}
	if(i==4) return 0;
	l=4;
	for(int k=0x80;k>0;k=k>>1){
		while((k & bitsInRead) == 0) k=k>>1;
		if((*readPort & k )!=0) return i*4+l;
		l--;
	}
	return 0;
}

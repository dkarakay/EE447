
extern void lcd_begin_init(void);
extern void delay(void);
extern void screen_begin(void);
extern void screen_clear(void);
extern void lcd_update_screen(int a);

int main(void){
	int i = 0;
	lcd_begin_init();

	while(1){
		
		screen_begin();

		for(i=0; i<50; i++){
			delay();
		}
		screen_clear();
		
		for(i=0; i<25; i++){
			delay();
		}
		
		lcd_update_screen(45);
		
		for(i=0; i<50; i++){
			delay();
		}
	
	}
	
}
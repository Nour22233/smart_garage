#line 1 "C:/Users/hp/Desktop/project  smart garage/code/MyProject.c"

sbit LCD_RS at RB2_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;

sbit LCD_RS_Direction at TRISB2_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;
#line 27 "C:/Users/hp/Desktop/project  smart garage/code/MyProject.c"
void main() {
 unsigned int count=0;
 unsigned int adc_value,temvalue;
 float volt;
 char txt[15];
 char txtt[6];
 trisa=1;
 trisd=0b00000000;
 trisc=0b11111111;
 portd=0;
 portc=0;

 lcd_init();
 lcd_cmd(_lcd_clear);
 lcd_cmd(_lcd_cursor_off);
 lcd_out(1,2,"Welcome");
 delay_ms(1500);
 lcd_cmd(_lcd_clear);
 lcd_out(1,1,"Temp.");
 lcd_out(2,1,"Cars");

 while(1){
 adc_value=adc_Read(0);
 volt=(adc_value*5.0)/1023.0;
 temvalue= volt*100.0;
 wordtostr(temvalue,txtt);
 lcd_out(1,7,txtt);
 if(temvalue>40){
  portd.f2 =1;
 }
 else{
  portd.f2 =0;
 }

 while( portc.f1 ==0&&count<2){
  portd.f0  =1;
 delay_ms(1000);
  portd.f0  =0;
 while( portc.f0 ==1);
 delay_ms(100);
 while( portc.f0 ==0);
 delay_ms(100);
  portd.f1 =1;
 delay_ms(700);
  portd.f1 =0;
 count++;
 inttostr(count,txt);
 lcd_out(2,7,txt);
 }

 if(  portc.f2 ==0&&count>0){
  portd.f4 =1;
 delay_ms(1000);
  portd.f4  =0;
 while( portc.f3 ==1);
 delay_ms(100);
 while( portc.f3 ==0);
 delay_ms(100);
  portd.f5 =1;
 delay_ms(700);
  portd.f5 =0;
 count--;
 inttostr(count,txt);
 lcd_out(2,7,txt);
 }


 }
}

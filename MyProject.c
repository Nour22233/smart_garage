// Lcd pinout settings
sbit LCD_RS at RB2_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;
// Pin direction
sbit LCD_RS_Direction at TRISB2_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;
//.....................
#define motoroenteropeen     portd.f0
#define motorenterclosed       portd.f1
#define fan                    portd.f2
#define motoroexitopeen      portd.f4
#define motorexitclosed        portd.f5
#define ls1_inside             portc.f0
#define ls2_outside            portc.f1
#define ls3_insideexit       portc.f2
#define ls4_outsideexit        portc.f3


void main() {
  unsigned int count=0;
  unsigned int adc_value,temvalue;
  float volt;
  char txt[15];
  char txtt[6];
  trisa=1;                 //lm35
  trisd=0b00000000;     // motors output
  trisc=0b11111111;     // sensors inputs
  portd=0;
  portc=0;

  lcd_init();                         // .................lcd init
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
     fan=1;
     }
     else{
     fan=0;
     }

    while(ls2_outside==0&&count<2){
     motoroenteropeen =1;
     delay_ms(1000);
     motoroenteropeen =0;
     while(ls1_inside==1);
     delay_ms(100);
     while(ls1_inside==0);
     delay_ms(100);
     motorenterclosed=1;
     delay_ms(700);
     motorenterclosed=0;
     count++;
     inttostr(count,txt);
     lcd_out(2,7,txt);
     }

     if( ls3_insideexit==0&&count>0){
          motoroexitopeen=1;
          delay_ms(1000);
          motoroexitopeen =0;
          while(ls4_outsideexit==1);
          delay_ms(100);
          while(ls4_outsideexit==0);
          delay_ms(100);
          motorexitclosed=1;
          delay_ms(700);
          motorexitclosed=0;
          count--;
          inttostr(count,txt);
          lcd_out(2,7,txt);
                }


        }
}
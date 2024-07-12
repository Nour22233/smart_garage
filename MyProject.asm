
_main:

;MyProject.c,27 :: 		void main() {
;MyProject.c,28 :: 		unsigned int count=0;
	CLRF       main_count_L0+0
	CLRF       main_count_L0+1
;MyProject.c,33 :: 		trisa=1;                 //lm35
	MOVLW      1
	MOVWF      TRISA+0
;MyProject.c,34 :: 		trisd=0b00000000;     // motors output
	CLRF       TRISD+0
;MyProject.c,35 :: 		trisc=0b11111111;     // sensors inputs
	MOVLW      255
	MOVWF      TRISC+0
;MyProject.c,36 :: 		portd=0;
	CLRF       PORTD+0
;MyProject.c,37 :: 		portc=0;
	CLRF       PORTC+0
;MyProject.c,39 :: 		lcd_init();                         // .................lcd init
	CALL       _Lcd_Init+0
;MyProject.c,40 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,41 :: 		lcd_cmd(_lcd_cursor_off);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,42 :: 		lcd_out(1,2,"Welcome");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,43 :: 		delay_ms(1500);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
	NOP
;MyProject.c,44 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,45 :: 		lcd_out(1,1,"Temp.");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,46 :: 		lcd_out(2,1,"Cars");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,48 :: 		while(1){
L_main1:
;MyProject.c,49 :: 		adc_value=adc_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
;MyProject.c,50 :: 		volt=(adc_value*5.0)/1023.0;
	CALL       _word2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
;MyProject.c,51 :: 		temvalue= volt*100.0;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _double2word+0
	MOVF       R0+0, 0
	MOVWF      main_temvalue_L0+0
	MOVF       R0+1, 0
	MOVWF      main_temvalue_L0+1
;MyProject.c,52 :: 		wordtostr(temvalue,txtt);
	MOVF       R0+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_WordToStr_input+1
	MOVLW      main_txtt_L0+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;MyProject.c,53 :: 		lcd_out(1,7,txtt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      main_txtt_L0+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,54 :: 		if(temvalue>40){
	MOVF       main_temvalue_L0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main31
	MOVF       main_temvalue_L0+0, 0
	SUBLW      40
L__main31:
	BTFSC      STATUS+0, 0
	GOTO       L_main3
;MyProject.c,55 :: 		fan=1;
	BSF        PORTD+0, 2
;MyProject.c,56 :: 		}
	GOTO       L_main4
L_main3:
;MyProject.c,58 :: 		fan=0;
	BCF        PORTD+0, 2
;MyProject.c,59 :: 		}
L_main4:
;MyProject.c,61 :: 		while(ls2_outside==0&&count<2){
L_main5:
	BTFSC      PORTC+0, 1
	GOTO       L_main6
	MOVLW      0
	SUBWF      main_count_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main32
	MOVLW      2
	SUBWF      main_count_L0+0, 0
L__main32:
	BTFSC      STATUS+0, 0
	GOTO       L_main6
L__main29:
;MyProject.c,62 :: 		motoroenteropeen =1;
	BSF        PORTD+0, 0
;MyProject.c,63 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main9:
	DECFSZ     R13+0, 1
	GOTO       L_main9
	DECFSZ     R12+0, 1
	GOTO       L_main9
	DECFSZ     R11+0, 1
	GOTO       L_main9
	NOP
	NOP
;MyProject.c,64 :: 		motoroenteropeen =0;
	BCF        PORTD+0, 0
;MyProject.c,65 :: 		while(ls1_inside==1);
L_main10:
	BTFSS      PORTC+0, 0
	GOTO       L_main11
	GOTO       L_main10
L_main11:
;MyProject.c,66 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main12:
	DECFSZ     R13+0, 1
	GOTO       L_main12
	DECFSZ     R12+0, 1
	GOTO       L_main12
	DECFSZ     R11+0, 1
	GOTO       L_main12
	NOP
;MyProject.c,67 :: 		while(ls1_inside==0);
L_main13:
	BTFSC      PORTC+0, 0
	GOTO       L_main14
	GOTO       L_main13
L_main14:
;MyProject.c,68 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main15:
	DECFSZ     R13+0, 1
	GOTO       L_main15
	DECFSZ     R12+0, 1
	GOTO       L_main15
	DECFSZ     R11+0, 1
	GOTO       L_main15
	NOP
;MyProject.c,69 :: 		motorenterclosed=1;
	BSF        PORTD+0, 1
;MyProject.c,70 :: 		delay_ms(700);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      27
	MOVWF      R12+0
	MOVLW      39
	MOVWF      R13+0
L_main16:
	DECFSZ     R13+0, 1
	GOTO       L_main16
	DECFSZ     R12+0, 1
	GOTO       L_main16
	DECFSZ     R11+0, 1
	GOTO       L_main16
;MyProject.c,71 :: 		motorenterclosed=0;
	BCF        PORTD+0, 1
;MyProject.c,72 :: 		count++;
	INCF       main_count_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_count_L0+1, 1
;MyProject.c,73 :: 		inttostr(count,txt);
	MOVF       main_count_L0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       main_count_L0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      main_txt_L0+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,74 :: 		lcd_out(2,7,txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      main_txt_L0+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,75 :: 		}
	GOTO       L_main5
L_main6:
;MyProject.c,77 :: 		if( ls3_insideexit==0&&count>0){
	BTFSC      PORTC+0, 2
	GOTO       L_main19
	MOVF       main_count_L0+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main33
	MOVF       main_count_L0+0, 0
	SUBLW      0
L__main33:
	BTFSC      STATUS+0, 0
	GOTO       L_main19
L__main28:
;MyProject.c,78 :: 		motoroexitopeen=1;
	BSF        PORTD+0, 4
;MyProject.c,79 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main20:
	DECFSZ     R13+0, 1
	GOTO       L_main20
	DECFSZ     R12+0, 1
	GOTO       L_main20
	DECFSZ     R11+0, 1
	GOTO       L_main20
	NOP
	NOP
;MyProject.c,80 :: 		motoroexitopeen =0;
	BCF        PORTD+0, 4
;MyProject.c,81 :: 		while(ls4_outsideexit==1);
L_main21:
	BTFSS      PORTC+0, 3
	GOTO       L_main22
	GOTO       L_main21
L_main22:
;MyProject.c,82 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main23:
	DECFSZ     R13+0, 1
	GOTO       L_main23
	DECFSZ     R12+0, 1
	GOTO       L_main23
	DECFSZ     R11+0, 1
	GOTO       L_main23
	NOP
;MyProject.c,83 :: 		while(ls4_outsideexit==0);
L_main24:
	BTFSC      PORTC+0, 3
	GOTO       L_main25
	GOTO       L_main24
L_main25:
;MyProject.c,84 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main26:
	DECFSZ     R13+0, 1
	GOTO       L_main26
	DECFSZ     R12+0, 1
	GOTO       L_main26
	DECFSZ     R11+0, 1
	GOTO       L_main26
	NOP
;MyProject.c,85 :: 		motorexitclosed=1;
	BSF        PORTD+0, 5
;MyProject.c,86 :: 		delay_ms(700);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      27
	MOVWF      R12+0
	MOVLW      39
	MOVWF      R13+0
L_main27:
	DECFSZ     R13+0, 1
	GOTO       L_main27
	DECFSZ     R12+0, 1
	GOTO       L_main27
	DECFSZ     R11+0, 1
	GOTO       L_main27
;MyProject.c,87 :: 		motorexitclosed=0;
	BCF        PORTD+0, 5
;MyProject.c,88 :: 		count--;
	MOVLW      1
	SUBWF      main_count_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       main_count_L0+1, 1
;MyProject.c,89 :: 		inttostr(count,txt);
	MOVF       main_count_L0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       main_count_L0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      main_txt_L0+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyProject.c,90 :: 		lcd_out(2,7,txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      main_txt_L0+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,91 :: 		}
L_main19:
;MyProject.c,94 :: 		}
	GOTO       L_main1
;MyProject.c,95 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

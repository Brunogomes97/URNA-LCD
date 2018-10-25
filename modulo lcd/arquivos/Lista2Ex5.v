/* Neste exercicio foram feitas alteracoes nos modulos apresentados em sala de aula para escrita no LCD, de modo a permitir que o LCD
 * tenha a sua mensagem alterada sempre que um botao for pressionado. As alteracoes foram feitas no modulo LCD_Reset_Delay (para forcar
 * o LCD a ser resetado quando a mensagem for alterada), e no modulo LCD_CONTENT (para que a mensagem mude dependendo de um novo sinal de
 * entrada para este modulo, onde esse novo sinal representa o dia da semana). 
 */

module lcd_urna(
  input CLOCK_50,    
  input key0, // Botao com dupla funcao: trocar o dia da semana e, consequentemente, forcar o reset do LCD para nova exibicao
  
//    LCD Module 16X2
  output LCD_ON,    // LCD Power ON/OFF
  output LCD_BLON,    // LCD Back Light ON/OFF
  output LCD_RW,    // LCD Read/Write Select, 0 = Write, 1 = Read
  output LCD_EN,    // LCD Enable
  output LCD_RS,    // LCD Command/Data Select, 0 = Command, 1 = Data
  inout [7:0] LCD_DATA    // LCD Data bus 8 bits    
);

wire DLY_RST;

reg [2:0] week_state = 3'd0; //Variavel de 3 bits para armazenar numeros de 0 a 6, referentes aos 7 dias da semana
reg [2:0] teste=3'd3;
LCD_Reset_Delay r0(.iCLK(CLOCK_50),.FORCE_RESET(key0),.oRESET(DLY_RST));

// turn LCD ON
assign    LCD_ON        =    1'b1;
assign    LCD_BLON    =    1'b1;

//Dia da semana eh incrementado (de forma circular) toda vez que o botao key0 eh pressionado
always@(negedge key0) begin     
	if (week_state==3'd7) week_state=3'd0; else week_state = week_state+3'd1;					
end


LCD_CONTENT u1(
// Host Side - i.e., what is provided to the module by the FPGA kit
   .iCLK(CLOCK_50),
   .iRST_N(DLY_RST),
	.week_state(week_state),
	.teste(teste),
// LCD Side - i.e., what the module provides to the LCD
   .LCD_DATA(LCD_DATA),
   .LCD_RW(LCD_RW),
   .LCD_EN(LCD_EN),
   .LCD_RS(LCD_RS)
);


endmodule

module urna (reset,clock,key0,key1,key2,HEX0,teste,confirma,
				 finalizar,apuracao,corrigir,valor1,valor2,
				 LCD_ON,LCD_BLON,LCD_RW,LCD_EN,LCD_RS,LCD_DATA);
	//maquina de estado
    input reset,clock,key0,corrigir,finalizar;	
	 output reg confirma,apuracao;
    output reg [6:0] HEX0;
    reg [4:0] estado_atual;
	 output reg [2:0] teste;
	 reg [2:0] lcd; 
	 
	//digitos
	input key1,key2; // botoes de digitar
	wire [6:0] hex1,hex2;
	wire [3:0] bcd1,bcd2;
	output reg [3:0] valor1,valor2; // valores dos digitos
	
	
	//lcd
  output LCD_ON;    // LCD Power ON/OFF
  output LCD_BLON;    // LCD Back Light ON/OFF
  output LCD_RW;    // LCD Read/Write Select, 0 = Write, 1 = Read
  output LCD_EN;    // LCD Enable
  output LCD_RS;    // LCD Command/Data Select, 0 = Command, 1 = Data
  inout [7:0] LCD_DATA;    // LCD Data bus 8 bits 
  wire DLY_RST;
  assign    LCD_ON        =    1'b1;
  assign    LCD_BLON    =    1'b1;
	
  reg [2:0] estado = 3'd0; //Variavel de 3 bits para armazenar numeros de 0 a 6, referentes aos 7 dias da semana
  //reg [3:0] bcd1,bcd2;
  LCD_Reset_Delay r0(.iCLK(clock),.FORCE_RESET(key0),.oRESET(DLY_RST));
  

	LCD_CONTENT u1(
	// Host Side - i.e., what is provided to the module by the FPGA kit
   .iCLK(clock),
   .iRST_N(DLY_RST),
	.estado(lcd),
	.bcd1(bcd1),
	.bcd2(bcd2),
	.c1Uni(c1Uni),.c1Dez(c1Dez),.c2Uni(c2Uni),
	.c2Dez(c2Dez),.c3Uni(c3Uni),.c3Dez(c3Dez),
	.c4Uni(c4Uni),.c4Dez(c4Dez),.nUni(nUni),
	.nDez(nDez),.tDez(tDez),.tUni(tUni),.cadVencedr1(cadVencedr1),.cadVencedr2(cadVencedr2),

// LCD Side - i.e., what the module provides to the LCD
   .LCD_DATA(LCD_DATA),
   .LCD_RW(LCD_RW),
   .LCD_EN(LCD_EN),
   .LCD_RS(LCD_RS)
);









	 //parametros de estado
    parameter esperaMsg=0;
	 parameter esperaDigito=1,confirmaDig=2,confirmaMsg=3,apura=4,cadvencedor=5,totalvotos1=6,totalvotos2=7; 	
	 parameter cad1=10,cad2=13,cad3=17,cad4=51;
	 reg [3:0] cadVencedr1,cadVencedr2;
	 reg [3:0] c1Uni,c1Dez,c2Uni,c2Dez,c3Uni,c3Dez,c4Uni,c4Dez,nUni,nDez,tDez,tUni;
	 reg [5:0] cv1,cv2,cv3,cv4,nulo,total;//contadores de votos
	 
    digitos a1(.key1(key1),.key2(key2),.hex1(hex1),.hex2(hex2),.bcd1(bcd1),.bcd2(bcd2)); // modulos de digitos
	 
    initial begin 
		estado_atual <= esperaMsg;
		HEX0 <=7'b1001111;
		cv1<=0;
		cv2<=0;
		cv3<=0;			
		cv4<=0;
		nulo<= 0;
		total<= 0;
		tDez <= 0;
		tUni <= 0;
		nDez <= 0;
		nUni <= 0;
		
    end
	 
	 always @(*)begin//capturar valores dos digitos
			valor1<=bcd1;
			valor2<=bcd2;
			c1Dez <= cv1/10;
			c1Uni <= cv1%10;
			c2Dez <= cv2/10;
			c2Uni <= cv2%10;
			c3Dez <= cv3/10;
			c3Uni <= cv3%10;
			c4Dez <= cv4/10;
			c4Uni <= cv4%10;
			tDez <= total/10;
			tUni <= total%10;
			nDez <= nulo/10;
			nUni <= nulo%10;
		end
	 
	always@(negedge key0 or negedge reset) begin
		if(!reset)
			estado_atual<=0;
		else begin	
		case(estado_atual)
		0: estado_atual<=1;
		1: estado_atual<=2;
		2: estado_atual<=3;
		3: estado_atual<=4;
		5: estado_atual<=6;
		6: estado_atual<=7;
		7: estado_atual<=0;
		endcase
		end
	
	end

	
	
    always @(*) begin
			
			
			case (estado_atual)

					esperaMsg: begin
						HEX0 <= 7'b1000000;//0
						teste<=0;
						lcd<=0;
					end
					esperaDigito: begin
						HEX0 <= 7'b1111001;//1
						teste<=1;
						lcd<=1;
					end
					 confirmaDig: begin
						HEX0 <= 7'b0100100;//2
						teste<=2;
						lcd<=2;
					 end
					confirmaMsg: begin
						HEX0 <= 7'b0110000;//3
						teste<=3;
						lcd<=3;
						total<=total + 1;
						if(valor1==1 && valor2==0)
							cv1=cv1+1;
						else if(valor1==1 && valor2==3)
							cv2=cv2+1;
						else if(valor1==1 && valor2==7)
							cv3=cv3+1;
						else if(valor1==5 && valor2==1)
							cv4=cv2+4;
						else nulo = nulo + 1;
									
					 end	
					apura: begin
						HEX0 <= 7'b0011001;//4
						teste<=4;
						lcd<=4;
						
					 end	
					cadvencedor: begin
						HEX0 <= 7'b0010010;//5
						teste<=5;
						lcd<=5;
						if(cv1>cv2 && cv1>cv3 && cv1>cv4)begin
							cadVencedr1<=1;
							cadVencedr2<=0;end
						else if(cv2>cv1 && cv2>cv3 && cv2>cv4) begin
							cadVencedr1<=1;
							cadVencedr2<=3;end
						else if(cv3>cv1 && cv3>cv2 && cv3>cv4)begin
							cadVencedr1<=1;
							cadVencedr2<=7;end
						else if(cv4>cv1 && cv4>cv2 && cv4>cv3) begin
							cadVencedr1<=5;
							cadVencedr2<=1;end
						else begin
							cadVencedr1<=4'bx;
							cadVencedr2<=4'bx;
						end	
						
					 end
					totalvotos1: begin
						HEX0 <= 7'b0000010;//6
						teste<=6;
						lcd<=6;
					 end	
					totalvotos2: begin
						HEX0 <= 7'b1111000;//7
						teste<=7;
						lcd<=7;
					 end	
				endcase
    end
	 
	 
	 
endmodule



module testbench();
	reg key1,key2;
	wire [6:0] hex1,hex2;
	wire [3:0] bcd1;
	wire teste;
	wire [3:0]d3;
	digitos a12(.key1(key1),.key2(key2),.hex1(hex1),.hex2(hex2),.bcd1(bcd1),.teste(teste),.d3(d3));
	initial begin
	
	key1=1;key2=1;#1;
	
	#4;key1=0;key2=0;#1;#4;key1=1;key2=0;#1;#4;key1=0;key2=0;#1;#4;key1=1;key2=0;#1;#4;key1=0;key2=0;
	#4;key1=0;key2=0;#1;#4;key1=1;key2=0;#1;#4;key1=0;key2=0;#1;#4;key1=1;key2=0;#1;#4;key1=0;key2=0;
	#4;key1=0;key2=0;#1;#4;key1=1;key2=0;#1;#4;key1=0;key2=0;#1;#4;key1=1;key2=0;#1;#4;key1=0;key2=0;
	#4;key1=0;key2=0;#1;#4;key1=1;key2=0;#1;#4;key1=0;key2=0;#1;#4;key1=1;key2=0;#1;#4;key1=0;key2=0;
	#4;key1=0;key2=0;#1;#4;key1=1;key2=0;#1;#4;key1=0;key2=0;#1;#4;key1=1;key2=0;#1;#4;key1=0;key2=0;
	#4;key1=0;key2=0;#1;#4;key1=1;key2=0;#1;#4;key1=0;key2=0;#1;#4;key1=1;key2=0;#1;#4;key1=0;key2=0;
	#4;key1=0;key2=0;#1;#4;key1=1;key2=0;#1;#4;key1=0;key2=0;#1;#4;key1=1;key2=0;#1;#4;key1=0;key2=0;
	#4;key1=0;key2=0;#1;#4;key1=1;key2=0;#1;#4;key1=0;key2=0;#1;#4;key1=1;key2=0;#1;#4;key1=0;key2=0;
	#4;key1=0;key2=0;#1;#4;key1=1;key2=0;#1;#4;key1=0;key2=0;#1;#4;key1=1;key2=0;#1;#4;key1=0;key2=0;
	#4;key1=0;key2=0;#1;#4;key1=1;key2=0;#1;#4;key1=0;key2=0;#1;#4;key1=1;key2=0;#1;#4;key1=0;key2=0;
	#4;key1=0;key2=0;#1;#4;key1=1;key2=0;#1;#4;key1=0;key2=0;#1;#4;key1=1;key2=0;#1;#4;key1=0;key2=0;
	#1;

	end
	initial begin
	$monitor("TESTE/  key1 = %b, key2 = %b ,bcd1 = %d  hex1 = %b  , hex2  = %b,teste = %b,d3=%d", key1,key2,bcd1,hex1,hex2,teste,d3);
	end

endmodule
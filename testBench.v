module testBench();

reg [31:0]data;
reg [6:0]dataAddress;
reg [31:0]instruction;
reg [6:0]instructionAddress;
reg writeEnable;
reg clk;

main mips(clk, instruction, instructionAddress, data, dataAddress, writeEnable);

initial 
	begin
		//addi r2 r1 2
		//instruction <= 32'b001000_00001_00010_0000000000000011;//addi
		//instruction <= 32'b100011_00000_00001_0000000000000000;//lw 
		//instruction <= 32'b101011_00000_00001_0000000000000000; //sw
		//instruction <= 32'b000000_00010_00001_00011_00000_100010;// sub
		//instruction <= 32'b000000_00010_00001_00011_00000_100000;// add
		//instruction <= 32'b000000_00010_00001_00011_00001_000000;// sll
		//	instruction <= 32'b000000_00001_00010_00011_00000_101010;// slt
		//	instruction <= 32'b000000_00001_00010_00011_00000_100100;// and
		//instruction <= 32'b000000_00001_00010_00011_00000_100101;// or
		//instruction <= 32'b001100_00001_00010_0000000001111111;// andi

		instructionAddress <= 7'd0;
		//data
		data <= 32'd12;
		dataAddress <= 7'd0;
		writeEnable <= 1;

//	#5 writeEnable <=0 ;
//	#7 instruction <= 32'b100011_00000_00001_0000000000000000;//lw 
//	#7 instructionAddress <= 7'd1;
//	#10 writeEnable <=1 ;

//	#15 writeEnable <=0 ;
//	#17 instruction <= 32'b101011_00000_00011_0000000000000000;//sw 
//	#17 instructionAddress <= 7'd2;
	
//	#20 writeEnable <=1 ;


	end
	//comment
initial
	begin
		#0 clk <= 0;
		#1000 
		forever 
			begin
				#200 clk <= ~clk; 
			end
	end	
	
initial
	#3000 $finish;
	
endmodule


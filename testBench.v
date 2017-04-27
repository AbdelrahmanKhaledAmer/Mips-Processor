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

			//instruction <= 32'b001000_00001_00010_0000000000000011;//addi
			//instruction <= 32'b100011_00000_00001_0000000000000000;//lw 
			//instruction <= 32'b101011_00000_00001_0000000000000000; //sw
			//instruction <= 32'b000000_00010_00001_00011_00000_100010;// sub
			//instruction <= 32'b000000_00010_00001_00011_00000_100000;// add
			//instruction <= 32'b000000_00010_00001_00011_00001_000000;// sll
			//instruction <= 32'b000000_00001_00010_00011_00000_101010;// slt
			//instruction <= 32'b000000_00001_00010_00011_00000_100100;// and
			//instruction <= 32'b000000_00001_00010_00011_00000_100101;// or
			//instruction <= 32'b001100_00001_00010_0000000001111111;// andi
			//instruction <= 32'b000100_00001_00010_0000000000111111;// beq
			//instructionAddress <= 7'd0;

			///program with MEM forwarding//
			//1
			data <= 32'd12;
			dataAddress <= 7'd0;
			#1 instruction <= 32'b100011_00000_00001_0000000000000000;//lw s1 0($0) 	s1=12
			#1 instructionAddress <= 7'd0;
			#1 writeEnable <= 1;
			#1 writeEnable <=0 ;
			//2
			#5 instruction <= 32'b001000_00010_00010_0000000000000011;// addi s2 s2 3     s2=3
			#1 instructionAddress <= 7'd1;
			#1 writeEnable <= 1;
			#1 writeEnable <=0 ;
			//3
			//#1 instruction = 32'b000100_00000_00000_0000000000111111;// beq 0 0
			#1 instruction = 32'b000101_00000_00001_0000000000111111;// bnq 0 1  to test modify regFile or change instruction order 

			#1 instructionAddress = 7'd2;
			#1 writeEnable = 1;
			#1 writeEnable =0 ;
			
			//4
			#1 instruction = 32'b101011_00001_00001_0000000000000001;//sw s1 1(s1)
			#1 instructionAddress = 7'd66;
			#1 writeEnable = 1;
			#5 writeEnable =0 ;
			
			//5
			#1 instruction <= 32'b000000_00001_00010_00011_00000_100010;// sub S3 S2 S1  s3=9
			#1 instructionAddress = 7'd67;
			#1 writeEnable = 1;
			#5 writeEnable =0 ;
			
			//////////////////////////////////

			///program with  forwarding alu to alu//
			/*
			//1
			#5 instruction <= 32'b001000_00010_00010_0000000000000011;// addi s2 s2 3     s2=3
			#1 instructionAddress <= 7'd0;
			#1 writeEnable <= 1;
			#1 writeEnable <=0 ;
			//2
			
			#1 instruction <= 32'b000000_00010_00010_00011_00000_100000;// add S3 S2 S2   s3=6
			#1 instructionAddress = 7'd1;
			#1 writeEnable = 1;
			#5 writeEnable =0 ;
			*/
			//////////////////////////////////////////

			// program	with Mem to ALu forwarding
			/*
			//1
			data <= 32'd12;
			dataAddress <= 7'd0;
			#1 instruction <= 32'b100011_00010_00010_0000000000000000;//lw s2 0($0) 	s2=12
			#1 instructionAddress <= 7'd0;
			#1 writeEnable <= 1;
			#1 writeEnable <=0 ;
			
			// stall
			#1 instruction = 32'b000000_00000_00000_0000000000000000;// stall
			#1 instructionAddress = 7'd1;
			#1 writeEnable = 1;
			#1 writeEnable =0 ;
			
			//2
			#1 instruction = 32'b101011_00010_00010_0000000000000011;//sw s2 3(s2)
			#1 instructionAddress = 7'd2;
			#1 writeEnable = 1;
			#5 writeEnable =0 ;
			*/
			//////////////////////////////////
		end

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
		#5400 $finish;
		
endmodule
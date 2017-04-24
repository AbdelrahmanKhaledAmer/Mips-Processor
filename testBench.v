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
		instruction <= 32'b001000_00001_00010_0000000000000010;
		instructionAddress <= 7'd0;
		//data
		data <= 32'd2;
		dataAddress <= 7'd1;
		writeEnable <= 1;
	end
	//comment
initial
	begin
		#0 clk <= 0;
		#1000 
		forever 
			begin
				#30 clk <= ~clk; 
			end
	end	
	
initial
	#1300 $finish;
	
endmodule


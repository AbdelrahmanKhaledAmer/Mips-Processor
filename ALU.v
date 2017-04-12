module ALU (OUT, ZeroFlag, In1, In2, ALUOP); 
	input [31:0] In1, In2;
	input [2:0] ALUOP;
	output [31:0] OUT;
	reg [31:0] OUT;
	output ZeroFlag;
	reg ZeroFlag;

	always @ (In1 or In2 or ALUOP) 
	begin 
		if (In1 == In2)
			ZeroFlag = 1;
		else
			ZeroFlag = 0;
	end

	always @ (In1 or In2 or ALUOP)
	begin
		case (ALUOP)
			0 : OUT = In1 + In2; //0 ADD //2 ADDi //3 LW //4 SW
			1 : OUT = In1 - In2; //1 SUB // Handle Overflow
			2 : OUT = In1 & In2; //5 AND //9 ANDi
			3 : OUT = In1 | In2; //6 OR //10 ORi
			4 : OUT = In1 << In2;//7 SLL
			5 : OUT = In1 >> In2;//8 SRL
			6 : OUT = 3'bx;//11 BEQ //12 BNE
			7 : OUT = In1 < In2;//13 SLT
		endcase 
	end

endmodule

/*
module ALUTest();
	reg [31:0] r1, r2;
	reg [2:0] select;
	wire [31:0] OUT;
	wire zeroFlag;

	initial
	begin
		r1 = 5;
		r2 = 2;
		select = 7;
		#10 $display ("Output is%d\n", OUT);
		$display ("Zero Flag is%d\n", zeroFlag);
		#10 r1 = 17;
		r2 = 25;
		#10 $display ("Output is%d\n", OUT);
		$display ("Zero Flag is%d\n", zeroFlag);
		#10 r1 = 22;
		r2 = 22;
		#10 $display ("Output is%d\n", OUT);
		$display ("Zero Flag is%d\n", zeroFlag);
	end

	always@(r1 or r2 or select);
		ALU test(OUT,zeroFlag,r1,r2,select);
	
endmodule
*/
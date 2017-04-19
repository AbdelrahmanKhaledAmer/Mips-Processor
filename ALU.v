module ALU (OUT, ZeroFlag, In1, In2, ALUOP , shamt); 
	input [31:0] In1, In2;
	input [4:0] shamt ;
	input [2:0] ALUOP;
	output [31:0] OUT;
	reg [31:0] OUT;
	output ZeroFlag;
	wire ZeroFlag;
	
	assign ZeroFlag = (In1==In2)? 1'b1 : 1'b0 ;

	always @ (In1 or In2 or ALUOP)
	begin
		case (ALUOP)
			0 : OUT = In1 + In2; //0 ADD //2 ADDi //3 LW //4 SW
			1 : OUT = In1 - In2; //1 SUB // Handle Overflow
			2 : OUT = In1 & In2; //5 AND //9 ANDi
			3 : OUT = In1 | In2; //6 OR //10 ORi
			4 : OUT = In1 << shamt;//7 SLL
			5 : OUT = In1 >> shamt;//8 SRL
			6 : OUT = 3'bx;//11 BEQ //12 BNE
			7 : OUT = In1 < In2;//13 SLT
		endcase 
	end

endmodule
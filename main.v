module main(clk);
	input clk;
	reg [31:0] pc;
	//fetch reg
	reg [31:0] fetchDecode_PC;
	reg [31:0] fetchDecode_instruction;
	//decode reg
	reg  [31:0] decodeExecute_PC;
	reg  [31:0] decodeExecute_readReg1;
	reg  [31:0] decodeExecute_readReg2;
	reg  [31:0] decodeExecute_signExtend;
	reg  [4:0] decodeExecute_rt;
	reg  [4:0] decodeExecute_rd;//write register
	reg  [1:0] decodeExecute_wb;//reqWrite memToReg
	reg  [2:0] decodeExecute_mem;//memRead memWrite branch
	reg  [4:0] decodeExecute_ex;//ALUSrc regDest ALUOp(3 bits)
	//execute reg
	reg [31:0] executeMemory_branchAddress;
	reg executeMemory_zf;
	reg [31:0] executeMemory_aluOut;
	reg [31:0] executeMemory_regToMem;
	reg [4:0] executeMemory_rd;//write register
	reg [1:0] executeMemory_wb;//reqWrite memToReg
	reg [2:0] executeMemory_mem;//memRead memWrite branch
	//memory reg
	reg  [31:0] memoryWriteBack_aluOut;
	reg  [31:0] memoryWriteBack_memOut;
	reg  [4:0] memoryWriteBack_rd;//write register
	reg  [1:0] memoryWriteBack_wb;//reqWrite memToReg
	//instruction memory
	reg  [31:0] instructionMemory[511:0];
	//data memory
	reg  [31:0] dataMemory [511:0];
	//ALU
	reg [31:0] out;
	reg zeroFlag;
	reg [2:0] ALUOP ;
	//Register file
	reg [31:0] r1;
	reg [31:0]r2;
	//Control signals
	reg pcSrc;
	reg branch; 
	reg RegDst;
	reg MemRead;
	reg MemToReg;
	reg MemWrite;
	reg ALUsrc;
	reg RegWrite;
	//modules used
	//ALU aluCircuit(out,zeroFlag,r1,r2,ALUOP);
	//registerFile registers();
	//Fetch stage
	always @(posedge clk)
		
		begin
			if(branch ==1'b0)
				pc = pc+1 ;
			else  
				pc = executeMemory_branchAddress; 			
			fetchDecode_instruction <= instructionMemory[pc] ;
			fetchDecode_PC <= pc ;
		end
	 
	//Decode stage
	always @(posedge clk)
		begin
			
		end
	
	//Execute stage
	always @(posedge clk)
		begin
			
		end
	
	//Memory stage
	always @(posedge clk)
		begin
			
		end
	
	//Write back stage
	always @(posedge clk)
		begin
			
		end
		
	
	// for pc 
	//always(@posedge clk)
	//begin
		
	
	//end 
endmodule
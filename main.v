module main(clk);
	input clk;
	reg [31:0] pc;
	//fetch reg
	reg [31:0] fetchDecode_PC;
	reg [31:0] fetchDecode_instruction;
	//decode reg
	reg  [31:0] decodeExecute_PC;
	wire [31:0] decodeExecute_readData1;
	wire [31:0] decodeExecute_readData2;
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
	reg  [1:0] memoryWriteBack_wb;//regWrite memToReg   0 RegWrite   / 1 MemtoReg
	//instruction memory
	reg  [31:0] instructionMemory[511:0];
	//data memory
	reg  [31:0] dataMemory [511:0];
	//ALU
	wire [31:0] out; //ALUOut
	wire zeroFlag;
	reg [2:0] ALUOP ;
	//Register file
	reg [31:0] r1;
	reg [31:0]r2;
	//Control signals
	wire pcSrc;
	reg branch; 
	reg RegDst;
	reg MemRead;
	reg MemToReg;
	reg MemWrite;
	reg ALUsrc;
	reg RegWrite;
	//modules used
	ALU aluCircuit(out,zeroFlag,decodeExecute_readData1,(ALUSrc)?decodeExecute_readData2:decodeExecute_signExtend,ALUOP,decodeExecute_signExtend[10:6]);
	registerFile registers(clk ,fetchDecode_instruction [25:21],  fetchDecode_instruction[20:16], memoryWriteBack_rd,(memoryWriteBack_wb [1])? memoryWriteBack_aluOut: memoryWriteBack_memOut, memoryWriteBack_wb[0], decodeExecute_readData1, decodeExecute_readData2);
	//assignments
	assign pcSrc = executeMemory_zf & executeMemory_mem[2];
	//Fetch stage
	always @(posedge clk)
		
		begin
			fetchDecode_instruction <= instructionMemory[pc] ;
			fetchDecode_PC <= pc+1 ;
			if(pcSrc ==1'b1)
				pc = executeMemory_branchAddress; 	
			else  
				pc = pc+1 ;				
		end
	 
	//Decode stage
	always @(posedge clk)
		begin
			
		if(fetchDecode_instruction[31:26] == 6'b0)
			begin
					branch <= 0; 
					RegDst <= 1;
					MemRead <= 0;
					MemToReg<= 0;
					MemWrite <=0;
					ALUsrc <=0;
					RegWrite <= 1;
				case(fetchDecode_instruction[5:0])
					5'h20 : ALUOP <= 0 ;  //add
					5'h22 : ALUOP <= 1 ;//SUB
					5'h0 : ALUOP <= 4 ; // SLL	
					5'h2 : ALUOP  <= 5 ;//SRL	
					5'h24 : ALUOP <= 2 ;// AND		
					5'h25 : ALUOP <= 3 ; // OR		
					5'h2A : ALUOP <= 7 ;// SLT	
				endcase
			end
		else if (fetchDecode_instruction[31:26] == 6'h23) //LW
			begin
					branch <= 0; 
					RegDst <= 0;
					MemRead <= 1;
					MemToReg<= 1;
					MemWrite <=0;
					ALUsrc <=1;
					RegWrite <= 1;	
					ALUOP <= 0 ;
			end
		else if(fetchDecode_instruction[31:26] == 6'h2B) //SW
			begin
					branch <= 0; 
					RegDst <= 0;
					MemRead <= 0;
					MemToReg<= 0;
					MemWrite <=1;
					ALUsrc <=1;
					RegWrite <= 0;		
					ALUOP <= 0 ;
			end
		else if(fetchDecode_instruction[31:26] == 6'h8) // ADDI
			begin
					branch <= 0; 
					RegDst <= 0;
					MemRead <= 0;
					MemToReg<= 0;
					MemWrite <=0;
					ALUsrc <=1;
					RegWrite <= 1;		
					ALUOP <= 0 ;
			end
		else if(fetchDecode_instruction[31:26] == 6'hD) // ORI
			begin
					branch <= 0; 
					RegDst <= 0;
					MemRead <= 0;
					MemToReg<= 0;
					MemWrite <=0;
					ALUsrc <=1;
					RegWrite <= 1;		
					ALUOP <= 3 ;
			end
		else if(fetchDecode_instruction[31:26] == 6'h4) // BEQ
			begin
					branch <= 1; 
					RegDst <= 0;
					MemRead <= 0;
					MemToReg<= 0;
					MemWrite <=0;
					ALUsrc <= 0;
					RegWrite <= 0;	
					ALUOP <= 0 ;
			end
		else if(fetchDecode_instruction[31:26] == 6'h5) //BNE
			begin
					branch <= 1; 
					RegDst <= 0;
					MemRead <= 0;
					MemToReg<= 0;
					MemWrite <=0;
					ALUsrc <=0;
					RegWrite <= 0;
					ALUOP <= 0 ;
			end
			decodeExecute_PC <= fetchDecode_PC;
			decodeExecute_signExtend <= {{16{fetchDecode_instruction[15]}},fetchDecode_instruction[15:0]};
			decodeExecute_rt <= fetchDecode_instruction[20:16];
			decodeExecute_rd <= fetchDecode_instruction[15:11];
			decodeExecute_wb[0] <= RegWrite ;
			decodeExecute_wb[1] <= MemToReg ;
			decodeExecute_mem[0] <= MemRead;
			decodeExecute_mem[1] <= MemWrite;
			decodeExecute_mem[2] <= branch;
			decodeExecute_ex[0] <= ALUsrc ;
			decodeExecute_ex[1] <= RegDst;
			decodeExecute_ex[4:2]<= ALUOP;
		
		end
	
	//Execute stage
	always @(posedge clk)
		begin
			executeMemory_branchAddress <= decodeExecute_PC + decodeExecute_signExtend*4;
			executeMemory_zf <= zeroFlag;
			executeMemory_aluOut <= out;
			executeMemory_regToMem <= decodeExecute_readData2;
			executeMemory_rd <= (decodeExecute_ex[1])?decodeExecute_rd:decodeExecute_rt;
			executeMemory_wb <= decodeExecute_wb;
			executeMemory_mem <= decodeExecute_mem;
		end
	
	//Memory stage
	always @(posedge clk)
		begin
			memoryWriteBack_aluOut <= executeMemory_aluOut;
			if(executeMemory_mem[0])
				memoryWriteBack_memOut <= dataMemory[executeMemory_aluOut];
			else
				memoryWriteBack_memOut <= 0;
			if(executeMemory_mem[1])
				dataMemory[executeMemory_aluOut] <= executeMemory_regToMem; 
			memoryWriteBack_rd <= executeMemory_rd;
			memoryWriteBack_wb <= decodeExecute_wb;
		end

endmodule

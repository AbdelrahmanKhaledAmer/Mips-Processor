module main(clk);
	input clk ;
	reg [31:0] pc;
	reg [63:0] fetchDecode ;
	reg  [146:0] decodeExecute;
	reg [106:0] executeMemory ;
	reg  [70:0] memoryWriteBack;
	reg  [7:0] instructionMemory[511:0];
	reg  [7:0] dataMemory [511:0];
	reg [31:0] out;
	reg zeroFlag;
	reg [31:0] r1;
	reg [31:0]r2;
	reg [2:0] ALUOP ;
	reg pcSrc ;
	reg stall;
	reg branch; 
	reg RegDst ;
	reg MemRead ;
	reg MemToReg ;
	reg ALUOP ;
	reg MemWrite ;
	reg ALUsrc ;
	reg RegWrite;
	reg counter  ;
	
	always @(posedge clk)
		begin
			if(counter ==2 )
				stall =0 ;
			else if (stall ==1 )
				counter =counter+1  ;
		end
	
	
	always @(posedge clk)
		begin
			if(stall == 1'b0)
				begin
					if(branch ==1'b0)
						pc = pc+4 ;
					else  
						pc = executeMemory[31:0] ; 
	
					fetchDecode [7:0] <= instructionMemory[pc-1] ;
					fetchDecode [15:8] <= instructionMemory[pc-2] ;
					fetchDecode [23:16] <= instructionMemory[pc-3] ;
					fetchDecode [31:24] <= instructionMemory[pc-4] ;
					fetchDecode [63:32] <= pc ;
				end
		end
	 
	always @(posedge clk)
		begin
			if(fetchDecode != 64'b0 && stall != 1) // if fetchdecode is 0 or there is stall stop .
				begin
					if( fetchDecode[31:26] == 6'b000100) // if instruction is branch stall on next clock cycle .
						stall <= 1'b1 ;
					if(fetchDecode[31:26] == 6'b000000 ) //  R instructions
						begin
							case(fetchDecode[5:0])
								5'h20 : 
								5'h22 : 
								5'h0 : 
								5'h2 : 
								5'h24 : 
								5'h25 : 
								5'h2A : 
							endcase
						end
					else if(fetchDecode[31:26] == 6'h23 )   // I lw
						begin
	
						end
					else if(fetchDecode[31:26] == 6'h2B )    // I SW
						begin
						
						end
					else if(fetchDecode[31:26] == 6'h8 )     /// I ADDI
						begin
	
						end
					else if(fetchDecode[31:26] == 6'hd )    /// I ORI
						begin
	
						end
					else if(fetchDecode[31:26] == 6'hc )   // I ADDI
						begin
	
						end
					else if(fetchDecode[31:26] == 6'h4 )  /// I BEQ
						begin
	
						end
					else if(fetchDecode[31:26] == 6'h5 )  /// I BNE
						begin
	
						end
				end
		end
	
	
	//ALU aluCircuit(out,zeroFlag,r1,r2,ALUOP);
		
	
	// for pc 
	//always(@posedge clk)
	//begin
		
	
	//end 
endmodule
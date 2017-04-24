module registerFile(clk,read_reg_1, read_reg_2, write_reg, write_data, regWrite, read_data_1, read_data_2);
	input clk ;
	input [4:0] read_reg_1, read_reg_2, write_reg;
    input [31:0] write_data;
    input regWrite;
    output[31:0] read_data_1, read_data_2;
    wire [31:0] read_data_1, read_data_2;
    reg [31:0] registers[31:0];
	integer i ;
	   
    assign read_data_1 = (read_reg_1==0)? 32'b0 : registers[read_reg_1];
    assign read_data_2 = (read_reg_2==0)? 32'b0 : registers[read_reg_2];

	initial
		begin
			for(i = 0 ; i < 32 ; i = i + 1)
				begin
					registers[i] <= 0;
				end
		end
	//comment
	always @(posedge clk)
		begin
			registers[0] <= 0;
			if(regWrite)
				begin
					if(write_reg!=0)
						registers[write_reg] <= write_data;
				end
		end

	
	always @(posedge clk)
		begin
			$monitor("Value of r1 = %d\n Value of r2 = %d\n",registers[1],registers[2]);
		end
endmodule
module registerFile(clk,read_reg_1, read_reg_2, write_reg, write_data, regWrite, read_data_1, read_data_2);
	input clk ;
	input [4:0] read_reg_1, read_reg_2, write_reg;
    input [31:0] write_data;
    input regWrite;
    output[31:0] read_data_1, read_data_2;
    reg [31:0] read_data_1, read_data_2;
    reg [31:0] registers[31:0];
	integer i ;
	   
   
	initial
		begin
			for(i = 0 ; i < 32 ; i = i + 1)
				begin
					registers[i] <= 0;
				end
		end
	always @(posedge clk)
		begin
			read_data_1 = (read_reg_1==0)? 32'b0 : registers[read_reg_1];
			read_data_2 = (read_reg_2==0)? 32'b0 : registers[read_reg_2];
			registers[0] <= 0;
			if(regWrite)
				begin
					if(write_reg!=0)
						registers[write_reg] <= write_data;
				end
		end

	initial
		begin
			#5350
			for(i = 0 ; i < 32 ; i = i + 1)
				begin
					$display("Value of register %d = %d",i,registers[i]);
				end
				$display("\n");
		end
	
endmodule
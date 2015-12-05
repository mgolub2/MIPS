/*
Configurable register created to have value switched every 
clock cycle, rather than with write enable every cycle.
*/
module Register(data_in, data_out, clk, rst);
	//make register size configurable
	parameter width = 32;
	// width bit input data to flip flops
	input [width-1:0] data_in;
	// reset and clock for flip flop
	input clk, rst;
	// Output signal for flip flops
	output [width-1:0] data_out;

	// Iterator variable for generating each flip flop
	genvar ff;
	// Generate width flip flops, one for each bit
	generate
		for(ff = 0; ff < width; ff = ff+1)
			begin: genflops
				D_FF d(.q(data_out[ff]), 
						.d(data_in[ff]), 
						.reset(rst), 
						.clk(clk)
				);
			end
	endgenerate
endmodule

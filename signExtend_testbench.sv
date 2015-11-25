/*
Tests 16 to 32 bit sign extension by extending 
*/

`timescale 1 ps / 100 fs

module signExtend_testbench();
	// Immediate bits to be extended
	reg [15:0] in_16;
	// Extended bits
	reg [31:0] out_32;
	
	// Sign extend module to test
	signExtend dut(in_16, out_32);

	parameter Delay = 5000;
	
	// Starting at a value of 0 for the first bit, sets each place of bit
	// to 1 until top bit has been set to 1.
	initial begin
	  	in_16 <= 16'h00000000;
	    #(Delay);
	    for (int i = 1; i < 32768; i = i * 2) begin
			  in_16 <= 16'h0 + i;
	      #(Delay);
	    end
	    for (int i = 1; i < 32768; i = i * 2) begin
			  in_16 <= 32768 + i;
	      #(Delay);
	    end
		$stop;
	end
	
endmodule

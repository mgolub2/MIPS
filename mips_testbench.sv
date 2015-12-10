`timescale 1 ps / 100 fs
/*
Testbench for mips cpu. Basically just clock the thing forever, yo.
*/

module mips_testbench();

	reg clk, rst;

	parameter CLK_DELAY = 50000;

	//awesome mips cpu
	mips cpu(clk, rst); 

	initial begin
		clk = 0;
		rst = 1; //rst is required to set program counter to 0.
		#(CLK_DELAY*2);
		rst = 0;
		#(CLK_DELAY*1500);
		$stop;
	end

	always #(CLK_DELAY) clk = ~clk;

endmodule // mips_testbench
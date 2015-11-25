/*
Testbench for the program counter
*/

`timescale 1 ps / 100 fs

module pc_testbench();


	reg [31:0] seIn; //sign extended 32 bit value
	reg [25:0] target_inst; //target intruction to branch to
	reg jump, branch, zero, clk, rst; //single bit inputs
	wire [31:0] inst;
	reg [31:0] reg_Da

	parameter DELAY = 50000;
	
	pc DUT(inst, target_inst, seIn, jump, branch, zero, clk, rst, reg_Da);


	initial begin
	  	clk = 0;
	  	jump = 0;
	  	branch = 0;
	  	zero = 0;
	  	seIn = 32'h00000000;
	  	target_inst = 26'h0000000;
	  	rst = 1;
	  	#(DELAY*2);
	  	rst = 0;
	  	#(DELAY*100);
	end

	always #(DELAY) clk = ~clk;
	
endmodule

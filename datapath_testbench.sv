/*
Tests various instruction compositions on datapath file to make
sure that all instructions function. 
*/

`timescale 1 ps / 100 fs

module datapath_testbench();

	// Control signals
	reg clk, RegDst, RegWr, ALUsrc, MemWr, MemToReg, Branch, Jump, rst;
	reg [1:0] ALUcntrl;

	// Instructions from instruction fetch unit.
	reg [31:0] Instructions;

	// To connect to Instruction Fetch Unit.
	wire Zero;
	
	// seOut signal to be used in Instruction Fetch.
	wire [31:0] seOut;
	wire [31:0] reg_Da;

	// datapath module to test
	datapath dut(
				.clk(clk), 
				.RegDst(RegDst), 
				.RegWr(RegWr),
				.ALUsrc(ALUsrc), 
				.ALUcntrl(ALUcntrl), 
				.MemWr(MemWr), 
				.MemToReg(MemToReg), 
				.Zero(Zero), 
				.seOut(seOut), 
				.Instructions(Instructions), 
				.reg_Da(reg_Da),
				.rst(rst)
	);

	parameter Delay = 50000;
	
	// Run through instructions to test that each function works
	initial begin
		clk = 0;
		rst = 1;
		// We won't use op bits
		Instructions[31:26] = 6'bx;
		#(Delay * 2);
		rst = 0;
		#(Delay * 2);

		// addi $1, $0, 2015
		RegDst = 0;
		RegWr = 1;
		ALUsrc = 1;
		ALUcntrl = 2'b0;
		MemWr = 0;
		MemToReg = 0;

		// Rs register
		Instructions[25:21] = 5'b00000;
		// Rt register
		Instructions[20:16] = 5'b00001;
		// Imm register
		Instructions[15:0] = 16'b0 + 2015;

		#(Delay * 2);

		// addi $2, $0, 404
		RegDst = 0;
		RegWr = 1;
		ALUsrc = 1;
		ALUcntrl = 2'b0;
		MemWr = 0;
		MemToReg = 0;

		// Rs register
		Instructions[25:21] = 5'b00000;
		// Rt register
		Instructions[20:16] = 5'b00010;
		// Imm register
		Instructions[15:0] = 16'b0 + 404;

		#(Delay * 2);

		// add $1, $1, $2 
		RegDst = 1;
		RegWr = 1;
		ALUsrc = 0;
		ALUcntrl = 2'b0;
		MemWr = 0;
		MemToReg = 0;

		// Rs register
		Instructions[25:21] = 5'b00001;
		// Rt register
		Instructions[20:16] = 5'b00010;
		// Rd register
		Instructions[15:11] = 5'b00001;
		// Dont cares
		Instructions[10:0] = 10'bx;

		#(Delay * 2);

		// sw $2, 0[$0]
		RegDst = 1'bx;
		RegWr = 0;
		ALUsrc = 1;
		ALUcntrl = 2'b0;
		MemWr = 1;
		MemToReg = 1'bx;

		// Rs register
		Instructions[25:21] = 5'b00000;
		// Rt register
		Instructions[20:16] = 5'b00010;
		// Imm register
		Instructions[15:0] = 16'b0;

		#(Delay * 2);

		// lw $3, 0[$0]
		RegDst = 0;
		RegWr = 1;
		ALUsrc = 1;
		ALUcntrl = 2'b0;
		MemWr = 0;
		MemToReg = 1;

		// Rs register
		Instructions[25:21] = 5'b00000;
		// Rt register
		Instructions[20:16] = 5'b00011;
		// Imm register
		Instructions[15:0] = 16'b0;
		
		#(Delay * 2);

		$stop;
	end

	always #(Delay) clk = ~clk;
	
endmodule

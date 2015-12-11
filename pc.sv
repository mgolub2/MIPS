`timescale 1 ps / 100 fs
/*
Program counter for a single cycle mips cpu

By default, the program counter is always incremented by
1. This results in a an instruction being fetched that is 
one word away from the previuos instruction.

supports bltz and jumps. Uses given instruction memory. 

Gates are modeled with a 50ps delay. 

Adder is a kogge stone adder.

Registers are built with d flip flops.
*/

module pc(inst, target_inst, seIn, jump, branch, clk, rst, reg_Da);

	output [31:0] inst;
	input [31:0] seIn;
	input [25:0] target_inst;
	input [31:0] reg_Da;
	input jump, branch, clk, rst;

	parameter DELAY = 50;

	wire [31:0] jump_mux_0;
	wire [29:0] jump_r_mux_0; 
	wire [31:0] jump_mux_1;
	wire [29:0] program_counter;
	wire [31:0] sign_ex_mux_out;
	wire [31:0] jump_mux_out;
	wire not_branch;

	//This could be assign statement....
	concat pc_concat(
		.out(jump_r_mux_0), 
		.top (program_counter[29:26]), 
		.bott(target_inst)
	);

	//Intruction memory as given from class
	InstructionMem mem(
		.instruction(inst), 
		.address({program_counter, 2'b00})
	);

	//kogge stone adder for jumps
	adder kg(
		.out(jump_mux_0), 
		.Cout(), 
		.overflow(), 
		.A({2'b00, program_counter}), 
		.B(sign_ex_mux_out), 
		.Cin(not_branch)
	);

	//30 bit program counter
	Register_32 #(.width(30))
		counter_register(
			.data_out		(program_counter), 
			.data_in		(jump_mux_out[29:0]), 
			.write_enable	(1'b1), 
			.clk			(clk),
			.rst            (rst)
	);

	//mux to select wether we are adding a signextended value or 0
	Mux_32_2x1 sign_ex_mux(
		.out   (sign_ex_mux_out),
		.in    ({seIn, 32'h0000}),
		.select(branch_and_negative)
	);

	//mux to select if we are jumping
	Mux_32_2x1 jump_mux(
		.out   (jump_mux_out),
		.in    ({jump_mux_1, jump_mux_0}),
		.select(jump)
	);

	//mux for jr - since we need to select the output of the regfile. 
	Mux_32_2x1 jump_r_mux(
		.out   (jump_mux_1),
		.in    ({{2'b00, reg_Da[31:2]}, {2'b00, jump_r_mux_0}}),
		.select(jump_r)
	);

	//and gate for branch and zero flags
	and #(DELAY) branchnegative(branch_and_negative, branch, reg_Da[31]);
	//and for jr 
	and #(DELAY) jumpandbranch(jump_r, jump, branch);

	not #(DELAY) notBranch(not_branch, branch_and_negative);

endmodule // program_counter

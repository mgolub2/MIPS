`timescale 1 ps / 100 fs
/*
Top level file for the EE 471 MIPS CPU
Authors: Maximilian Golub, Michael Von Hippel

A simple single cycle MIPS cpu, tested at 100Mhz in modelsim.

The CPU supports the following instructions:

ADDI rt, rs, imm16: Reg[rt] = Reg[rs] + Sign_ext(Imm16).
BLTZ rs, Imm16: if (Reg[rs]<0) PC = PC + 4 + Sign_ext(Imm16)<<2
else PC = PC + 4. For lab #4 (only) this instr. has a delay slot.
J target: PC = { PC[31:28], target, 00 }. For lab #4 (only) this instr. has a delay slot. JR rs: PC = Reg[rs]. For lab #4 (only) this instr. has a delay slot.
LW rt, imm16(rs): Reg[rt] = Mem[Reg[rs] + Sign_ext(Imm16)].
For lab #4 (only) the value in rt cannot be used in the next cycle. NOR rd, rs, rt: Reg[rd] = Reg[rs] nor Reg[rt].
SLTU rd, rs, rt: Reg[rs] and Reg[rt] are considered to be unsigned numbers.
If (Reg[rs] < Reg[rt]) Reg[rd] = 0000000116
else Reg[rd] = 0000000016.
SUBU rd, rs, rt: Reg[rd] = Reg[rs] – Reg[rt]. This is normal, 2’s complement subtraction. The difference
between “sub” and “subu” is that “subu” completely ignores overflow, where “sub” will cause an
exception if an overflow occurs.
SW rt, imm16(rs): Mem[Reg[rs] + Sign_ext(Imm16)] = Reg[rt].

*/

module mips (clk, rst);

	input clk, rst;

	wire [31:0] Instructions;
	wire [31:0] signExtend;
	wire [31:0] reg_Da;
	wire [25:0] target_inst;
	wire [1:0] ALUcntrl;
	wire Negative, RegDst, RegWr, ALUsrc, MemWr, MemToReg, jump, branch;

	//regfile and data memory, with an ALU between
	datapath data(
		.clk		    (clk), 
		.RegDst		    (RegDst), 
		.RegWr		    (RegWr), 
		.ALUsrc		    (ALUsrc), 
		.ALUcntrl	    (ALUcntrl), 
		.MemWr		    (MemWr),
		.MemToReg	    (MemToReg),
		.seOut			(signExtend), 
		.Instructions	(Instructions),
		.reg_Da			(reg_Da)
	);

	//Program counter, reads from intruction memory
	pc program_counter(
		.inst 			(Instructions), 
		.target_inst    (target_inst), 
		.seIn 			(signExtend), 
		.jump       	(jump), 
		.branch 		(branch), 
		.clk 			(clk), 
		.rst 			(rst),
		.reg_Da     	(reg_Da)
	);

	control control_logic(
		.target_inst	(target_inst),
		.RegDst			(RegDst),
		.RegWr			(RegWr),
		.ALUsrc			(ALUsrc),
		.ALUcntrl		(ALUcntrl),
		.MemWr			(MemWr),
		.MemToReg		(MemToReg),
		.jump			(jump),
		.branch			(branch),
		.clk			(clk),
		.instruction 	(Instructions)
	);

endmodule
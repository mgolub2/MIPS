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
SUBU rd, rs, rt: Reg[rd] = Reg[rs] â€“ Reg[rt]. This is normal, 2â€™s complement subtraction. The difference
between â€œsubâ€? and â€œsubuâ€? is that â€œsubuâ€? completely ignores overflow, where â€œsubâ€? will cause an
exception if an overflow occurs.
SW rt, imm16(rs): Mem[Reg[rs] + Sign_ext(Imm16)] = Reg[rt].

*/

module mips (clk, rst, led );

	input clk, rst;
	output [15:0] led;

    assign led = Instructions[15:0];

	(* keep = "true" *) wire [31:0] Instructions;
	(* keep = "true" *) wire [31:0] signExtend;
	(* keep = "true" *) wire [31:0] mem_int_forward;
	(* keep = "true" *) wire [31:0] ex_int_forward;
	(* keep = "true" *) wire [31:0] if_id_forward;
	(* keep = "true" *) wire [31:0] reg_Da;
	//wire [25:0] target_inst_del;
	(* keep = "true" *) wire [1:0] ALUcntrl;
	(* keep = "true" *) wire Negative, RegDst, RegWr, ALUsrc, MemWr, MemToReg, jump, branch, ex_forward_a, ex_forward_b, mem_forward_a, mem_forward_b;

	//regfile and data memory, with an ALU between
	(* keep = "true" *) datapath data(
		.clk		    (clk), 
		.rst            (rst),
		.RegDst		    (RegDst), 
		.RegWr		    (RegWr), 
		.ALUsrc		    (ALUsrc), 
		.ALUcntrl	    (ALUcntrl), 
		.MemWr		    (MemWr),
		.MemToReg	    (MemToReg),
		.seOut			(signExtend), 
		.Instructions	(Instructions),
		.reg_Da			(reg_Da),
		.mem_forward_a  (mem_forward_a),
		.ex_forward_a   (ex_forward_a),
		.mem_forward_b  (mem_forward_b),
		.ex_forward_b   (ex_forward_b),
		.if_id_forward  (if_id_forward),
		.ex_int_forward (ex_int_forward),
		.mem_int_forward(mem_int_forward)
	);

	//Program counter, reads from intruction memory
	(* keep = "true" *) pc program_counter(
		.inst 			(Instructions), 
		.target_inst    (if_id_forward[25:0]), //for a jump, this will be the target instruction
		.seIn 			(signExtend), 
		.jump       	(jump), 
		.branch 		(branch), 
		.clk 			(clk), 
		.rst 			(rst),
		.reg_Da     	(reg_Da)
	);

	(* keep = "true" *) control control_logic(
		//.target_inst	(target_inst_del),
		.RegDst			(RegDst),
		.RegWr			(RegWr),
		.ALUsrc			(ALUsrc),
		.ALUcntrl		(ALUcntrl),
		.MemWr			(MemWr),
		.MemToReg		(MemToReg),
		.jump			(jump), 
		.branch			(branch), 
		.instruction 	(if_id_forward),
		.mem_forward_a	(mem_forward_a),
		.ex_forward_a 	(ex_forward_a),
		.mem_forward_b	(mem_forward_b),
		.ex_forward_b 	(ex_forward_b),
		.ex_int_forward (ex_int_forward),
		.mem_int_forward(mem_int_forward)
	);

endmodule
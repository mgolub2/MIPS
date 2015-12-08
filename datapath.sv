`timescale 1 ps / 100 fs
/*
Datapth for 32 Bit single cycle mips cpu based on architecture 
from slides 88 and 89.
*/
module datapath(clk, RegDst, RegWr, ALUsrc, ALUcntrl, MemWr,
					MemToReg, seOut, Instructions, reg_Da, rst, mem_forward_a, ex_forward_a, mem_forward_b, ex_forward_b);

	// Control signals
	input clk, rst, RegDst, RegWr, ALUsrc, MemWr, MemToReg, mem_forward_a, ex_forward_a, mem_forward_b, ex_forward_b;
	input [1:0] ALUcntrl;

	// Instructions from instruction fetch unit.
	input [31:0] Instructions;

	// seOut signal to be used in Instruction Fetch.
	output [31:0] seOut;

	//output for jr from da
	output [31:0] reg_Da;

	// Immediate 16 bits input to sign extender.
	wire [15:0] Imm16;

	// Connections to and from registers.
	wire [31:0] se32, Dw, Da, Db, 
				Dout, ALUin, ALUout, Instructions;

	// Register addresses
	wire [4:0] Aw, Rs, Rd, Rt;

	// Single bit wires for ALU
	wire overflow, carryout, Negative, Zero;

	// Wires for stage registers
	wire [38:0] reg_if_id_out;
	wire [107:0] reg_id_ex_out;
	wire [72:0] reg_ex_mem_out;
	wire [38:0] reg_mem_wr_out;

	wire [31:0] ex_forward_out_a;
	wire [31:0] ex_forward_out_b;
	wire [31:0] mem_forward_out_b;
	wire [31:0] mem_forward_out_a;

	// Selects reg address to which to write.
	Mux_32_2x1 #(.width(5)) regDstMux(
			.out(Aw), 
			.in({Rd, Rt}), 
			.select(reg_id_ex_out[0])
	);

	// Extends imm_16 bits.
	signExtend SE(.imm(Imm16), .out(se32));

	// Register File
	regfile registerFile(
			.ReadData1(Da), 
			.ReadData2(Db), 
			.WriteData(reg_mem_wr_out[38:7]),
			.ReadRegister1(Rs), 
			.ReadRegister2(Rt), 
			.WriteRegister(reg_mem_wr_out[6:2]), 
			.RegWrite(reg_mem_wr_out[1]), 
			.clk(clk)
	);

	// Mux for ALU input.
	Mux_32_2x1 ALUSrcMux(
			.out(ALUin), 
			.in({reg_id_ex_out[75:44], reg_id_ex_out[43:12]}), 
			.select(reg_id_ex_out[2])
	);

	// System ALU.
	alu ALU(.out(ALUout), 
			.carryout(carryout), 
			.zero(Zero), 
			.overflow(overflow), 
			.negative(Negative), 
			.bus_a(reg_id_ex_out[107:76]), 
			.bus_b(ALUin), 
			.alu_cntr(reg_id_ex_out[1:0])
	);

	//Mux to foward EX back to ID, placed in front of the MEM_forward mux.
	Mux_32_2x1 EXForwardMuxA(
		.out(ex_forward_out_a),
		.in({ALUout, mem_forward_out_a}),
		.select(ex_forward_b)
	);

	Mux_32_2x1 EXForwardMuxB(
		.out(ex_forward_out_b),
		.in({ALUout, mem_forward_out_b}),
		.select(ex_forward_b)	
	);
	//Forward the value from the mem stage, or the standard register value.
	Mux_32_2x1 MEMForwardMuxA(
		.out(mem_forward_out_a),
		.in({Dw, Rs}),
		.select(mem_forward_b)
	);

	Mux_32_2x1 MEMForwardMuxB(
		.out(mem_forward_out_b),
		.in({Dw, Rt}),
		.select(mem_forward_b)	
	);

	// Data memory unit
	dataMem dataMemory(.data(Dout), 
			.address(reg_ex_mem_out[72:41]), 
			.writedata(reg_ex_mem_out[40:9]),
			.writeenable(reg_ex_mem_out[1]), 
			.clk(clk));

	// Mux for write data back to Reg File.
	Mux_32_2x1 DwMux(
			.out(Dw), 
			.in({Dout, reg_ex_mem_out[72:41]}), 
			.select(reg_id_ex_out[0])
	);

	// 39 bits data, with no added control yet
	// RegWr
	// RegDst
	// MemWr
	// MemToReg
	// ALUsrc
	// [1:0] ALUcntrl
	Register #(.width(39)) IF_ID_register(
			.data_in({Instructions, RegWr, RegDst, MemWr, MemToReg, ALUsrc, ALUcntrl}), 
			.data_out(reg_if_id_out), 
			.clk(clk), 
			.rst(rst)
	);

	// 32 bits Da
	// 32 bit SE
	// 32 bits Db
	// [4:0] Aw
	// RegWr
	// RegDst
	// MemWr
	// MemToReg
	// ALUsrc
	// [1:0] ALUcntrl
	// 108 total
	Register #(.width(108)) ID_EX_register(
			//.data_in({Da, se32, Db, Aw, reg_if_id_out[6:0]}),
			.data_in({ex_forward_out_a, se32, ex_forward_out_b, Aw, reg_if_id_out[6:0]}), 
			.data_out(reg_id_ex_out), 
			.clk(clk), 
			.rst(rst)
	);

	// 32 bits data from ALU
	// 32 bits Db
	// [4:0] Aw
	// RegWr
	// RegDst
	// MemWr
	// MemToReg
	// 73 total
	Register #(.width(73)) EX_MEM_register(
			.data_in({ALUout, reg_id_ex_out[43:3]}), //ALU out can be forwared back to ID
			.data_out(reg_ex_mem_out), 
			.clk(clk), 
			.rst(rst)
	);

	// 32 bits from mux
	// [4:0] Aw
	// RegWr
	// RegDst
	// 39 total
	Register #(.width(39)) MEM_WR_register(
			.data_in({Dw, reg_ex_mem_out[8:2]}), //DW can be forwared back to ID (or should i be before the mux...)
			.data_out(reg_mem_wr_out), 
			.clk(clk), 
			.rst(rst)
	);

	// Connect register addresses from instruction fetch.
	assign Rs = reg_if_id_out[32:28];
	assign Rt = reg_if_id_out[27:23];
	assign Rd = reg_if_id_out[22:18];

	// Connect Imm16.
	assign Imm16 = reg_if_id_out[22:7];

	// Connect output to out of reg/dec stage.
	assign seOut = reg_id_ex_out[75:44];

	// Output from reg/dec stage
	assign reg_Da = reg_id_ex_out[107:76];

endmodule
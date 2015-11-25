`timescale 1 ps / 100 fs
/*
Datapth for 32 Bit single cycle mips cpu based on architecture 
from slides 88 and 89.
*/
module datapath(clk, RegDst, RegWr, ALUsrc, ALUcntrl, MemWr,
					MemToReg, seOut, Instructions, reg_Da);

	// Control signals
	input clk, RegDst, RegWr, ALUsrc, MemWr, MemToReg;
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

	assign reg_Da = Da;

	// Register addresses
	wire [4:0] Aw, Rs, Rd, Rt;

	// Single bit wires for ALU
	wire overflow, carryout, Negative;

	// Selects reg address to which to write.
	Mux_32_2x1 #(.width(5)) regDstMux(.out(Aw), .in({Rd, Rt}), .select(RegDst));

	// Extends imm_16 bits.
	signExtend SE(.imm(Imm16), .out(se32));

	// Register File
	regfile registerFile(
			.ReadData1(Da), .ReadData2(Db), .WriteData(Dw),
			.ReadRegister1(Rs), .ReadRegister2(Rt), 
			.WriteRegister(Aw), .RegWrite(RegWr), .clk(clk));

	// Mux for ALU input.
	Mux_32_2x1 ALUSrcMux(.out(ALUin), .in({se32, Db}), .select(ALUsrc));

	// System ALU.
	alu ALU(.out(ALUout), .carryout(carryout), .zero(Zero), 
				.overflow(overflow), .negative(Negative), 
				.bus_a(Da), .bus_b(ALUin), .alu_cntr(ALUcntrl));

	// Data memory unit
	dataMem dataMemory(.data(Dout), .address(ALUout), .writedata(Db),
				 .writeenable(MemWr), .clk(clk));

	// Mux for write data back to Reg File.
	Mux_32_2x1 DwMux(.out(Dw), .in({Dout, ALUout}), .select(MemToReg));

	// Connect register addresses from instruction memory.
	assign Rs = Instructions[25:21];
	assign Rt = Instructions[20:16];
	assign Rd = Instructions[15:11];
	assign Imm16 = Instructions[15:0];
	assign seOut = se32;

endmodule
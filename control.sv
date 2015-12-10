/*
Control logic for the single cycle mips CPU
This is the only part of the CPU in behavorial Verilog.

The control always block is broken into 2 seperate parts,
the I type instructions, and the R type instructions. 
Which case statement to use to map the control flags is 
based on the top six bits of a 32 bit machine code value.
An R type instruction has the top 6 bits set to 0.
*/

module control (
	output reg [25:0] target_inst, 
	output reg RegDst, 
	output reg RegWr, 
	output reg ALUsrc, 
	output reg [1:0] ALUcntrl, 
	output reg MemWr, 
	output reg MemToReg, 
	output jump_del, 
	output branch_del, 
	output reg mem_forward_a,
	output reg ex_forward_a,
	output reg mem_forward_b,
	output reg ex_forward_b,
	input clk, 
	input rst,
	input [31:0] instruction,
	input [31:0] ex_int_forward, //instruction 1 clocks back
	input [31:0] mem_int_forward //instruction 2 clocks back
);

	//parameters describing different possible instructions. 
	//the values map to the MIPS machine code, either in the 
	//op field for I type instructions, or the func field for r 
	//type instructions. when parameters have an underscore, it indicates
	//that the value is overloaded between r type and i type instructions. 
	parameter [5:0] addi_jr = 6'b001000, bltz = 6'b000001, j = 6'b000010, 
			lw_subu = 6'b100011, norr = 6'b100111, sltu_sw = 6'b101011;

	//parameters for the ALU operations. 
	parameter [1:0] ADD = 2'b00, SUB = 2'b01, NOR = 2'b10, SLTU = 2'b11;

	reg jump, branch;

	//delay branch and jump flags by one clock (datapathy)
	Register branchDelayer(
		.data_in (branch),
		.data_out(branch_del),
		.clk     (clk),
		.rst     (rst)
	);

	Register jumpDelayer(
		.data_in (jump),
		.data_out(jump_del),
		.clk     (clk),
		.rst     (rst)
	);

	/*Forwarding control singals:
		mem_forward_a = 0;
		ex_forward_a = 0;
		mem_forward_b = 0;
		ex_forward_b = 0;
	*/

	//rename wire slices for clarity (shouldnt effect actual delay/speed)
	wire [4:0] rs_last = ex_int_forward[25:21];
	wire [4:0] rt_last = ex_int_forward[20:16];
	wire [4:0] rd_last = ex_int_forward[15:11];
	wire [4:0] rs_last_last = mem_int_forward[25:21];
	wire [4:0] rt_last_last = mem_int_forward[20:16];
	wire [4:0] rd_last_last = mem_int_forward[15:11];
	wire [5:0] op_last =  ex_int_forward[31:26];
	wire [5:0] op_last_last = mem_int_forward[31:26];
	wire [5:0] func_last = ex_int_forward[5:0];
	wire [5:0] func_last_last = mem_int_forward[5:0];
	wire[4:0] rs = instruction[25:21];
	wire[4:0] rt = instruction[20:16];

	always @ (*) begin: forward_logic
		if(rst) begin : rst_statement
			mem_forward_a = 1'b0;
			mem_forward_b = 1'b0;
			ex_forward_a = 1'b0;
			ex_forward_b = 1'b0;
		end
		//forawrd ex a
		if(rd_last == rs & rd_last != 0 & op_last == 0) begin
			ex_forward_a = 1'b1;
		end else if(rt_last == rs & rt_last != 0 & op_last != 0) begin
			ex_forward_a = 1'b1;
		end else begin
			ex_forward_a = 1'b0;
		end
		//forward ex b (only r type)
		if(rd_last == rt & rd_last != 0 & op_last == 0) begin
			ex_forward_b = 1'b1;
		end else if(rt_last == rt & rt_last != 0 & op_last != 0) begin
			ex_forward_b = 1'b1;
		end else begin
			ex_forward_b = 1'b0;
		end
		//forward mem a
		if(rd_last_last == rs & rd_last_last != 0 & op_last_last == 0) begin
			mem_forward_a = 1'b1;
		end else if(rt_last_last == rs & rt_last_last != 0 & op_last_last != 0) begin
			mem_forward_a = 1'b1;
		end else begin
			mem_forward_a = 1'b0;
		end
		//forward mem b (only r type)
		if(rd_last_last == rt & rd_last_last != 0 & op_last_last == 0) begin
			mem_forward_b = 1'b1;
		end else if(rt_last_last == rt & rt_last_last != 0 & op_last_last != 0) begin
			mem_forward_b = 1'b1;
		end else begin
			mem_forward_b = 1'b0;
		end
	end

	always @ (instruction) begin: control_logic
		if (instruction[31:26] == 6'h00) begin //r type case statement
			case(instruction[5:0]) 
				addi_jr: begin //jump register
					RegDst <= 1'bx;
					RegWr <= 1'b0;
					ALUsrc <= 1'bx;
					ALUcntrl <= 2'bxx;
					MemWr <= 1'b0;
					MemToReg <= 1'bx;
					jump <= 1'b1;
					branch <= 1'b1;
					target_inst <= 25'hxxxxxxx;
				end
				lw_subu: begin //sub unsigned
					RegDst <= 1'b1;
					RegWr <= 1'b1;
					ALUsrc <= 1'b0;
					ALUcntrl <= SUB;
					MemWr <= 1'b0;
					MemToReg <= 1'b0;
					jump <= 1'b0;
					branch <= 1'b0;
					target_inst <= 25'hxxxxxxx;
				end
				norr: begin //not or
					RegDst <= 1'b1;
					RegWr <= 1'b1;
					ALUsrc <= 1'b0;
					ALUcntrl <= NOR;
					MemWr <= 1'b0;
					MemToReg <= 1'b0;
					jump <= 1'b0;
					branch <= 1'b0;
					target_inst <= 25'hxxxxxxx;
				end
				sltu_sw: begin //set less than unsigned
					RegDst <= 1'b1;
					RegWr <= 1'b1;
					ALUsrc <= 1'b0;
					ALUcntrl <= SLTU;
					MemWr <= 1'b0;
					MemToReg <= 1'b0;
					jump <= 1'b0;
					branch <= 1'b0;
					target_inst <= 25'hxxxxxxx;
				end
				default: begin //if we end up here, something went wrong
					RegDst <= 1'bx;
					RegWr <= 1'bx;
					ALUsrc <= 1'bx;
					ALUcntrl <= 1'bx;
					MemWr <= 1'bx;
					MemToReg <= 1'bx;
					jump <= 1'bx;
					branch <= 1'bx;
					target_inst <= 25'hxxxxxxx;
				end
			endcase
		end else begin
			case(instruction[31:26])  //I type intructions
				addi_jr: begin //add immediate
					RegDst <= 1'b0;
					RegWr <= 1'b1;
					ALUsrc <= 1'b1;
					ALUcntrl <= ADD;
					MemWr <= 1'b0;
					MemToReg <= 1'b0;
					jump <= 1'b0;
					branch <= 1'b0;
					target_inst <= 25'hxxxxxxx;
				end
				bltz: begin //branch less than zero
					RegDst <= 1'bx;
					RegWr <= 1'b0;
					ALUsrc <= 1'bx;
					ALUcntrl <= 2'bxx;
					MemWr <= 1'b0;
					MemToReg <= 1'bx;
					jump <= 1'b0;
					branch <= 1'b1;
					target_inst <= 25'hxxxxxxx;
				end
				j: begin //jump
					RegDst <= 1'bx;
					RegWr <= 1'b0;
					ALUsrc <= 1'bx;
					ALUcntrl <= 2'bxx;
					MemWr <= 1'b0;
					MemToReg <= 1'bx;
					jump <= 1'b1;
					branch <= 1'b0; //Due to how jr is implemented, this must be 0
					target_inst <= instruction[25:0];
				end
				lw_subu: begin //load word
					RegDst <= 1'b0;
					RegWr <= 1'b1;
					ALUsrc <= 1'b1;
					ALUcntrl <= ADD;
					MemWr <= 1'b0;
					MemToReg <= 1'b1;
					jump <= 1'b0;
					branch <= 1'b0;
					target_inst <= 25'hxxxxxxx;
				end
				sltu_sw: begin //store word
					RegDst <= 1'bx;
					RegWr <= 1'b0;
					ALUsrc <= 1'b1;
					ALUcntrl <= ADD;
					MemWr <= 1'b1;
					MemToReg <= 1'b0;
					jump <= 1'b0;
					branch <= 1'b0;
					target_inst <= 25'hxxxxxxx;
				end
				default: begin
					RegDst <= 1'bx;
					RegWr <= 1'bx;
					ALUsrc <= 1'bx;
					ALUcntrl <= 1'bx;
					MemWr <= 1'bx;
					MemToReg <= 1'bx;
					jump <= 1'bx;
					branch <= 1'bx;
					target_inst <= 25'hxxxxxxx;
				end
			endcase
		end
	end


endmodule
/*
Takes a 16 bit integer and extends the sign bit across 16 bits to
extend the 16 bit number to 32 bits.
*/
`timescale 1 ps / 100 fs

module signExtend(imm, out);
	// To be extended
	input [15:0] imm;
	// Output from extension
	output [31:0] out;
	
	// Set bottom bits to immediate value
	assign out[15:0] = imm;

	// Wire to be assigned
	genvar currentWire;
	// connect all top bits to be same as sign bit
	generate
		for(currentWire = 16; currentWire < 32; currentWire++) begin: SEwires
			assign out[currentWire] = imm[15];	
		end
	endgenerate
endmodule
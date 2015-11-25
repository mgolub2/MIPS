`timescale 1 ps / 100 fs
/*
Module to concatenate the top 4 bits of the program counter
and the bottom 26 of the target instruction

Retrospectivly, this could easily be a single statement. 
However it was a seperate block on the schematic, and was implemented
as a module.
*/

module concat(out, top, bott);
	
	output [29:0] out;
	input [3:0] top;
	input [25:0] bott;

	assign out[29:26] = top;
	assign out[25:0] = bott;

endmodule // concat
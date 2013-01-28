module KeyCounter(LEDG, KEY); 
	output [3:0] LEDG;
	input [0:0] KEY;
	reg [3:0] state; // A 4-bit register
	initial state = 0; // Note - this is a 4-bit zero
	always @(posedge !KEY[0])
		state <= state+1; // Note - creates a 4-bit adder
	assign LEDG = state;
endmodule

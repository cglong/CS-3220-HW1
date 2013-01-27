module MultiSwitchLight(LEDG, KEY);
	output [0:0] LEDG;
	input [3:0] KEY;
	
	wire flip1 = !KEY[2];
	wire flip2 = !KEY[3];
	
	reg state1, state2;
	always @(posedge flip1) state1 <= !state1;
	always @(posedge flip2) state2 <= !state2;
	assign LEDG[0] = state1 ^ state2;
endmodule
module MultiSwitchLight(LEDG, KEY);
	output [1:0] LEDG;
	input [3:0] KEY;
	
	wire flip0 = !KEY[0];
	wire flip1 = !KEY[1];
	wire flip2 = !KEY[2];
	wire flip3 = !KEY[3];
	
	reg state0, state1, state2, state3;
	always @(posedge flip0) state0 <= !state0;
	always @(posedge flip1) state1 <= !state1;
	always @(posedge flip2) state2 <= !state2;
	always @(posedge flip3) state3 <= !state3;
	
	assign LEDG[0] = state0 ^ state1 ^ state2 ^ state3;
	assign LEDG[1] = state0 ^ state1 ^ state2 ^ state3;
endmodule

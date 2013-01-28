module MemoryValueReader();
	reg [15:0] mem[0:1023]; // 1024-entry, 16-bit memory
	reg [15:0] mdr; // 16-bit MDR register
	reg [9:0] mar; // 10-bit MAR register
	initial mar = 10'd0; // MAR starts with value zero
	always @(posedge clock) begin
	mdr <= mem[mar]; // Read memory
	mar <= mar + 10’d1; // And increment mar register
	end
	// Do something with MDR, e.g. display it:
	SevenSeg sseg0(.IN(mdr[ 3: 0]),.OUT(HEX0));
	SevenSeg sseg1(.IN(mdr[ 7: 4]),.OUT(HEX1));
	SevenSeg sseg2(.IN(mdr[11: 8]),.OUT(HEX2));
	SevenSeg sseg3(.IN(mdr[15:12]),.OUT(HEX3));
endmodule
	
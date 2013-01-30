module MemoryValueReader(KEY, HEX0, HEX1, HEX2, HEX3, CLOCK_50);
	(* ram_init_file = "3.mif" *)
	input CLOCK_50;
	input [0:0] KEY;
	output [6:0] HEX0, HEX1, HEX2, HEX3;	
	reg [15:0] mem[0:1023]; // 1024-entry, 16-bit memory
	reg [15:0] mdr; // 16-bit MDR register
	reg [9:0] mar; // 10-bit MAR register
	reg [31:0] Cnt;
	initial mar = 10'd0; // MAR starts with value zero
	initial Cnt = 32'd0;
	
	always @(posedge CLOCK_50) begin
		Cnt <= Cnt + 32'd1;
		if (Cnt == 32'd25000000) begin
			mdr <= mem[mar]; // Read memory
			mar <= mar + 10'd1; // And increment mar register
			Cnt <= 32'd0;
		end
	end
	
	// Do something with MDR, e.g. display it:
	SevenSeg sseg0(.IN(mdr[ 3: 0]),.OUT(HEX0));
	SevenSeg sseg1(.IN(mdr[ 7: 4]),.OUT(HEX1));
	SevenSeg sseg2(.IN(mdr[11: 8]),.OUT(HEX2));
	SevenSeg sseg3(.IN(mdr[15:12]),.OUT(HEX3));
	
endmodule
	
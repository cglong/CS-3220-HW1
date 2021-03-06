module MemoryValueReader(KEY, HEX0, HEX1, HEX2, HEX3, CLOCK_50); 
	output [6:0] HEX0, HEX1, HEX2, HEX3; 
	input [0:0] KEY;
	input CLOCK_50;
	reg [15:0] mem[0:1023]; // 1024-entry, 16-bit memory
	(* ram_init_file = "mem.mif" *)
	reg [15:0] mdr; // 16-bit MDR register
	reg [9:0] mar; // 10-bit MAR register
	initial mar = 10'd0; // MAR starts with value zero
	reg [31:0] Cnt;
	initial Cnt = 32'd0;
		
	always @(posedge CLOCK_50) begin
		Cnt <= Cnt + 32'd1;
		if (Cnt == 32'd50000000) begin
			mdr <= mem[mar]; // Read memory
			mar <= mar + 10'd1; // And increment mar register
			Cnt <= 32'd0;
		end
		if (!KEY[0])
			mar <= 10'd0; // Reset value
	end
		
	SevenSeg sseg0(.IN(mdr[ 3: 0]),.OUT(HEX0));
	SevenSeg sseg1(.IN(mdr[ 7: 4]),.OUT(HEX1));
	SevenSeg sseg2(.IN(mdr[11: 8]),.OUT(HEX2));
	SevenSeg sseg3(.IN(mdr[15:12]),.OUT(HEX3));
	
endmodule

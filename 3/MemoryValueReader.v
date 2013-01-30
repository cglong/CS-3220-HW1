module MemoryValueReader(HEX0, HEX1, HEX2, HEX3, KEY, CLOCK_50);
	(* ram_init_file = "3.mif" *)
	output [6:0] HEX0, HEX1, HEX2, HEX3;
	input [0:0] KEY;
	input CLOCK_50;
	
	reg [15:0] mem[0:16]; // 16-entry, 16-bit memory
	reg [15:0] mdr; // 16-bit MDR register
	reg [9:0] mar; // 10-bit MAR register
	reg [31:0] Cnt;
	initial mar = 10'd0; // MAR starts with value zero
	initial Cnt = 32'd0;
	
	always @(posedge CLOCK_50) begin
		Cnt <= Cnt + 32'd1;
		
		if (Cnt == 32'd25000000) begin
			mdr <= mem[mar]; // Read memory
			Cnt <= 32'd0;
			if (mar == 10'd16)
				mar <= 10'd0;
			else
				mar <= mar + 10'd1; // Increment value
		end
		
		if (!KEY[0])
			mar <= 10'd0; // Reset value
	end
	
	// Display value
	SevenSeg sseg0(.IN(mdr[3:0]),.OUT(HEX0));
	SevenSeg sseg1(.IN(mdr[7:4]),.OUT(HEX1));
	SevenSeg sseg2(.IN(mdr[3:0]),.OUT(HEX2));
	SevenSeg sseg3(.IN(mdr[7:4]),.OUT(HEX3));
endmodule
	
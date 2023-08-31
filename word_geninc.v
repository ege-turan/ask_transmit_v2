module word_geninc(
	input clk,
	output [11:0] word,
	output newres);
	
reg [9:0] number;  // number to send
//reg [9:0] invert ;  // use to invert bits every other new pulse
reg [3:0] bitcnt;   // counts from 0 to 11
reg [23:0] slowcnt ; // delay counter to enable increment of number
wire cnt_en;

// make counter of 12 bits and pulse new high at bit 11
assign newres = (bitcnt == 11) ;
always @(posedge clk)
	if (newres) bitcnt <= 0;
	else bitcnt <= bitcnt + 1;

// make slow counter to have readable number updated slowly
assign cnt_en = (slowcnt == 24'HFFFFFF);
always @(posedge clk) 
	if (newres & cnt_en) begin
		slowcnt <= 0;
		number <= number + 1;
		//invert <= 0;
	end
	else if (newres) begin
		slowcnt <= slowcnt + 1;
		//invert <= ~invert ;  // comment out to stop inverting
	end

//assign word = {1'b1, number^invert, 1'b0};  // append start stop bits to number

assign word = {1'b1, number, 1'b0};

endmodule



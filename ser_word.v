//loads a 12 bit word on the clk rising edge into a
//shift register if signal new_word is high, else it shifts the bits to the left
//on each pulse.  Since the register is 12 bits, it should always get refilled
//in time. The serial output is just connected to the most significant bit.

module ser_word(
	input [11:0] word,
	input clk, new_word,	
	output ser_out);
	
//  when new_word is high, load in a new word to a 12 bit shift register.
// output bit 11 (most sig bit). On each clock shift data left
	

	reg[11:0] shiftreg;   // 12 bit shift register data
	
	
	 assign ser_out = shiftreg[11] ; //use for ASK modulation
	

	always @(negedge clk)
		if (new_word) shiftreg <= word ;
		else begin
			shiftreg[11:1] <= shiftreg[10:0] ;
			shiftreg[0] <= 1'b0 ;
		end
	
endmodule
	

			
					
// Ege Turan
// 8/30/23, Stanford, CA
// Scrambling Serializer

// Loads a 12 bit word on the clk rising edge into a
//shift register if signal new_word is high, else it shifts the bits to the left
//on each pulse.  
// Does multiplicative scrambling (on non-start/stop bits) by XOR'ing with a
// 22 bit schift register
// Since the register is 12 bits, it should always get refilled
//in time. The serial output is just connected to the most significant bit.

module ser_scrambled_word(
	input [11:0] word,
	input clk, new_word,
	output ser_out);
	
//  when new_word is high, load in a new word to a 12 bit shift register.
// output bit 11 (most sig bit). On each clock shift data left
	

	reg[11:0] shiftreg;   // 12 bit shift register data
	wire ser_in;
	
	assign ser_in = shiftreg[11] ;
	
	always @(negedge clk)
		if (new_word) shiftreg <= word ;
		else begin
			shiftreg[11:1] <= shiftreg[10:0] ;
			shiftreg[0] <= 1'b0 ;
		end
	
	parameter SEED = 23'b1;
	reg[22:0] scrambler = SEED;
	reg[3:0] track = 0;
	
	wire in_xor;
	reg out;
	assign in_xor = ser_in^scrambler[3]^scrambler[22];
	
	always @(posedge clk) begin
		if (new_word || (track == 10)) begin
			track <= 0;
			out <= ser_in; 	//  out <= 1 ; // flag for alternative way below with multiplexer
			end
		else begin
			out <= in_xor;      // out <= 0 ;
			scrambler[22:1] <= scrambler[21:0];
			scrambler[0] <= in_xor;
			track <= track + 1; //where I put the track <= track +1 only determines what I put in the condition, it is just two different ways of looking at it.
			end
		end
	
	
	//assign ser_out = out ? ser_in : in_xor; // to use is pos edge for first always block.
	
	
	/*---------------ASK/DPSK Modulation Selection-------------------*/
	
	//assign ser_out = out; //use for ASK modulation
	
	/* use below for DPSK modulation */
	reg last;
	assign ser_out = (out)^(last);
	
	always @(posedge clk)
		 last <= ser_out;

	/* use above for DPSK modulation */
	
/*---------------------------------------------------------------*/
	
	
endmodule
	

			
					
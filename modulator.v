module modulator (
	input clk, rst, load,
	output new_word,
	output xor_result);

	
wire passed_bit;
wire strobe;
wire [11:0] word;

assign new_word = strobe;

lfsr l1 (.outbit(passed_bit), .clk(clk), .rst(rst), .load(load));

word_geninc u1(.clk(clk), .word(word), .newres(strobe));

// to be updated with a shift register structure (case 0 and case 11).
//word_generator wg1(.inbit(passed_bit), .clk(clk), .new_word(new_word), .finished_word(word));	
//word_generator wg1(.inbit(passed_bit), .clk(clk), .new_word(strobe), .finished_word(word));	

//xor_word x1(.word(word), .receive_word(new_word), .clk(clk), .result_out(result_out), .xor_result(xor_result));

// SHUFFLE SETTINGS
//ser_word x1(.word(word), .clk(clk), .new_word(strobe), .ser_out(xor_result));				//not shuffled
ser_scrambled_word x1(.word(word), .clk(clk), .new_word(strobe), .ser_out(xor_result));	//shuffled

endmodule
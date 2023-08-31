// Ege Turan
// 8/30/23, Stanford, CA
// Microwave Link Transmit System

module top (
	input MAX10_CLK1_50, rst, load,
	output demodulated, new_word
	);
	
wire result_out, xor_result, clk;

// Clock frequency control
fast_pll pll_inst(.inclk0(MAX10_CLK1_50), .c0(clk));  // activate for 240 Mbps (actual 200 Mbps data transfer)
//slow_pll pll_inst(.inclk0(MAX10_CLK1_50), .c0(clk)); // activate for 120 Mbps (actual 100 Mbps data transfer)

//fastpll pll_inst(.inclk0(MAX10_CLK1_50), .c0(clk)); // for random words, 250 Mbps


modulator mod(clk, rst, load, new_word, xor_result);
assign demodulated = xor_result;

// For testing:
// LVDS requires negated output
// assign demodulated = ~neg_demodulated;

endmodule
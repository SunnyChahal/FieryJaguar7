module datapath ( slow_clock, fast_clock, resetb,
                  load_pcard1, load_pcard2, load_pcard3,
                  load_dcard1, load_dcard2, load_dcard3,				
                  pcard3_out,
                  pscore_out, dscore_out,
                  HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
						
input slow_clock, fast_clock, resetb;
input load_pcard1, load_pcard2, load_pcard3;
input load_dcard1, load_dcard2, load_dcard3;
output [3:0] pcard3_out;
output [3:0] pscore_out, dscore_out;
output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

wire [3:0] new_card, pcard1_out, pcard2_out, pcard3_out, dcard1_out, dcard2_out, dcard3_out;

//dealer
dealcard DEALER (.clock(fast_clock), .resetb(resetb), .new_card(new_card));

//card value registers	
reg4 PCARD1 (.in(new_card), .load(load_pcard1), .rst(resetb), .clk(slow_clock), .out(pcard1_out));
reg4 PCARD2 (.in(new_card), .load(load_pcard2), .rst(resetb), .clk(slow_clock), .out(pcard2_out));
reg4 PCARD3 (.in(new_card), .load(load_pcard3), .rst(resetb), .clk(slow_clock), .out(pcard3_out));
reg4 DCARD1 (.in(new_card), .load(load_dcard1), .rst(resetb), .clk(slow_clock), .out(dcard1_out));
reg4 DCARD2 (.in(new_card), .load(load_dcard2), .rst(resetb), .clk(slow_clock), .out(dcard2_out));
reg4 DCARD3 (.in(new_card), .load(load_dcard3), .rst(resetb), .clk(slow_clock), .out(dcard3_out));

//card 7seg drivers
card7seg PC1_7SEG (.SW(pcard1_out), .HEX0(HEX0));
card7seg PC2_7SEG (.SW(pcard2_out), .HEX0(HEX1));
card7seg PC3_7SEG (.SW(pcard3_out), .HEX0(HEX2));
card7seg DC1_7SEG (.SW(dcard1_out), .HEX0(HEX3));
card7seg DC2_7SEG (.SW(dcard2_out), .HEX0(HEX4));
card7seg DC3_7SEG (.SW(dcard3_out), .HEX0(HEX5));

//hand scorers
scorehand PSCORER (.card1(pcard1_out), .card2(pcard2_out), .card3(pcard3_out), .total(pscore_out));
scorehand DSCORER (.card1(dcard1_out), .card2(dcard2_out), .card3(dcard3_out), .total(dscore_out));

// The code describing your datapath will go here.  Your datapath 
// will hierarchically instantiate six card7seg blocks, two scorehand
// blocks, and a dealcard block.  The registers may either be instatiated
// or included as sequential always blocks directly in this file.
//
// Follow the block diagram in the Lab 1 handout closely as you write this code


endmodule

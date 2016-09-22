// This module contains a Verilog description of the top level module
// Assuming you don't modify the inputs and outputs of the various submodules,
// you should not have to modify anything in this file.

module lab1_w_chlngtsk (CLOCK_50, SW, KEY, LEDR, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
input CLOCK_50;
input [9:0] SW;
input [3:0] KEY;
output [9:0] LEDR;
output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

// Some local signals 

wire fast_clock, slow_clock, resetb;
wire load_pcard1, load_pcard2, load_pcard3;
wire load_dcard1, load_dcard2, load_dcard3;
wire endround;
wire [3:0] pscore, dscore;
wire [3:0] pcard3;
	

assign resetb = KEY[3];
assign slow_clock = KEY[0];
assign fast_clock = CLOCK_50;

// instantiate the datapath
	
datapath dp (.slow_clock(slow_clock),
             .fast_clock(fast_clock),
             .resetb(resetb),
             .load_pcard1(load_pcard1),
             .load_pcard2(load_pcard2),
             .load_pcard3(load_pcard3),
             .load_dcard1(load_dcard1),
             .load_dcard2(load_dcard2),
             .load_dcard3(load_dcard3),
             .dscore_out(dscore),
             .pscore_out(pscore),
             .pcard3_out(pcard3),
             .HEX5(HEX5),
             .HEX4(HEX4),
             .HEX3(HEX3),
             .HEX2(HEX2),
             .HEX1(HEX1),
             .HEX0(HEX0));
							


// instantiate the state machine
	
statemachine sm (.slow_clock(slow_clock),
                 .resetb(resetb),
				 .endround(endround),
                 .dscore(dscore),
                 .pscore(pscore),
                 .pcard3(pcard3),
                 .load_pcard1(load_pcard1),
                 .load_pcard2(load_pcard2),
                 .load_pcard3(load_pcard3),						  
                 .load_dcard1(load_dcard1),
                 .load_dcard2(load_dcard2),
                 .load_dcard3(load_dcard3),	
                 .player_win_light(LEDR[8]), 
                 .dealer_win_light(LEDR[9]));
					  
balance bal ( .endround(endround),
			  .reset(KEY[2]), 
			  .SW(SW), 
			  .pscore(pscore), 
			  .dscore(dscore), 
			  .LEDR(LEDR[7:0]));				  
	
endmodule

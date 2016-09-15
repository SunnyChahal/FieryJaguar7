module statemachine ( slow_clock, resetb,
                      dscore, pscore, pcard3,
                      load_pcard1, load_pcard2,load_pcard3,
                      load_dcard1, load_dcard2, load_dcard3,
                      player_win_light, dealer_win_light);
							 
	input slow_clock, resetb;
	input [3:0] dscore, pscore, pcard3;
	output load_pcard1, load_pcard2, load_pcard3;
	output load_dcard1, load_dcard2, load_dcard3;
	output player_win_light, dealer_win_light;

	`define RST 0;	//define states
	`define PC1 1;
	`define DC1 2;
	`define PC2 3;
	`define DC2 4;
	`define PC3 5;
	`define DC3 6;
	`define END 7;

	reg [7:0] state;
	
	//next state logic
	always @(negedge slow_clock or negedge resetb) begin
		if (reset)
			state <= `RST;
		case (state)
			`RST: state <= `PC1;
			`PC1: state <= `DC1;
			`DC1: state <= `PC2;
			`PC2: state <= `DC2;
			`DC2:
				//pscore is [0-5]
				if (pscore < 6)
					state <= `PC3;
				//pscore is [6-7] and dscore is [0-5]
				else if ((pscore == 6 || pscore == 7) &&
				          dscore < 6)
					state <= `DC3;
				//pscore or dscore is [8-9], or pscore and dscore is [6-7]
				else
					state <= `END;
			`PC3: 
				//ridiculous conditions
				if (dscore == 6)
					if (pcard3 == 6 || pcard3 == 7)
						state <= `DC3;
					else state <= `END;
				if (dscore == 5)
					//got to here sunny
					state <= `DC3;
				else
					state <= `END;
			`DC3: state <= `END;
			`END: state <= `RST;
			default: state <= `RST;
		endcase
	end
	
	//output logic
	always_comb @(*) begin
		case (pstate)
			//turn on load signal for each card
			`RST: {load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3, player_win_light, dealer_win_light}
			= 0'b00000000;
			`PC1: {load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3, player_win_light, dealer_win_light}
			= 0'b10000000;
			`PC2: {load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3, player_win_light, dealer_win_light}
			= 0'b01000000;
			`PC3: {load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3, player_win_light, dealer_win_light}
			= 0'b00100000;
			`DC1: {load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3, player_win_light, dealer_win_light}
			= 0'b00010000;
			`DC2: {load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3, player_win_light, dealer_win_light}
			= 0'b00001000;
			`DC3: {load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3, player_win_light, dealer_win_light}
			= 0'b00000100;
			//display win lights for player and dealer
			`END: 
				if (dscore > pscore)
					{load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3, player_win_light, dealer_win_light}
					= 0'b00000001;		//dealer wins
				else if (dscore < pscore)
					{load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3, player_win_light, dealer_win_light}
					= 0'b00000010;		//player wins
				else
					{load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3, player_win_light, dealer_win_light}
					= 0'b00000011;		//tie
			default: {load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3, player_win_light, dealer_win_light}
					= 0'b00000000;
		endcase
	end
	
// The code describing your state machine will go here.  Remember that
// a state machine consists of next state logic, output logic, and the 
// registers that hold the state.  You will want to review your notes from
// CPEN 211 or equivalent if you have forgotten how to write a state machine.
	
endmodule

module statemachine ( slow_clock, resetb, endround,
                      dscore, pscore, pcard3,
                      load_pcard1, load_pcard2,load_pcard3,
                      load_dcard1, load_dcard2, load_dcard3,
                      player_win_light, dealer_win_light);
							 
	input slow_clock, resetb;
	input [3:0] dscore, pscore, pcard3;
	output reg load_pcard1, load_pcard2, load_pcard3;
	output reg load_dcard1, load_dcard2, load_dcard3;
	output reg player_win_light, dealer_win_light;
	
	output reg endround; //for challenge task (this is turned on after each round)
    
	`define RST 0	//define states
	`define PC1 1
	`define DC1 2
	`define PC2 3
	`define DC2 4
	`define PC3 5
	`define DC3 6
	`define END 7

	reg [7:0] state;
	
	//next state logic
	always @(negedge slow_clock or negedge resetb) begin
		if (resetb == 0) 
			begin
			state <= `RST;
			end
		else 
		begin
		case (state)
			`RST: state <= `PC1;
			`PC1: state <= `DC1;
			`DC1: state <= `PC2;
			`PC2: state <= `DC2;
			`DC2:
				//pscore is [0-5]
				if (pscore == 8 || pscore == 9 || dscore == 8 || dscore == 9)
					begin 
					state <= `END;
					end
				else if (pscore < 6)
					begin
					state <= `PC3;
				//pscore is [6-7] and dscore is [0-5]
				   end 
				else if ((pscore == 6 || pscore == 7) && dscore < 6) 
				   begin
					state <= `DC3;
				//pscore or dscore is [8-9], or pscore and dscore is [6-7]
				   end 
				else 
					begin
					state <= `END;
					end
			`PC3: 
				//ridiculous conditions
				if (dscore == 6) 
				   begin
					if (pcard3 == 6 || pcard3 == 7)
						begin
						state <= `DC3;
						end 
					else 
						begin 
						state <= `END; 
						end
					end 
				else if (dscore == 5) 
					begin
					if (pcard3 == 4 || pcard3 == 5 || pcard3 == 6 || pcard3 == 7) 
						begin
					   state <= `DC3;
						end 
					else 
						begin 
						state <= `END;
						end
					end
            else if (dscore == 4)
					begin
               if (pcard3 == 2 || pcard3 == 3 || pcard3 == 4 || pcard3 == 5 || pcard3 == 6 || pcard3 == 7)
						begin
                  state <= `DC3;
						end
               else
						begin
						state <= `END;
						end
					end	
            else if (dscore == 3)
					begin
					if (pcard3 != 8)
						begin
                  state <= `DC3;
						end
               else
						begin
						state <= `END;
						end
					end
            else if (dscore == 2 || dscore == 1 || dscore == 0)
					begin
					state <= `DC3;
					end
				else
					begin
					state <= `END;
					end
			`DC3: state <= `END;
			`END: state <= `RST;
			default: state <= `RST;
		endcase
		end
	end
	
	//output logic
	always @(*) begin
		case (state)
			//turn on load signal for each card
			`RST: {load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3, player_win_light, dealer_win_light, endround}
			= 9'b000000000;
			`PC1: {load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3, player_win_light, dealer_win_light, endround}
			= 9'b100000000;
			`PC2: {load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3, player_win_light, dealer_win_light, endround}
			= 9'b010000000;
			`PC3: {load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3, player_win_light, dealer_win_light, endround}
			= 9'b001000000;
			`DC1: {load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3, player_win_light, dealer_win_light, endround}
			= 9'b000100000;
			`DC2: {load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3, player_win_light, dealer_win_light, endround}
			= 9'b000010000;
			`DC3: {load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3, player_win_light, dealer_win_light, endround}
			= 9'b000001000;
			//display win lights for player and dealer
			`END: 
				if (dscore > pscore) begin
					{load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3, player_win_light, dealer_win_light, endround}
					= 9'b000000011;		//dealer wins
				end else if (dscore < pscore) begin
					{load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3, player_win_light, dealer_win_light, endround}
					= 9'b000000101;		//player wins
				end else begin
					{load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3, player_win_light, dealer_win_light, endround}
					= 9'b000000111;		//tie
				end	
			default: {load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3, player_win_light, dealer_win_light, endround}
					= 9'b000000000;			
		endcase
	end
endmodule

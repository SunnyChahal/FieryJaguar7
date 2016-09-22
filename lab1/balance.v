module balance (endround, reset, SW, pscore, dscore, LEDR);
	input [9:0] SW;
	input endround;
	input reset;
	input [3:0] pscore, dscore;
	output [7:0] LEDR;
	
	reg [7:0] balance;    // we are initially letting the gambler start with 100$. She can choose to keep betting until she becomes broke i.e. 0$ balance or earn upto a maximum of 512 $ balance so we use 8 bits.

	assign LEDR[7:0] = balance;
	
	//bits in winner:          pwin     |       dwin     |       tie
	wire [2:0] winner = {pscore > dscore, pscore < dscore, pscore == dscore};
	//bits in bet:         pbet     |      dbet     |      tbet
	wire [2:0] bet = {SW[8] & ~SW[9], SW[9] & ~SW[8], SW[8] & SW[9]};
	
	//synchronous module that computes balance every time the round is over (i.e. in `END state)
	always @(posedge endround, negedge reset) begin
		if (reset == 0) begin
			balance <= 50;
		end else begin
		case (winner)
			3'b001: //tie
				if (bet == 3'b001) begin				//bet on tie,    +%800 payout
					balance <= balance + (SW[7:0] * 8);
				end else begin							//otherwise -%100 payout
					balance <= balance - SW[7:0];
				end
			3'b100: //player won
				if (bet == 3'b100) begin				//bet on player,    +%100 payout
					balance <= balance + SW[7:0];
				end else begin							//otherwise, -%100 payout
					balance <= balance - SW[7:0];
				end
			3'b010:	//dealer won
				if (bet == 3'b010) begin				//bet on dealer, +%100 payout
					balance <= balance + SW[7:0];
				end else begin							//bet on dealer, +%95 payout
					balance <= balance - SW[7:0];
				end
			default:
				balance <= balance;
		endcase
		end
	end
endmodule

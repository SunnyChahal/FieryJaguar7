module balance (endround, SW, pscore, dscore, LEDR)
	input [7:0] SW, balance;
	input endround;
	input [3:0] pscore, dscore;
	output [0:7] LEDR;
	reg [7:0] balance;
	
	assign LEDR[7:0] = balance;
	
	//bits in winner:          pwin     |       dwin     |       tie
	wire [2:0] winner = {pscore > dscore, pscore < dscore, pscore == dscore};
	//bits in bet:         pbet     |      dbet     |      tbet
	wire [2:0] bet = {SW[9] & ~SW[8], SW[8] & ~SW[9], SW[8] & SW[9]}
	
	//synchronous module that computes balance every time the round is over (i.e. in `END state)
	always @(posedge endround) begin
		case (winner)
			3'b001: //tie
				if (tbet) begin				//bet on tie,    +%800 payout
					LEDR[7:0] <= balance + (SW[7:0] * 8);
				end else if (pbet) begin	//bet on player, -%100 payout
					LEDR[7:0] <= balance - SW[7:0];
				end else begin				//bet on dealer, -%100 payout
					LEDR[7:0] <= balance - SW[7:0];
				end
			2'b010: //player won
				if (tbet) begin				//bet on tie,    -%100 payout
					LEDR[7:0] <= balance - SW[7:0];
				end else if (pbet) begin	//bet on player, +%100 payout
					LEDR[7:0] <= balance + SW[7:0];
				end else begin				//bet on dealer, -%100 payout
					LEDR[7:0] <= balance - SW[7:0];
				end
			2'b001:	//dealer won
				if (tbet) begin				//bet on tie,    -%100 payout
					LEDR[7:0] <= balance - SW[7:0];
				end else if (pbet) begin	//bet on player, -%100 payout
					LEDR[7:0] <= balance - SW[7:0];
				end else begin				//bet on dealer, +%95 payout
					LEDR[7:0] <= balance + (SW[7:0] * 0.95);
				end
			default:
				LEDR[7:0] <= balance;
		endcase
	end
endmodule

module statemachine_task2 (clk, reset, initx, inity, loadx, loady, xdone, ydone, plot);
input xdone, ydone, reset, clk;
output reg initx, inity, loadx, loady, plot;
reg [1:0] current_state, next_state;

always_comb
	case (current_state)
		2'b00: {initx, inity, loady, loadx, plot} <= 5'b11110;
		2'b01: {initx, inity, loady, loadx, plot} <= 5'b10110;
		2'b10: {initx, inity, loady, loadx, plot} <= 5'b00011;
		default: {initx, inity, loady, loadx, plot} <= 5'b00010;
	endcase
always_ff@(posedge clk or posedge reset)
        if(reset == 1)
		current_state <= 2'b00;
		else
		current_state <= next_state;
		
always_comb
	case (current_state)
		2'b00: next_state <= 2'b10;
		2'b01: next_state <= 2'b10;
		2'b10: if (xdone == 0) next_state <= 2'b10;
				else if (ydone ==0) next_state <= 2'b01;
							  else next_state <= 2'b11;
		default: next_state <= 2'b11;
	endcase
endmodule	
		
module statemachine (clk, reset, initx, inity, initc, initr, loadx, loady, loadc, loadr, xdone, ydone, cdone, rdone, flagc, plot, selx, sely);
input xdone, ydone, cdone, cdone, rdone, clk, reset;
output reg initx, inity, initc, initr, loadx, loady, loadc, loadr, flagc, plot;
output reg [4:0] selx, sely;

//define states
`define RESET   4'd0
`define CNT_Y   4'd1
`define CNT_X   4'd2
`define INITR   4'd3
`define INITC   4'd4
`define OCT_1 	4'd5
`define OCT_2 	4'd6
`define OCT_3 	4'd7
`define OCT_4 	4'd8
`define OCT_5 	4'd9
`define OCT_6 	4'd10
`define OCT_7 	4'd11
`define OCT_8 	4'd12
`define UPDATE	4'd13
`define DONE 	4'd14

reg [3:0] state;

always_comb begin
	case(state)
		`RESET:   {loady, inity, loadx, flagc, initx, loadc, initc, loadr, initr, selx, sely, plot} <= {9'b111010011,5'b00000,5'b00000,1'b0}; //initr =0 loadr =0
		`CNT_Y:   {loady, inity, loadx, flagc, initx, loadc, initc, loadr, initr, selx, sely, plot} <= {9'b101010000,5'b10000,5'b10000,1'b0};//00
		`CNT_X:   {loady, inity, loadx, flagc, initx, loadc, initc, loadr, initr, selx, sely, plot} <= {9'b001000000,5'b10000,5'b10000,1'b1};	//00
		`INITR:	  {loady, inity, loadx, flagc, initx, loadc, initc, loadr, initr, selx, sely, plot} <= {9'b000000011,5'b10000,5'b10000,1'b0};
		`INITC:   {loady, inity, loadx, flagc, initx, loadc, initc, loadr, initr, selx, sely, plot} <= {9'b111111110,5'b10000,5'b10000,1'b0};   //initr = 1 loadr =1 
		`OCT_1:   {loady, inity, loadx, flagc, initx, loadc, initc, loadr, initr, selx, sely, plot} <= {9'b000100000,5'b00001,5'b00001,1'b1};  //0 0
		`OCT_2:   {loady, inity, loadx, flagc, initx, loadc, initc, loadr, initr, selx, sely, plot} <= {9'b000100000,5'b00010,5'b00010,1'b1};  
		`OCT_3:   {loady, inity, loadx, flagc, initx, loadc, initc, loadr, initr, selx, sely, plot} <= {9'b000100000,5'b00100,5'b00001,1'b1};  //it's written oct 4 here in the lab handout
		`OCT_4:   {loady, inity, loadx, flagc, initx, loadc, initc, loadr, initr, selx, sely, plot} <= {9'b000100000,5'b01000,5'b00010,1'b1};  
		`OCT_5:   {loady, inity, loadx, flagc, initx, loadc, initc, loadr, initr, selx, sely, plot} <= {9'b000100000,5'b00100,5'b00100,1'b1};  
		`OCT_6:   {loady, inity, loadx, flagc, initx, loadc, initc, loadr, initr, selx, sely, plot} <= {9'b000100000,5'b01000,5'b01000,1'b1};  
		`OCT_7:   {loady, inity, loadx, flagc, initx, loadc, initc, loadr, initr, selx, sely, plot} <= {9'b000100000,5'b00001,5'b00100,1'b1};  
		`OCT_8:   {loady, inity, loadx, flagc, initx, loadc, initc, loadr, initr, selx, sely, plot} <= {9'b000100000,5'b00010,5'b01000,1'b1};  
		`UPDATE:  {loady, inity, loadx, flagc, initx, loadc, initc, loadr, initr, selx, sely, plot} <= {9'b101101000,5'b10000,5'b10000,1'b0};  //loadr = 1 
		`DONE:    {loady, inity, loadx, flagc, initx, loadc, initc, loadr, initr, selx, sely, plot} <= {9'b000100000,5'b10000,5'b10000,1'b0};  
		default:  {loady, inity, loadx, flagc, initx, loadc, initc, loadr, initr, selx, sely, plot} <= {9'b000100000,5'b10000,5'b10000,1'b0};
	endcase
end

always_ff @(posedge clk or posedge reset) begin
	if (reset == 1)
		state <= `RESET;
	else
	case(state)
		`RESET:   state <= `CNT_X;
		`CNT_Y:   state <= `CNT_X;
		`CNT_X:   
			if (xdone == 0) state <= `CNT_X;
			else if (ydone ==0) state <= `CNT_Y;
			else state <= `INITR;
		`INITR:   state <= `INITC; 	
		`INITC:   state	<= `OCT_1;					  
		`OCT_1:   state <= `OCT_2;
		`OCT_2:   state <= `OCT_3;
		`OCT_3:   state <= `OCT_4;
		`OCT_4:   state <= `OCT_5;
		`OCT_5:   state <= `OCT_6;
		`OCT_6:   state <= `OCT_7;
		`OCT_7:   state <= `OCT_8;
		`OCT_8:   state <= `UPDATE;
		`UPDATE:
			if (!cdone) state <= `OCT_1;
			else if(!rdone) state <= `INITC;
			else state <= `DONE;
		default: state <= `DONE;
	endcase
end

endmodule		





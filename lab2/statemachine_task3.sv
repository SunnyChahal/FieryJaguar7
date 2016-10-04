module statemachine (clk, initx, inity, loadx, loady, xdone, ydone, flagc, plot);
input xdone, ydone, cdone, clk;
input [6:0] yp;
input [7:0] xp;

output reg initx, inity, loadx, loady, flagc, plot;
output [4:0] selx, sely;

//define states
`define CLR_SCR 0
`define OCT_1 	1
`define OCT_2 	2
`define OCT_3 	3
`define OCT_4 	4
`define OCT_5 	5
`define OCT_6 	6
`define OCT_7 	7
`define OCT_8 	8	
`define Done 	9

reg [17:0] state;
always_ff@(posedge clk or posedge cdone)
		case(state)
		begin
		CLR_SCR: {loady, inity, loadx, flagc, initx, loadc, initc, selx, sely, plot} <= {7`b1111111,5`b10000,5`b10000,1`b1};
		OCT_1:   {loady, inity, loadx, flagc, initx, loadc, initc, selx, sely, plot} <= {7`b1011001,5`b00001,5`b00001,1`b1};
		OCT_2:   {loady, inity, loadx, flagc, initx, loadc, initc, selx, sely, plot} <= {7`b1011001,5`b00010,5`b00010,1`b1};
		OCT_3:   {loady, inity, loadx, flagc, initx, loadc, initc, selx, sely, plot} <= {7`b1011001,5`b00100,5`b00001,1`b1};  //it's written oct 4 here in the lab handout
		OCT_4:   {loady, inity, loadx, flagc, initx, loadc, initc, selx, sely, plot} <= {7`b1011001,5`b01000,5`b00010,1`b1};
		OCT_5:   {loady, inity, loadx, flagc, initx, loadc, initc, selx, sely, plot} <= {7`b1011001,5`b00100,5`b00100,1`b1};
		OCT_6:   {loady, inity, loadx, flagc, initx, loadc, initc, selx, sely, plot} <= {7`b1011001,5`b01000,5`b01000,1`b1};
		OCT_7:   {loady, inity, loadx, flagc, initx, loadc, initc, selx, sely, plot} <= {7`b1011001,5`b00001,5`b00100,1`b1};
		OCT_8:   {loady, inity, loadx, flagc, initx, loadc, initc, selx, sely, plot} <= {7`b1011001,5`b00010,5`b01000,1`b1};
		Done:    {loady, inity, loadx, flagc, initx, loadc, initc, selx, sely, plot} <= {7`b0000000,5`b00000,5`b00000,1`b0};
		endcase

always_comb
		case(state)
		`CLR_SCR: state <= `OCT_1;
		`OCT_2:   state <= `OCT_3;
		`OCT_3:   state <= `OCT_4;
		`OCT_4:   state <= `OCT_5;
		`OCT_5:   state <= `OCT_6;
		`OCT_6:   state <= `OCT_7;
		`OCT_7:   state <= `OCT_8;
		`OCT_8:   state <= `Done;
		default: state <= 17`b00000000000000000;
		endcase 
endmodule		





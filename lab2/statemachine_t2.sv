module statemachine (clk, resetb, xdone, ydone, initx, inity, loadx, loady, plot, led);

input xdone, ydone, resetb, clk;
output reg initx, inity, loadx, loady, plot;
output [2:0] led;

assign led = state;

reg [2:0] state;

`define INIT 3'b000
`define XCNT 3'b001
`define YCNT 3'b010
`define DONE 3'b011

//outputs
always_comb begin
	case (state)
		`INIT: {initx,inity,loady,loadx,plot} <=   5'b11110; //init everything
		`XCNT: {initx,inity,loady,loadx,plot} <=   5'b10110; 
		`YCNT: {initx,inity,loady,loadx,plot} <=   5'b00011; //plot on y tic
		`DONE: {initx,inity,loady,loadx,plot} <=   5'b00010; //do nothing
		default: {initx,inity,loady,loadx,plot} <= 5'b00010; //do nothing
	endcase
end

//states
always_ff @(posedge clk, negedge resetb) begin
	if (resetb == 0) state <= `INIT;
	case (state)
		`INIT: state <= `YCNT;
		`XCNT: state <= `YCNT;
		`YCNT: if (ydone) state <= `YCNT;
			   else if (!xdone) state <= `XCNT;
			   else state <= `DONE;
		default: state <= `DONE;
	endcase
end

endmodule
		
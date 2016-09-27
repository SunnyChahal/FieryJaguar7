module statemachine (clk, resetb, xdone, ydone, initx, inity, loadx, loady, colour, plot);

input xdone, ydone, resetb, clk;
output reg initx, inity, loadx, loady, plot;
output reg [2:0] colour;

reg [2:0] state;

`define INIT 3'd0
`define YCNT 3'd1
`define XCNT 3'd2
`define DONE 3'd3

//outputs
always_comb begin
	case (state)
		`INIT: {initx,inity,loady,loadx,plot} <=   5'b11110; //init everything
		`YCNT: {initx,inity,loady,loadx,plot} <=   5'b10110;
		`XCNT: {initx,inity,loady,loadx,plot} <=   5'b00011; //plot on x tic
		`DONE: {initx,inity,loady,loadx,plot} <=   5'b00010; //do nothing
		default: {initx,inity,loady,loadx,plot} <= 5'b00010; //do nothing
	endcase
end

//states
always_ff @(posedge clk, posedge resetb) begin
	if (resetb) state <= `INIT;
	case (state)
		`INIT: state <= `XCNT;
		`YCNT: state <= `XCNT;
		`XCNT: if (!xdone) state <= `XCNT;
			   else if (!ydone) state <= `YCNT;
			   else state <= `DONE;
		default: state <= `DONE;
	endcase
end

endmodule
		
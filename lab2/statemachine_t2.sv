module statemachine (clk, resetb, xdone, ydone, initx, inity, loadx, loady, plot);

input xdone, ydone, resetb, clk;
output reg initx, inity, loadx, loady, plot;


reg [2:0] state;

`define INIT 3'd0
`define YCNT 3'd1
`define XCNT 3'd2
`define DONE 3'd3

//outputs
always_comb begin
	case (state)
		`INIT: {inity,initx,loadx,loady,plot} <=   5'b11110; //init everything
		`XCNT: {inity,initx,loadx,loady,plot} <=   5'b10110; 
		`YCNT: {inity,initx,loadx,loady,plot} <=   5'b00011; //plot on y tic
		`DONE: {inity,initx,loadx,loady,plot} <=   5'b00010; //do nothing
		default: {inity,initx,loadx,loady,plot} <= 5'b00010; //do nothing
	endcase
end

//states
always_ff @(posedge clk, posedge resetb) begin
	if (resetb) state <= `INIT;
	case (state)
		`INIT: state <= `YCNT;
		`XCNT: state <= `YCNT;
		`YCNT: if (!ydone) state <= `YCNT;
			   else if (!xdone) state <= `XCNT;
			   else state <= `DONE;
		default: state <= `DONE;
	endcase
end

endmodule
		
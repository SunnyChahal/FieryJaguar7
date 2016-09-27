module datapath (clk, initx, inity, loadx, loady, xdone, ydone, xp, yp);

input initx, inity, loadx, loady, clk;
output xdone, ydone;
output reg [5:0] yp;
output reg [6:0] xp;

always_ff @(posedge clk) begin
	if (loady)
		if (inity)
			yp = 0;
		else
			yp ++;
	if (loadx)
		if (initx)
			xp = 0;
		else
			yp ++;
	ydone <= 0;
	xdone <= 0;
	if (yp == 119)
		ydone <= 1;
	if (xp == 159)
		xdone <= 1;
end

endmodule
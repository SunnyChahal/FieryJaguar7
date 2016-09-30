module datapath_task2 (clk, initx, inity, loadx, loady, xp, yp, xdone, ydone);
input clk, initx, inity, loadx, loady;
output reg [6:0] yp;
output reg [7:0] xp;
output reg xdone, ydone;
//output [2:0] colour;
always_ff @(posedge(clk))
begin
	if (loady ==1)
		if (inity == 1)
			yp = 0;
		else
			yp++;
	if (loadx == 1)
		if (initx == 1)
			xp = 0;
		else
			xp++;
	ydone <= 0;
	xdone <= 0;
	if (yp == 119)
		ydone <= 1;
	if (xp == 159)
		xdone <= 1;
end
//assign colour = xp % 8; 
endmodule		
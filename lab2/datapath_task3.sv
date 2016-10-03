module datapath (clk, flagc, initx, inity, loadx, loady, xp, yp, xdone, ydone, cdone);
input [4:0] sel;
input clk, initx, inity, loadx, loady, flagc;
output reg [6:0] yp;
output reg [7:0] xp;
output reg xdone, ydone, cdone;

reg [6:0] y;
reg [7:0] x;
reg signed [8:0] crit;
reg [6:0] center_y = 7'd40;
reg [7:0] center_x = 8'd80;
reg [7:0] radius = 8'd40;

//output [2:0] colour;
always_ff @(posedge(clk))
begin
	//y and y-offset register
	if (loady)
		if (inity)
			y = 0;
		else
			y++;
	//x and x-offset register
	if (loadx)
		if (flagc)
			if (initx)
				x = radius;
			else
				x = crit > 0 ? x - 1 : x;
		else
			if (initx)
				x = 0;
			else
				x++;
	//crit register	
	if (loadc)
		if (initc)
			crit = 1 - radius;
		else 
			crit = (crit > 0) ? (crit + 2 * (y - x) + 1) :
								(crit + 2 * y + 1);
	//done signals
	ydone <= 0;
	xdone <= 0;
	cdone <= 0;
	if (y == 119)
		ydone <= 1;
	if (x == 159)
		xdone <= 1;
	if (y <= x)
		cdone <= 1;
end

//mux to select the VGA input for x
always_comb
	case (selx)
		5'b00001: 
			xp = center_x + x;
		5'b00010:
			xp = center_x + y; 
		5'b00100: 
			xp = center_x - x;
		5'b01000: 
			xp = center_x - y;
		5'b10000:
			xp = x; //default needed?
	endcase
end
//mux to select the VGA input for y
always_comb
	case (sely)
		5'b00001: 
			yp = center_y + y;
		5'b00010:
			yp = center_y + x; 
		5'b00100: 
			yp = center_y - y;
		5'b01000: 
			yp = center_y - x;
		5'b10000:
			yp = y; //default needed?
	endcase
end

//assign colour = xp % 8; 
endmodule		
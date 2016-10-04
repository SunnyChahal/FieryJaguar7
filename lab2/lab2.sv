module lab2 (CLOCK_50, 
		 KEY,             
       VGA_R, VGA_G, VGA_B, 
       VGA_HS,             
       VGA_VS,             
       VGA_BLANK,           
       VGA_SYNC,            
       VGA_CLK);
  
input CLOCK_50;
input [3:0] KEY;
output [9:0] VGA_R, VGA_G, VGA_B; 
output VGA_HS;             
output VGA_VS;          
output VGA_BLANK;           
output VGA_SYNC;            
output VGA_CLK;

// Some constants that might be useful for you

parameter SCREEN_WIDTH = 160;
parameter SCREEN_HEIGHT = 120;

parameter BLACK = 3'b000;
parameter BLUE = 3'b001;
parameter GREEN = 3'b010;
parameter YELLOW = 3'b110;
parameter RED = 3'b100;
parameter WHITE = 3'b111;

  // To VGA adapter
  
wire resetn;
wire [7:0] x;
wire [6:0] y;
reg [2:0] colour; //used to be a reg
wire plot; // used to be a reg
   
wire loadx, loady, loadc, loadr, initx, inity, initc, initr, xdone, ydone, cdone, rdone, flagc;
wire [4:0] selx, sely;
wire [2:0] ring;
// instantiate VGA adapter 
	
vga_adapter #( .RESOLUTION("160x120"))
    vga_u0 (.resetn(KEY[3]),
	         .clock(CLOCK_50),
			   .colour(colour), //3'b101
			   .x(x), //8'b00111111
			   .y(y), //7'b0011111 
			   .plot(plot), //1'b1
			   .VGA_R(VGA_R),
			   .VGA_G(VGA_G),
			   .VGA_B(VGA_B),	
			   .VGA_HS(VGA_HS),
			   .VGA_VS(VGA_VS),
			   .VGA_BLANK(VGA_BLANK),
			   .VGA_SYNC(VGA_SYNC),
			   .VGA_CLK(VGA_CLK));  

datapath dp (.clk(CLOCK_50),
			 .flagc(flagc),
			 .initx(initx), 
			 .inity(inity),
			 .initc(initc),
			 .initr(initr),
			 .loadx(loadx),
			 .loady(loady),
			 .loadc(loadc),
			 .loadr(loadr),
			 .selx(selx),
			 .sely(sely),
			 .xp(x),
			 .yp(y),
			 .xdone(xdone),
			 .ydone(ydone),
			 .cdone(cdone),
			 .rdone(rdone),
			 .ring(ring));
				
statemachine sm (.clk(CLOCK_50),
				 .reset(!KEY[3]),
				 .initx(initx),
				 .inity(inity),
				 .initc(initc),
				 .initr(initr),
				 .loadx(loadx),
				 .loady(loady),
				 .loadc(loadc),
				 .loadr(loadr),
				 .xdone(xdone),
				 .ydone(ydone),
				 .cdone(cdone),
				 .rdone(rdone),
				 .flagc(flagc),
				 .plot(plot),
				 .selx(selx),
				 .sely(sely));

always_comb begin
	case(ring)
		3'd1:	colour = BLUE;
		3'd2:	colour = YELLOW;
		3'd3:	colour = WHITE;
		3'd4:	colour = GREEN;
		3'd5:	colour = RED;
		default:colour = BLACK;	endcase
end
				 
endmodule
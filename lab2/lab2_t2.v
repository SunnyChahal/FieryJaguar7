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
wire [2:0] colour;	//******USED TO BE REG*******
wire plot;				//******USED TO BE REG*******
   
// instantiate VGA adapter 
	
vga_adapter #( .RESOLUTION("160x120"))
    vga_u0 (.resetn(KEY[3]),
	         .clock(CLOCK_50),
			   .colour(colour),
			   .x(x),
			   .y(y),
			   .plot(plot),
			   .VGA_R(VGA_R),
			   .VGA_G(VGA_G),
			   .VGA_B(VGA_B),	
			   .VGA_HS(VGA_HS),
			   .VGA_VS(VGA_VS),
			   .VGA_BLANK(VGA_BLANK),
			   .VGA_SYNC(VGA_SYNC),
			   .VGA_CLK(VGA_CLK));


// Your code to fill the screen goes here. 
wire initx,inity,loadx,loady,xdone,ydone;

datapath dp     (.clk(CLOCK_50),
				 .initx(initx), 
				 .inity(inity), 
				 .loadx(loadx), 
				 .loady(loady), 
				 .xdone(xdone), 
				 .ydone(ydone),
				 .xp(x),
				 .yp(y));
				 
statemachine sm (.clk(CLOCK_50), 
				 .resetb(!KEY[3]),
				 .xdone(xdone), 
				 .ydone(ydone), 
				 .initx(initx), 
				 .inity(inity), 
				 .loadx(loadx), 
				 .loady(loady),
				 .colour(colour),
				 .plot(plot));

endmodule

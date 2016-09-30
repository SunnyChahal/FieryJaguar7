module task2 (CLOCK_50, 
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
   
wire loadx, loady, initx, inity, xdone, ydone;   
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


// Your code to fill the screen goes here.  
datapath_task2 dp (.clk(CLOCK_50),
				.initx(initx), 
				.inity(inity), 
				.loadx(loadx),
				.loady(loady),
				.xp(x),
				.yp(y),
				.xdone(xdone),
				.ydone(ydone)
				);
				
statemachine_task2 sm (.clk(CLOCK_50),
					.reset(!KEY[3]),
					.initx(initx),
					.inity(inity),
					.loadx(loadx),
					.loady(loady),
					.xdone(xdone),
					.ydone(ydone),
					.plot(plot));
always_comb
colour = x%8;
					

endmodule



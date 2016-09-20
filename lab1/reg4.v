module reg4 (in, load, rst, clk, out);
	input [3:0] in;
	input load, rst, clk;
	output [3:0] out;
	reg [3:0] out;
	
	//always block for a 4-bit wide register with asynchronous reset
	always @(posedge clk or negedge rst)
	 if (rst == 0) begin
	    out = 4'b0000;
	end else begin
	      if ( load == 1) 
	         out <= in;
		  else
		     out <= out;
	end
endmodule 
	
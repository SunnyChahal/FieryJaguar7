module card7seg (SW, HEX0);
	input [3:0] SW;
	output reg [6:0] HEX0;
	
	always @(*) begin
		case(SW)
			4'b0001: HEX0 = 7'b0001000 ;
			4'b0010: HEX0 = 7'b0010010 ;
			4'b0011: HEX0 = 7'b0000110 ;
			4'b0100: HEX0 = 7'b1001100 ;
			4'b0101: HEX0 = 7'b0100100 ;
			4'b0110: HEX0 = 7'b0100000 ;
			4'b0111: HEX0 = 7'b0001111 ;
			4'b1000: HEX0 = 7'b0000000 ;
			4'b1001: HEX0 = 7'b0000100 ;
			4'b1010: HEX0 = 7'b0000001 ;
			4'b1011: HEX0 = 7'b1000011 ;
			4'b1100: HEX0 = 7'b0001100 ;
			4'b1101: HEX0 = 7'b1001000 ;
			default: HEX0 = 7'b1111111 ;
		endcase
	end
	
endmodule

new module 3 5
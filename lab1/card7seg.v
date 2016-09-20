module card7seg (SW, HEX0);
	input [3:0] SW;
	output reg [6:0] HEX0;
	
	always @(*) begin
		case(SW)
			4'b0001: HEX0 = 7'b0001000 ;	//ace
			4'b0010: HEX0 = 7'b0100100 ;	//2
			4'b0011: HEX0 = 7'b0110000 ;	//3
			4'b0100: HEX0 = 7'b0011001 ;	//4
			4'b0101: HEX0 = 7'b0010010 ;	//5
			4'b0110: HEX0 = 7'b0000010 ;	//6
			4'b0111: HEX0 = 7'b1111000 ;	//7
			4'b1000: HEX0 = 7'b0000000 ;	//8
			4'b1001: HEX0 = 7'b0010000 ;	//9
			4'b1010: HEX0 = 7'b1000000 ;	//0
			4'b1011: HEX0 = 7'b1100001 ;	//jack
			4'b1100: HEX0 = 7'b0011000 ;	//queen
			4'b1101: HEX0 = 7'b0001001 ;	//king
			default: HEX0 = 7'b1111111 ;	//blank
		endcase
	end
	
endmodule
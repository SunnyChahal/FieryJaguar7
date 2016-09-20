
module scorehand (card1, card2, card3, total);

input [3:0] card1, card2, card3;
output [3:0] total;
wire [3:0] card1value, card2value, card3value;

// The code describing scorehand will go here.  Remember this is a combinational
// block.  The function is described in the handout.  Be sure to read the section
// on representing numbers in Slide Set 2.

assign card1value = (card1 > 4'b1001) ? 4'b0000 : card1;
assign card2value = (card2 > 4'b1001) ? 4'b0000 : card2;
assign card3value = (card3 > 4'b1001) ? 4'b0000 : card3;

assign total = (card1value + card2value + card3value) % 10;

endmodule

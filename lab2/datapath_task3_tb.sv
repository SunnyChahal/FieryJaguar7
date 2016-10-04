module dptest;

reg [4:0] selx, sely;
reg clk, initx, inity, initc, loadx, loady, loadc, flagc;
wire [6:0] yp;
wire [7:0] xp;
wire xdone, ydone, cdone;

datapath DUT (.clk(clk),
			 .flagc(flagc),
			 .initx(initx), 
			 .inity(inity),
			 .initc(initc),
			 .loadx(loadx),
			 .loady(loady),
			 .loadc(loadc),
			 .selx(selx),
			 .sely(sely),
			 .xp(xp),
			 .yp(yp),
			 .xdone(xdone),
			 .ydone(ydone),
			 .cdone(cdone));

 initial begin
    clk = 0; #5;
    forever begin
      clk = 1; #5;
      clk = 0; #5;
    end
  end

  initial begin
    repeat(50)
	//init
	flagc = 1;
	initx = 1;
	inity = 1;
	initc = 1;
	loadx = 1;
	loady = 1;
	loadc = 1;
	selx = 0;
	sely = 0;
	#10;
	//q1
	initx = 0;
	inity = 0;
	initc = 0;
	loadx = 0;
	loady = 0;
	loadc = 0;
	selx = 5'b00001;
	sely = 5'b00001;
	#10;
	//q2
	selx = 5'b00010;
	sely = 5'b00010;
	#10;
	//q3
	selx = 5'b00010;
	sely = 5'b00010;
	#10;
	//q4...
	selx = 5'b00010;
	sely = 5'b00010;
	#10;

	selx = 5'b00010;
	sely = 5'b00010;
	#10;

	selx = 5'b00010;
	sely = 5'b00010;
	#10;

	selx = 5'b00010;
	sely = 5'b00010;
	#10;

	selx = 5'b00010;
	sely = 5'b00010;
	#10;


	$stop;
  end
endmodule

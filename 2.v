module four_comparator();
	reg[3:0] a, b;
	wire[2:0] g;
	

	not #1 (not_b3, b[3]);
	and #1 (and3, not_b3, a[3]);

	xnor #1 (xnor3, b[3], a[3]);

	not #1 (not_b2, b[2]);
	and #1 (and2, xnor3, not_b2, a[2]);

	xnor #1 (xnor2, a[2], b[2]);

	not #1 (not_b1, b[1]);
	and #1 (and1, xnor3, xnor2, not_b1, a[1]);

	xnor #1 (xnor1, a[1], b[1]);
	
	not #1 (not_b0, b[0]);
	and #1 (and0, xnor3, xnor2, xnor1, not_b0, a[0]);

	xnor #1 (xnor0, a[0], b[0]);

	or #1 (g[0], and3, and2, and1, and0);

	and #1 (g[1], xnor3, xnor2, xnor1, xnor0);

	nor(g[2], g[1], g[0]);

	initial begin
                
		$monitor($time,
                         "a=%b, b=%b, a > b --> %b, a = b --> %b, a < b --> %b",
                          a, b, g[0], g[1], g[2]);
		
		a=2; b=4;
                #100 $display ("\n", $time, "\n");
                
		#900 a=4; b=10;
                #100 $display ("\n", $time, "\n");

		#900 a=0; b=0;
                #100 $display ("\n", $time, "\n");

		#900 a=7; b=5;
                #100 $display ("\n", $time, "\n");

		#900 a=14; b=15;
                #100 $display ("\n", $time, "\n");

		#900 a=12; b=3;
                #100 $display ("\n", $time, "\n");

		#900 a=15; b=15;
                #100 $display ("\n", $time, "\n");


        end


endmodule

module sixteen_adder();
	reg[15:0] a, b;
	wire[15:0] s;
	wire c_out;

	fulladder FA0(c1, s[0], a[0], b[0], 1'b0);
	fulladder FA1(c2, s[1], a[1], b[1], c1);
	fulladder FA2(c3, s[2], a[2], b[2], c2);
	fulladder FA3(c4, s[3], a[3], b[3], c3);
	fulladder FA4(c5, s[4], a[4], b[4], c4);
	fulladder FA5(c6, s[5], a[5], b[5], c5);
	fulladder FA6(c7, s[6], a[6], b[6], c6);
	fulladder FA7(c8, s[7], a[7], b[7], c7);
	fulladder FA8(c9, s[8], a[8], b[8], c8);
	fulladder FA9(c10, s[9], a[9], b[9], c9);
	fulladder FA10(c11, s[10], a[10], b[10], c10);
	fulladder FA11(c12, s[11], a[11], b[11], c11);
	fulladder FA12(c13, s[12], a[12], b[12], c12);
	fulladder FA13(c14, s[13], a[13], b[13], c13);
	fulladder FA14(c15, s[14], a[14], b[14], c14);
	fulladder FA15(c_out, s[15], a[15], b[15], c15);

	initial begin

                $monitor($time, 
                         "a=%b, b=%b, s=%b, cout=%b, c1=%b, c2=%b, c3=%b, c4=%b, c5=%b, c6=%b, c7=%b, c8=%b, c9=%b, c10=%b, c11=%b, c12=%b, c13=%b, c14=%b, c15=%b",
                          a, b, s, c_out, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15);

                a=-10; b=100;
                #100 $display ("\n", $time, "\n");

                #900 a=63; b=-(-127);
                #100 $display ("\n", $time, "\n");

                #900 a=15; b=95;
                #100 $display ("\n", $time, "\n");

                #900 a=-32; b=79;
                #100 $display ("\n", $time, "\n");

                #900 a=-59; b=-16;
                #100 $display ("\n", $time, "\n");

		#900 a=1000; b=2001;
                #100 $display ("\n", $time, "\n");
		
		#900 a=-3210; b=15;
                #100 $display ("\n", $time, "\n");
		
        end

endmodule 

module fulladder(cout, si, ai, bi, cin);
	input ai, bi, cin;
	output cout, si;

	xor #1 (si1, ai, bi);
	xor #1 (si, si1, cin);

	and #1 (ci1, ai, bi);
	and #1 (ci2, cin, si1);
	or #1 (cout, ci1, ci2);
endmodule

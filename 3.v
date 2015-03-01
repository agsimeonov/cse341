module sixteen_cla();
	reg[15:0] a, b;
	wire[3:0] cout, p, g;
	wire[15:0] s;

	four_cla F0(cout[0], s[3:0], p[0], g[0], a[3:0], b[3:0], 1'b0);
	and #1 (t0, 1'b0, p[0]);
	or #1 (c1, g[0], t0);

	four_cla F1(cout[1], s[7:4], p[1], g[1], a[7:4], b[7:4], c1);
	and #1 (t1, g[0], p[1]);
	and #1 (t2, 1'b0, p[0], p[1]);
	or #1 (c2, g[1], t1, t2);

	four_cla F2(cout[2], s[11:8], p[2], g[2], a[11:8], b[11:8], c2);
	and #1 (t3, g[1], p[2]);
	and #1 (t4, g[0], p[1], p[2]);
	and #1 (t5, 1'b0, p[0], p[1], p[2]);
	or #1 (c3, g[2], t3, t4, t5);

	four_cla F3(cout[3], s[15:12], p[3], g[3], a[15:12], b[15:12], c3);
	and #1 (t6, g[2], p[3]);
	and #1 (t7, g[1], p[2], p[3]);
	and #1 (t8, g[0], p[1], p[2], p[3]);
	and #1 (t9, 1'b0, p[0], p[1], p[2], p[3]);
	or #1 (c4, g[3], t6, t7, t8, t9);
	
	initial begin

                $monitor($time,
                         "a=%b, b=%b, s=%b",
                          a, b, s);

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

module four_cla(cout, s, pi, gi, a, b, cin);
	input cin;
	input[3:0] a, b;
	output cout, pi, gi;
	output[3:0] s;
	
	xor #1 (p0, a[0], b[0]);
	and #1 (g0, a[0], b[0]);

	xor #1 (p1, a[1], b[1]);
	and #1 (g1, a[1], b[1]);

	xor #1 (p2, a[2], b[2]);
	and #1 (g2, a[2], b[2]);

	xor #1 (p3, a[3], b[3]);
	and #1 (g3, a[3], b[3]);

	and #1 (and0, p0, cin);
	or #1 (c1, g0, and0);

	and #1 (and1, p1, g0);
	and #1 (and2, p1, p0, cin);
	or #1 (c2, g1, and2, and1);

	and #1 (and3, p2, g1);
	and #1 (and4, p2, p1, g0);
	and #1 (and5, p2, p1, p0, cin);
	or #1 (c3, g2, and5, and4, and3);

	and #1 (and6, p3, g2);
	and #1 (and7, p3, p2, g1);
	and #1 (and8, p3, p2, p1, g0);
	and #1 (and9, p3, p2, p1, p0, cin);
	or #1 (cout, g3, and9, and8, and7, and6);

	xor #1 (s[0], p0, cin);
	xor #1 (s[1], p1, c1);
	xor #1 (s[2], p2, c2);
	xor #1 (s[3], p3, c3);

	and #1 (pi, p3, p2, p1, p0);
	and #1 (t0, g0, p1, p2, p3);
	and #1 (t1, g1, p2, p3);
	and #1 (t2, g2, p3);
	or #1 (gi, g3, t2, t1, t0);	

endmodule

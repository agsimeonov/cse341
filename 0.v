/* A 4 bit ripple carry adder is implemented using structural Verilog HDL */
/* code. a and b are 4 bit inputs and s and c_out are outputs. s is a 4 bit */
/* sum output and c_out is a 1 bit carry output. */


module adder ();

        reg[3:0] a, b;  /* declare data types of inputs a and b */
        wire[3:0] s;    /* declare data type of output s */
        wire c_out;     /* declare data type of output c_out */

/* Instantiate the 1 bit full adder module defined below to form the */
/* 4 blocks of ripple carry adder. The input carry is assumed to be zero. */

        fulladder FA0(c1, s[0], a[0], b[0], 1'b0);
        fulladder FA1(c2, s[1], a[1], b[1], c1);
        fulladder FA2(c3, s[2], a[2], b[2], c2);
        fulladder FA3(c_out, s[3], a[3], b[3], c3);


/* Testbench to give the inputs and check the output values. The time */
/* variable, inputs and outputs are displayed. */

        initial begin                   /* Beginning of initial block */

/* The monitor statement monitors the value of variables at all instants */
/*  and displays the result whenever there is any change. */

                $monitor ($time, "a=%b, b=%b, s=%b, cout=%b, c1=%b, c2=%b, c3=%b ", a, b, s, c_out, c1, c2, c3);
                a=0; b=0;               /* give specific input values */
                #100 $display ($time);  /* display the time variable */

                #900 a=15; b=15;
                #100 $display ($time);

                 a=0; b=15;
                #100 $display ($time);

                #900 a=15; b=1;
                #100 $display ($time);

                #900 a=5; b=7;
                #100 $display ($time);

        end                                     /* end of the initial block */

endmodule                                       /* end of the adder module */



/* 1 Bit Full adder module */

module fulladder (cout, si, ai, bi, cin);

        parameter delay2=1, delay3=2, delay4=3;
                                        /* variables defined as parameter */

        input ai, bi, cin;                      /* declaring inputs */
        output cout, si;                        /* declaring outputs */
        and #2 (si1, ~ai, ~bi, cin),       /* si1=~ai.~bi.cin */
                    (si2, ~ai, bi, ~cin),       /* si2=~ai.bi.~cin */
                    (si3, ai, ~bi, ~cin),       /* si3=ai.~bi.~cin */
                    (si4, ai, bi, cin);         /* si4=ai.bi.cin */
        or #2 (si, si1, si2, si3, si4);    /* si=si1+si2+si3+si4 */
        and #1 (ci1, ai, bi),              /* ci1=ai.bi */
                    (ci2, ai, cin),             /* ci2=ai.cin */
                    (ci3, bi, cin);             /* ci3=bi.cin */
        or #1 (cout, ci1, ci2, ci3);       /* cout=ci1+ci2+ci3 */


endmodule


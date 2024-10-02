`timescale 1ns/1ns
module cmosnot_tb;
    reg a;
    wire f;
    cmosnot cmos_not (f,a);
    initial begin
       $dumpfile("test.vcd");
       $dumpvars(0, cmosnot_tb);
             a=0;
        #20   a=1;
        #20  a=0;
        #40 $finish;
    end
    initial begin
        $monitor("%2d:\ta = %b\tf = %b", $time,a,f);
    end
endmodule    
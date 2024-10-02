`timescale 1ns/1ns

module graycounter_tb;
 reg clk;
 reg load_en;
 reg reset;
 reg [3:0] d;
 wire [3:0] q;

graycounter circ(clk, load_en, reset, d, q);

always begin
    clk = ~clk;
    #10;
end

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, graycounter_tb);

    clk <=0;
    reset <= 1;
    load_en <= 0;

    #20;
    reset <= 0;
    #20;
    load_en <= 1;
    d <= 4'b0011;
    #20;
    
    load_en <= 0;
    #20;
    
    #20;
    #20;
    #20;
    reset <= 1;
    #20;
    #20;
    $finish;
end

initial begin
    $monitor("time = %0t, clk = %b, load_en = %b, reset = %b, d = %b, q = %b",$time, clk, load_en, reset, d, q);
end
endmodule
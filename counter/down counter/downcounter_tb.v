`timescale 1ns/1ns

module downcounter_tb;
 reg clk;
 reg load_en;
 reg reset;
 reg [3:0] d;
 wire [3:0] q;

downcounter circ1(.clk(clk),.reset(reset),.load_en(load_en),.d(d),.q(q));

always begin
    clk = ~clk;
    #10;
end

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0,downcounter_tb);
    
    clk <= 0;
    load_en <= 0;
    reset <= 1;
    

    #20;
    reset <= 0;
    #20;
    load_en <= 1;
    d <= 4'b1011;
    #20;
    load_en <= 0;
    #20;
    #20;
    #20;
    reset <= 1;
    #20;
    #20;
    #20;
    $finish;
end

initial begin 
    $monitor("time = %0t, clk = %b, reset = %b, load_en = %b, d = %b, q = %b",$time,clk,reset,load_en,d,q);
end
endmodule


 
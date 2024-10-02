`timescale 1ns/1ns
 
module upcounter_tb;
  parameter data_width = 4;
  reg clk;
  reg reset;
  reg load_en;
  reg [data_width-1:0] d;
  wire [data_width-1:0] q;

upcounter circ1(clk,reset,load_en,d,q);

always begin
    clk = ~clk;
    #10;
end

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0,upcounter_tb);
 
 clk <= 0;
 reset <= 1;
 load_en <= 0;
 d <= 4'b0000;

#20;
reset <= 0;
#20;
load_en <= 1;
d <= 4'b0010;
#20;
load_en <= 0;
#20;
#20;
#20;
reset <= 1;
#20;
#20;
$finish;
end

initial begin
    $monitor("time = %0t,clk = %b, reset = %b, load_en =  %b, d = %b, q = %b",$time,clk,reset,load_en,d,q);
end
endmodule


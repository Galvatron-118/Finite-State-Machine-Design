`timescale 1ns/1ns
module DPRAM_tb;
 reg clk;
 reg we;
 reg [9:0] wr_add, rd_add;
 reg [7:0] d;
 wire [7:0]q;

DPRAM circ1(clk, we, wr_add, rd_add, d, q);

always 
 begin
    clk=~clk;
    #10;
 end

initial begin
 $dumpfile("test.vcd");
 $dumpvars(0, DPRAM_tb);
    
    clk<= 0;
    we <= 0;
    //rd_add <= 2'b00;
    //wr_add <= 2'b00;
    //d <= 8'b00000000;

    #40;
    rd_add <= 10'b0000000000;
    #40;
    rd_add <= 10'b0000000010;
    #40;
    we <= 1;
    wr_add <= 10'b0000000010;
    d <= 8'b11010011;
    rd_add <= 10'b0000000011;
    #40;
    rd_add <= 10'b0000000010;
    #40;
    $finish;
end

initial begin 
    $monitor("clk = %b, we = %b, wr_add = %10b, rd_add = %10b, d = %8b, q = %8b", clk, we, wr_add, rd_add, d, q);
end

endmodule
    

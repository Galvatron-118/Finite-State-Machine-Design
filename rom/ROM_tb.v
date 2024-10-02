`timescale 1ns/1ns

module ROM_tb;
 reg clk;
 reg [9:0] addr;
 wire [7:0] data;

ROM circ1(clk, addr, data);

always begin
    clk=~clk;
    #10;
end

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, ROM_tb);

    clk <= 0;
    #40;
    addr <= 10'b0000000000;
    #40;
    addr <= 10'b0000000010;
    #40;
    addr <= 10'b0000000011;
    #40;
    $finish;
end

initial begin
    $monitor("clk = %b, addr = %10b, data = %8b",clk,addr,data);
end

endmodule

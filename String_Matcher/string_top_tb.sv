`timescale 1ns/1ps

module string_top_tb;

reg clk, reset, start;
reg a, b;
wire y_val;

string_top DUT(
    .clk(clk),
    .reset(reset),
    .start(start),
    .a(a),
    .b(b), 
    .y_val(y_val)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, string_top_tb);

    clk <= 0;
    reset <= 0;
    start <= 0;
    a <= 0;
    b <= 0;

    @(negedge clk)
    reset <= 1;

    @(negedge clk)
    reset <= 0;
    start <= 1;
    a <= 1;
    b <= 1;

    repeat(10) @(negedge clk);

    $finish();

end

endmodule
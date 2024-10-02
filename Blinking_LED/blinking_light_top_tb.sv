`timescale 1ns/1ns

module blinking_light_top_tb;

reg clk, reset, start, en;
wire light;

blinking_light_top DUT(
    .clk(clk),
    .reset(reset),
    .start(start),
    .en(en),
    .light(light)
);


initial begin 
    clk = 0;
    forever #5 clk= ~clk;
end

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, blinking_light_top_tb);

    clk <= 0;
    reset <= 0;
    start <= 0;
    en <= 0;

    @(negedge clk);
    reset <= 1;

    @(negedge clk);
    reset <= 0;
    start <= 1;
    en <= 1;

    repeat(50) @(negedge clk);

    $finish();
end

endmodule

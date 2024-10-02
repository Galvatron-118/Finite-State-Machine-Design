`timescale 1ns/1ns
module top_tb;
        reg clk, reset, start;
        reg [3:0] req, send;
        wire [2:0] at_floor;
        wire wash_done;

    top DUT(
        .clk(clk),
        .reset(reset),
        .start(start),
        .req_laundry(req),
        .send(send),
        .at_floor(at_floor),
        .wash_done(wash_done));

    initial begin 
        clk  = 0;
        forever #5 clk = ~clk;
    end


    initial begin
        reset <= 0;
        req <= 4'b0000;
        send <= 4'b0000;
        start <= 0;

        @(negedge clk);
            reset <= 1;
        
        @(negedge clk);
            start <= 1;
            req <= 4'b1100;

        repeat(3)  @(negedge clk);
             send <= 4'b1000;
        
        repeat(6)  @(negedge clk);
             send <= 4'b0001;

        @(negedge clk);
             req <= 4'b1000;
        
        repeat(100) @(negedge clk);
             $finish();
    end
endmodule
             
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
        //clk = 0;
        forever #5 clk = ~clk;  // Toggle clk every 5 time units
    end


    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, top_tb);
        
        clk = 0;
        reset <= 0;
        req <= 4'b0000;
        send <= 4'b0000;
        start <= 0;
        

        #20; reset <= 1;

        #10; req <= 4'b1001;
       
        #10; start <= 1'b1;

        #80; req <= 4'b1000;



        repeat(100) #20;        
             $finish();
    
    end
endmodule
             

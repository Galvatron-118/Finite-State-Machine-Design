`timescale 1ns/1ns
module top_tb;
        
        reg clk, reset, start;
        wire [3:0] at_side;
        wire [3:0] at_state;
        wire R, G ,Y;




        top top1(
                    .clk(clk),
                    .reset(reset),
                    .start(start),
                    .at_side(at_side),
                    .at_state(at_state),
                    .R(R),
                    .Y(Y),
                    .G(G));

            always begin
                clk = ~clk;
                #5;
            end

            initial begin 
                $dumpfile("test.vcd");
                $dumpvars(0, top_tb);

                    clk <= 0;
                    reset <= 0;
                    start <= 0;
                    //side <= 4'b0001;
                    
                    #20; start <= 1;

                    #20; reset <= 1;

//                    #20; side <= 4'bx;

                    repeat(200) #20;

                    $finish();
            end

endmodule
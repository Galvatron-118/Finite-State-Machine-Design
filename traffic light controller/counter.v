module counter(
            input wire clk, reset, clear,
            output reg [6:0] count);
     
                always @(posedge clk or negedge reset) begin
                        if (~reset)
                            count <= 7'b0000000;
                        
                        else 
                            count <= clear ? 7'b0000000 : count + 1'b1;
                end
endmodule
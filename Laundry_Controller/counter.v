module counter (
    input wire clk, reset, clear,
    output reg [5:0] count);
 
        always @(posedge clk or negedge reset) begin
                  if(~reset) begin
                      count <= 6'b000000;
                    end
                  else begin
                      count <= clear ? 6'b000000 :  count + 1'b1;
                    end
        end
endmodule
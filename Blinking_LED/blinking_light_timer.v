module blinking_light_timer(
    input wire clk, reset, clear,
    output reg [3:0] count
);

always @(posedge clk, negedge reset)
begin
    if(reset)
        begin
            count <= 4'b0000;
        end
    else 
        begin
            count <= clear ? 4'b0000 : count + 1'b1;
        end
end

endmodule
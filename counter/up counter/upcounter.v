module upcounter 
 #(
    parameter data_width = 4
  )
  
  (
    input wire clk,
    input wire reset,
    input wire load_en,
    input wire [data_width-1:0] d,
    output reg [data_width-1:0] q 
  );

always @(posedge clk, posedge reset)
 begin
    if(reset)
     q <= 4'b0000;
    else if(load_en)
     q <= d;
    else
     q <= q + 1'b1;
 end
endmodule
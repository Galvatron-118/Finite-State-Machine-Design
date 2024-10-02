module ROM 
 #(
    parameter addr_width = 10,
    parameter data_width = 8
  )

  ( input wire clk,
    input [addr_width-1:0] addr,
    output [data_width-1:0] data
  );

  reg [data_width-1:0] rom [(2**addr_width)-1:0];
  reg [data_width-1:0] data_reg;
  
  initial $readmemb("initialROM.txt", rom);

always @(posedge clk)
 begin
    data_reg <= rom[addr];
 end
assign data = data_reg;

endmodule
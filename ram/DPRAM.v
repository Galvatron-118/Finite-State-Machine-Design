module DPRAM 
 #(
   parameter data_width = 8,
   parameter addr_width = 10
  )

  (
   input wire clk,
   input wire we,
   input wire [(addr_width-1):0] wr_add, rd_add,
   input wire [(data_width-1):0] d,
   output wire [(data_width-1):0] q
  );

  reg [(data_width-1):0] ram [(2**addr_width)-1:0]; // must be written reg [(data_width-1):0] ram [0:(2**addr_width)-1];
  reg [(data_width-1):0] data_reg;

  initial 
    $readmemb("initialRAM.txt", ram);
    
  always @(posedge clk)
  begin
    if (we)  
      ram[wr_add] <= d;
    data_reg <= ram[rd_add];
  end
  assign q = data_reg;
endmodule

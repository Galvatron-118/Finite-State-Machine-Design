module temp_comp(
    input wire [6:0] datapath_in1, datapath_in2, datapath_in3,
    output wire [3:0] datapath_out
);

assign datapath_out[0] = datapath_in1 < datapath_in2 - datapath_in3;
assign datapath_out[1] = datapath_in1 > datapath_in2 + datapath_in3;
assign datapath_out[2] = datapath_in1 > datapath_in2;
assign datapath_out[3] = datapath_in1 < datapath_in2;

endmodule

module blinking_light_datapath(
    input wire [3:0] datapath_in1, datapath_in2,
    output wire datapath_out
);

assign datapath_out = datapath_in1 == datapath_in2 -  1;

endmodule
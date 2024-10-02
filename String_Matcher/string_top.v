module string_top(
    input wire clk, reset, start,
    input wire a, b,
    output wire y_val
);

wire x_val;
wire [3:0] datapath_in1, datapath_in2;
wire datapath_out;

assign x_val = ~(a ^ b);

string_controller controller1(

    .clk(clk), 
    .reset(reset), 
    .start(start),
    .x_val(x_val),
    .y_val(y_val),
    .datapath_in1(datapath_in1), 
    .datapath_in2(datapath_in2),
    .datapath_out(datapath_out) 
);


string_datapath datapath1(
    .datapath_in1(datapath_in1), 
    .datapath_in2(datapath_in2),
    .datapath_out(datapath_out)
);

endmodule
module blinking_light_top(
    input wire clk, reset, start,
    input wire en,
    output wire light
);

wire [3:0] datapath_in1, datapath_in2;
wire datapath_out;
wire [3:0] count;
wire clear;

blinking_light_controller controller1(
    .clk(clk), 
    .reset(reset), 
    .start(start),
    .en(en),
    .light(light), 
    .clear(clear),
    .datapath_in1(datapath_in1), 
    .datapath_in2(datapath_in2),
    .datapath_out(datapath_out),
    .count(count)
);

blinking_light_datapath datapath1(
    .datapath_in1(datapath_in1), 
    .datapath_in2(datapath_in2),
    .datapath_out(datapath_out)
);

blinking_light_timer timer1(
    .clk(clk),
    .reset(reset),
    .clear(clear),
    .count(count)
);

endmodule




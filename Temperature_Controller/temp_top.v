module temp_top(
    input wire clk, reset, start,
    input wire [6:0] troom, tref, dt,
    output wire h, c 
    
);

wire [6:0] datapath_in1, datapath_in2, datapath_in3;
wire [3:0] datapath_out;

temp_controller temp1(

            .clk(clk),
            .reset(reset), 
            .start(start), 
            .troom(troom), 
            .tref(tref), 
            .dt(dt),
            .h(h),
            .c(c),
            .datapath_in1(datapath_in1),
            .datapath_in2(datapath_in2),
            .datapath_in3(datapath_in3),
            .datapath_out(datapath_out)
);

temp_comp comp1(
            .datapath_in1(datapath_in1), 
            .datapath_in2(datapath_in2), 
            .datapath_in3(datapath_in3),
            .datapath_out(datapath_out)
);


endmodule


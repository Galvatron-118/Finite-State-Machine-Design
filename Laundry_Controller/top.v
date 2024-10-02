module top (
    input wire clk, reset, start,
    input wire [3:0]req_laundry, send,

    output wire [2:0] at_floor,
    output wire wash_done);

    wire [5:0] count_2_comp;
    wire comp_2_fsm_10, comp_2_fsm_50,clear;

    
        counter count1 (.clk(clk), 
                            .reset(reset), 
                            .clear(clear), 
                            .count(count_2_comp));
            
        comparator comp1 (.count(count_2_comp),
                              .count_eq10(comp_2_fsm_10),
                              .count_eq50(comp_2_fsm_50));

        laundry_controller_fsm fsm (.clk(clk),
                                    .reset(reset),
                                    .start(start),
                                    .req_laundry(req_laundry),
                                    .send(send),
                                    .count_eq10(comp_2_fsm_10),
                                    .count_eq50(comp_2_fsm_50),
                                    .at_floor(at_floor),
                                    .wash_done(wash_done),
                                    .clear(clear));
endmodule


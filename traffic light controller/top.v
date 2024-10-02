module top(
        input wire clk, reset, start,
        output wire [3:0] at_side,
        output wire [3:0] at_state,
        output wire R, G ,Y);

        wire clear, count_eq30, count_eq90, count_eq100, count_g_100;
        wire [6:0] count;                               

            traffic_light_controller tfc1 (
                                            .clk(clk),
                                            .reset(reset),
                                            .start(start),
                                            .count_eq30(count_eq30),
                                            .count_eq90(count_eq90),
                                            .count_eq100(count_eq100),
                                            .count_g_100(count_g_100),
                                            .at_state(at_state),
                                            .clear(clear),
                                            .at_side(at_side),
                                            .R(R),
                                            .G(G),
                                            .Y(Y));     

                          counter count1 (
                                            .clk(clk),
                                            .reset(reset),
                                            .clear(clear),
                                            .count(count)); 

                        comparator comp1 (
                                            .count(count),
                                            .count_eq30(count_eq30),
                                            .count_eq90(count_eq90),
                                            .count_eq100(count_eq100),
                                            .count_g_100(count_g_100));

endmodule
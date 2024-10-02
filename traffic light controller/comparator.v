module comparator(
    input wire [6:0] count,
    output wire count_eq30, count_eq90, count_eq100, count_g_100);


        assign count_eq30 = count == 30;
        assign count_eq90 = count == 90;
        assign count_eq100 = count == 100;
        assign count_g_100 = count >= 100;

endmodule
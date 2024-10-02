module comparator(
    input wire [5:0] count,
    output wire count_eq10, count_eq50);

        assign count_eq10 = count == 10;
        assign count_eq50 = count == 50;
endmodule
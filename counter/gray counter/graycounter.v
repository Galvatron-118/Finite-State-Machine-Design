module graycounter
#(
    parameter data_width = 4
)
(
    input wire clk,
    input wire load_en,
    input wire reset,
    input wire [data_width-1:0] d,
    output reg [data_width-1:0] q
);

reg [data_width-1:0] count;
reg q2,q1,q0;

always @(posedge clk, posedge reset)
 begin
    if(reset)
     begin
     q <= 4'b0000;
     count <= 4'b0000;
     {q2,q1,q0} <= 3'b000;
     end
    else if(load_en)
     begin
        q <= d;
        count <=d;
        {q2,q1,q0} <= {d[2],d[1],d[0]};
     end
    else
     begin
        count <= count + 4'b0001;
        q2 <= count[3] ^ count[2];
        q1 <= count[2] ^ count[1];
        q0 <= count[1] ^ count[0];
        q <= {count[3], q2, q1, q0};
     end
end
endmodule
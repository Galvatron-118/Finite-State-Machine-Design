`timescale 1ns/1ns

module temp_top_tb;

    reg clk, reset, start;
    reg [6:0] troom, tref, dt;
    wire h, c;

temp_top top1(
     .clk(clk),
     .reset(reset),
     .start(start),
     .troom(troom),
     .tref(tref),
     .dt(dt),
     .h(h),
     .c(c)
);

initial begin
    clk = 0;
    forever #5 clk=~clk;
end

initial begin

    $dumpfile("test10.vcd");
    $dumpvars(0, temp_top_tb);

   	clk <= 0;
	reset <= 0;
	start <= 0; 	
    troom <= 0;
    tref <= 0;
    dt <= 0;

	@(negedge clk);
	reset <= 0;

	@(negedge clk);
	reset <= 1;
	start <= 1;
    troom <= 50;
    tref <= 60;
    dt <= 1;
    #20;

    troom <= 61;
    #20;

    troom <= 80;
    #20;

    troom <= 59;
    #20;

	$finish();
end

endmodule
module temp_controller(
    input wire clk, reset, start,
    input wire [6:0] troom, tref, dt,
    input wire [3:0] datapath_out,
    output reg h, c,
    output wire [6:0] datapath_in1, datapath_in2, datapath_in3
);

reg [3:0] pstate, nstate;

parameter [3:0] IDLE = 4'b0000,
                HOT =  4'b0001,
                COLD = 4'b0010,
                ERROR = 4'b0011;

//Memory Design 
always @(posedge clk, negedge reset) 
begin : PSR
    if(~reset)
        begin
            pstate <= IDLE;
        end
    else
        begin
            pstate <= nstate;
        end
end

//Next State Logic
always @(*) begin : NSOL

    if(pstate == IDLE)
        $monitor("pstate = IDLE -> clk = %b, reset = %b, start = %b, troom = %d, tref = %d, dt = %d, h = %b, c = %b\n", clk, reset, start, troom, tref, dt, h, c);
    
    else if(pstate == HOT)
        $monitor("pstate = HOT -> clk = %b, reset = %b, start = %b, troom = %d, tref = %d, dt = %d, h = %b, c = %b\n", clk, reset, start, troom, tref, dt, h, c);
 
    else if(pstate == COLD)
        $monitor("pstate = COLD -> clk = %b, reset = %b, start = %b, troom = %d, tref = %d, dt = %d, h = %b, c = %b\n", clk, reset, start, troom, tref, dt, h, c);

    nstate = pstate;


        begin : NSL

            case(pstate)

                IDLE :
                        begin
                            if(start)
                                begin
                                    nstate = (datapath_out[0]) ? HOT : 
                                        (datapath_out[1]) ? COLD :
                                        IDLE;
                                end
                        end
                
                HOT:    
                    begin
                
                        nstate = (datapath_out[2]) ? IDLE :
                                    HOT;
                    end

                COLD: 
                    begin
                        nstate = (datapath_out[3]) ? IDLE :
                                     COLD;
                    end

            default: nstate = ERROR; 

        endcase
        end

        begin : OL

            case(pstate)
            
                IDLE: 
                begin
                     h = 1'b0;
                      c = 1'b0;
                end      

                HOT: 
                begin
                h = 1'b1;
                    c = 1'b0;
                end
                
                COLD: 
                begin
                h = 1'b0;
                      c = 1'b1;
                end
            
            default : nstate = ERROR;

            endcase

        end

end

assign datapath_in1 = troom;
assign datapath_in2 = tref;
assign datapath_in3 = dt;

endmodule
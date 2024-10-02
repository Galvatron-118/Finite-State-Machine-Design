module blinking_light_controller(
    input wire clk, reset, start,
    input wire en,
    output reg light, clear,
    output wire [3:0] datapath_in1, datapath_in2,
    input wire datapath_out,
    input wire [3:0] count
);

reg [3:0] pstate, nstate;

parameter [3:0] STOP = 4'b0000,
                ON   = 4'b0001,
                OFF  = 4'b0010,
               ERROR = 4'b0011;


//Memory Design

always @(posedge clk, posedge reset) begin : PSR

                    if(reset)
                        begin
                            pstate <= STOP;
                        end
                    else
                        begin
                            pstate <= nstate;
                        end
end

always @(*) begin : NSOL

            if(pstate == STOP)
                $monitor("pstate = STOP -> clk = %b, reset = %b, start = %b, en = %b, light = %b, count = %d\n", clk, reset, start, en, light, count);
            
            else if(pstate == ON)
                $monitor("pstate = ON  -> clk = %b, reset = %b, start = %b, en = %b, light = %b, count = %d\n", clk, reset, start, en, light, count);

            else if(pstate == OFF)
                $monitor("pstate = OFF  -> clk = %b, reset = %b, start = %b, en = %b, light = %b, count = %d\n", clk, reset, start, en, light, count);

            nstate = pstate;

            begin : NSL 

                case(pstate)
          
                    STOP : 
                        begin
                            if(start)
                                begin
                                    nstate = en ? ON : STOP;
                                end
                        end

                    ON : 
                        begin
                            if(start)
                                begin
                                    nstate = en ? (datapath_out ? OFF : ON) : STOP;
                                end
                        end
                    
                    OFF: 
                        begin
                            if(start)
                                begin
                                    nstate = en ? (datapath_out ? ON : OFF) : STOP;
                                end
                        end
                    
                    default : nstate = ERROR;
                
                endcase
            end

            begin : OL
                case(pstate)

                    STOP : begin
                    
                        light = 1'b0;
                        clear = 1'b1;
                        
                    end

                    ON : begin
                    
                        light = 1'b1;
                        clear = (nstate == OFF) ? 1'b1 : 1'b0;
                    
                    end

                    OFF : begin

                        light = 1'b0;
                        clear = (nstate == ON) ? 1'b1 : 1'b0;
                    
                    end

                    default : nstate = ERROR;
                endcase
            end   
end

assign datapath_in1 =  count;
assign datapath_in2 = (pstate == ON) ? 5 : ((pstate == OFF) ? 7 : 0);

endmodule
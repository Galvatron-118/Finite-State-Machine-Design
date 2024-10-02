module string_controller(
    input wire clk, reset, start,
    input wire x_val,
    output reg y_val,
    output wire [3:0] datapath_in1, datapath_in2,
    input wire datapath_out  
);

reg [3:0] nstate, pstate;
reg [3:0] i_pstate, i_nstate;

parameter [3:0] A = 4'b0000,
                B = 4'b0001,
                C = 4'b0010,
            ERROR = 4'b0011;

//Memory Design 

always @(posedge clk, posedge reset) begin : PSR

    if(reset)
        begin
            pstate <= A;
            i_pstate <= 4'b0000;
        end
    else
        begin
            pstate <= nstate;
            i_pstate <= i_nstate;
        end
end

//Next state Logic design

always @(*) begin : NSOL
    
    if(pstate == A)
        $monitor("pstate = A -> clk = %b, reset = %b, start = %b, x_val = %b, y_val = %b, i = %d\n", clk, reset, start, x_val, y_val, i_pstate);
    else if(pstate == B)
        $monitor("pstate = B -> clk = %b, reset = %b, start = %b, x_val = %b, y_val = %b, i = %d\n", clk, reset, start, x_val, y_val, i_pstate);
    else if(pstate == C)
        $monitor("pstate = C -> clk = %b, reset = %b, start = %b, x_val = %b, y_val = %b, i = %d\n", clk, reset, start, x_val, y_val, i_pstate);
    
    nstate = pstate;  

    begin : NSL 

        case(pstate)

            A : 
                begin
                    if(start)
                        begin
                            nstate = (x_val) ? B : A;
                        end
                end

            B : 
                begin
                            nstate = (x_val) ? ((datapath_out) ? C : B) : A;
                end

            C : 
                begin
                            nstate = (x_val) ? C : A;
                end

            default:        nstate = ERROR;
        
        endcase

    end

    begin : OL

        case(pstate)

            A : begin 
                    y_val = 1'b0;
                    i_nstate = 4'b0000;
                end

            B : begin 
                    y_val = 1'b0;
                    i_nstate = i_pstate + 1;
                end    

            C : begin 
                    y_val = 1'b1;
                    i_nstate = i_pstate + 1;
                end
            
            default : nstate = ERROR;

        endcase      
    end
end

assign datapath_in1 = i_pstate;
assign datapath_in2 = 4;


endmodule
module traffic_light_controller (
                input wire clk, reset, start,
                
                input wire count_eq30, count_eq90, count_eq100, count_g_100,
                output reg [3:0] at_state,
                output reg [3:0] at_side,
                output reg clear, R, G ,Y);

                reg [3:0] pstate, nstate;
                

                    parameter [3:0] IDLE = 4'b0000, //state declaration
                                    R_1 = 4'b0001,
                                    Y_1 = 4'b0011,
                                    G_1 = 4'b0010,

                                    R_2 = 4'b0100,
                                    Y_2 = 4'b0110,
                                    G_2 = 4'b0101,

                                    R_3 = 4'b0111,
                                    Y_3 = 4'b1001,
                                    G_3 = 4'b1000,

                                    R_4 = 4'b1010,
                                    Y_4 = 4'b1100,
                                    G_4 = 4'b1011;


                           always @(*) begin : NSOL
                                begin : NSL
                                    case(pstate) 

                                            IDLE : nstate = start ? R_1 : IDLE;

                                            R_1 : nstate = count_eq30 ? G_1 : (count_g_100 ? R_2 : R_1); 

                                            G_1 : nstate = count_eq90 ? Y_1 : G_1;

                                            Y_1 : nstate = count_eq100 ? R_1 : Y_1;

                                            R_2 : nstate = count_eq30 ? G_2 : (count_g_100 ? R_3 : R_2);

                                            G_2 : nstate = count_eq90 ? Y_2 : G_2 ;

                                            Y_2 : nstate = count_eq100 ? R_2 : Y_2 ;

                                            R_3 : nstate = count_eq30 ? G_3 : (count_g_100 ? R_4 : R_3);

                                            G_3 : nstate = count_eq90 ? Y_3 : G_3 ;

                                            Y_3 : nstate = count_eq100 ? R_3 : Y_3 ;

                                            R_4 : nstate = count_eq30 ? G_4 : (count_g_100 ? R_1 : R_4);

                                            G_4 : nstate = count_eq90 ? Y_4 : G_4 ;

                                            Y_4 : nstate = count_eq100 ? R_4 : Y_4 ;

                                            default : nstate = 4'bx;

                                    endcase
                                end

                                
                                begin : OL 
                                    case(pstate)

                                            IDLE : begin
                                                clear = 1'b1;
                                                at_state = 4'b0000;
                                                at_side = 4'bx;
                                                R = 1'bx;
                                                G = 1'bx;
                                                Y = 1'bx;
                                            end

                                            R_1 : begin
                                                clear = count_g_100;
                                                at_state = 4'b0001;
                                                at_side =  4'b0001;
                                                R = 1'b1;
                                                G = 1'b0;
                                                Y = 1'b0;
                                            end

                                            Y_1 : begin
                                                clear = 1'b0;
                                                at_state = 4'b0011;
                                                at_side = 4'b0001; 
                                                R = 1'b0;
                                                G = 1'b0;
                                                Y = 1'b1;   
                                            end

                                            G_1 : begin
                                                clear = 1'b0;
                                                at_state = 4'b0010;
                                                at_side = 4'b0001; 
                                                R = 1'b0;
                                                G = 1'b1;
                                                Y = 1'b0;   
                                            end 
                                            
                                            R_2 : begin
                                                clear = count_g_100;
                                                at_state = 4'b0100;
                                                at_side = 4'b0010;
                                                R = 1'b1;
                                                G = 1'b0;
                                                Y = 1'b0;
                                            end

                                            Y_2 : begin
                                                clear = 1'b0;
                                                at_state = 4'b0110;
                                                at_side = 4'b0010;   
                                                R = 1'b0;
                                                G = 1'b0;
                                                Y = 1'b1; 
                                            end

                                            G_2 : begin
                                                clear = 1'b0;
                                                at_state = 4'b0101;
                                                at_side = 4'b0010; 
                                                R = 1'b0;
                                                G = 1'b1;
                                                Y = 1'b0;   
                                            end 

                                            R_3 : begin
                                                clear = count_g_100;
                                                at_state = 4'b0111;
                                                at_side = 4'b0100;
                                                R = 1'b1;
                                                G = 1'b0;
                                                Y = 1'b0;
                                            end

                                            Y_3 : begin
                                                clear = 1'b0;
                                                at_state = 4'b1001;
                                                at_side = 4'b0100;
                                                R = 1'b0;
                                                G = 1'b0;
                                                Y = 1'b1;     
                                            end

                                            G_3 : begin
                                                clear = 1'b0;
                                                at_state = 4'b1000;
                                                at_side = 4'b0100;  
                                                R = 1'b0;
                                                G = 1'b1;
                                                Y = 1'b0;  
                                            end

                                            R_4 : begin
                                                clear = count_g_100;
                                                at_state = 4'b1010;
                                                at_side = 4'b1000;
                                                R = 1'b1;
                                                G = 1'b0;
                                                Y = 1'b0;
                                            end

                                            Y_4 : begin
                                                clear = 1'b0;
                                                at_state = 4'b1100;
                                                at_side = 4'b1000;  
                                                R = 1'b0;
                                                G = 1'b0;
                                                Y = 1'b1;  
                                            end

                                            G_4 : begin
                                                clear = 1'b0;
                                                at_state = 4'b1011;
                                                at_side = 4'b1000;  
                                                R = 1'b0;
                                                G = 1'b1;
                                                Y = 1'b0;  
                                            end

                                            default : begin
                                                clear = 1'bx;
                                                at_state = 4'bx;
                                                at_side = 4'bx;
                                                R = 1'bx;
                                                G = 1'bx;
                                                Y = 1'bx;
                                            end
                                endcase
                            end

                            end

                        always @(posedge clk or negedge reset) begin : PSR
                                begin
                                        if(~reset) begin 
                                            pstate <= IDLE;
                                        end

                                        else begin
                                            pstate <= nstate;
                                        end
                                end
                        end

endmodule
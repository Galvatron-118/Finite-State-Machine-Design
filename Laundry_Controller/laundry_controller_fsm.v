module laundry_controller_fsm( 
		input wire clk, reset, start,
		input wire [3:0] req_laundry, send,
		input wire count_eq10, count_eq50,
                 
		output reg [2:0] at_floor,
		output reg wash_done,clear);
			
		reg [2:0] pstate, nstate;

                parameter [2:0] IDLE = 3'b000,
				FLOOR_1 = 3'b001,
				FLOOR_2 = 3'b010,
				FLOOR_3 = 3'b011,
				FLOOR_4 = 3'b100,
				WASHING = 3'b101,
                WASHING_DONE = 3'b110; 
		

 			always @(*) begin : NSOL    
			  	begin : NSL
					case(pstate)

						IDLE : nstate = start ? 
									(req_laundry[3]? FLOOR_4 
								    	: (req_laundry[2]? FLOOR_3 
	                                    : (req_laundry[1]? FLOOR_2
                                        : (req_laundry[0]? FLOOR_1 : IDLE))))
								    	: IDLE; 
						
						FLOOR_4	: nstate = send[3] ?
									(req_laundry[2] ? FLOOR_3
									: (req_laundry[1] ? FLOOR_2
									: (req_laundry[0] ? FLOOR_1 : WASHING)))
									: (count_eq10 ? FLOOR_3 : FLOOR_4);
					       
						FLOOR_3 : nstate = send[2] ? 
									(req_laundry[1] ? FLOOR_2
									: (req_laundry[0] ? FLOOR_1 : WASHING))
									: (count_eq10 ? FLOOR_2 : FLOOR_3);
					     
						FLOOR_2 : nstate = send[1] ?
									(req_laundry[0] ? FLOOR_1 : WASHING)
									: (count_eq10 ? FLOOR_1 :FLOOR_2);
						
						FLOOR_1 : nstate = send[0] ? WASHING 
									: (count_eq10 ? FLOOR_1 : WASHING);
						
						WASHING : nstate = count_eq50 ? WASHING_DONE : WASHING;
                                                
						WASHING_DONE : nstate = IDLE;  

						default : nstate = 3'bx;

					endcase
                              end

			      begin : OL
                    case(pstate)
						
					    	IDLE :  begin
								clear = 1'b1;
								at_floor = 3'b101;
								wash_done = 1'b0;
							end
                                                
					      FLOOR_4 : begin
							    clear = count_eq10 | send[3];
								at_floor = 3'b100;
								wash_done = 1'b0;
							end
					     
					      FLOOR_3 : begin
							    clear = count_eq10 | send[2];
								at_floor = 3'b011;
								wash_done = 1'b0;
							end

					     FLOOR_2 : begin
							    clear = count_eq10 | send[1];
								at_floor = 3'b010;
								wash_done = 1'b0;
						       end

					     FLOOR_1 : begin
							    clear = count_eq10 | send[0];
								at_floor = 3'b001;
								wash_done = 1'b0;
						       end
				
					    WASHING :  begin
							    clear = count_eq50;
								at_floor = 3'b101;
								wash_done = 1'b0;
						       end
								
					 WASHING_DONE: begin
						        clear = 1'b1;
								at_floor = 3'b000;
								wash_done = 1'b1;
						       end

				        default : begin
							    clear = 1'bx;
								at_floor = 3'bx;
								wash_done = 1'bx;
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
									 
								     	
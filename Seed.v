------------------------------------------------------------------------------------------------
--  This source is dedicated to the research paper enttled                                    --
--  "An 8-bit Serialized Architecture of SEED Block Cipher for Constrained Devices"           --
--  on IET Circuits, Devices & Systems journal                                                --
--  Authors : Lampros Pyrgas, Filippos Pirpilidis and Paris Kitsos                            --
--  Institute: University of the Peloponnese                                                  --
--  Department: Electrical and Computer Engineering                                           --
--                                                                                            --
--  This source is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY.  --
------------------------------------------------------------------------------------------------

module Seed(
	input clk,
	input reset_n,
	input [7:0] Key,
	input [7:0] Mes,
	output [7:0] Cryp,
	output valid_data
);


wire [7:0] LR_out;
wire [7:0] SK;

reg [4:0] main_counter;
reg [4:0] round_counter;

always@(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		main_counter <= 0;
		round_counter <= 0;
	end else begin
		if(main_counter < 16) begin 
			main_counter <= main_counter + 1;
		end else if(round_counter < 16)begin
			main_counter <= 0;
			round_counter <= round_counter + 1;
		end else begin
			round_counter <= 0;
			main_counter <= 0;
		end
	end
end

reg [7:0] delay_LR;
reg [7:0] delay_mes; //used for simulation-synchronization  purposes

always @ ( posedge clk or negedge reset_n ) begin
	if(!reset_n) begin
		delay_LR  <= 0;
		delay_mes  <= 0;					
	end else begin
        delay_LR  <= LR_out;
        delay_mes  <= Mes;						
	end
end

//reg [10:0] counter; 

//always @ ( posedge clk or negedge reset_n ) begin
//	if(!reset_n) begin
//		counter  <= 0;
//	end else begin
//        counter  <= counter +1;		
//	end
//end



wire [7:0] Mes_in_mux = (round_counter != 1) ? delay_LR : delay_mes;

Round_block inst_round(
.clk 			(clk),
.reset_n 		(reset_n),
.LR0 			(Mes_in_mux),
.SK 			(SK),
.main_counter   (main_counter),
.LR1            (LR_out)
);

Kschedule inst_KShcedule(
.clk              (clk),
.reset_n          (reset_n),
.Key              (Key),
.SK               (SK),
.main_counter     (main_counter),
.round_counter    (round_counter)
);


reg [71:0] final_round;

always @ ( posedge clk or negedge reset_n ) begin
	if(!reset_n) begin
		final_round <= 0;
	end else begin
		final_round <= {LR_out,final_round[71:8]};
end
end

assign Cryp = ((main_counter <16)&(round_counter==16 ))? final_round[7:0]:LR_out;


reg seed_done;

always @ ( posedge clk or negedge reset_n ) begin
	if(!reset_n) begin
		seed_done  <= 0;					
	end else begin
	if(round_counter == 16) begin	
        seed_done  <= 1'b1;		
	end else begin
    if(round_counter == 1) begin    
        seed_done  <= 1'b0;        
    end    	
end
end
end


assign valid_data = ( seed_done &(
((round_counter == 16) & (main_counter > 7))||
((round_counter == 0) & (main_counter < 7))
)) ? 1'b1 : 1'b0;
endmodule

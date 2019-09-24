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

module Round_block(
	input clk,
	input reset_n,
	input  [7:0]  LR0,
	input  [7:0]  SK,
	input  [4:0]  main_counter,
	output [7:0]  LR1
);

reg [7:0] reg_KEY0;
reg [7:0] reg_KEY1;
reg [7:0] reg_KEY2;
reg [7:0] reg_KEY3;


always @ ( posedge clk or negedge reset_n ) begin
	if(!reset_n) begin
		reg_KEY0  <= 0;
        reg_KEY1  <= 0;
        reg_KEY2  <= 0;
        reg_KEY3  <= 0;
	end else begin
        reg_KEY0  <= SK;
        reg_KEY1  <= reg_KEY0;
        reg_KEY2  <= reg_KEY1;
        reg_KEY3  <= reg_KEY2;
end
end




//reg [7:0] R;
//reg [199:0] shift_R0;

//always @ ( posedge clk or negedge reset_n ) begin
//	if(!reset_n) begin
//		shift_R0 <= 0;
//		R <= 0;
//	end else begin
//		shift_R0 <= {LR0,shift_R0[199:8]};
//		R<= shift_R0[7:0];
//end
//end


reg [7:0] reg_LR0;
reg [7:0] reg_LR1;
reg [7:0] reg_LR2;
reg [7:0] reg_LR3;
reg [7:0] reg_LR4;
reg [7:0] reg_LR5;
reg [7:0] reg_LR6;
reg [7:0] reg_LR7;
reg [7:0] reg_LR8;
reg [7:0] reg_LR9;
reg [7:0] reg_LR10;
reg [7:0] reg_LR11;
reg [7:0] reg_LR12;
reg [7:0] reg_LR13;
reg [7:0] reg_LR14;
reg [7:0] reg_LR15;
reg [7:0] reg_LR16;
reg [7:0] reg_LR17;
reg [7:0] reg_LR18;
reg [7:0] reg_LR19;
reg [7:0] reg_LR20;
reg [7:0] reg_LR21;
reg [7:0] reg_LR22;
reg [7:0] reg_LR23;

always @ ( posedge clk or negedge reset_n ) begin
	if(!reset_n) begin
		reg_LR0  <= 0;
		reg_LR1  <= 0;
		reg_LR2  <= 0;
		reg_LR3  <= 0;
		reg_LR4  <= 0;
		reg_LR5  <= 0;
		reg_LR6  <= 0;
		reg_LR7  <= 0;
		reg_LR8  <= 0;
		reg_LR9  <= 0;
		reg_LR10 <= 0;
		reg_LR11 <= 0;
		reg_LR12 <= 0;
		reg_LR13 <= 0;
		reg_LR14 <= 0;
		reg_LR15 <= 0;
		reg_LR16 <= 0;
		reg_LR17 <= 0;
		reg_LR18 <= 0;
		reg_LR19 <= 0;
		reg_LR20 <= 0;
		reg_LR21 <= 0;
		reg_LR22 <= 0;
		reg_LR23 <= 0;
	end else begin
        reg_LR0  <= LR0;
        reg_LR1  <= reg_LR0;
        reg_LR2  <= reg_LR1;
        reg_LR3  <= reg_LR2;
        reg_LR4  <= reg_LR3;
        reg_LR5  <= reg_LR4;
        reg_LR6  <= reg_LR5;
        reg_LR7  <= reg_LR6;
        reg_LR8  <= reg_LR7;
        reg_LR9  <= reg_LR8;
        reg_LR10 <= reg_LR9;
        reg_LR11 <= reg_LR10;
        reg_LR12 <= reg_LR11;
        reg_LR13 <= reg_LR12;
        reg_LR14 <= reg_LR13;
        reg_LR15 <= reg_LR14;
        reg_LR16 <= reg_LR15;
        reg_LR17 <= reg_LR16;
        reg_LR18 <= reg_LR17;
        reg_LR19 <= reg_LR18;
        reg_LR20 <= reg_LR19;
        reg_LR21 <= reg_LR20;
        reg_LR22 <= reg_LR21;
		reg_LR23 <= reg_LR22;       		
	end 
end


wire [7:0] Dn;
wire [7:0] Cn;

F_function funF(
.clk(clk),
.reset_n(reset_n),
.C(LR0),
.D(reg_LR3),
.main_counter(main_counter),
.SK0(SK),
.SK1(reg_KEY3),
.Cn(Cn),
.Dn(Dn)
);


reg [7:0] reg_Cn0;
reg [7:0] reg_Cn1;
reg [7:0] reg_Cn2;
reg [7:0] reg_Cn3;


always @ ( posedge clk or negedge reset_n ) begin
	if(!reset_n) begin
		reg_Cn0  <= 0;
        reg_Cn1  <= 0;
        reg_Cn2  <= 0;
        reg_Cn3  <= 0;
	end else begin
        reg_Cn0  <= Cn;
        reg_Cn1  <= reg_Cn0;
        reg_Cn2  <= reg_Cn1;
        reg_Cn3  <= reg_Cn2;
	end
end

wire [7:0] X_IN = ((main_counter < 3)||(main_counter==16)) ? Dn : reg_Cn3;

wire [7:0] XOR  = reg_LR7^X_IN;

assign LR1 = ((main_counter < 7)||(main_counter==16)) ? XOR :reg_LR23;


endmodule

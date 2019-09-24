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

// 4 LSBs first 

module Kschedule(
	input clk,
	input reset_n,
	input [7:0] Key,
	output[7:0] SK,
	input [4:0] main_counter,
	input [4:0] round_counter
);


wire [31:0] KC_0 =  32'h9E3779B9;
wire [31:0] KC_1 =  32'h3C6EF373;
wire [31:0] KC_2 =  32'h78DDE6E6;
wire [31:0] KC_3 =  32'hF1BBCDCC;
wire [31:0] KC_4 =  32'hE3779B99;
wire [31:0] KC_5 =  32'hC6EF3733;
wire [31:0] KC_6 =  32'h8DDE6E67;
wire [31:0] KC_7 =  32'h1BBCDCCF;
wire [31:0] KC_8 =  32'h3779B99E;
wire [31:0] KC_9 =  32'h6EF3733C;
wire [31:0] KC_A =  32'hDDE6E678;
wire [31:0] KC_B =  32'hBBCDCCF1;
wire [31:0] KC_C =  32'h779B99E3;
wire [31:0] KC_D =  32'hEF3733C6;
wire [31:0] KC_E =  32'hDE6E678D;
wire [31:0] KC_F =  32'hBCDCCF1B;

wire [31:0] KC_32 = (
 round_counter[3:0] == 0) ? KC_0 :
(round_counter[3:0] == 1) ? KC_1 :
(round_counter[3:0] == 2) ? KC_2 :
(round_counter[3:0] == 3) ? KC_3 :
(round_counter[3:0] == 4) ? KC_4 :
(round_counter[3:0] == 5) ? KC_5 :
(round_counter[3:0] == 6) ? KC_6 :
(round_counter[3:0] == 7) ? KC_7 :
(round_counter[3:0] == 8) ? KC_8 :
(round_counter[3:0] == 9) ? KC_9 :
(round_counter[3:0] == 10) ? KC_A :
(round_counter[3:0] == 11) ? KC_B :
(round_counter[3:0] == 12) ? KC_C :
(round_counter[3:0] == 13) ? KC_D :
(round_counter[3:0] == 14) ? KC_E : KC_F;

wire [7:0] KC =
(main_counter == 16 ) ? KC_32[31:24] :
(main_counter == 15 ) ? KC_32[23:16] :
(main_counter == 14 ) ? KC_32[15:8]  : KC_32[7:0];


reg [7:0] reg_ABCD0;
reg [7:0] reg_ABCD1;
reg [7:0] reg_ABCD2;
reg [7:0] reg_ABCD3;
reg [7:0] reg_ABCD4;
reg [7:0] reg_ABCD5;
reg [7:0] reg_ABCD6;
reg [7:0] reg_ABCD7;
reg [7:0] reg_ABCD8;
reg [7:0] reg_ABCD9;
reg [7:0] reg_ABCD10;
reg [7:0] reg_ABCD11;
reg [7:0] reg_ABCD12;
reg [7:0] reg_ABCD13;
reg [7:0] reg_ABCD14;
reg [7:0] reg_ABCD15;
reg [7:0] reg_ABCD16;
reg [7:0] reg_ABCD17;
reg [7:0] reg_ABCD18;
reg [7:0] reg_ABCD19;
reg [7:0] reg_ABCD20;
reg [7:0] reg_ABCD21;
reg [7:0] reg_ABCD22;
reg [7:0] reg_ABCD23;


////////////////////////////////////////////////////////////////////////////
/////////////////////////////CONTROL///////////////////////////////////////
wire round_mod2    = (round_counter[0]) ? 1'b1 : 1'b0;    //'1' at odd rounds 

wire [7:0] ABCD_AB_rot;
wire [7:0] ABCD_CD_rot;

wire [7:0] ABCD_IN = (round_mod2) ? ABCD_AB_rot : ABCD_CD_rot;

wire [7:0] ABCD = (round_counter == 0) ? Key : ABCD_IN;

wire enable_cb = (main_counter>13)? 1'b1 : 1'b0; 

wire enable_output = (main_counter<4) ? 1'b1 : 1'b0;

wire load_store = (main_counter >12) ? 1'b1 : 1'b0;



wire g_enable_cb = ( main_counter == 13
	|| main_counter == 14
	|| main_counter == 15
	|| main_counter == 16
	|| main_counter == 0
	|| main_counter == 1
	|| main_counter == 2
	|| main_counter == 3
	|| main_counter == 4
    || main_counter == 5
    || main_counter == 6
    || main_counter == 7
	) ? 1'b1 : 1'b0;
		
////////////////////////////////////////////////////////////////////////////

reg dff_carry_AC;
reg dff_borrow_ACK;

reg dff_borrow_BD;
reg dff_carry_BDK;
////////////////////////////////////////////////////////////////////////////
wire AC_carry_out;
wire AC_carry_in = (enable_cb) ? dff_carry_AC : 1'b0;
wire [7:0] AC_sum;

adder AC_adder(
.A      (reg_ABCD0),
.B      (reg_ABCD8),
.c_in   (AC_carry_in),
.Sum    (AC_sum),
.c_out  (AC_carry_out)
 );
 
wire AC_K_borrow_out;
wire AC_K_borrow_in = (enable_cb) ? dff_borrow_ACK : 1'b0;
wire [7:0] AC_K_out;


subtractor AC_K_subtractor(
.A      (AC_sum),
.B      (KC),
.d_in   (AC_K_borrow_in),
.Diff   (AC_K_out),
.d_out  (AC_K_borrow_out)
 );


reg [7:0] regF0;
reg [7:0] regF1;
reg [7:0] regF2;
reg [7:0] regF3;


always @ ( posedge clk or negedge reset_n ) begin
	if(!reset_n) begin
		regF0  <= 0;
        regF1  <= 0;
        regF2  <= 0;
        regF3  <= 0;
	end else begin
        regF0  <= AC_K_out;
        regF1  <= regF0;
        regF2  <= regF1;
        regF3  <= regF2;
	end
end


////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
wire BD_borrow_out;
wire BD_borrow_in = (enable_cb) ? dff_borrow_BD : 1'b0;
wire [7:0] BD_diff;


subtractor BD_subtractor(
.A      (reg_ABCD4),
.B      (reg_ABCD12),
.d_in   (BD_borrow_in),
.Diff   (BD_diff),
.d_out  (BD_borrow_out)
 );
 
wire BD_K_carry_out;
wire BD_K_carry_in = (enable_cb) ? dff_carry_BDK : 1'b0;
wire [7:0] BD_K_out;


adder BD_K_adder(
.A      (BD_diff),
.B      (KC),
.c_in   (BD_K_carry_in),
.Sum    (BD_K_out),
.c_out  (BD_K_carry_out)
 );

////////////////////////////////////////////////////////////////////////////


always @ ( posedge clk or negedge reset_n ) begin
  if(!reset_n)begin
    dff_carry_AC   <= 0;
    dff_borrow_ACK <= 0;
    dff_borrow_BD  <= 0;
    dff_carry_BDK  <= 0;
    
  end else begin
    dff_carry_AC   <= AC_carry_out;
    dff_borrow_ACK <= AC_K_borrow_out;
    dff_borrow_BD  <= BD_borrow_out;
    dff_carry_BDK  <= BD_K_carry_out;
    
  end
end

wire [7:0] F_IN = (main_counter>3) ? BD_K_out : regF3;

  G_function fnG0(
  .clk(clk),
  .reset_n(reset_n),
  .inp(F_IN),
  .outp(SK),
  .enable(g_enable_cb)
  );
  

always @ ( posedge clk or negedge reset_n ) begin
	if(!reset_n) begin
		reg_ABCD0  <= 0;
		reg_ABCD1  <= 0;
		reg_ABCD2  <= 0;
		reg_ABCD3  <= 0;
		reg_ABCD4  <= 0;
		reg_ABCD5  <= 0;
		reg_ABCD6  <= 0;
		reg_ABCD7  <= 0;
		reg_ABCD8  <= 0;
		reg_ABCD9  <= 0;
		reg_ABCD10 <= 0;
		reg_ABCD11 <= 0;
		reg_ABCD12 <= 0;
		reg_ABCD13 <= 0;
		reg_ABCD14 <= 0;
		reg_ABCD15 <= 0;
		reg_ABCD16 <= 0;
		reg_ABCD17 <= 0;
		reg_ABCD18 <= 0;
		reg_ABCD19 <= 0;
		reg_ABCD20 <= 0;
		reg_ABCD21 <= 0;
		reg_ABCD22 <= 0;
		reg_ABCD23 <= 0;
	end else begin
        reg_ABCD0  <= ABCD;
        reg_ABCD1  <= reg_ABCD0;
        reg_ABCD2  <= reg_ABCD1;
        reg_ABCD3  <= reg_ABCD2;
        reg_ABCD4  <= reg_ABCD3;
        reg_ABCD5  <= reg_ABCD4;
        reg_ABCD6  <= reg_ABCD5;
        reg_ABCD7  <= reg_ABCD6;
        reg_ABCD8  <= reg_ABCD7;
        reg_ABCD9  <= reg_ABCD8;
        reg_ABCD10 <= reg_ABCD9;
        reg_ABCD11 <= reg_ABCD10;
        reg_ABCD12 <= reg_ABCD11;
        reg_ABCD13 <= reg_ABCD12;
        reg_ABCD14 <= reg_ABCD13;
        reg_ABCD15 <= reg_ABCD14;
        reg_ABCD16 <= reg_ABCD15;
        reg_ABCD17 <= reg_ABCD16;
        reg_ABCD18 <= reg_ABCD17;
        reg_ABCD19 <= reg_ABCD18;
        reg_ABCD20 <= reg_ABCD19;
        reg_ABCD21 <= reg_ABCD20;
        reg_ABCD22 <= reg_ABCD21;
		reg_ABCD23 <= reg_ABCD22;       		
	end 
end



assign ABCD_AB_rot =
 (main_counter < 8 ) ? reg_ABCD16 :
((main_counter > 7) & (main_counter < 15)) ? reg_ABCD15 :
 (main_counter > 14 ) ? reg_ABCD23 : 0;

assign ABCD_CD_rot =
 (main_counter < 1 ) ? reg_ABCD9 :
((main_counter > 0) & (main_counter < 8)) ? reg_ABCD17 :
 (main_counter > 7 ) ? reg_ABCD16 : 0;
 
endmodule

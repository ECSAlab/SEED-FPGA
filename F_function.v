////////////////////////////////////////////////////////////////////////////////////////////////
//  This source is dedicated to the research paper enttled                                    //
//  "An 8-bit Serialized Architecture of SEED Block Cipher for Constrained Devices"           //
//  on IET Circuits, Devices & Systems journal                                                //
//  Authors : Lampros Pyrgas, Filippos Pirpilidis and Paris Kitsos                            //
//  Institute: University of the Peloponnese                                                  //
//  Department: Electrical and Computer Engineering                                           //
//                                                                                            //
//  This source is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY.  //
////////////////////////////////////////////////////////////////////////////////////////////////

module F_function(
	input  clk,
	input  reset_n,
	input  [7:0] C,
	input  [7:0] D,
	input  [7:0] SK0,
	input  [7:0] SK1,
	input  [4:0] main_counter,
	output [7:0] Cn,
	output [7:0] Dn
);


wire [7:0] CK0 =  C^SK0		;
wire [7:0] DK1 =  D^SK1^CK0 ;

wire [7:0] C_out0;
wire [7:0] D_out0;

wire [7:0] C_IN = (main_counter < 8) ? CK0 : D_out0;
wire [7:0] D_IN = (main_counter < 8) ? DK1 : C_out0;

SF_Function sub_f_round0(
.clk            (clk),
.reset_n        (reset_n),
.C              (C_IN),
.D              (D_IN),
.main_counter   (main_counter),
.Cn             (C_out0),
.Dn             (D_out0)
  );

assign Cn = C_out0;
assign Dn = D_out0;

endmodule

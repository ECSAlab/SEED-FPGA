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

module x_pow_4_f(
	input  [7:0] a,
	output [7:0] p
);

wire [7:0] comb_p0;
wire [7:0] comb_p1;

x_pow_n comb_inst0(
.a(a),
.b(a),
.p(comb_p0)
);
x_pow_n comb_inst1(
.a(a),
.b(comb_p0),
.p(comb_p1)
);
x_pow_n comb_inst2(
.a(a),
.b(comb_p1),
.p(p)
);
endmodule

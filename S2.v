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

module S2(
input [7:0] Inp,
output [7:0] Outp
);


wire [7:0] inv_out;
wire [7:0] p;
wire [7:0] Outp_tmp;

GFmin1 inverter(
.x(Inp),
.ch(1'b1), //1:inverter used for SEED,0:inverter used for AES 
.xmin1_out(inv_out)
);

x_pow_4_f x4(
.a(inv_out),
.p(p)
);

assign Outp_tmp[7] = p[6]^p[2]^p[0];
assign Outp_tmp[6] = p[7]^p[2]^p[0];
assign Outp_tmp[5] = p[7]^p[6]^p[5]^p[4]^p[3]^p[2]^p[1];
assign Outp_tmp[4] = p[5]^p[0];
assign Outp_tmp[3] = p[7]^p[3]^p[1];
assign Outp_tmp[2] = p[7]^p[3];
assign Outp_tmp[1] = p[6]^p[1];
assign Outp_tmp[0] = p[4]^p[2];

assign Outp = Outp_tmp^56;

endmodule

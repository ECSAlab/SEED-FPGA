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

module GFmin1(
input  [7:0] x,
input ch,
output reg [7:0] xmin1_out
);

reg  [7:0] xd;
reg [7:0] xmin0_out;
wire [3:0] x2;
wire [3:0] xl;

wire [3:0] xin0;
wire [3:0] xin1;
wire [3:0] x_xr0;
wire [3:0] ab0;
wire  [7:0] xmin0;
reg  [3:0] xmin1;
wire [3:0] x_xr1;
wire [3:0] xr_mid;
wire [3:0] ab_out0;
wire [3:0] ab_out1;
wire x_x02_l;
wire [3:0] qmin;

reg [7:0] xs;
always@(*) begin
	xd = 0;
	if(ch == 1'b1) begin
		xs[7] = x[6]^x[5]^x[3];//x[7]^x[2];
		xs[6] = x[6]^x[5];//x[6]^x[0];
		xs[5] = x[7]^x[4]^x[2]^x[1];//x[6]^x[4]^x[3]^x[2]^x[1]^x[0];
		xs[4] = x[7]^x[6]^x[2];//x[6]^x[4]^x[2]^x[1];
		xs[3] = x[6]^x[5]^x[3]^x[1];//x[5]^x[1]^x[0];
		xs[2] = x[7]^x[6]^x[5]^x[4]^x[3]^x[1];//x[6]^x[5]^x[3]^x[0];
		xs[1] = x[7]^x[1];//x[2]^x[1];
		xs[0] = x[5]^x[0];//x[4]^x[2]^x[1];
		xd = xs;//^8'd169;
	end else begin
		xs[7] = x[7]^x[5];
		xs[6] = x[7]^x[6]^x[4]^x[3]^x[2]^x[1];
		xs[5] = x[7]^x[5]^x[3]^x[2];
		xs[4] = x[7]^x[5]^x[3]^x[2]^x[1];
		xs[3] = x[7]^x[6]^x[2]^x[1];
		xs[2] = x[7]^x[4]^x[3]^x[2]^x[1];
		xs[1] = x[6]^x[4]^x[1];
		xs[0] = x[6]^x[1]^x[0];
		xd = xs;//^8'd169;
	end
end


GF22_mult gf0(
.a(x_xr0),
.b(xd[3:0]),
.ab(ab0)
);

GF22_mult gf1(
.a(qmin),
.b(xd[7:4]),
.ab(xmin0[7:4])
);

GF22_mult gf2(
.a(qmin),
.b(xd[7:4]^xd[3:0]),
.ab(xmin0[3:0])
);

assign x_xr0 = xd[7:4]^xd[3:0];

assign x_xr1  = ab0^xl;

assign xin0[3] = xd[7];
assign xin0[2] = xd[6];
assign xin0[1] = xd[5];
assign xin0[0] = xd[4];

assign x2[3] = xd[7];
assign x2[2] = xd[7]^xd[6];
assign x2[1] = xd[6]^xd[5];
assign x2[0] = xd[5]^xd[4]^xd[7];

assign xin1[3] = x2[3];
assign xin1[2] = x2[2];
assign xin1[1] = x2[1];
assign xin1[0] = x2[0];


assign x_x02_l = x2[0]^x2[2];
assign xl[3] = x2[0]^x2[2];
assign xl[2] = x2[3]^x2[1]^x2[0]^x2[2];//x_x02_l;
assign xl[1] = x2[3];
assign xl[0] = x2[2];


assign xr_mid = ab0^xl; 

wire [3:0] q = x_xr1;
assign qmin[3] = q[3]^(q[3]&q[2]&q[1])^(q[3]&q[0])^q[2];
assign qmin[2] = (q[3]&q[2]&q[1])^(q[3]&q[2]&q[0])^(q[3]&q[0])^q[2]^(q[2]&q[1]);
assign qmin[1] = q[3]^(q[3]&q[2]&q[1])^(q[3]&q[1]&q[0])^q[2]^(q[2]&q[0])^q[1];
assign qmin[0] = (q[3]&q[2]&q[1])^(q[3]&q[2]&q[0])^(q[3]&q[1])^(q[3]&q[1]&q[0])^(q[3]&q[0])^q[2]^(q[2]&q[1])^(q[2]&q[1]&q[0])^q[1]^q[0];

always@(*) begin
	if(ch == 1'b1) begin
		xmin1_out[7] = xmin0[7]^xmin0[3]^xmin0[1];//xmin0[7]^xmin0[6]^xmin0[5]^xmin0[4]^xmin0[3]^xmin0[2]^xmin0[1];
		xmin1_out[6] = xmin0[5]^xmin0[4]^xmin0[3]^xmin0[2]^xmin0[1];//xmin0[4]^xmin0[0];
		xmin1_out[5] = xmin0[6]^xmin0[5]^xmin0[4]^xmin0[3]^xmin0[2]^xmin0[1];//xmin0[5]^xmin0[2]^xmin0[0];
		xmin1_out[4] = xmin0[7]^xmin0[2]^xmin0[1];//xmin0[1]^xmin0[0];
		xmin1_out[3] = xmin0[7]^xmin0[6];//xmin0[6]^xmin0[5]^xmin0[0];
		xmin1_out[2] = xmin0[7]^xmin0[5]^xmin0[2];//xmin0[6]^xmin0[5]^xmin0[4]^xmin0[3]^xmin0[2]^xmin0[1];
		xmin1_out[1] = xmin0[7]^xmin0[3];//xmin0[6]^xmin0[5]^xmin0[4]^xmin0[3]^xmin0[2];
		xmin1_out[0] = xmin0[6]^xmin0[5]^xmin0[4]^xmin0[3]^xmin0[2]^xmin0[1]^xmin0[0];//xmin0[6]^xmin0[4]^xmin0[0];
	end else begin 
		xmin1_out[7] = xmin0[7]^xmin0[6]^xmin0[5]^xmin0[1];
		xmin1_out[6] = xmin0[6]^xmin0[2];
		xmin1_out[5] = xmin0[6]^xmin0[5]^xmin0[1];
		xmin1_out[4] = xmin0[6]^xmin0[5]^xmin0[4]^xmin0[2]^xmin0[1];
		xmin1_out[3] = xmin0[5]^xmin0[4]^xmin0[3]^xmin0[2]^xmin0[1];
		xmin1_out[2] = xmin0[7]^xmin0[4]^xmin0[3]^xmin0[2]^xmin0[1];
		xmin1_out[1] = xmin0[5]^xmin0[4];
		xmin1_out[0] = xmin0[6]^xmin0[5]^xmin0[4]^xmin0[2]^xmin0[0];
	end
end

endmodule

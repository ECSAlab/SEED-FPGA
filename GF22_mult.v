module GF22_mult(
input  [3:0] a,
input  [3:0] b,
output [3:0] ab
);

wire [1:0] xF;
wire [1:0] x;

wire [1:0] a_xr;
wire [1:0] b_xr;
wire [1:0] gf_r1;
wire [1:0] gf_r2;

assign xF[1] = x[1]^x[0];
assign xF[0] = x[1];

assign a_xr = a[3:2]^a[1:0];
assign b_xr = b[3:2]^b[1:0];

assign ab[3:2] = gf_r1^gf_r2;
assign ab[1:0] = xF^gf_r2;

GF2 gf2a(
.a(b[3:2]),
.b(a[3:2]),
.ab(x)
); 

GF2 gf2b(
.a(a_xr),
.b(b_xr),
.ab(gf_r1)
);

GF2 gf2c(
.a(b[1:0]),
.b(a[1:0]),
.ab(gf_r2)
);

endmodule
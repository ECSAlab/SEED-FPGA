module x_pow_8_f(
	input  [7:0] a,
	output [7:0] p
);

wire [7:0] comb_p0;
wire [7:0] comb_p1;
wire [7:0] comb_p2;
wire [7:0] comb_p3;
wire [7:0] comb_p4;
wire [7:0] comb_p5;
wire [7:0] comb_p6;
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
.p(comb_p2)
);
x_pow_n comb_inst3(
.a(a),
.b(comb_p2),
.p(comb_p3)
);
x_pow_n comb_inst4(
.a(a),
.b(comb_p3),
.p(comb_p4)
);
x_pow_n comb_inst5(
.a(a),
.b(comb_p4),
.p(comb_p5)
);
x_pow_n comb_inst6(
.a(a),
.b(comb_p5),
.p(p)
);
endmodule
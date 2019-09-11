module GF2(
input [1:0] a,
input [1:0] b,
output [1:0] ab
);

assign ab[1] = (a[1]&b[0])^(a[0]&b[1])^(a[1]&b[1]);
assign ab[0] = (a[1]&b[1])^(a[0]&b[0]);
endmodule

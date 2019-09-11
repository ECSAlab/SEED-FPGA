module x_pow_n(
	input  [7:0] a,
	input  [7:0] b,
	output reg [7:0] p
);
reg [7:0] c;
reg [7:0] h;
reg [7:0] aa;
reg [7:0] bb;
always@(*) begin
	aa=a;
	bb=b;
	p=0;
	c=0;
	p=0;
	h=0;
	
	for(c = 0; c < 8; c = c + 1) begin
		if(bb[0]) begin
			p = aa^p;
		end
		h  = (aa & 8'h80);
		aa = {aa[6:0],1'b0};
		if(h[7]) begin
			aa = aa^8'h63;
		end
		bb = {1'b0,bb[7:1]};
	end
end

endmodule
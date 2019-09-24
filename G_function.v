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

module G_function(
	input clk,
	input reset_n,
	input [7:0] inp,
	output reg [7:0] outp,
	input enable
);

localparam m0 = 8'hfc;
localparam m1 = 8'hf3;
localparam m2 = 8'hcf;
localparam m3 = 8'h3f;


wire [7:0] x3;
wire [7:0] x2;
wire [7:0] x1;
wire [7:0] x0;

wire [7:0] s3;
wire [7:0] s2;
wire [7:0] s1;
wire [7:0] s0;

wire [7:0] z3;
wire [7:0] z2;
wire [7:0] z1;
wire [7:0] z0;



reg [31:0] shift_inp;
reg [31:0] shift_out;

reg [7:0] dff_s0_0;
reg [7:0] dff_s0_1;
reg [7:0] dff_s0_2;

reg [7:0] dff_s1_0;
reg [7:0] dff_s1_1;

reg [7:0] dff_s2_0;
always@(posedge clk or negedge reset_n) begin
	if(~reset_n) begin
		dff_s0_0 <= 0;
		dff_s0_1 <= 0;
		dff_s0_2 <= 0;

		dff_s1_0 <= 0;
		dff_s1_1 <= 0;

		dff_s2_0 <= 0;
	end else begin
		dff_s0_0 <= s1;
		dff_s0_1 <= dff_s0_0;
		dff_s0_2 <= dff_s0_1;

		dff_s1_0 <= s2;
		dff_s1_1 <= dff_s1_0;

	end
end



assign z3 = (dff_s0_2 & m3)^(dff_s1_1 & m0)^(dff_s0_0 & m1)^(s2 & m2);
assign z2 = (dff_s0_2 & m2)^(dff_s1_1 & m3)^(dff_s0_0 & m0)^(s2 & m1);
assign z1 = (dff_s0_2 & m1)^(dff_s1_1 & m2)^(dff_s0_0 & m3)^(s2 & m0);
assign z0 = (dff_s0_2 & m0)^(dff_s1_1 & m1)^(dff_s0_0 & m2)^(s2 & m3);
wire [31:0] zout_tmp = {z3,z2,z1,z0};
reg [23:0] zout;
reg [1:0] counter;
always @ ( posedge clk or negedge reset_n ) begin
	if(!reset_n) begin
		counter <= 'd3;
	end else begin
		if(enable) begin
			counter <= counter + 1;
		end else begin
			counter <= 'd0;
		end
	end
end
always@( posedge clk or negedge reset_n )begin
	if(!reset_n)begin
		outp <= 0;
	end else begin
		case(counter)
		  0:begin
			 outp <= zout[7:0];
		  end
			1:begin
			 outp <= zout[15:8];
			end
			2:begin
			 outp <= zout[23:16];
			end
			3:begin
			 outp <= z0;
			 zout <= {z3,z2,z1};
			end
		endcase
	end
end

S2 sbox3(
.Inp(inp),
.Outp(s2)
);

S1 sbox4(
.Inp(inp),
.Outp(s1)
);

endmodule

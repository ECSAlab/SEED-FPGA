
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

module SF_Function(
  input  clk,
  input  reset_n,
  input  [7:0] C,
  input  [7:0] D,
  input  [4:0] main_counter,
  output [7:0] Cn,
  output [7:0] Dn
  );



wire [7:0] G_OUT;


wire g_enable_cb = ( main_counter == 4
	|| main_counter == 5
	|| main_counter == 6
	|| main_counter == 7

    || main_counter == 8	
	|| main_counter == 9
	|| main_counter == 10
	|| main_counter == 11
	
	|| main_counter == 12
	|| main_counter == 13
	|| main_counter == 14
	|| main_counter == 15
	
	|| main_counter == 16
	|| main_counter == 0
    || main_counter == 1
    || main_counter == 2
	
	) ? 1'b1 : 1'b0;
	

  G_function fnG0(
  .clk(clk),
  .reset_n(reset_n),
  .inp(D),
  .outp(G_OUT),
  .enable(g_enable_cb)
  );

reg [7:0] reg_C0;
reg [7:0] reg_C1;
reg [7:0] reg_C2;
reg [7:0] reg_C3;


always @ ( posedge clk or negedge reset_n ) begin
	if(!reset_n) begin
		reg_C0  <= 0;
        reg_C1  <= 0;
        reg_C2  <= 0;
        reg_C3  <= 0;
       
	end else begin
        reg_C0  <= C;
        reg_C1  <= reg_C0;
        reg_C2  <= reg_C1;
        reg_C3  <= reg_C2;
      
	end
end

wire enable_cb = (
  ((main_counter>8)  & (main_counter<12))
||((main_counter>12) & (main_counter<16))
||(main_counter<3)
 )? 1'b1 : 1'b0; 
 
reg dff_carry;
wire carry_out;
wire carry_in = (enable_cb) ? dff_carry : 1'b0;
wire [7:0] Sum;


adder F_adder(
.A      (G_OUT),
.B      (reg_C3),
.c_in   (carry_in),
.Sum    (Sum),
.c_out  (carry_out)
 );

////////////////////////////////////////////////////////////////////////////

always @ ( posedge clk or negedge reset_n ) begin
  if(!reset_n)begin
    dff_carry  <= 0;   
  end else begin
    dff_carry  <= carry_out;
  end
end

assign Cn = Sum;
assign Dn = G_OUT;

endmodule

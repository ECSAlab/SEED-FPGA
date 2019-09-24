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

module subtractor(
input [7:0] A,
input [7:0] B,
input d_in,
output [7:0] Diff,
output d_out
    );
    
wire [8:0] D =  {1'b0,A} - {1'b0,B} - d_in;
  
assign Diff = D[7:0];
assign d_out = D[8];
      
endmodule

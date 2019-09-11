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
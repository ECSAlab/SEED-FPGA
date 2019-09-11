module adder(
input [7:0] A,
input [7:0] B,
input c_in,
output [7:0] Sum,
output c_out
    );
    
wire [8:0] S = (A + B + c_in) ; 
  
assign Sum = S[7:0];
assign c_out = S[8];
      
endmodule

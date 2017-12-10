`include "rc_add_sub_32.v"
// Name: mult.v
// Module: MULT32 , MULT32_U
//
// Output: HI: 32 higher bits
//         LO: 32 lower bits
//
//
// Input: A : 32-bit input
//        B : 32-bit input
//
// Notes: 32-bit multiplication
//
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

module MULT32(HI, LO, A, B);
  // output list
  output [31:0] HI;
  output [31:0] LO;
  // input list
  input [31:0] A;
  input [31:0] B;

  // TBD

endmodule

// 32-bits unsigned multiplier
// Output: HI: 32 higher bits
//         LO: 32 lower bits
//
// Input: A : 32-bit input
//        B : 32-bit input
module MULT32_U(HI, LO, A, B);
  // output list
  output [31:0] HI;
  output [31:0] LO;
  // input list
  input [31:0] A;
  input [31:0] B;

  wire [31:0][31:0] inner; //



endmodule

//32 bit parallel AND gates.
module AND32_ARRAY (Y, A, B);
  // output list
  output [31:0] Y;

  // input list
  input [31:0] A;
  input [31:0] B;

  genvar i;
  generate
    for (i=0;i<32;i=i+1)
    begin: and32_array_gen
      and and_inst(Y[i],A[i],B[i]);
    end
  endgenerate
endmodule

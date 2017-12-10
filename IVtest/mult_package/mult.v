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
  input [31:0] A; //MCND
  input [31:0] B; //MPLR

  wire [31:0] wire_And [31:0]; //output wires of AND gates.
  wire [31:0] wire_Add [31:0]; //output wires of Adders.
  wire [31:0] wire_cout;       //output wire of carry out.

  genvar i;
  //connect AND gates.
  generate
    for (i=0; i<32; i=i+1)
    begin: mult32_u_and_gen
      AND32_ARRAY AND32_INST (wire_And[i],A,{32{B[i]}});
    end
  endgenerate

  //adder[0]
  RC_ADD_SUB_32 ADD32_INST0 (wire_Add[0], wire_cout[0], {1'b0,wire_And[0][31:1]}, wire_And[1], 1'b0);

  //adder[1..29]
  generate
    for (i=1; i<30; i=i+1)
    begin: mult32_u_add_gen
      RC_ADD_SUB_32 ADD32_INST (wire_Add[i], wire_cout[i], {wire_cout[i-1],wire_Add[i-1][31:1]}, wire_And[i+1], 1'b0);
    end
  endgenerate

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

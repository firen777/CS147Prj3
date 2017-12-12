`include "rc_add_sub_32.v"
`include "logic.v"
`include "mux.v"
`ifndef _MULT_V_
`define _MULT_V_
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

  wire [31:0] wire_2comp1;  //complement of MCND
  wire [31:0] wire_2comp2;  //complement of MPLR
  wire [31:0] mcnd;         //MCND to used in unsigned
  wire [31:0] mplr;         //MPLR to used in unsigned
  wire [31:0] mult_u_HI;    //HI from unsigned
  wire [31:0] mult_u_LO;    //LO from unsigned
  wire [63:0] wire_2comp64; //complement of unsigned
  wire finalS;              //Selection for final 64bit 2x1 mux

  TWOSCOMP32 TCOMP32_1(wire_2comp1,A);
  TWOSCOMP32 TCOMP32_2(wire_2comp2,B);

  MUX32_2x1 M32_1(mcnd, A, wire_2comp1, A[31]);
  MUX32_2x1 M32_2(mplr, B, wire_2comp2, B[31]);

  MULT32_U MULT32_U_INST(mult_u_HI, mult_u_LO, mcnd, mplr);

  TWOSCOMP64 TWOSCOMP64_INST(wire_2comp64, {mult_u_HI, mult_u_LO});
  xor(finalS, A[31], B[31]);

  MUX32_2x1 M64_HI(HI, mult_u_HI, wire_2comp64[63:32], finalS);
  MUX32_2x1 M64_LO(LO, mult_u_LO, wire_2comp64[31:0], finalS);

endmodule

// 32-bits unsigned multiplier
module MULT32_U(HI, LO, A, B);
  // output list
  output [31:0] HI;
  output [31:0] LO;
  // input list
  input [31:0] A; //MCND
  input [31:0] B; //MPLR

  wire [31:0] wire_And [31:0]; //output wires of AND gates.
  wire [31:0] wire_Add [30:0]; //output wires of Adders.
  wire [30:0] wire_cout;       //output wire of carry out.

  genvar i;
  //connect AND gates.
  generate
    for (i=0; i<32; i=i+1)
    begin: mult32_u_and_gen
      AND32_2x1 AND32_2x1_INST (wire_And[i],A,{32{B[i]}});
    end
  endgenerate

  //adder[0]
  RC_ADD_SUB_32 ADD32_INST0 (wire_Add[0], wire_cout[0], {1'b0,wire_And[0][31:1]}, wire_And[1], 1'b0);

  //adder[1..30]
  generate
    for (i=1; i<31; i=i+1)
    begin: mult32_u_add_gen
      RC_ADD_SUB_32 ADD32_INST (wire_Add[i], wire_cout[i], {wire_cout[i-1],wire_Add[i-1][31:1]}, wire_And[i+1], 1'b0);
    end
  endgenerate
  //-----------------------------

  //write back to output:
  //LO[0]
  assign LO[0] = wire_And[0][0];
  //LO[1..31]
  generate
    for (i=1; i<32; i=i+1)
    begin: mult32_u_out_lo_gen
      assign LO[i] = wire_Add[i-1][0];
    end
  endgenerate
  //HI[0..31]
  assign HI = {wire_cout[30], wire_Add[30][31:1]};

endmodule

//------------------------------------------------------------------------------------------
`endif

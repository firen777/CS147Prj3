`include "mult.v"
`include "barrel_shifter.v"
`include "rc_add_sub_32.v"
`include "mux.v"
`include "logic_32_bit.v"
`ifndef _ALU_V_
`define _ALU_V_
// Name: alu.v
// Module: ALU
// Input: OP1[32] - operand 1
//        OP2[32] - operand 2
//        OPRN[6] - operation code
// Output: OUT[32] - output result for the operation
//
// Notes: 32 bit combinatorial ALU
//
// Supports the following functions
//	- Integer add (0x1), sub(0x2), mul(0x3)
//	- Integer shift_rigth (0x4), shift_left (0x5)
//	- Bitwise and (0x6), or (0x7), nor (0x8)
//  - set less than (0x9)
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
//
`include "prj_definition.v"

module ALU(OUT, ZERO, OP1, OP2, OPRN);
  // input list
  input [`DATA_INDEX_LIMIT:0] OP1; // operand 1           //[31:0]
  input [`DATA_INDEX_LIMIT:0] OP2; // operand 2           //[31:0]
  input [`ALU_OPRN_INDEX_LIMIT:0] OPRN; // operation code //[5:0]

  // output list
  output [`DATA_INDEX_LIMIT:0] OUT; // result of the operation.
  output ZERO;

  // internal wire list
  wire [31:0] w_mul_out_HI;         // HI of multiplier
  wire [31:0] w_mul_out_LO;         // LO of multiplier
  wire [31:0] w_shf_out;            // result of shifter
  wire [31:0] w_add_out;            // result of adder
  wire [31:0] w_AND_out;            // result of AND
  wire [31:0] w_OR_out;             // result of OR
  wire [31:0] w_NOR_out;            // result of NOR
  wire [31:0] F;                    // final mux result

  wire w_not_OPRN0;                 // !OPRN[0]
  wire w_OPRN3and0;                 // OPRN[3] & OPRN[0]
  wire w_SnA_select;                // SnA input: !OPRN[0] | (OPRN[3] & OPRN[0])

  wire cout;                        // adder carry out

  // multiplier
  MULT32 MULT32_INST(.HI(w_mul_out_HI), .LO(w_mul_out_LO), .A(OP1), .B(OP2));
  // shifter
  SHIFT32 SHIFT32_INST(.Y(w_shf_out), .D(OP1), .S(OP2), .LnR(OPRN[0]));

  //adder
  not not_inst(w_not_OPRN0, OPRN[0]);
  and and_inst(w_OPRN3and0, OPRN[0], OPRN[3]);
  or  or_inst (w_SnA_select, w_not_OPRN0, w_OPRN3and0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_INST(.Y(w_add_out), .CO(cout), .A(OP1), .B(OP2), .SnA(w_SnA_select));

  // 32bit AND
  AND32_2x1 AND32_2x1_INST(w_AND_out, OP1, OP2);
  // 32bit OR
  OR32_2x1   OR32_2x1_INST(w_OR_out , OP1, OP2);
  // 32bit NOR
  NOR32_2x1 NOR32_2x1_INST(w_NOR_out, OP1, OP2);

  MUX32_16x1 MUX32_16x1_INST(.Y(F),
                             .I0(),
                             .I1(w_add_out),
                             .I2(w_add_out),
                             .I3(w_mul_out_LO),
                             .I4(w_shf_out),
                             .I5(w_shf_out),
                             .I6(w_AND_out),
                             .I7(w_OR_out),
                             .I8(w_NOR_out),
                             .I9({31'b0, w_add_out[31]}),
                             .I10(), .I11(), .I12(), .I13(), .I14(), .I15(),
                             .S(OPRN[3:0]));
  // Final data:
  nor nor_zero_inst(ZERO, F[0], F[8], F[16], F[24],
                          F[1], F[9], F[17], F[25],
                          F[2], F[10], F[18], F[26],
                          F[3], F[11], F[19], F[27],
                          F[4], F[12], F[20], F[28],
                          F[5], F[13], F[21], F[29],
                          F[6], F[14], F[22], F[30],
                          F[7], F[15], F[23], F[31] );
  assign OUT = F;

endmodule

//------------------------------------------------------------------------------------------
`endif

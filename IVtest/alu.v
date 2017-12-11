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

  wire w_not_OPRN0;                 // !OPRN[0]
  wire w_OPRN3and0;                 // OPRN[3] & OPRN[0]
  wire w_SnA_select;                // SnA input: !OPRN[0] | (OPRN[3] & OPRN[0])

  wire cout;                        // adder carry out

  // multiplier
  MULT32 MULT32_INST(w_mul_out_HI, w_mul_out_LO, OP1, OP2);
  // shifter
  SHIFT32 SHIFT32_INST(w_shf_out, OP1, OP2, OPRN[0]);

  //adder
  not not_inst(w_not_OPRN0, OPRN[0]);
  and and_inst(w_OPRN3and0, OPRN[0], OPRN[3]);
  or  or_inst (w_SnA_select, w_not_OPRN0, w_OPRN3and0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_INST(w_add_out, cout, OP1, OP2, w_SnA_select);

  // 32bit AND
  AND32_2x1 AND32_2x1_INST(w_AND_out, OP1, OP2);
  // 32bit OR
  OR32_2x1   OR32_2x1_INST(w_OR_out , OP1, OP2);
  // 32bit NOR
  NOR32_2x1 NOR32_2x1_INST(w_NOR_out, OP1, OP2);



endmodule

//------------------------------------------------------------------------------------------
`endif

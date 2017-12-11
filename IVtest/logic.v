`include "logic_32_bit.v"
`include "rc_add_sub_32.v"
`ifndef _LOGIC_V_
`define _LOGIC_V_
// Name: logic.v
// Module:
// Input:
// Output:
//
// Notes: Common definitions
//
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 02, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
//
// 64-bit two's complement
module TWOSCOMP64(Y,A);
  //output list
  output [63:0] Y;
  //input list
  input [63:0] A;

  wire [63:0] notA; //!A
  wire CO; //dummy wire

  INV32_1x1 INV32_1x1_INST1(notA[31:0],A[31:0]);
  INV32_1x1 INV32_1x1_INST2(notA[63:32],A[63:32]);

  RC_ADD_SUB_64 RC_ADD_SUB_64_INST(Y, CO, notA, 64'h0000000000000001, 1'b0);

endmodule

// 32-bit two's complement
module TWOSCOMP32(Y,A);
  //output list
  output [31:0] Y;
  //input list
  input [31:0] A;

  wire [31:0] notA; //!A
  wire CO; //dummy wire

  INV32_1x1 INV32_1x1_INST(notA,A);

  RC_ADD_SUB_32 RC_ADD_SUB_32_INST(Y, CO, notA, 32'h00000001, 1'b0);

endmodule

// 32-bit registere +ve edge, Reset on RESET=0
module REG32(Q, D, LOAD, CLK, RESET);
  output [31:0] Q;

  input CLK, LOAD;
  input [31:0] D;
  input RESET;

  // TBD

endmodule

// 1 bit register +ve edge,
// Preset on nP=0, nR=1, reset on nP=1, nR=0;
// Undefined nP=0, nR=0
// normal operation nP=1, nR=1
module REG1(Q, Qbar, D, L, C, nP, nR);
  input D, C, L;
  input nP, nR;
  output Q,Qbar;

  // TBD

endmodule

// 1 bit flipflop +ve edge,
// Preset on nP=0, nR=1, reset on nP=1, nR=0;
// Undefined nP=0, nR=0
// normal operation nP=1, nR=1
module D_FF(Q, Qbar, D, C, nP, nR);
  input D, C;
  input nP, nR;
  output Q,Qbar;

  wire w_notC;  //!CLK
  wire w_DQ;    //Q from D Latch
  wire w_DnQ;   //!Q from D Latch

  not not_inst(w_notC, C);
  D_LATCH D_LATCH_INST(.Q(w_DQ), .Qbar(w_DnQ), .D(D), .C(w_notC), .nP(nP), .nR(nR));
  SR_LATCH SR_LATCH_INST(.Q(Q), .Qbar(Qbar), .S(w_DQ), .R(w_DnQ), .C(C), .nP(nP), .nR(nR));

endmodule

// 1 bit D latch
// Preset on nP=0, nR=1, reset on nP=1, nR=0;
// Undefined nP=0, nR=0
// normal operation nP=1, nR=1
module D_LATCH(Q, Qbar, D, C, nP, nR);
  input D, C;
  input nP, nR;
  output Q,Qbar;

  wire w_0_0;     //output from first level, first nand
  wire w_0_1;     //output from first level, second nand
  wire w_1_0;     //output from second level, first nand
  wire w_1_1;     //output from second level, second nand
  wire not_D;     //!D

  not not_inst(not_D, D);
  nand nand_lvl0_0(w_0_0, D, C);
  nand nand_lvl0_1(w_0_1, not_D, C);
  nand nand_lvl1_0(w_1_0, nP, w_0_0, w_1_1);
  nand nand_lvl1_0(w_1_1, nR, w_0_1, w_1_0);

  assign Q = w_1_0;
  assign Qbar = w_1_1;

endmodule

// 1 bit SR latch
// Preset on nP=0, nR=1, reset on nP=1, nR=0;
// Undefined nP=0, nR=0
// normal operation nP=1, nR=1
module SR_LATCH(Q,Qbar, S, R, C, nP, nR);
  input S, R, C;
  input nP, nR;
  output Q,Qbar;

  wire w_0_0;     //output from first level, first nand
  wire w_0_1;     //output from first level, second nand
  wire w_1_0;     //output from second level, first nand
  wire w_1_1;     //output from second level, second nand

  nand nand_lvl0_0(w_0_0, S, C);
  nand nand_lvl0_1(w_0_1, R, C);
  nand nand_lvl1_0(w_1_0, nP, w_0_0, w_1_1);
  nand nand_lvl1_0(w_1_1, nR, w_0_1, w_1_0);

  assign Q = w_1_0;
  assign Qbar = w_1_1;

endmodule

// 5x32 Line decoder
module DECODER_5x32(D,I);
  // output
  output [31:0] D;
  // input
  input [4:0] I;

  // TBD

endmodule

// 4x16 Line decoder
module DECODER_4x16(D,I);
  // output
  output [15:0] D;
  // input
  input [3:0] I;

  // TBD


endmodule

// 3x8 Line decoder
module DECODER_3x8(D,I);
  // output
  output [7:0] D;
  // input
  input [2:0] I;

  //TBD


endmodule

// 2x4 Line decoder
module DECODER_2x4(D,I);
  // output
  output [3:0] D;
  // input
  input [1:0] I;

  // TBD

endmodule

//------------------------------------------------------------------------------------------
`endif

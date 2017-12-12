`include "mux.v"
`ifndef _BARREL_SHIFTER_V_
`define _BARREL_SHIFTER_V_

// Name: barrel_shifter.v
// Module: SHIFT32_L , SHIFT32_R, SHIFT32
//
// Notes: 32-bit barrel shifter
//
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

// 32-bit shift amount shifter
module SHIFT32(Y,D,S, LnR);
  // output list
  output [31:0] Y;
  // input list
  input [31:0] D;
  input [31:0] S;
  input LnR;

  wire [31:0] wire_shift; //shifter result
  wire wire_or;           //or([31:5])

  BARREL_SHIFTER32 B_S32_INST(wire_shift, D, S[4:0], LnR);

  or or_inst(wire_or, S[5], S[6], S[7], S[8], S[9],
                      S[10], S[11], S[12], S[13], S[14],
                      S[15], S[16], S[17], S[18], S[19],
                      S[20], S[21], S[22], S[23], S[24],
                      S[25], S[26], S[27], S[28], S[29], S[30], S[31]);


  MUX32_2x1 M32_INST(Y, wire_shift, 32'h0, wire_or);

endmodule

// Shift with control L or R shift
module BARREL_SHIFTER32(Y,D,S, LnR);
  // output list
  output [31:0] Y;
  // input list
  input [31:0] D;
  input [4:0] S;
  input LnR;       //L=1, R=0

  wire [31:0] w_L; //result from LShift
  wire [31:0] w_R; //result from RShift

  SHIFT32_R SR_INST(w_R,D,S);
  SHIFT32_L SL_INST(w_L,D,S);

  MUX32_2x1 M32(Y, w_R, w_L, LnR);

endmodule

// Right shifter
module SHIFT32_R(Y,D,S);
  // output list
  output [31:0] Y;
  // input list
  input [31:0] D;
  input [4:0] S;

  // wire between mux
  wire [31:0] w_0to1;
  wire [31:0] w_1to2;
  wire [31:0] w_2to3;
  wire [31:0] w_3to4;

  MUX32_2x1 M32_0(w_0to1, D     , {1'b0,D[31:1]}, S[0]); //>>1
  MUX32_2x1 M32_1(w_1to2, w_0to1, {2'b0,w_0to1[31:2]}, S[1]); //>>2
  MUX32_2x1 M32_2(w_2to3, w_1to2, {4'b0,w_1to2[31:4]}, S[2]); //>>4
  MUX32_2x1 M32_3(w_3to4, w_2to3, {8'b0,w_2to3[31:8]}, S[3]); //>>8
  MUX32_2x1 M32_4(Y     , w_3to4, {16'b0,w_3to4[31:16]}, S[4]); //>>16

endmodule

// Left shifter
module SHIFT32_L(Y,D,S);
  // output list
  output [31:0] Y;
  // input list
  input [31:0] D;
  input [4:0] S;
  // wire between mux
  wire [31:0] w_0to1;
  wire [31:0] w_1to2;
  wire [31:0] w_2to3;
  wire [31:0] w_3to4;

  MUX32_2x1 M32_0(w_0to1, D     , {D[30:0],1'b0}, S[0]); //<<1
  MUX32_2x1 M32_1(w_1to2, w_0to1, {w_0to1[29:0],2'b0}, S[1]); //<<2
  MUX32_2x1 M32_2(w_2to3, w_1to2, {w_1to2[27:0],4'b0}, S[2]); //<<4
  MUX32_2x1 M32_3(w_3to4, w_2to3, {w_2to3[23:0],8'b0}, S[3]); //<<8
  MUX32_2x1 M32_4(Y     , w_3to4, {w_3to4[15:0],16'b0}, S[4]); //<<16


endmodule

//------------------------------------------------------------------------------------------
`endif

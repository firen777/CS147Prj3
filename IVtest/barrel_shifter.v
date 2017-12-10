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
  wire [30:5] wire_or;           //or([31:5])

  BARREL_SHIFTER32 B_S32_INST(Y, D, S[4:0], LnR);

  genvar i;
  generate
    for (i=5; i<31; i=i+1)
    begin: shift32_gen
      or or_inst(wire_or[i], S[i], S[i+1]);
    end
  endgenerate

  MUX32_2x1 M32_INST(Y, wire_shift, 32'h0, wire_or[30]);

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

  MUX32_2x1 M32_0(w_0to1, D     , {1b'0,D[30:0]}, S[0]); //>>1
  MUX32_2x1 M32_1(w_1to2, w_0to1, {2b'0,w_0to1[29:0]}, S[1]); //>>2
  MUX32_2x1 M32_2(w_2to3, w_1to2, {4b'0,w_1to2[27:0]}, S[2]); //>>4
  MUX32_2x1 M32_3(w_3to4, w_2to3, {8b'0,w_2to3[23:0]}, S[3]); //>>8
  MUX32_2x1 M32_4(Y     , w_3to4, {16b'0,w_3to4[15:0]}, S[4]); //>>16

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

  MUX32_2x1 M32_0(w_0to1, D     , {D[31:1],1b'0}, S[0]); //<<1
  MUX32_2x1 M32_1(w_1to2, w_0to1, {w_0to1[31:2],2b'0}, S[1]); //<<2
  MUX32_2x1 M32_2(w_2to3, w_1to2, {w_1to2[31:4],4b'0}, S[2]); //<<4
  MUX32_2x1 M32_3(w_3to4, w_2to3, {w_2to3[31:8],8b'0}, S[3]); //<<8
  MUX32_2x1 M32_4(Y     , w_3to4, {w_3to4[31:16],16b'0}, S[4]); //<<16

endmodule

//------------------------------------------------------------------------------------------
`endif

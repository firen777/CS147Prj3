`include "half_adder.v"
`ifndef _FULL_ADDER_V_
`define _FULL_ADDER_V_
// Name: full_adder.v
// Module: FULL_ADDER
//
// Output: S : Sum
//         CO : Carry Out
//
// Input: A : Bit 1
//        B : Bit 2
//        CI : Carry In
//
// Notes: 1-bit full adder implementaiton.
//
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

module FULL_ADDER(S,CO,A,B, CI);
output S,CO;
input A,B, CI;
wire Y1, C1, C2;

HALF_ADDER H1(Y1,C1,A,B);
HALF_ADDER H2(S,C2,Y1,CI);
or(CO,C2,C1);

endmodule

//------------------------------------------------------------------------------------------
`endif

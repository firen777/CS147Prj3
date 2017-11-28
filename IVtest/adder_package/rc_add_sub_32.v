`include "full_adder.v"
// Name: rc_add_sub_32.v
// Module: RC_ADD_SUB_32
//
// Output: Y : Output 32-bit
//         CO : Carry Out
//
//
// Input: A : 32-bit input
//        B : 32-bit input
//        SnA : if SnA=0 it is add, subtraction otherwise
//
// Notes: 32-bit adder / subtractor implementaiton.
//
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

module RC_ADD_SUB_64(Y, CO, A, B, SnA);
// output list
output [63:0] Y;
output CO;
// input list
input [63:0] A;
input [63:0] B;
input SnA;

// TBD

endmodule

module RC_ADD_SUB_32(Y, CO, A, B, SnA);
// output list
output [`DATA_INDEX_LIMIT:0] Y;
output CO;
// input list
input [`DATA_INDEX_LIMIT:0] A;
input [`DATA_INDEX_LIMIT:0] B;
input SnA;

wire [`DATA_INDEX_LIMIT:0] carryWire; //ripple carry wire
wire [`DATA_INDEX_LIMIT:0] subWire; //B xor SnA, for subtraction


//XOR array for subtraction:
genvar i;
generate
  for (i=0; i<32; i=i+1)
  begin: add_sub_32_xor_gen
    xor xor_inst(subWire[i],B[i],SnA);
  end
endgenerate

//module FULL_ADDER(S,CO,A,B, CI);
//first full_adder
FULL_ADDER F1(Y[0],carryWire[0],A[0],subWire[0],SnA);

//full_adder array [1..30]
generate
  for (i=1; i<32; i=i+1)
  begin: add_sub_32_adder_gen
    FULL_ADDER FULL_ADDER_INST(Y[i],carryWire[i],A[i],subWire[i],carryWire[i-1]);
  end
endgenerate

assign CO = carryWire[31];

endmodule

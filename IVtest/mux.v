`ifndef _MUX_V_
`define _MUX_V_
// Name: mux.v
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

// 32-bit 32x1 mux
module MUX32_32x1(Y, I0, I1, I2, I3, I4, I5, I6, I7,
                     I8, I9, I10, I11, I12, I13, I14, I15,
                     I16, I17, I18, I19, I20, I21, I22, I23,
                     I24, I25, I26, I27, I28, I29, I30, I31, S);
  // output list
  output [31:0] Y;
  //input list
  input [31:0] I0, I1, I2, I3, I4, I5, I6, I7;
  input [31:0] I8, I9, I10, I11, I12, I13, I14, I15;
  input [31:0] I16, I17, I18, I19, I20, I21, I22, I23;
  input [31:0] I24, I25, I26, I27, I28, I29, I30, I31;
  input [4:0] S;

  genvar i;
  generate
    for (i=0;i<32;i=i+1)
    begin: mux32_32x1_gen
      MUX1_32x1 MUX1_32x1_INST(Y[i],I0[i],I1[i],I2[i],I3[i],I4[i],I5[i],I6[i],I7[i],
                                    I8[i],I9[i],I10[i],I11[i],I12[i],I13[i],I14[i],I15[i],
                                    I16[i],I17[i],I18[i],I19[i],I20[i],I21[i],I22[i],I23[i],
                                    I24[i],I25[i],I26[i],I27[i],I28[i],I29[i],I30[i],I31[i],S);
    end
  endgenerate

endmodule

// 1-bit 32x1 mux
module MUX1_32x1(Y, I0, I1, I2, I3, I4, I5, I6, I7,
                    I8, I9, I10, I11, I12, I13, I14, I15,
                    I16, I17, I18, I19, I20, I21, I22, I23,
                    I24, I25, I26, I27, I28, I29, I30, I31, S);
  // output list
  output Y;
  // input list
  input I0, I1, I2, I3, I4, I5, I6, I7,
        I8, I9, I10, I11, I12, I13, I14, I15,
        I16, I17, I18, I19, I20, I21, I22, I23,
        I24, I25, I26, I27, I28, I29, I30, I31;
  input [4:0] S;
  // wire list
  wire a, b, c;

  MUX1_16x1 M1a(a, I0, I1, I2, I3, I4, I5, I6, I7,
                   I8, I9, I10, I11, I12, I13, I14, I15, S[3:0]);
  MUX1_16x1 M1b(b, I16, I17, I18, I19, I20, I21, I22, I23,
                   I24, I25, I26, I27, I28, I29, I30, I31, S[3:0]);
  MUX1_2x1 M2(Y,a,b,S[4]);

endmodule

// 32-bit 16x1 mux
module MUX32_16x1(Y, I0, I1, I2, I3, I4, I5, I6, I7,
                     I8, I9, I10, I11, I12, I13, I14, I15, S);
  // output list
  output [31:0] Y;
  //input list
  input [31:0] I0;
  input [31:0] I1;
  input [31:0] I2;
  input [31:0] I3;
  input [31:0] I4;
  input [31:0] I5;
  input [31:0] I6;
  input [31:0] I7;
  input [31:0] I8;
  input [31:0] I9;
  input [31:0] I10;
  input [31:0] I11;
  input [31:0] I12;
  input [31:0] I13;
  input [31:0] I14;
  input [31:0] I15;
  input [3:0] S;

  genvar i;
  generate
    for (i=0;i<32;i=i+1)
    begin: mux32_16x1_gen
      MUX1_16x1 MUX1_16x1_INST(Y[i],I0[i],I1[i],I2[i],I3[i],I4[i],I5[i],I6[i],I7[i],
                                    I8[i],I9[i],I10[i],I11[i],I12[i],I13[i],I14[i],I15[i],S);
    end
  endgenerate

endmodule

// 1-bit 16x1 mux
module MUX1_16x1(Y, I0, I1, I2, I3, I4, I5, I6, I7,
                    I8, I9, I10, I11, I12, I13, I14, I15, S);
  // output list
  output Y;
  // input list
  input I0, I1, I2, I3, I4, I5, I6, I7,
        I8, I9, I10, I11, I12, I13, I14, I15;
  input [3:0] S;
  // wire list
  wire a, b, c;

  MUX1_8x1 M1a(a, I0, I1, I2, I3, I4, I5, I6, I7, S[2:0]);
  MUX1_8x1 M1b(b, I8, I9, I10, I11, I12, I13, I14, I15, S[2:0]);
  MUX1_2x1 M2(Y,a,b,S[3]);

endmodule

// 32-bit 8x1 mux
module MUX32_8x1(Y, I0, I1, I2, I3, I4, I5, I6, I7, S);
  // output list
  output [31:0] Y;
  //input list
  input [31:0] I0;
  input [31:0] I1;
  input [31:0] I2;
  input [31:0] I3;
  input [31:0] I4;
  input [31:0] I5;
  input [31:0] I6;
  input [31:0] I7;
  input [2:0] S;

  genvar i;
  generate
    for (i=0;i<32;i=i+1)
    begin: mux32_8x1_gen
      MUX1_8x1 MUX1_8x1_INST(Y[i],I0[i],I1[i],I2[i],I3[i],I4[i],I5[i],I6[i],I7[i],S);
    end
  endgenerate

endmodule

// 1-bit 8x1 mux
module MUX1_8x1(Y, I0, I1, I2, I3, I4, I5, I6, I7, S);
  // output list
  output Y;
  // input list
  input I0, I1, I2, I3, I4, I5, I6, I7;
  input [2:0] S;
  // wire list
  wire a, b, c;

  MUX1_4x1 M1a(a,I0, I1, I2, I3,S[1:0]);
  MUX1_4x1 M1b(b,I4, I5, I6, I7,S[1:0]);
  MUX1_2x1 M2(Y,a,b,S[2]);

endmodule

// 32-bit 4x1 mux
module MUX32_4x1(Y, I0, I1, I2, I3, S);
  // output list
  output [31:0] Y;
  //input list
  input [31:0] I0;
  input [31:0] I1;
  input [31:0] I2;
  input [31:0] I3;
  input [1:0] S;

  genvar i;
  generate
    for (i=0;i<32;i=i+1)
    begin: mux32_4x1_gen
      MUX1_4x1 MUX1_4x1_INST(Y[i],I0[i],I1[i],I2[i],I3[i],S);
    end
  endgenerate

endmodule

// 1-bit 4x1 mux
module MUX1_4x1(Y, I0, I1, I2, I3, S);
  // output list
  output Y;
  // input list
  input I0, I1, I2, I3;
  input [1:0] S;
  // wire list
  wire a, b;

  MUX1_2x1 M1a(a,I0,I1,S[0]);
  MUX1_2x1 M1b(b,I2,I3,S[0]);
  MUX1_2x1 M2(Y,a,b,S[1]);

endmodule

// 32-bit 2x1 mux
module MUX32_2x1(Y, I0, I1, S);
  // output list
  output [31:0] Y;
  //input list
  input [31:0] I0;
  input [31:0] I1;
  input S;
  genvar i;
  generate
    for (i=0;i<32;i=i+1)
    begin: mux32_2x1_gen
      MUX1_2x1 MUX1_2x1_INST(Y[i],I0[i],I1[i],S);
    end
  endgenerate
endmodule

// 1-bit 2x1 mux
module MUX1_2x1(Y,I0, I1, S);
  //output list
  output Y;
  //input list
  input I0, I1, S;
  //internal wire
  wire notS, I0nNS, I1nS;

  not(notS, S);
  and(I0nNS, notS, I0);
  and(I1nS, S, I1);
  or(Y,I0nNS,I1nS);

endmodule

//------------------------------------------------------------------------------------------
`endif

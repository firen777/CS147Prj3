`include "logic.v"
`include "mux.v"
`ifndef _REGISTER_FILE_V_
`define _REGISTER_FILE_V_
// Name: register_file.v
// Module: REGISTER_FILE_32x32
// Input:  DATA_W : Data to be written at address ADDR_W
//         ADDR_W : Address of the memory location to be written
//         ADDR_R1 : Address of the memory location to be read for DATA_R1
//         ADDR_R2 : Address of the memory location to be read for DATA_R2
//         READ    : Read signal
//         WRITE   : Write signal
//         CLK     : Clock signal
//         RST     : Reset signal
// Output: DATA_R1 : Data at ADDR_R1 address
//         DATA_R2 : Data at ADDR_R1 address
//
// Notes: - 32 bit word accessible dual read register file having 32 regsisters.
//        - Reset is done at -ve edge of the RST signal
//        - Rest of the operation is done at the +ve edge of the CLK signal
//        - Read operation is done if READ=1 and WRITE=0
//        - Write operation is done if WRITE=1 and READ=0
//        - X is the value at DATA_R* if both READ and WRITE are 0 or 1
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
//
`include "prj_definition.v"

// This is going to be +ve edge clock triggered register file.
// Reset on RST=0
module REGISTER_FILE_32x32(DATA_R1, DATA_R2, ADDR_R1, ADDR_R2,
                            DATA_W, ADDR_W, READ, WRITE, CLK, RST);

  // input list
  input READ, WRITE, CLK, RST;
  input [`DATA_INDEX_LIMIT:0] DATA_W;
  input [`REG_ADDR_INDEX_LIMIT:0] ADDR_R1, ADDR_R2, ADDR_W;

  // output list
  output [`DATA_INDEX_LIMIT:0] DATA_R1;
  output [`DATA_INDEX_LIMIT:0] DATA_R2;

  wire nRST;    //!RST, such that reset on 1.
  wire [`DATA_INDEX_LIMIT:0] w_5x32;    //output of 5x32 decoder
  wire [`DATA_INDEX_LIMIT:0] w_load;    //output of w_5x32 & WRITE
  wire [`DATA_INDEX_LIMIT:0] rQ [`DATA_INDEX_LIMIT:0]; //Q of reg32s
  wire [`DATA_INDEX_LIMIT:0] w_r1;      //ADDR_R1
  wire [`DATA_INDEX_LIMIT:0] w_r2;      //ADDR_R2
  genvar i;

  //decode write address
  DECODER_5x32 DECODER_5x32_INST(.D(w_5x32), .I(ADDR_W));
  generate
    for(i=0;i<32;i=i+1)
    begin: register_file_w_decode_gen
      and and_inst(w_load[i], w_5x32[i], WRITE);
    end
  endgenerate

  //init 32x reg32
  not not_inst(nRST, RST);
  generate
    for(i=0;i<32;i=i+1)
    begin: register_file_reg32_gen
      REG32 REG32_INST(.Q(rQ[i]),
                       .D(DATA_W),
                       .LOAD(w_load[i]),
                       .CLK(CLK),
                       .RESET(RST));     //nRST ? RST ?
    end
  endgenerate

  //ADDR_R1 selection
  MUX32_32x1 MUX32_32x1_INST1(w_r1, rQ[0], rQ[1], rQ[2], rQ[3], rQ[4], rQ[5], rQ[6], rQ[7],
                                    rQ[8], rQ[9], rQ[10], rQ[11], rQ[12], rQ[13], rQ[14], rQ[15],
                                    rQ[16], rQ[17], rQ[18], rQ[19], rQ[20], rQ[21], rQ[22], rQ[23],
                                    rQ[24], rQ[25], rQ[26], rQ[27], rQ[28], rQ[29], rQ[30], rQ[31], ADDR_R1);
  //ADDR_R2 selection
  MUX32_32x1 MUX32_32x1_INST2(w_r2, rQ[0], rQ[1], rQ[2], rQ[3], rQ[4], rQ[5], rQ[6], rQ[7],
                                    rQ[8], rQ[9], rQ[10], rQ[11], rQ[12], rQ[13], rQ[14], rQ[15],
                                    rQ[16], rQ[17], rQ[18], rQ[19], rQ[20], rQ[21], rQ[22], rQ[23],
                                    rQ[24], rQ[25], rQ[26], rQ[27], rQ[28], rQ[29], rQ[30], rQ[31], ADDR_R2);

  //READ enable
  MUX32_2x1 MUX32_2x1_INST1 (DATA_R1, 32'bZ, w_r1, READ);
  MUX32_2x1 MUX32_2x1_INST2 (DATA_R2, 32'bZ, w_r2, READ);
  // high Z: 32'bZ
endmodule

//------------------------------------------------------------------------------------------
`endif

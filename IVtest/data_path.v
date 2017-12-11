`include "alu.v"
`include "logic.v"
`include "mux.v"
`include "register_file.v"
`include "rc_add_sub_32.v"
`ifndef _DATH_PATH_V_
`define _DATH_PATH_V_
// Name: data_path.v
// Module: DATA_PATH
// Output:  DATA : Data to be written at address ADDR
//          ADDR : Address of the memory location to be accessed
//
// Input:   DATA : Data read out in the read operation
//          CLK  : Clock signal
//          RST  : Reset signal
//
// Notes: - 32 bit processor implementing cs147sec05 instruction set
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
//
`include "prj_definition.v"
  module DATA_PATH(DATA_OUT, ADDR, ZERO, INSTRUCTION, DATA_IN, CTRL, CLK, RST);

  // output list
  output [`ADDRESS_INDEX_LIMIT:0] ADDR;
  output ZERO;
  output [`DATA_INDEX_LIMIT:0] DATA_OUT, INSTRUCTION;

  // input list
  input [`CTRL_WIDTH_INDEX_LIMIT:0]  CTRL;
  input CLK, RST;
  input [`DATA_INDEX_LIMIT:0] DATA_IN;

  wire [`DATA_INDEX_LIMIT:0] pc_Q;
  wire [`DATA_INDEX_LIMIT:0] pc_D;
  wire pc_load;
  REG32 pc_inst(.Q(pc_Q), .D(pc_D), .LOAD(pc_load), .CLK(CLK), .RESET(RST));  //Flag: RST or nRST?

  wire [`DATA_INDEX_LIMIT:0] pc_plus_one;
  RC_ADD_SUB_32 pc_increment_inst(.Y(pc_plus_one), .CO(), .A(pc_Q), .B(32'h00000001), .SnA(1'b0));

  wire [`DATA_INDEX_LIMIT:0] pc_sel_1_out
  wire pc_sel_1;
  MUX32_2x1 pc_sel_1_mux_inst(Y, I0, I1, S);
endmodule
//------------------------------------------------------------------------------------------
`endif

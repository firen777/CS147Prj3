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
  output [`ADDRESS_INDEX_LIMIT:0] ADDR; //[25:0]
  output ZERO;
  output [`DATA_INDEX_LIMIT:0] DATA_OUT, INSTRUCTION; //[31:0]

  // input list
  input [`CTRL_WIDTH_INDEX_LIMIT:0]  CTRL; //[31:0]
  input CLK, RST;
  input [`DATA_INDEX_LIMIT:0] DATA_IN; //[31:0]

  //[0]pc_load
  wire [`DATA_INDEX_LIMIT:0] pc_Q;
    wire [`DATA_INDEX_LIMIT:0] pc_D;
    wire pc_load;
    REG32 pc_inst(.Q(pc_Q), .D(pc_D), .LOAD(pc_load), .CLK(CLK), .RESET(RST));  //Danger Flag: RST or nRST?
    wire [`DATA_INDEX_LIMIT:0] pc_plus_one;
    RC_ADD_SUB_32 pc_increment_inst(.Y(pc_plus_one), .CO(), .A(pc_Q), .B(32'h00000001), .SnA(1'b0));

  //[1]pc_sel_1
  wire [`DATA_INDEX_LIMIT:0] pc_sel_1_out;
    wire pc_sel_1;
    wire [`DATA_INDEX_LIMIT:0] pc_sel_1_i0;
    MUX32_2x1 pc_sel_1_mux_inst(.Y(pc_sel_1_out), .I0(pc_sel_1_i0), .I1(pc_plus_one), .S(pc_sel_1));

  //[2]pc_sel_2
  wire [`DATA_INDEX_LIMIT:0] pc_sel_2_out;
    wire pc_sel_2;
    wire [`DATA_INDEX_LIMIT:0] pc_sel_2_i1;
    MUX32_2x1 pc_sel_2_mux_inst(.Y(pc_sel_2_out), .I0(pc_sel_1_out), .I1(pc_sel_2_i1), .S(pc_sel_2));

  //[3]pc_sel_3
  wire [`DATA_INDEX_LIMIT:0] pc_sel_3_out;
    wire pc_sel_3;
    wire [`DATA_INDEX_LIMIT:0] pc_sel_3_i0;
    MUX32_2x1 pc_sel_3_mux_inst(.Y(pc_sel_3_out), .I0(pc_sel_3_i0), .I1(pc_sel_2_out), .S(pc_sel_3));

  //[4]ir_load
  wire ir_load;
    wire [`DATA_INDEX_LIMIT:0] ir_Q;
    wire [`DATA_INDEX_LIMIT:0] ir_D;
    REG32 ir_inst(.Q(ir_Q), .D(ir_D), .LOAD(ir_load), .CLK(CLK), .RESET(RST));  //Danger Flag: RST or nRST?

  //parsing
  wire [5:0] opcode, funct;
    wire [4:0] rs, rt, rd, shamt;
    wire [15:0] imm;
    wire [25:0] addr;
    assign opcode = ir_Q[31:26];
    assign rs = ir_Q[25:21];
    assign rt = ir_Q[20:16];
    assign rd = ir_Q[15:11];
    assign shamt = ir_Q[10:6];
    assign funct = ir_Q[5:0];
    assign imm = ir_Q[15:0];
    assign addr = ir_Q[25:0];


  //[5]mem_r

  //[6]mem_w

  //[7]r1_sel_1
  wire r1_sel_1;
    wire [31:0] r1_sel_1_out;
    MUX32_2x1 r1_sel_1_mux_inst(.Y(r1_sel_1_out), .I0({27'b0,rs}), .I1(32'b0), .S(r1_sel_1));

  //[8]reg_r
  //[9]reg_w
  //[10]wa_sel_1
  //[11]wa_sel_2
  //[12]wa_sel_3
  //[13]wd_sel_1
  //[14]wd_sel_2
  //[15]wd_sel_3
  //[16]sp_load
  //[17]op1_sel_1
  //[18]op2_sel_1
  //[19]op2_sel_2
  //[20]op2_sel_3
  //[21]op2_sel_4
  //[22:25]alu_oprn
  //[26]ma_sel_1
  //[27]ma_sel_2
  //[28]md_sel_1



endmodule
//------------------------------------------------------------------------------------------
`endif

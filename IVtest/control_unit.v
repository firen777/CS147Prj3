`include "data_path.v"
`ifndef _CONTROL_UNIT_V_
`define _CONTROL_UNIT_V_
// Name: control_unit.v
// Module: CONTROL_UNIT
// Output: CTRL  : Control signal for data path
//         READ  : Memory read signal
//         WRITE : Memory Write signal
//
// Input:  ZERO : Zero status from ALU
//         CLK  : Clock signal
//         RST  : Reset Signal
//
// Notes: - Control unit synchronize operations of a processor
//          Assign each bit of control signal to control one part of data path
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"
module CONTROL_UNIT(CTRL, READ, WRITE, ZERO, INSTRUCTION, CLK, RST);
  // Output signals
  output [`CTRL_WIDTH_INDEX_LIMIT:0]  CTRL;
  output READ, WRITE;

  // input signals
  input ZERO, CLK, RST;
  input [`DATA_INDEX_LIMIT:0] INSTRUCTION;

  // State nets
  wire [2:0] proc_state;

  PROC_SM state_machine(.STATE(proc_state),.CLK(CLK),.RST(RST)); //instantiate State_Machine

  reg MEM_READ_reg; assign READ = MEM_READ_reg;
  reg MEM_WRITE_reg; assign WRITE = MEM_WRITE_reg;
  reg [`CTRL_WIDTH_INDEX_LIMIT:0]  CTRL_reg; assign CTRL = CTRL_reg;

  reg [5:0] opcode;  //<<used
  reg [4:0] rs;
  reg [4:0] rt;
  reg [4:0] rd;
  reg [4:0] shamt;
  reg [5:0] funct;  //<<used
  reg [15:0] immediate;
  reg [25:0] address;
  reg [`DATA_INDEX_LIMIT:0] SIGN_EXT;
  reg [`DATA_INDEX_LIMIT:0] ZERO_EXT;
  reg [`DATA_INDEX_LIMIT:0] LUI;
  reg [`DATA_INDEX_LIMIT:0] JMP_ADDR;

  reg [21:0] ctrl_low;
  reg [3:0] ctrl_oprn;
  reg [2:0] ctrl_hi;

  always @ (proc_state)
  begin
    //Addr<=PC; R<=1; W<=0; RegRW<=00||11
    if (proc_state === `PROC_FETCH)
    begin
      CTRL_reg = 32'h08000020;
      MEM_ADDR_reg = PC_REG;
      MEM_READ_reg = 1'b1; MEM_WRITE_reg = 1'b0;
    end
    //Decoding INST_REG
    else if (proc_state === `PROC_DECODE)
    begin
      CTRL_reg = 32'h00000110; //? 32'h00000010
      //Parse Instruction
      //R-Type
      {opcode, rs, rt, rd, shamt, funct} = INSTRUCTION;
      //I-Type
      {opcode, rs, rt, immediate} = INSTRUCTION;
      //J-Type
      {opcode, address} = INSTRUCTION;
      //Sign extension
      SIGN_EXT = {{16{immediate[15]}},immediate};
      //Zero extension
      ZERO_EXT = {16'h0000, immediate};
      //LUI: {16-bit , 16x0}
      LUI = {immediate, 16'h0000};
      //Jump address: {6x0, 26-bit}
      JMP_ADDR = {6'b000000, address};
    end
    //Execution phase
    else if (proc_state === `PROC_EXE)
    begin
      case (opcode)
        // R-Type //ALU: 1,2,3, 6,7,8,9, 5,4, x
        6'h00 : begin //read: r1, r2
          case(funct)
            6'h20: begin ALU_OPRN_reg = `ALU_OPRN_WIDTH'h01; ALU_OP1_reg = RF_DATA_R1; ALU_OP2_reg = RF_DATA_R2;
            end
            6'h22: begin ALU_OPRN_reg = `ALU_OPRN_WIDTH'h02; ALU_OP1_reg = RF_DATA_R1; ALU_OP2_reg = RF_DATA_R2;
            end
            6'h2c: begin ALU_OPRN_reg = `ALU_OPRN_WIDTH'h03; ALU_OP1_reg = RF_DATA_R1; ALU_OP2_reg = RF_DATA_R2;
            end
            6'h24: begin ALU_OPRN_reg = `ALU_OPRN_WIDTH'h06; ALU_OP1_reg = RF_DATA_R1; ALU_OP2_reg = RF_DATA_R2;
            end
            6'h25: begin ALU_OPRN_reg = `ALU_OPRN_WIDTH'h07; ALU_OP1_reg = RF_DATA_R1; ALU_OP2_reg = RF_DATA_R2;
            end
            6'h27: begin ALU_OPRN_reg = `ALU_OPRN_WIDTH'h08; ALU_OP1_reg = RF_DATA_R1; ALU_OP2_reg = RF_DATA_R2;
            end
            6'h2a: begin ALU_OPRN_reg = `ALU_OPRN_WIDTH'h09; ALU_OP1_reg = RF_DATA_R1; ALU_OP2_reg = RF_DATA_R2;
            end
            6'h01: begin ALU_OPRN_reg = `ALU_OPRN_WIDTH'h05; ALU_OP1_reg = RF_DATA_R1; ALU_OP2_reg = shamt;
            end
            6'h02: begin ALU_OPRN_reg = `ALU_OPRN_WIDTH'h04; ALU_OP1_reg = RF_DATA_R1; ALU_OP2_reg = shamt;
            end
            6'h08: begin PC_REG = RF_DATA_R1;
            end
          endcase
        end

        // I-Type //ALU: 1,3, 6,7,x,9, 2,2,1,1
        6'h08 : begin ALU_OPRN_reg = `ALU_OPRN_WIDTH'h01; ALU_OP1_reg = RF_DATA_R1; ALU_OP2_reg = SIGN_EXT;
        end
        6'h1d : begin ALU_OPRN_reg = `ALU_OPRN_WIDTH'h03; ALU_OP1_reg = RF_DATA_R1; ALU_OP2_reg = SIGN_EXT;
        end
        6'h0c : begin ALU_OPRN_reg = `ALU_OPRN_WIDTH'h06; ALU_OP1_reg = RF_DATA_R1; ALU_OP2_reg = ZERO_EXT;
        end
        6'h0d : begin ALU_OPRN_reg = `ALU_OPRN_WIDTH'h07; ALU_OP1_reg = RF_DATA_R1; ALU_OP2_reg = ZERO_EXT;
        end
        // 6'h0f : begin
        // end
        6'h0a : begin ALU_OPRN_reg = `ALU_OPRN_WIDTH'h09; ALU_OP1_reg = RF_DATA_R1; ALU_OP2_reg = SIGN_EXT;
        end
        6'h04, 6'h05 : begin ALU_OPRN_reg = `ALU_OPRN_WIDTH'h02; ALU_OP1_reg = RF_DATA_R1; ALU_OP2_reg = RF_DATA_R2;
        end
        // 6'h05 ...
        6'h23, 6'h2b : begin ALU_OPRN_reg = `ALU_OPRN_WIDTH'h01; ALU_OP1_reg = RF_DATA_R1; ALU_OP2_reg = SIGN_EXT;
        end
        // 6'h2b ...

        // J-Type
        // 6'h02 : begin
        // end
        // 6'h03 : begin
        // end
        6'h1b : begin RF_ADDR_R1_reg = 0;
        end
        // 6'h1c : begin
        // end

      endcase
      CTRL_reg = {ctrl_hi, ctrl_oprn, ctrl_low};
    end
    //Memory Operation Phase
    else if (proc_state === `PROC_MEM)
    begin
      case (opcode)
        //lw:
        6'h23 : begin
        MEM_READ_reg = 1'b1; MEM_WRITE_reg = 1'b0;
        MEM_ADDR_reg = ALU_RESULT;
        end
        //sw:
        6'h2b : begin
        MEM_READ_reg = 1'b0; MEM_WRITE_reg = 1'b1;
        MEM_ADDR_reg = ALU_RESULT; MEM_DATA_reg = RF_DATA_R2;
        end
        //push:
        6'h1b : begin
        MEM_READ_reg = 1'b0; MEM_WRITE_reg = 1'b1;
        MEM_ADDR_reg = SP_REF; MEM_DATA_reg = RF_DATA_R1; SP_REF = SP_REF-1;
        end
        //pop:
        6'h1c : begin
        MEM_READ_reg = 1'b1; MEM_WRITE_reg = 1'b0;
        SP_REF = SP_REF+1; MEM_ADDR_reg = SP_REF;
        end
        //default
        default: begin MEM_READ_reg = 1'b0; MEM_WRITE_reg = 1'b0;
        end
      endcase
      CTRL_reg = {ctrl_hi, ctrl_oprn, ctrl_low};
    end
    //Write Back Phase
    else if (proc_state === `PROC_WB)
    begin
      PC_REG = PC_REG + 1;
      MEM_READ_reg = 1'b0; MEM_WRITE_reg = 1'b0;
      case (opcode)
        // R-Type
        6'h00 : begin
          case (funct)
            6'h08: PC_REG = RF_DATA_R1;
            6'h02, 6'h01, 6'h2a, 6'h27, 6'h25, 6'h24, 6'h2c, 6'h22, 6'h20:
            begin
              RF_READ_reg = 1'b0; RF_WRITE_reg = 1'b1;
              RF_ADDR_W_reg = rd; RF_DATA_W_reg = ALU_RESULT;
            end
          endcase
        end

        // I-Type
        6'h08, 6'h1d, 6'h0c, 6'h0d, 6'h0a : begin
          RF_READ_reg = 1'b0; RF_WRITE_reg = 1'b1;
          RF_ADDR_W_reg = rt; RF_DATA_W_reg = ALU_RESULT;
        end
        // 6'h1d ... 6'h0c ... 6'h0d ...
        6'h0f : begin
          RF_READ_reg = 1'b0; RF_WRITE_reg = 1'b1;
          RF_ADDR_W_reg = rt; RF_DATA_W_reg = LUI;
        end
        // 6'h0a ...
        6'h04 : begin
          if (ZERO === 1'b1)
            PC_REG = PC_REG + SIGN_EXT;
        end
        6'h05 : begin
          if (ZERO === 1'b0)
            PC_REG = PC_REG + SIGN_EXT;
        end
        6'h23 : begin
          RF_READ_reg = 1'b0; RF_WRITE_reg = 1'b1;
          RF_ADDR_W_reg = rt; RF_DATA_W_reg = MEM_DATA;
        end
        // 6'h2b : begin
        // end

        // J-Type
        6'h02 : begin
          PC_REG = JMP_ADDR;
        end
        6'h03 : begin
          RF_READ_reg = 1'b0; RF_WRITE_reg = 1'b1;
          RF_ADDR_W_reg = 5'b11111; RF_DATA_W_reg = PC_REG;
          PC_REG = JMP_ADDR;
        end
        // 6'h1b : begin
        // end
        6'h1c : begin
          RF_READ_reg = 1'b0; RF_WRITE_reg = 1'b1;
          RF_ADDR_W_reg = 5'b00000; RF_DATA_W_reg = MEM_DATA;
        end
      endcase
      CTRL_reg = {ctrl_hi, ctrl_oprn, ctrl_low};
    end
  end
  // TBD - take action on each +ve edge of clock

endmodule


//------------------------------------------------------------------------------------------
// Module: PROC_SM
// Output: STATE      : State of the processor
//
// Input:  CLK        : Clock signal
//         RST        : Reset signal
//
// INOUT: MEM_DATA    : Data to be read in from or write to the memory
//
// Notes: - Processor continuously cycle witnin fetch, decode, execute,
//          memory, write back state. State values are in the prj_definition.v
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
module PROC_SM(STATE,CLK,RST);
  // list of inputs
  input CLK, RST;
  // list of outputs
  output [2:0] STATE;

  //state and next_state register
  reg [2:0] state_reg;
  reg [2:0] next_state;

  assign STATE = state_reg;

  //initial
  initial
  begin
    state_reg = 3'bxxx;
    next_state = `PROC_FETCH;
  end

  //reset on negedge RST
  always @ (negedge RST)
  begin
    state_reg = 3'bxxx;
    next_state = `PROC_FETCH;
  end

  //posedge CLK signal
  always @ (posedge CLK)
  begin
    state_reg = next_state;
  end

  //update next_state
  always @ (state_reg)
  begin
    case(state_reg)
      `PROC_FETCH : next_state = `PROC_DECODE;
      `PROC_DECODE : next_state = `PROC_EXE;
      `PROC_EXE : next_state = `PROC_MEM;
      `PROC_MEM : next_state = `PROC_WB;
      `PROC_WB : next_state = `PROC_FETCH;
    endcase
  end

  //===========================================================================
  //print_instruction task
  //usage: print_instruction(INST_REG);
  //===========================================================================
  task print_instruction;
  input [`DATA_INDEX_LIMIT:0] inst;

  reg [5:0] op_task;
  reg [4:0] rs_task;
  reg [4:0] rt_task;
  reg [4:0] rd_task;
  reg [4:0] shamt_task;
  reg [5:0] funct_task;
  reg [15:0] imm_task;
  reg [25:0] addr_task;

  begin
    // parse the instruction
    // R-type
    {op_task, rs_task, rt_task, rd_task, shamt_task, funct_task} = inst;
    // I-type
    {op_task, rs_task, rt_task, imm_task } = inst;
    // J-type
    {op_task, addr_task} = inst;
    $write("@ %6dns -> [0X%08h] ", $time, inst);
    case(op_task)
      // R-Type
      6'h00 : begin
        case(funct_task)
          6'h20: $write("add  r[%02d], r[%02d], r[%02d];", rd_task, rs_task, rt_task);
          6'h22: $write("sub  r[%02d], r[%02d], r[%02d];", rd_task, rs_task, rt_task);
          6'h2c: $write("mul  r[%02d], r[%02d], r[%02d];", rd_task, rs_task, rt_task);
          6'h24: $write("and  r[%02d], r[%02d], r[%02d];", rd_task, rs_task, rt_task);
          6'h25: $write("or   r[%02d], r[%02d], r[%02d];", rd_task, rs_task, rt_task);
          6'h27: $write("nor  r[%02d], r[%02d], r[%02d];", rd_task, rs_task, rt_task);
          6'h2a: $write("slt  r[%02d], r[%02d], r[%02d];", rd_task, rs_task, rt_task);
          6'h01: $write("sll  r[%02d], %2d, r[%02d];", rd_task, rs_task, shamt_task);
          6'h02: $write("srl  r[%02d], %2d, r[%02d];", rd_task, rs_task, shamt_task);
          6'h08: $write("jr   r[%02d];", rs_task);
          default: $write("R-funct ERR!");
        endcase
      end
      6'h08 : $write("addi  r[%02d], r[%02d], 0X%04h;", rt_task, rs_task, imm_task);
      6'h1d : $write("muli  r[%02d], r[%02d], 0X%04h;", rt_task, rs_task, imm_task);
      6'h0c : $write("andi  r[%02d], r[%02d], 0X%04h;", rt_task, rs_task, imm_task);
      6'h0d : $write("ori   r[%02d], r[%02d], 0X%04h;", rt_task, rs_task, imm_task);
      6'h0f : $write("lui   r[%02d], 0X%04h;", rt_task, imm_task);
      6'h0a : $write("slti  r[%02d], r[%02d], 0X%04h;", rt_task, rs_task, imm_task);
      6'h04 : $write("beq r[%02d], r[%02d], 0X%04h;", rt_task, rs_task, imm_task);
      6'h05 : $write("bne r[%02d], r[%02d], 0X%04h;", rt_task, rs_task, imm_task);
      6'h23 : $write("lw r[%02d], r[%02d], 0X%04h;", rt_task, rs_task, imm_task);
      6'h2b : $write("sw r[%02d], r[%02d], 0X%04h;", rt_task, rs_task, imm_task);
      6'h02 : $write("jmp 0X%07h;", addr_task);
      6'h03 : $write("jal 0X%07h;", addr_task);
      6'h1b : $write("push;");
      6'h1c : $write("pop;");
      default: $write("opcode ERR!");
    endcase
    $write("\n");
  end
  endtask

endmodule

//------------------------------------------------------------------------------------------
`endif

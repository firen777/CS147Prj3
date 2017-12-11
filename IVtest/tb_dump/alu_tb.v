`include "alu.v"

`include "prj_definition.v"
module ALU_TB;

  reg [`DATA_INDEX_LIMIT:0] OP1; // operand 1           //[31:0]
  reg [`DATA_INDEX_LIMIT:0] OP2; // operand 2           //[31:0]
  reg [`ALU_OPRN_INDEX_LIMIT:0] OPRN; // operation code //[5:0]

  wire [`DATA_INDEX_LIMIT:0] OUT; // result of the operation.
  wire ZERO;

  ALU ALU_INST(OUT, ZERO, OP1, OP2, OPRN);

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, ALU_TB);
    OP1=32'h00000000; OP2=32'h00000000; OPRN=6'b000000;
    #5 OP1=32'h001fb700; OP2=32'h00000321; OPRN=6'b000001; //add
    #5 OP1=32'h000000ff; OP2=32'h00000100; OPRN=6'b000010; //sub
    #5 OP1=32'h00008bf7; OP2=32'h000000ab; OPRN=6'b000011; //mul
    #5 OP1=32'hffffffff; OP2=32'h000000ff; OPRN=6'b000100; //>>
    #5 OP1=32'h00000001; OP2=32'h00000002; OPRN=6'b000101; //<<
    #5 OP1=32'h01a44bd0; OP2=32'he78fa105; OPRN=6'b000110; //&
    #5 OP1=32'h10101000; OP2=32'h09780afd; OPRN=6'b000111; //|
    #5 OP1=32'h0fabd140; OP2=32'h326f9ed1; OPRN=6'b001000; //!|
    #5 OP1=32'h0fffffff; OP2=32'h10000000; OPRN=6'b001001; //< ?
    #5
    $finish;
  end

endmodule

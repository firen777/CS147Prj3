`include "logic_32_bit.v"

`include "prj_definition.v"
module LOGIC_32_BIT_TB;

  reg [31:0] A,B;
  wire [31:0] WNOR, WAND, WOR, WINV_A, WINV_B;

  NOR32_2x1 NOR32_2x1_INST(WNOR,A,B);
  AND32_2x1 AND32_2x1_INST(WAND,A,B);
  OR32_2x1 OR32_2x1_INST(WOR,A,B);
  INV32_1x1 INV32_1x1_INST_A(WINV_A,A);
  INV32_1x1 INV32_1x1_INST_B(WINV_B,B);

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, LOGIC_32_BIT_TB);
    A=32'h00000000; B=32'h00000000;
    #5 A=32'h0a17b980; B=32'h11af6077;
    #5 A=32'h34cdd610; B=32'h7b5aaee1;
    #5 A=32'h0134ba87; B=32'h00000000;
    #5 A=32'h00000000; B=32'hf987bae1;
    #5 A=32'hffffffff; B=32'h00000000;
    #5 A=32'h00000000; B=32'hffffffff;
    #5 A=32'h00000000; B=32'h00000000;
    #5
    $finish;
  end

endmodule

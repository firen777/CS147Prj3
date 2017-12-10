`include "barrel_shifter.v"

`include "prj_definition.v"
module SHIFT32_TB;

  reg[31:0] D;
  reg[31:0] S;
  reg LnR;

  wire[31:0] Y;

  SHIFT32 S32_INST(Y,D,S, LnR); //R=0, L=1

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, SHIFT32_TB);
    S=32'h00000000; D=32'h00000000; LnR=1'b0;
    #5 S=32'h00000001; D=32'h00000001; LnR=1'b0;
    #5 S=32'h00000001; D=32'h00000001; LnR=1'b1;
    #5 S=32'h00000002; D=32'h00000001; LnR=1'b0;
    #5 S=32'h00000002; D=32'h00000001; LnR=1'b1;
    #5 S=32'h00000005; D=32'hffffffff; LnR=1'b0;
    #5 S=32'h0000000f; D=32'hffffffff; LnR=1'b1;
    #5 S=32'h0000ffff; D=32'h198af7b1; LnR=1'b0;
    #5 S=32'h000aaa00; D=32'h101f568a; LnR=1'b1;
    #5 S=32'h0000001f; D=32'hffffffff; LnR=1'b0;
    #5 S=32'h0000001f; D=32'hffffffff; LnR=1'b1;
    #5 S=32'h00000020; D=32'hffffffff; LnR=1'b0;
    #5 S=32'h00000020; D=32'hffffffff; LnR=1'b1;
    #5
    $finish;
  end

endmodule

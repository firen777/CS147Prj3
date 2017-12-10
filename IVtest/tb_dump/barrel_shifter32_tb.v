`include "barrel_shifter.v"

`include "prj_definition.v"
module BARREL_SHIFTER32_TB;

  reg[31:0] D;
  reg[4:0] S;
  reg LnR;

  wire[31:0] Y;

  BARREL_SHIFTER32 BS32_INST(Y,D,S, LnR); //R=0, L=1

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, BARREL_SHIFTER32_TB);
    S=5'h00; D=32'h00000000; LnR=1'b0;
    #5 S=5'h01; D=32'h00000001; LnR=1'b1;
    #5 S=5'h01; D=32'h00000001; LnR=1'b0;
    #5 S=5'h02; D=32'h00000001; LnR=1'b1;
    #5 S=5'h02; D=32'h00000001; LnR=1'b0;
    #5 S=5'h05; D=32'hffffffff; LnR=1'b0;
    #5 S=5'h0f; D=32'hffffffff; LnR=1'b1;
    #5 S=5'h1f; D=32'h198af7b1; LnR=1'b0;
    #5 S=5'h11; D=32'h101f568a; LnR=1'b1;
    #5 S=5'h14; D=32'h9078af1b; LnR=1'b0;
    #5 S=5'h04; D=32'h7811bf90; LnR=1'b1;
    #5 S=5'h00; D=32'hffffffff; LnR=1'b0;
    #5
    $finish;
  end

endmodule

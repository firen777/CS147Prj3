`include "barrel_shifter.v"

`include "prj_definition.v"
module RIGHT_SHIFTER_TB;

  reg[31:0] D;
  reg[4:0] S;

  wire[31:0] Y;

  SHIFT32_R SR_INST(Y,D,S);

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, RIGHT_SHIFTER_TB);
    S=5'h00; D=32'h00000000;
    #5 S=5'h01; D=32'h00000001;
    #5 S=5'h01; D=32'h00000001;
    #5 S=5'h02; D=32'h00000001;
    #5 S=5'h02; D=32'h00000001;
    #5 S=5'h05; D=32'hffffffff;
    #5 S=5'h0f; D=32'hffffffff;
    #5 S=5'h1f; D=32'h198af7b1;
    #5 S=5'h11; D=32'h101f568a;
    #5 S=5'h14; D=32'h9078af1b;
    #5 S=5'h04; D=32'h7811bf90;
    #5 S=5'h00; D=32'hffffffff;
    #5
    $finish;
  end

endmodule

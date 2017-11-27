`include "full_adder.v"

`include "prj_definition.v"
module FULL_ADDER_TB;

  reg A,B,CI;
  wire S,CO;

  FULL_ADDER FULL_ADDER_INST(S,CO,A,B,CI);

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, FULL_ADDER_TB);
    A=0;B=0;CI=0;
    #5 A=0;B=0;CI=1;
    #5 A=0;B=1;CI=0;
    #5 A=0;B=1;CI=1;
    #5 A=1;B=0;CI=0;
    #5 A=1;B=0;CI=1;
    #5 A=1;B=1;CI=0;
    #5 A=1;B=1;CI=1;
    #5
    $finish;
  end

endmodule

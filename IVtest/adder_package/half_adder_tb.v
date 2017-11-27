`include "half_adder.v"

`include "prj_definition.v"
module HALF_ADDER_TB;

  reg A,B;
  wire Y,C;

  HALF_ADDER HALF_ADDER_INST(Y,C,A,B);

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, HALF_ADDER_TB);
    A=0;B=0;
    #5 A=1; B=0;
    #5 A=0; B=1;
    #5 A=1; B=1;
    $finish;
  end

endmodule

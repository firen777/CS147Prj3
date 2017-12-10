`include "mult.v"

`include "prj_definition.v"
module MULT32_U_TB;

  reg [`DATA_INDEX_LIMIT:0] A;
  reg [`DATA_INDEX_LIMIT:0] B;
  wire [`DATA_INDEX_LIMIT:0] HI;
  wire [`DATA_INDEX_LIMIT:0] LO;

  MULT32_U MULT32_U_INST(HI, LO, A, B);

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, MULT32_U_TB);
    A='h00000000;B='h00000000;
    #5 A='h00000001;B='h00000001;
    #5 A='h00000002;B='h00000002;
    #5 A='h00000003;B='h00000003;
    #5 A='h00000004;B='h00000004;
    #5 A='h00000005;B='h00000005;
    #5 A='h00000006;B='h00000006;
    #5 A='h00000007;B='h00000007;
    #5 A='h00000008;B='h00000008;
    #5 A='h00000009;B='h00000009;
    #5 A='hffffffff;B='hffffffff;
    #5 A='h00000000;B='hffffffff;
    #5 A='hffffffff;B='h00000000;
    #5 A='h00000001;B='hffffffff;
    #5 A='hffffffff;B='h00000001;
    #5 A='h001dac78;B='h05900aff;
    #5 A='h0023df9b;B='h7ba01b1a;
    #5 A='hff000000;B='heeeeeeee;
    #5 A='hf0000000;B='hf0000001;
    #5
    $finish;
  end

endmodule

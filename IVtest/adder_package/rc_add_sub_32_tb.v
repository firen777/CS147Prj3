`include "rc_add_sub_32.v"

`include "prj_definition.v"
module RC_ADD_SUB_32_TB;

  reg [`DATA_INDEX_LIMIT:0] A
  reg [`DATA_INDEX_LIMIT:0] B;
  reg SnA;
  wire [`DATA_INDEX_LIMIT:0] Y;
  wire CO;

  RC_ADD_SUB_32 RC_ADD_SUB_32_INST(Y,CO,A,B,SnA);

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, RC_ADD_SUB_32_TB);
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

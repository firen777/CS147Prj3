`include "rc_add_sub_32.v"

`include "prj_definition.v"
module RC_ADD_SUB_32_TB;

  reg [`DATA_INDEX_LIMIT:0] A;
  reg [`DATA_INDEX_LIMIT:0] B;
  reg SnA;
  wire [`DATA_INDEX_LIMIT:0] Y;
  wire CO;

  RC_ADD_SUB_32 RC_ADD_SUB_32_INST(Y,CO,A,B,SnA);

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, RC_ADD_SUB_32_TB);
    A='h00000000;B='h00000000;SnA=0;
    #5 A='h00000001;B='h00000001;SnA=0;
    #5 A='h00000002;B='h00000002;SnA=0;
    #5 A='hffffffff;B='h00000001;SnA=0;
    #5 A='h00000001;B='h00000001;SnA=1;
    #5 A='h00000007;B='h00000003;SnA=1;
    #5 A='h00000001;B='h00000001;SnA=0;
    #5 A='hff000000;B='heeeeeeee;SnA=1;
    #5 A='h00000000;B='h00000001;SnA=1;
    #5
    $finish;
  end

endmodule

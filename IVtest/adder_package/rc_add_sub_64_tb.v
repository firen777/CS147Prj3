`include "rc_add_sub_32.v"

`include "prj_definition.v"
module RC_ADD_SUB_64_TB;

  reg [63:0] A;
  reg [63:0] B;
  reg SnA;
  wire [63:0] Y;
  wire CO;

  RC_ADD_SUB_64 RC_ADD_SUB_64_INST(Y,CO,A,B,SnA);

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, RC_ADD_SUB_64_TB);
    A='h0000000000000000;B='h0000000000000000;SnA=0;
    #5 A='h0000000000000001;B='h0000000000000001;SnA=0;
    #5 A='h0000000000000002;B='h0000000000000002;SnA=0;
    #5 A='hffffffffffffffff;B='h0000000000000001;SnA=0;
    #5 A='h0000000000000001;B='h0000000000000001;SnA=1;
    #5 A='h0000000000000007;B='h0000000000000003;SnA=1;
    #5 A='h0000000000000001;B='h0000000000000001;SnA=0;
    #5 A='hff00000000000000;B='heeeeeeeeeeeeeeee;SnA=1;
    #5 A='h0000000000000000;B='h0000000000000001;SnA=1;
    #5
    $finish;
  end

endmodule

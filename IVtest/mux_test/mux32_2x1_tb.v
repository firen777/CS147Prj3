`include "mux.v"

`include "prj_definition.v"
module MUX32_2x1_TB;

  reg[`DATA_INDEX_LIMIT:0] I0,I1;
  reg S;
  wire[`DATA_INDEX_LIMIT:0] Y;
  MUX32_2x1 MUX32_2x1_INST(Y,I0, I1, S);

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, MUX32_2x1_TB);
    S=0;I0='h00000000;I1='h00000000;
    #5 S=0;I0='h00001234;I1='h12340000;
    #5 S=1;I0='habcd0000;I1='h0000abcd;
    #5 S=0;I0='h00ef1200;I1='h12345678;
    #5 S=1;I0='h00000111;I1='h11120000;
    $finish;
  end

endmodule

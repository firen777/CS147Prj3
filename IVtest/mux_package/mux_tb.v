`include "mux.v"

`include "prj_definition.v"
module MUX_TB;

  reg I0,I1,S;
  wire Y;
  MUX1_2x1 MUX1_2x1_INST(Y,I0, I1, S);

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, MUX_TB);
    S=0;I0=0;I1=0;
    #5 S=0;I0=0;I1=1;
    #5 S=0;I0=1;I1=0;
    #5 S=0;I0=1;I1=1;
    #5 S=1;I0=0;I1=0;
    #5 S=1;I0=0;I1=1;
    #5 S=1;I0=1;I1=0;
    #5 S=1;I0=1;I1=1;
    #5
    $finish;
  end

endmodule

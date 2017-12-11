`include "logic.v"

`include "prj_definition.v"
module REG1_TB;

  reg D,L,C,nP,nR;
  wire Q, Qbar;

  REG1 REG1_INST(Q, Qbar, D, L, C, nP, nR);

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, REG1_TB);
       D=0;L=0;C=0;nP=0;nR=0;
    #5 D=0;L=0;C=0;nP=0;nR=1;
    #5 D=0;L=0;C=0;nP=1;nR=0;

    #5 D=1;L=0;C=0;nP=1;nR=1;
    #5 D=1;L=0;C=0;nP=1;nR=1;
    #5 D=1;L=0;C=0;nP=1;nR=1;
    #5 D=1;L=0;C=1;nP=1;nR=1;
    #5 D=1;L=1;C=1;nP=1;nR=1;

    #5 D=1;L=1;C=0;nP=1;nR=1;
    #5 D=1;L=1;C=0;nP=1;nR=1;
    #5 D=1;L=1;C=1;nP=1;nR=1;
    #5 D=0;L=0;C=1;nP=1;nR=1;

    #5 D=1;L=0;C=0;nP=1;nR=1;
    #5 D=1;L=0;C=0;nP=1;nR=1;
    #5 D=1;L=0;C=1;nP=1;nR=1;
    #5 D=1;L=1;C=1;nP=1;nR=1;
    #5

    $finish;
  end

endmodule

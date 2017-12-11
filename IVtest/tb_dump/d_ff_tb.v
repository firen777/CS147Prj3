`include "logic.v"

`include "prj_definition.v"
module D_FF_TB;

  reg S, R, D, DFF, nP, nR, C;

  wire srQ, srnQ, dQ, dnQ, dffQ, dffnQ;

  SR_LATCH SR_INST(srQ, srnQ, S, R, C, nP, nR);
  D_LATCH D_INST(dQ, dnQ, D, C, nP, nR);
  D_FF D_FF_INST(dffQ, dffnQ, DFF, C, nP, nR);


  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, D_FF_TB);
       S=0;R=0;D=0;DFF=0;nP=0;nR=0;C=0;
    #5 S=0;R=0;D=0;DFF=0;nP=1;nR=0;C=0;
    #5 S=0;R=0;D=0;DFF=0;nP=0;nR=1;C=0;
    #5 S=0;R=0;D=0;DFF=0;nP=1;nR=1;C=0;
    // check ve+
    #5 S=1;R=0;D=1;DFF=1;nP=1;nR=1;C=0;
    #5 S=1;R=0;D=1;DFF=1;nP=1;nR=1;C=1;
    #5 S=1;R=0;D=1;DFF=1;nP=1;nR=1;C=0;
    #5 S=0;R=1;D=0;DFF=0;nP=1;nR=1;C=0;
    #5 S=0;R=1;D=0;DFF=0;nP=1;nR=1;C=1;
    #5 S=0;R=0;D=0;DFF=0;nP=1;nR=1;C=0;

    /////////////

    #5 S=1;R=0;D=1;DFF=1;nP=1;nR=1;C=0;
    #5 S=1;R=0;D=1;DFF=1;nP=1;nR=1;C=1; //set
    #5 S=0;R=1;D=0;DFF=0;nP=1;nR=1;C=1;
    #5 S=1;R=0;D=1;DFF=1;nP=1;nR=1;C=1;
    #5 S=0;R=0;D=0;DFF=0;nP=1;nR=1;C=1;
    #5 S=1;R=0;D=1;DFF=1;nP=1;nR=1;C=1;
    #5 S=0;R=1;D=0;DFF=0;nP=1;nR=1;C=0; //ve-
    #5 S=0;R=1;D=0;DFF=0;nP=1;nR=1;C=1; //ve+
    #5 S=0;R=0;D=0;DFF=0;nP=1;nR=1;C=0;
    #5 S=0;R=0;D=0;DFF=0;nP=1;nR=1;C=0;
    #5 S=0;R=0;D=0;DFF=0;nP=1;nR=1;C=0;
    #5

    $finish;
  end

endmodule

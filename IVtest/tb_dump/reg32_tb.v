`include "logic.v"

`include "prj_definition.v"
module REG32_TB;

  reg [31:0] D;
  reg LOAD, CLK, RESET;

  wire [31:0] Q;

  REG32 REG32_INST(Q, D, LOAD, CLK, RESET); //reset on RESET=0

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, REG32_TB);
       D=32'h00000000;LOAD=0;CLK=0;RESET=1;
    #5 D=32'h007fb190;LOAD=1;CLK=0;RESET=1;
    #5 D=32'h007fb190;LOAD=1;CLK=1;RESET=1;
    #5 D=32'h00000000;LOAD=0;CLK=1;RESET=1;
    #5 D=32'h09abeff1;LOAD=1;CLK=0;RESET=1;
    #5 D=32'h09abe321;LOAD=1;CLK=0;RESET=1;
    #5 D=32'h09abe321;LOAD=1;CLK=1;RESET=1;
    #5 D=32'h000123a0;LOAD=1;CLK=1;RESET=1;
    #5 D=32'h000123a0;LOAD=1;CLK=0;RESET=1;
    #5 D=32'h000123a0;LOAD=1;CLK=0;RESET=1;
    #5 D=32'h000123a0;LOAD=0;CLK=1;RESET=1;
    #5 D=32'h000123a0;LOAD=1;CLK=1;RESET=1;
    #5 D=32'h00000000;LOAD=0;CLK=0;RESET=1;
    #5 D=32'h00000000;LOAD=0;CLK=0;RESET=0;
    #5 D=32'h000fffff;LOAD=1;CLK=1;RESET=1;
    #5 D=32'h00000000;LOAD=0;CLK=1;RESET=0;
    #5

    $finish;
  end

endmodule

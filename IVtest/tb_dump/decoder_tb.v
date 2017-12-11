`include "logic.v"

`include "prj_definition.v"
module DECODER_TB;

  reg [4:0] I;
  wire [31:0] D;

  DECODER_5x32 DECODER_5x32_INST(D,I);

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, DECODER_TB);
       I=5'b00000;
    #5 I=5'b00001;
    #5 I=5'b00010;
    #5 I=5'b00011;
    #5 I=5'b00100;
    #5 I=5'b00101;
    #5 I=5'b00110;
    #5 I=5'b00111;
    #5 I=5'b01000;
    #5 I=5'b01001;
    #5 I=5'b01010;
    #5 I=5'b01011;
    #5 I=5'b01100;
    #5 I=5'b01101;
    #5 I=5'b01110;
    #5 I=5'b01111;
    #5 I=5'b10000;
    #5 I=5'b10001;
    #5 I=5'b10010;
    #5 I=5'b10011;
    #5 I=5'b10100;
    #5 I=5'b10101;
    #5 I=5'b10110;
    #5 I=5'b10111;
    #5 I=5'b11000;
    #5 I=5'b11001;
    #5 I=5'b11010;
    #5 I=5'b11011;
    #5 I=5'b11100;
    #5 I=5'b11101;
    #5 I=5'b11110;
    #5 I=5'b11111;
    #5

    $finish;
  end

endmodule

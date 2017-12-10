`include "mux.v"

`include "prj_definition.v"
module MUX1_8x1_TB;

  reg I0, I1, I2, I3, I4, I5, I6, I7;
  reg [2:0]S;
  wire Y;
  MUX1_8x1 MUX1_8x1_INST(Y, I0, I1, I2, I3, I4, I5, I6, I7, S);

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, MUX1_8x1_TB);
    S='b000;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;
    #5 S='b001;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;
    #5 S='b010;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;
    #5 S='b011;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;
    #5 S='b100;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;
    #5 S='b101;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;
    #5 S='b110;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;
    #5 S='b111;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;
    #5
    $finish;
  end

endmodule

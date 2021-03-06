`include "mux.v"

`include "prj_definition.v"
module MUX1_16x1_TB;

  reg I0, I1, I2, I3, I4, I5, I6, I7,
      I8, I9, I10, I11, I12, I13, I14, I15;
  reg [3:0]S;
  wire Y;
  MUX1_16x1 MUX1_16x1_INST(Y, I0, I1, I2, I3, I4, I5, I6, I7,
                              I8, I9, I10, I11, I12, I13, I14, I15, S);

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, MUX1_16x1_TB);
    S='b0000;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;I8=1;I9=0;I10=1;I11=0;I12=1;I13=0;I14=1;I15=0;
    #5 S='b0000;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;I8=1;I9=0;I10=1;I11=0;I12=1;I13=0;I14=1;I15=0;
    #5 S='b0001;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;I8=1;I9=0;I10=1;I11=0;I12=1;I13=0;I14=1;I15=0;
    #5 S='b0010;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;I8=1;I9=0;I10=1;I11=0;I12=1;I13=0;I14=1;I15=0;
    #5 S='b0011;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;I8=1;I9=0;I10=1;I11=0;I12=1;I13=0;I14=1;I15=0;
    #5 S='b0100;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;I8=1;I9=0;I10=1;I11=0;I12=1;I13=0;I14=1;I15=0;
    #5 S='b0101;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;I8=1;I9=0;I10=1;I11=0;I12=1;I13=0;I14=1;I15=0;
    #5 S='b0110;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;I8=1;I9=0;I10=1;I11=0;I12=1;I13=0;I14=1;I15=0;
    #5 S='b0111;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;I8=1;I9=0;I10=1;I11=0;I12=1;I13=0;I14=1;I15=0;
    #5 S='b1000;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;I8=1;I9=0;I10=1;I11=0;I12=1;I13=0;I14=1;I15=0;
    #5 S='b1001;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;I8=1;I9=0;I10=1;I11=0;I12=1;I13=0;I14=1;I15=0;
    #5 S='b1010;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;I8=1;I9=0;I10=1;I11=0;I12=1;I13=0;I14=1;I15=0;
    #5 S='b1011;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;I8=1;I9=0;I10=1;I11=0;I12=1;I13=0;I14=1;I15=0;
    #5 S='b1100;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;I8=1;I9=0;I10=1;I11=0;I12=1;I13=0;I14=1;I15=0;
    #5 S='b1101;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;I8=1;I9=0;I10=1;I11=0;I12=1;I13=0;I14=1;I15=0;
    #5 S='b1110;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;I8=1;I9=0;I10=1;I11=0;I12=1;I13=0;I14=1;I15=0;
    #5 S='b1111;I0=1;I1=0;I2=1;I3=0;I4=1;I5=0;I6=1;I7=0;I8=1;I9=0;I10=1;I11=0;I12=1;I13=0;I14=1;I15=0;
    #5
    $finish;
  end

endmodule

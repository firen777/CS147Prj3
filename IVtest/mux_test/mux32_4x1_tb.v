`include "mux.v"

`include "prj_definition.v"
module MUX32_4x1_TB;

  reg[`DATA_INDEX_LIMIT:0] I0,I1,I2,I3;
  reg[1:0] S;
  wire[`DATA_INDEX_LIMIT:0] Y;
  MUX32_4x1 MUX32_4x1_INST(Y, I0, I1, I2, I3, S);

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, MUX32_4x1_TB);
    S='b00;I0='h00000000;I1='h00000000;I2='h00000000;I3='h00000000;
    #5 S='b00;I0='h00012340;I1='habc21000;I2='h00033300;I3='h00aadd00;
    #5 S='b01;I0='h22330000;I1='hffffffff;I2='h9999ffdd;I3='h00000001;
    #5 S='b10;I0='h00001230;I1='h02220000;I2='h0000ade0;I3='h00000000;
    #5 S='b11;I0='h09090901;I1='h0000efd1;I2='h94588255;I3='hacdefb00;
    #5 S='b00;I0='h00000000;I1='h00000001;I2='h00000002;I3='h00000003;
    #5 S='b01;I0='h00000000;I1='h00000001;I2='h00000002;I3='h00000003;
    #5 S='b10;I0='h00000000;I1='h00000001;I2='h00000002;I3='h00000003;
    #5 S='b11;I0='h00000000;I1='h00000001;I2='h00000002;I3='h00000003;
    $finish;
  end

endmodule

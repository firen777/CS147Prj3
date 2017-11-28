`include "mux.v"

`include "prj_definition.v"
module MUX32_8x1_TB;

  reg[`DATA_INDEX_LIMIT:0] I0,I1,I2,I3,I4,I5,I6,I7;
  reg[2:0] S;
  wire[`DATA_INDEX_LIMIT:0] Y;
  MUX32_8x1 MUX32_8x1_INST(Y, I0, I1, I2, I3, I4, I5, I6, I7, S);

  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, MUX32_8x1_TB);
    S='b000;I0='h00000000;I1='h00000000;I2='h00000000;I3='h00000000;I4='h00000000;I5='h00000000;I6='h00000000;I7='h00000000;
    #5 S='b000;I0='h00012340;I1='habc21000;I2='h00033300;I3='h00aadd00;I4='h44444444;I5='h55555555;I6='h66666666;I7='h77777777;
    #5 S='b001;I0='h22330000;I1='hffffffff;I2='h9999ffdd;I3='h00000001;I4='h44444444;I5='h55555555;I6='h66666666;I7='h77777777;
    #5 S='b010;I0='h00001230;I1='h02220000;I2='h0000ade0;I3='h00000000;I4='h44444444;I5='h55555555;I6='h66666666;I7='h77777777;
    #5 S='b011;I0='h09090901;I1='h0000efd1;I2='h94588255;I3='hacdefb00;I4='h44444444;I5='h55555555;I6='h66666666;I7='h77777777;
    #5 S='b100;I0='h00000000;I1='h00000001;I2='h00000002;I3='h00000003;I4='h44444444;I5='h55555555;I6='h66666666;I7='h77777777;
    #5 S='b101;I0='h00000000;I1='h00000001;I2='h00000002;I3='h00000003;I4='h44444444;I5='h55555555;I6='h66666666;I7='h77777777;
    #5 S='b110;I0='h00000000;I1='h00000001;I2='h00000002;I3='h00000003;I4='h44444444;I5='h55555555;I6='h66666666;I7='h77777777;
    #5 S='b111;I0='h00000000;I1='h00000001;I2='h00000002;I3='h00000003;I4='h44444444;I5='h55555555;I6='h66666666;I7='h77777777;
    $finish;
  end

endmodule

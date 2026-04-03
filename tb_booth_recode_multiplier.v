`timescale 1ps / 1ps

`include "booth_recode_multiplier.v"

module tb_booth_recode_multiplier;
  reg [7:0] multiplier;
  wire signed [2:0] encoding_0;
  wire signed [2:0] encoding_1;
  wire signed [2:0] encoding_2;
  wire signed [2:0] encoding_3;

  booth_recode_multiplier dut (
      multiplier,
      encoding_0,
      encoding_1,
      encoding_2,
      encoding_3
  );

  initial begin
    $dumpfile("tb_booth_recode_multiplier.vcd");
    $dumpvars(0, tb_booth_recode_multiplier);

    multiplier = 15;
    #1;
    multiplier = -30;
    #1;
    multiplier = 30;
    #1;
    multiplier = -15;
    #1;
    multiplier = 3;
    #1;
  end

endmodule

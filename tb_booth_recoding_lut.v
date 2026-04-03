`timescale 1ps / 1ps

`include "booth_recoding_lut.v"

module tb_booth_recoding_lut;
  reg [2:0] group;
  wire signed [2:0] encoding;

  booth_recoding_lut dut (
      .group(group),
      .encoding(encoding)
  );

  integer i;
  initial begin
    $dumpfile("tb_booth_recoding_lut.vcd");
    $dumpvars(0, tb_booth_recoding_lut);
    for (i = 0; i < 8; i = i + 1) begin
      group = i;
      #1;
    end
  end

endmodule

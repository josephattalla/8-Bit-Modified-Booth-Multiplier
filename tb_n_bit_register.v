`timescale 1ps / 1ps

`include "n_bit_register.v"

module tb_n_bit_register;
  reg clk;
  reg nrst;
  reg [3:0] d;
  wire [3:0] q;

  n_bit_register #(
      .N(4)
  ) dut (
      clk,
      nrst,
      d,
      q
  );

  initial begin
    nrst = 0;
    clk = 0;
    #1 nrst = 1;
  end

  always #5 clk = ~clk;

  integer i;
  initial begin
    $dumpfile("tb_n_bit_register.vcd");
    $dumpvars(0, tb_n_bit_register);

    for (i = 0; i < 16; i = i + 1) begin
      d = i;
      #10;
    end
  $finish;
  end


endmodule

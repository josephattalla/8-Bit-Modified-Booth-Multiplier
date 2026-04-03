`timescale 1ps / 1ps
`include "top.v"

module tb_top;
  reg signed [7:0] x;
  reg signed [7:0] y;
  reg clk;
  reg nrst;
  wire signed [15:0] z;

  top dut (
      x,
      y,
      clk,
      nrst,
      z
  );

  initial begin
    clk  = 0;
    nrst = 0;
    #1 nrst = 1;
  end

  always #5 clk = ~clk;

  initial begin
    $dumpfile("tb_top.vcd");
    $dumpvars(0, tb_top);
    x = 25;
    y = 15;
    #15;
    x = -30;
    y = -30;
    #10;
    x = -25;
    y = 30;
    #10;
    x = 30;
    y = -15;
    #10;
    x = 100;
    y = 3;
    #15;
    $finish;
  end
endmodule


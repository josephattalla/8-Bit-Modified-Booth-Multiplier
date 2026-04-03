`timescale 1ps / 1ps

`include "partial_product_computation.v"

module tb_partial_product_computation;
  reg signed  [ 7:0] multiplicand;
  reg signed  [ 2:0] encoding;
  wire signed [15:0] partial_product;

  partial_product_computation dut (
      multiplicand,
      encoding,
      partial_product
  );

  initial begin
    $dumpfile("tb_partial_product_computation.vcd");
    $dumpvars(0, tb_partial_product_computation);

    multiplicand = 15;
    encoding = 1;
    #1;
    encoding = -1;
    #1;
    encoding = 2;
    #1;
    encoding = -2;
    #1;
    encoding = 0;
    #1;
    multiplicand = 30;
    encoding = 1;
    #1;
    encoding = -1;
    #1;
    encoding = 2;
    #1;
    encoding = -2;
    #1;
    encoding = 0;
    #1;
  end

endmodule

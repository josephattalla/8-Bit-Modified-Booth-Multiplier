`include "booth_recode_multiplier.v"
`include "partial_product_computation.v"
`include "n_bit_register.v"

module top (
    input signed [7:0] x,
    input signed [7:0] y,
    input clk,
    input nrst,
    output [15:0] z
  );


  wire signed [7:0] multiplicand;
  wire signed [7:0] multiplier;

  n_bit_register #(.N(8)) u5 (.clk(clk), .nrst(nrst), .d(x), .q(multiplicand));
  n_bit_register #(.N(8)) u6 (.clk(clk), .nrst(nrst), .d(y), .q(multiplier));

  // 1. get encoded multiplier
  wire signed [2:0] encoding[0:3];
  booth_recode_multiplier u0 (
                            .multiplier(multiplier),
                            .encoding_0(encoding[0]),
                            .encoding_1(encoding[1]),
                            .encoding_2(encoding[2]),
                            .encoding_3(encoding[3])
                          );

  // 2. get partial products
  // wire signed [15:0] partial_product_0, partial_product_1, partial_product_2, partial_product_3;
  wire signed [15:0] partial_product[0:3];

  // assign partial_product_0 = encoding[0] * x;
  // assign partial_product_1 = (encoding[1] * x) << 2;
  // assign partial_product_2 = (encoding[2] * x) << 4;
  // assign partial_product_3 = (encoding[3] * x) << 6;
  partial_product_computation u1 (
                                .multiplicand(multiplicand),
                                .encoding(encoding[0]),
                                .partial_product(partial_product[0])
                              );

  partial_product_computation u2 (
                                .multiplicand(multiplicand),
                                .encoding(encoding[1]),
                                .partial_product(partial_product[1])
                              );

  partial_product_computation u3 (
                                .multiplicand(multiplicand),
                                .encoding(encoding[2]),
                                .partial_product(partial_product[2])
                              );

  partial_product_computation u4 (
                                .multiplicand(multiplicand),
                                .encoding(encoding[3]),
                                .partial_product(partial_product[3])
                              );
  // module partial_product_computation (
  //     input  signed [ 7:0] multiplicand,
  //     input  signed [ 2:0] encoding,
  //     output signed [15:0] partial_product
  // );


  // set output to sum of partial products
  wire signed [15:0] pp_sum;
  assign pp_sum = partial_product[0] + (partial_product[1] << 2) + (partial_product[2] << 4) + (partial_product[3] << 6);
  n_bit_register #(.N(16)) u7 (.clk(clk), .nrst(nrst), .d(pp_sum), .q(z));

endmodule

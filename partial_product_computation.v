module partial_product_computation (
    input  signed [ 7:0] multiplicand,
    input  signed [ 2:0] encoding,
    output signed [15:0] partial_product
);

  reg signed [15:0] pp_0;
  reg signed [15:0] pp_1;

  // mux for faster encoder multiplication
  always @(*) begin
    case (encoding)
      1, -1: pp_0 = multiplicand;
      2, -2: pp_0 = multiplicand << 1;
      0: pp_0 = 0;
      default: pp_0 = 0;
    endcase
  end

  // mux to perform 2's comp for negative encoding values
  always @(*) begin
    case (encoding)
      -1, -2:  pp_1 = (~pp_0) + 1;
      default: pp_1 = pp_0;
    endcase
  end

  assign partial_product = pp_1;

endmodule

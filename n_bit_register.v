module n_bit_register #(
    parameter N = 8
) (
    input clk,
    input nrst,
    input [N-1:0] d,
    output [N-1:0] q
);

  reg [N-1:0] q_reg;
  always @(negedge nrst, posedge clk) begin
    if (!nrst) q_reg <= 0;
    else q_reg <= d;
  end

  assign q = q_reg;

endmodule


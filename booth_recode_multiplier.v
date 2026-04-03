`include "booth_recoding_lut.v"

module booth_recode_multiplier (
    input [7:0] multiplier,
    output signed [2:0] encoding_0,
    output signed [2:0] encoding_1,
    output signed [2:0] encoding_2,
    output signed [2:0] encoding_3
);

  booth_recoding_lut u0 (
      .group({multiplier[1:0], 1'b0}),
      .encoding(encoding_0)
  );

  booth_recoding_lut u1 (
      .group(multiplier[3:1]),
      .encoding(encoding_1)
  );

  booth_recoding_lut u2 (
      .group(multiplier[5:3]),
      .encoding(encoding_2)
  );

  booth_recoding_lut u3 (
      .group(multiplier[7:5]),
      .encoding(encoding_3)
  );


endmodule

// int8_t* encoded_multipliers(int8_t multiplier) {
//   int8_t* out = (int8_t*)malloc(4*sizeof(int8_t));
//   out[0] = (multiplier & 0x03) << 1;
//   out[0] = encoding_lut(out[0]);
//
//   out[1] = (multiplier & 0x0E) >> 1;
//   out[1] = encoding_lut(out[1]);
//
//   out[2] = (multiplier & 0x38) >> 3;
//   out[2] = encoding_lut(out[2]);
//
//   out[3] = (multiplier & 0xE0) >> 5;
//   out[3] = encoding_lut(out[3]);
//
//   return out;
// }

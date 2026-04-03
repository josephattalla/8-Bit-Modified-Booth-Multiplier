module booth_recoding_lut (
    input [2:0] group,
    output reg signed [2:0] encoding
);
  // if (group == 0 || group == 7) return 0;
  // if (group == 1 || group == 2) return 1;
  // if (group == 3) return 2;
  // if (group == 4) return -2;
  // if (group == 5 || group == 6) return -1;
  always @(*) begin
    case (group)
      0, 7: encoding = 0;
      1, 2: encoding = 1;
      3: encoding = 2;
      4: encoding = -2;
      5, 6: encoding = -1;
      default: encoding = 0;
    endcase
  end
endmodule

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

// Function declarations
int8_t encoding_lut(int8_t);
int8_t* encoded_multipliers(int8_t multiplier);
int16_t booth_multiplier_1(int8_t, int8_t);

int main() {

  for (int16_t x = INT8_MIN; x <= INT8_MAX; x++) {
    for (int16_t y = INT8_MIN; y <= INT8_MAX; y++) {
      int16_t output = booth_multiplier_1(x, y);
      if (output != x*y) {
        printf("Error for x = %d, y = %d, expected: %d, got: %d\n", x, y, x*y, output);
        return 1;
      }
    }
  }
}


int8_t encoding_lut(int8_t group) {
  if (group == 0 || group == 7) return 0;
  if (group == 1 || group == 2) return 1;
  if (group == 3) return 2;
  if (group == 4) return -2;
  if (group == 5 || group == 6) return -1;
  printf("ERROR in encoding_lut for group = %d", group);
  return 0;
}


int8_t* encoded_multipliers(int8_t multiplier) {
  int8_t* out = (int8_t*)malloc(4*sizeof(int8_t));
  out[0] = (multiplier & 0x03) << 1;
  out[0] = encoding_lut(out[0]);

  out[1] = (multiplier & 0x0E) >> 1;
  out[1] = encoding_lut(out[1]);

  out[2] = (multiplier & 0x38) >> 3;
  out[2] = encoding_lut(out[2]);

  out[3] = (multiplier & 0xE0) >> 5;
  out[3] = encoding_lut(out[3]);

  return out;
}


int16_t booth_multiplier_1(int8_t x, int8_t y) {
  int8_t* encoded_multiplier = encoded_multipliers(y);

  int16_t partial_products[4];
  int16_t output = 0;
  for (int i = 0; i < 4; i++) {
    partial_products[i] = (encoded_multiplier[i] * x) << (i*2);
    output += partial_products[i];
  }

  free(encoded_multiplier);

  return output;
}

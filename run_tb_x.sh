#!/bin/bash

iverilog -o tb_$1.o tb_$1.v
./tb_$1.o
gtkwave tb_$1.vcd

rm -f *.o *.vcd

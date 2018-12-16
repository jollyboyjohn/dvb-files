#!/bin/sh
# Frequency: 10992.16 MHz
# Symbol Rete: 27500ksym/s 
# Polarity: 13v (vertical) / 18v (horizontal)
# DiSEqC = 3 (from 1 to 4)

dvblast -f 10992160 -s 27500000 -v 13 -S 3 -c dvblast-s2-rai1.conf

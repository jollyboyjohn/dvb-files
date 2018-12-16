#!/bin/bash

# Using TEMPLATE as a ordering and availability reference, match the first field
# inside SCANFILE then print it's bouquet line that proceeds it
#
# Scans are done with scan-s2 with the bouquet patch:
# $ scan-s2 -n -s 2 -o bouquet scan-s2-Hotbird13E > bouquet-Hotbird13E

SCANFILE="input-scans/output-Astra192E"
TEMPLATE="bouquet-templates/german-sd.txt"

awk 'FNR==NR {key=$2; for (i=3; i<=NF; i++){key=key" "$i}; getline y; array[key] = y; next; next} $0 in array {print $0; print array[$0]}' $SCANFILE $TEMPLATE

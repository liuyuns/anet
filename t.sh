#!/bin/bash

cfg_name=$1
echo "cfg name: ${cfg_name} or: $1"

weight=$( ls backup/${cfg_name}* -t | head -1 )

echo $weight

shift

echo "Other params $*"

./darknet/darknet detector test cfg/anet.data cfg/${cfg_name}.cfg $weight -ext_output $* < test.txt > r.log

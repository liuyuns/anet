#!/bin/bash

cfg=$1
shift

if [ "$cfg" == "" ]; then
    echo ""
    echo "Usage:"
    echo "$0 [cfg-file] [-min_id m](optional, 0 as default) [-max_id n](optional max as default) [-dont_show](optional)"
    echo ""
    exit 1
fi

echo "Args after cfg: $*"

conv=../data/yolov3-tiny.conv.15 
if [[ $1 == *.weights ]]; then
  conv=""
fi

./darknet/darknet detector train cfg/anet.data $cfg $conv $* -gpus 1,2,3 

# -gpus 0,1,2,3 


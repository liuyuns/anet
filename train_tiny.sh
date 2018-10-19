#!/bin/bash

echo "args: $*"

cfg=$1
shift

conv=../data/yolov3-tiny.conv.15 

./darknet/darknet detector train cfg/anet.data $cfg $conv $* -gpus 0,1,2,3 


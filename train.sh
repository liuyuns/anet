#!/bin/bash

echo "args: $*"

cfg=$1
shift

conv=../data/darknet53.conv.74 

./darknet/darknet detector train cfg/anet.data $cfg $conv $* -gpus 0,1,2,3 

# cfg/yolov3-anet.cfg 

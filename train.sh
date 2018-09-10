#!/bin/bash

conv=$1

echo $@


./darknet/darknet detector train cfg/anet.data cfg/yolov3-anet.cfg $conv -gpus 0,1,2,3

# ../data/darknet53.conv.74

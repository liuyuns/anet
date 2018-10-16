#!/bin/bash

echo $@

./darknet/darknet detector train cfg/anet.data $* -gpus 0,1,2,3 

# cfg/yolov3-anet.cfg ../data/darknet53.conv.74 

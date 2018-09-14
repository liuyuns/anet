#!/bin/bash

if [ ! -f yolov3-tiny.weights ]; then
    wget https://pjreddie.com/media/files/yolov3-tiny.weights
fi

if [ ! -f yolov3-tiny.conv.15 ]; then
    ./darknet/darknet partial cfg/yolov3-tiny.cfg yolov3-tiny.weights yolov3-tiny.conv.15 15
fi

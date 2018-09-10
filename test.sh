#!/bin/bash


it=$1

if [ "$1" == "" ]; then
  echo ""
  echo "  Usage: $0 [iteration] [path_to_image] [args (optional)]"
  echo ""
  exit 1
else
  it=$1
  shift
fi

if [ "$1" == "" ]; then
  image=$image
else
  image=$1
  shift
fi

echo "Detect image: $image, optional args $@"

./darknet/darknet detector test cfg/anet.data cfg/yolov3-anet.cfg backup/yolov3-anet_${it}.weights $image -thresh 0.5 $@

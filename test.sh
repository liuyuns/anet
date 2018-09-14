#!/bin/bash

if [ "$2" == "" ]; then
  echo ""
  echo "  Usage: $0 [cfg] [iteration] [path_to_image] [args (optional)]"
  echo ""
  exit 1
else
  cfg=$1
  shift
fi

if [ "$1" == "" ]; then
  it=$it
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

echo "
Detect image: $image, optional args $@"

result_weights="result/yolov3-anet_${it}.weights"
if [ -f ${result_weights} ]; then
  weights=$result_weights
else 
  backup_weights="backup/yolov3-anet_${it}.weights" 
  if [ -f $backup_weights ]; then
    weights=$backup_weights
  fi
fi

echo "
Using cfg: ${cfg}, weights: ${weights}"


./darknet/darknet detector test cfg/anet_v1.data $cfg $weights $image -thresh 0.3 $@

predict_name=predict_$(basename $image)

mv predictions.jpg $predict_name
